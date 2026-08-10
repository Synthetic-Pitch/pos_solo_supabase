import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { getCorsHeaders } from "./cors.ts";
import { getCookie } from "../login_v2/get_cookie.ts";
import { jsonResponse, isValidUuid } from "../login_v2/utils.ts";

type AddOrderBody = {
  flavor?: string;
  size?: string;
  payment_method?: string;
};
type StoreColumns = {
    id: number;
    session_id: string;
    csrf_token: string;
    session_expiration: string | null;
}
type SaleColumns = {
  id: number;
  flavor: string;
  size: string;
  payment_method?: string;
  stores_id: number;
}
function validateString(v: unknown): v is string {
  return typeof v === "string" && v.trim().length > 0;
}

export default {
  fetch: withSupabase({ auth: ["publishable", "secret"] }, async (req, ctx) => {
    const corsHeaders = getCorsHeaders(req);

    if (req.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders });
    }

    if (req.method !== "POST") {
      return jsonResponse({ message: "Method not allowed" }, 405, corsHeaders);
    }

    const csrfHeader = req.headers.get("x-csrf-token");
    if (!csrfHeader) {
      return jsonResponse({ message: "Missing CSRF token" }, 401, corsHeaders);
    }
 
    const cookieSessionId = getCookie(req);
    if (!cookieSessionId || !isValidUuid(cookieSessionId)) {
      return jsonResponse({ message: "Invalid or missing session cookie" }, 401, corsHeaders);
    }

    let body: AddOrderBody;
    try {
      body = await req.json();
    } catch {
      return jsonResponse({ message: "Invalid JSON body" }, 400, corsHeaders);
    }

    // basic validation (stores_id is derived from authenticated STORE)
    if (!validateString(body.flavor) || !validateString(body.size)) {
      return jsonResponse({ message: "flavor and size are required" }, 400, corsHeaders);
    }

    const supabase = ctx.supabaseAdmin;
    // verify session and csrf token belong together and are not expired
    
    const { data: storeRow, error: storeErr } = await supabase
      .from("STORES")
      .select("id, session_id, csrf_token, session_expiration")
      .eq("session_id", cookieSessionId)
      .maybeSingle<StoreColumns>();
    
    if (storeErr) {
      console.error("STORES lookup error:", storeErr);
      return jsonResponse({ message: "Unable to verify session" }, 500, corsHeaders);
    }

    if (!storeRow) {
      return jsonResponse({ message: "Session not found" }, 401, corsHeaders);
    }

    if (storeRow.csrf_token !== csrfHeader) {
      return jsonResponse({ message: "CSRF token mismatch" }, 403, corsHeaders);
    }

    // validate session_expiration robustly (parse ISO to timestamp)
    const sessExpTs = storeRow.session_expiration ? Date.parse(storeRow.session_expiration) : null;
    if (sessExpTs && Date.now() >= sessExpTs) {
      return jsonResponse({ message: "Session expired" }, 401, corsHeaders);
    }
    

    // Insert into SALES — re-check session_expiration immediately before inserting
    const { data: freshStore, error: freshErr } = await supabase
      .from("STORES")
      .select("session_expiration")
      .eq("id", storeRow.id)
      .maybeSingle<StoreColumns>();

    if (freshErr) {
      console.error("STORES re-check error:", freshErr);
      return jsonResponse({ message: "Unable to verify session" }, 500, corsHeaders);
    }

    if (!freshStore) {
      return jsonResponse({ message: "Session not found" }, 401, corsHeaders);
    }

    const freshExpTs = freshStore.session_expiration ? Date.parse(freshStore.session_expiration) : null;
    if (freshExpTs && Date.now() >= freshExpTs) {
      return jsonResponse({ message: "Session expired" }, 401, corsHeaders);
    }

    const paymentMethod = validateString(body.payment_method) ? body.payment_method!.trim() : "cash";

    const payload = {
      flavor: body.flavor!.trim(),
      size: body.size!.trim(),
      payment_method: paymentMethod,
      stores_id: storeRow.id,
    } as const;

    const { data: inserted, error: insertErr } = await supabase
      .from("SALES")
      .insert(payload as any)
      .select("id")
      .single<SaleColumns>();

    if (insertErr) {
      console.error("SALES insert error:", insertErr);
      return jsonResponse({ message: "Failed to create sale" }, 500, corsHeaders);
    }

    return jsonResponse({ message: "Sale recorded", id: inserted.id }, 201, corsHeaders);
  }),
};
