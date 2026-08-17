import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { getCorsHeaders } from "./cors.ts";
import {
  getCookie,
  isValidUuid,
  jsonResponse,
  validateString,
} from "./utils.ts";

type AddPotatoBody = {
  date?: unknown;
  kilo?: unknown;
};

type StoreColumns = {
  id: number;
  session_id: string;
  csrf_token: string;
  session_expiration: string | null;
};

type ReconciliationRow = {
  id: number;
  added_potatoes: Array<Record<string, unknown>> | null;
};

function normalizeEntry(body: AddPotatoBody) {
  const date = validateString(body.date) ? body.date.trim() : null;
  const kilo = typeof body.kilo === "number" && Number.isFinite(body.kilo)
    ? body.kilo
    : null;

  return { date, kilo };
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

    const csrfToken = req.headers.get("x-csrf-token");
    const cookieSessionId = getCookie(req);

    if (!csrfToken) {
      return jsonResponse({ message: "Missing CSRF token" }, 401, corsHeaders);
    }

    if (!cookieSessionId || !isValidUuid(cookieSessionId)) {
      return jsonResponse(
        { message: "Invalid or missing session cookie" },
        401,
        corsHeaders,
      );
    }

    let body: AddPotatoBody;
    try {
      body = await req.json();
    } catch {
      return jsonResponse({ message: "Invalid JSON body" }, 400, corsHeaders);
    }

    const { date, kilo } = normalizeEntry(body);
    if (!date || kilo === null) {
      return jsonResponse(
        { message: "Request body must include date and kilo" },
        400,
        corsHeaders,
      );
    }

    const supabase = ctx.supabaseAdmin;
    const { data: storeRow, error: storeErr } = await supabase
      .from("STORES")
      .select("id, session_id, csrf_token, session_expiration")
      .eq("session_id", cookieSessionId)
      .maybeSingle<StoreColumns>();

    if (storeErr) {
      console.error("STORES lookup error:", storeErr);
      return jsonResponse(
        { message: "Unable to verify session" },
        500,
        corsHeaders,
      );
    }

    if (!storeRow) {
      return jsonResponse({ message: "Session not found" }, 401, corsHeaders);
    }

    if (storeRow.csrf_token !== csrfToken) {
      return jsonResponse({ message: "CSRF token mismatch" }, 403, corsHeaders);
    }

    const expirationTs = storeRow.session_expiration
      ? Date.parse(storeRow.session_expiration)
      : null;
    if (expirationTs !== null && Date.now() >= expirationTs) {
      return jsonResponse({ message: "Session expired" }, 401, corsHeaders);
    }

    const { data: reconciliation, error: reconciliationError } = await supabase
      .from("INVENTORY_RECONCILIATION")
      .select("id, added_potatoes")
      .eq("stores_id", storeRow.id)
      .maybeSingle<ReconciliationRow>();

    if (reconciliationError) {
      console.error(
        "INVENTORY_RECONCILIATION lookup error:",
        reconciliationError,
      );
      return jsonResponse(
        { message: "Unable to fetch reconciliation record" },
        500,
        corsHeaders,
      );
    }
    
    if (!reconciliation) {
      return jsonResponse(
        { message: "No reconciliation record found for this store" },
        404,
        corsHeaders,
      );
    }
    
    const updatedAddedPotatoes = [
      ...(reconciliation.added_potatoes ?? []),
      { date, kilo },
    ];

    const { data: updatedRow, error: updateError } = await supabase
      .from("INVENTORY_RECONCILIATION")
      .update({ added_potatoes: updatedAddedPotatoes } as never)
      .eq("id", reconciliation.id)
      .select()
      .single();

    if (updateError) {
      console.error("INVENTORY_RECONCILIATION update error:", updateError);
      return jsonResponse(
        { message: "Failed to update reconciliation" },
        500,
        corsHeaders,
      );
    }

    return jsonResponse(
      { message: "Potato record added", data: updatedRow },
      200,
      corsHeaders,
    );
  }),
};
