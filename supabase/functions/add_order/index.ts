import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { getCorsHeaders } from "./cors.ts";
import { getCookie, isValidUuid, jsonResponse } from "./utils.ts";

type AddOrderItem = {
  flavor?: string;
  size?: string;
  payment_method?: string;
};

type AddOrderBody = {
  orders?: AddOrderItem[];
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
    
    if (!Array.isArray(body.orders) || body.orders.length === 0) {
      return jsonResponse({ message: "orders array is required" }, 400, corsHeaders);
    }

    const allowedPaymentMethods = ["cash", "gcash", "paypal"] as const;
    const allowedSizes = ["small", "medium", "large"] as const;
    const orders = [] as Array<{ flavor: string; size: string; payment_method: string }>;
    
    for (const [index, item] of body.orders.entries()) {
      const flavor = validateString(item.flavor) ? item.flavor!.trim() : null;
      const size = validateString(item.size) ? item.size!.trim().toLowerCase() : null;
      const method = validateString(item.payment_method)
        ? item.payment_method!.trim().toLowerCase()
        : "cash";
        
      if (!flavor || !size) {
        return jsonResponse(
          { message: `Order ${index + 1} missing flavor or size` },
          400,
          corsHeaders,
        );
      }

      if (!allowedPaymentMethods.includes(method as typeof allowedPaymentMethods[number])) {
        return jsonResponse(
          { message: `Order ${index + 1} has invalid payment_method` },
          400,
          corsHeaders,
        );
      }

      if (!allowedSizes.includes(size as typeof allowedSizes[number])) {
        continue; // skip unsupported size values
      }

      orders.push({ flavor, size, payment_method: method });
    }

    if (orders.length === 0) {
      return jsonResponse({ message: "No valid orders to insert" }, 400, corsHeaders);
    }

    orders.sort((a, b) => {
      const orderMap = { small: 0, medium: 1, large: 2 } as const;
      return orderMap[a.size as keyof typeof orderMap] - orderMap[b.size as keyof typeof orderMap];
    });

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
    
    const payload = orders.map((order) => ({
      flavor: order.flavor,
      size: order.size,
      payment_method: order.payment_method,
      stores_id: storeRow.id,
    }));

    const insertResult = await supabase
      .from("SALES")
      .insert(payload as any)
      .select("id");

    const insertedRows = insertResult.data as SaleColumns[] | null;
    const insertErr = insertResult.error;

    if (insertErr || !insertedRows) {
      console.error("SALES insert error:", insertErr);
      return jsonResponse({ message: "Failed to create sale" }, 500, corsHeaders);
    }
    
    // fetch sales count breakdown by size for this store
    const sizeBreakdown = { small: 0, medium: 0, large: 0 };
    try {
      const { data: salesSizes, error: sizeErr } = await supabase
        .from("SALES")
        .select("size")
        .eq("stores_id", storeRow.id);
      
      if (sizeErr) {
        console.error("SALES size breakdown error:", sizeErr);
      } else if (salesSizes) {
        for (const sale of salesSizes as Array<{ size: string }>) {
          const sizeKey = sale.size?.trim().toLowerCase();
          if (sizeKey === "small") sizeBreakdown.small += 1;
          else if (sizeKey === "medium") sizeBreakdown.medium += 1;
          else if (sizeKey === "large") sizeBreakdown.large += 1;
        }
      }
    } catch (e) {
      console.error("SALES size breakdown unexpected error:", e);
    }
    
    return jsonResponse(
      {
        message: "Sales recorded",
        inserted: insertedRows.map((row) => row.id),
        sales_count: sizeBreakdown,
      },
      201,
      corsHeaders,
    );
  }),
};
