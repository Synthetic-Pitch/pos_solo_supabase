import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { getCorsHeaders } from "./cors.ts";
import {
  buildReceipt,
  getSessionId,
  isJsonRecord,
  isNonNegativeSmallInt,
  isPriceRow,
  isValidUuid,
  jsonResponse,
  PAYMENT_METHODS,
  type ReconciliationRow,
  type SaleRow,
  type StoreSession,
} from "./utils.ts";

type SummarizeBody = {
  closing_small_cups?: unknown;
  closing_medium_cups?: unknown;
  closing_large_cups?: unknown;
  closing_potatoes?: unknown;
};

type StoreDefaultPriceRow = {
  small_cups: number;
  medium_cups: number;
  large_cups: number;
};

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
    const sessionId = getSessionId(req);
    if (!csrfToken) {
      return jsonResponse({ message: "Missing CSRF token" }, 401, corsHeaders);
    }
    if (!sessionId || !isValidUuid(sessionId)) {
      return jsonResponse(
        { message: "Invalid or missing session cookie" },
        401,
        corsHeaders,
      );
    }

    const { data: store, error: storeError } = await ctx.supabaseAdmin
      .from("STORES")
      .select("id, branch, csrf_token, session_expiration")
      .eq("session_id", sessionId)
      .maybeSingle<StoreSession>();
    if (storeError) {
      console.error("STORES lookup error:", storeError);
      return jsonResponse(
        { message: "Unable to verify session" },
        500,
        corsHeaders,
      );
    }
    if (!store) {
      return jsonResponse({ message: "Session not found" }, 401, corsHeaders);
    }
    if (store.csrf_token !== csrfToken) {
      return jsonResponse({ message: "CSRF token mismatch" }, 403, corsHeaders);
    }
    const expiration = store.session_expiration
      ? Date.parse(store.session_expiration)
      : Number.NaN;
    if (!Number.isFinite(expiration) || Date.now() >= expiration) {
      return jsonResponse({ message: "Session expired" }, 401, corsHeaders);
    }

    let body: SummarizeBody;
    try {
      const payload: unknown = await req.json();
      if (!isJsonRecord(payload)) throw new Error("Invalid body");
      body = payload;
    } catch {
      return jsonResponse({ message: "Invalid JSON body" }, 400, corsHeaders);
    }

    const closingInput = {
      small: body.closing_small_cups,
      medium: body.closing_medium_cups,
      large: body.closing_large_cups,
      potatoes: body.closing_potatoes,
    };
    if (
      !isNonNegativeSmallInt(closingInput.small) ||
      !isNonNegativeSmallInt(closingInput.medium) ||
      !isNonNegativeSmallInt(closingInput.large) ||
      !isNonNegativeSmallInt(closingInput.potatoes)
    ) {
      return jsonResponse(
        {
          message: "All closing inventory values must be non-negative integers",
        },
        400,
        corsHeaders,
      );
    }
    const closing = {
      small: closingInput.small as number,
      medium: closingInput.medium as number,
      large: closingInput.large as number,
      potatoes: closingInput.potatoes as number,
    };

    const [reconciliationResult, salesResult, storeDefaultResult] =
      await Promise.all([
        ctx.supabaseAdmin.from("INVENTORY_RECONCILIATION")
          .select(
            "id, small_cups, medium_cups, large_cups, opening_potatoes, added_cups, added_potatoes",
          )
          .eq("stores_id", store.id).maybeSingle<ReconciliationRow>(),
        ctx.supabaseAdmin.from("SALES").select("flavor, size, payment_method")
          .eq("stores_id", store.id).in("payment_method", PAYMENT_METHODS),
        ctx.supabaseAdmin.from("STORE_DEFAULT").select(
          "small_cups, medium_cups, large_cups",
        )
          .eq("branch", store.branch).maybeSingle<StoreDefaultPriceRow>(),
      ]);

    const { data: reconciliation, error: reconciliationError } =
      reconciliationResult;
    const { data: sales, error: salesError } = salesResult;
    const { data: storeDefault, error: storeDefaultError } = storeDefaultResult;
    if (reconciliationError || salesError || storeDefaultError) {
      console.error(
        "Summary lookup error:",
        reconciliationError ?? salesError ?? storeDefaultError,
      );
      return jsonResponse(
        { message: "Unable to calculate summary" },
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
    // In this database, STORE_DEFAULT holds the active prices using these names.
    const price = storeDefault && {
      small: storeDefault.small_cups,
      medium: storeDefault.medium_cups,
      large: storeDefault.large_cups,
    };
    if (!isPriceRow(price)) {
      return jsonResponse(
        {
          message: "No valid STORE_DEFAULT price values found for this branch",
        },
        404,
        corsHeaders,
      );
    }

    const { error: updateError } = await ctx.supabaseAdmin
      .from("INVENTORY_RECONCILIATION")
      .update({
        closing_small_cups: closing.small,
        closing_medium_cups: closing.medium,
        closing_large_cups: closing.large,
        closing_potatoes: closing.potatoes,
      } as never)
      .eq("id", reconciliation.id)
      .eq("stores_id", store.id);
    if (updateError) {
      console.error("INVENTORY_RECONCILIATION update error:", updateError);
      return jsonResponse(
        { message: "Unable to save closing inventory" },
        500,
        corsHeaders,
      );
    }

    return jsonResponse(
      {
        message: "Inventory summary calculated",
        receipt: buildReceipt(
          reconciliation,
          (sales ?? []) as SaleRow[],
          price,
          closing,
        ),
      },
      200,
      corsHeaders,
    );
  }),
};
