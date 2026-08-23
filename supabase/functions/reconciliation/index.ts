import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { getCorsHeaders } from "./cors.ts";

interface ReconciliationBody {
  small_cups?: number;
  medium_cups?: number;
  large_cups?: number;
  opening_cash?: number;
  opening_potatoes?: number;
  appeal?: Record<string, unknown>;
  added_cups?: Record<string, unknown>;
  added_potatoes?: Record<string, unknown>;
}

function defaultAppeal(): { opening_cash: false; date: string } {
  const dateParts = new Intl.DateTimeFormat("en-GB", {
    timeZone: "Asia/Manila",
    day: "numeric",
    month: "numeric",
    year: "2-digit",
  }).formatToParts(new Date());

  const day = dateParts.find((part) => part.type === "day")?.value;
  const month = dateParts.find((part) => part.type === "month")?.value;
  const year = dateParts.find((part) => part.type === "year")?.value;

  return { opening_cash: false, date: `${day}-${month}-${year}` };
}

export default {
  fetch: withSupabase({ auth: ["publishable"] }, async (req, ctx) => {
    const corsHeaders = getCorsHeaders(req);

    if (req.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders });
    }

    const csrfToken = req.headers.get("x-csrf-token");

    const session_id = req.headers
      .get("Cookie")
      ?.split(";")
      .find((cookie) => cookie.trim().startsWith("session_id="))
      ?.split("=")[1];

    if (!session_id || !csrfToken) {
      return Response.json(
        { message: "No session_id/CSRF token found" },
        { status: 400, headers: corsHeaders },
      );
    }

    const body: ReconciliationBody = await req.json();

    const supabase = ctx.supabaseAdmin as any;

    // Validate session
    const { data: store, error: storeError } = await supabase
      .from("STORES")
      .select("csrf_token, session_id, session_expiration, id")
      .eq("session_id", session_id)
      .maybeSingle();
    
    if (storeError || !store) {
      return Response.json(
        { message: "Invalid session_id/CSRF token" },
        { status: 401, headers: corsHeaders },
      );
    }

    if (store.csrf_token !== csrfToken || store.session_id !== session_id) {
      return Response.json(
        { message: "CSRF token/Session ID mismatch" },
        { status: 403, headers: corsHeaders },
      );
    }

    // Check if a reconciliation row already exists for this store
    const { data: existing, error: existingError } = await supabase
      .from("INVENTORY_RECONCILIATION")
      .select("id, appeal, added_cups, added_potatoes")
      .eq("stores_id", store.id)
      .maybeSingle();

    if (existingError) {
      return Response.json(
        {
          message: "Failed to check existing record",
          error: existingError.message,
        },
        { status: 500, headers: corsHeaders },
      );
    }

    if (existing) {
      // UPDATE path: append additions only. Appeal records the original opening
      // decision and must not be overwritten by later calls from the same session.
      const updatedAddedCups = body.added_cups
        ? [...(existing.added_cups ?? []), body.added_cups]
        : existing.added_cups;

      const updatedAddedPotatoes = body.added_potatoes
        ? [...(existing.added_potatoes ?? []), body.added_potatoes]
        : existing.added_potatoes;

      // Backfill old reconciliation rows that were created before appeal became
      // mandatory. Once stored, its value remains immutable through this API.
      const appeal = existing.appeal ?? defaultAppeal();

      const { data: updateData, error: updateError } = await supabase
        .from("INVENTORY_RECONCILIATION")
        .update({
          added_cups: updatedAddedCups,
          added_potatoes: updatedAddedPotatoes,
          appeal,
        })
        .eq("id", existing.id)
        .select()
        .single();

      if (updateError) {
        return Response.json(
          { message: "Update failed", error: updateError.message },
          { status: 500, headers: corsHeaders },
        );
      }

      return Response.json(
        { message: "Inventory reconciliation updated", data: updateData },
        { status: 200, headers: corsHeaders },
      );
    }

    // INSERT path: first entry of the day, requires opening fields
    if (
      body.small_cups == null ||
      body.medium_cups == null ||
      body.large_cups == null ||
      body.opening_cash == null ||
      body.opening_potatoes == null
    ) {
      return Response.json(
        { message: "Missing required opening fields" },
        { status: 400, headers: corsHeaders },
      );
    }

    const { data: insertData, error: insertError } = await supabase
      .from("INVENTORY_RECONCILIATION")
      .insert({
        small_cups: body.small_cups,
        medium_cups: body.medium_cups,
        large_cups: body.large_cups,
        opening_cash: body.opening_cash,
        opening_potatoes: body.opening_potatoes,
        // Always record an opening decision. A client that omits appeal receives
        // the default, preventing a later request from adding/replacing it.
        appeal: body.appeal ?? defaultAppeal(),
        added_cups: body.added_cups ? [body.added_cups] : null,
        added_potatoes: body.added_potatoes ? [body.added_potatoes] : null,
        stores_id: store.id,
      })
      .select()
      .single();

    if (insertError) {
      return Response.json(
        { message: "Insert failed", error: insertError.message },
        { status: 500, headers: corsHeaders },
      );
    }

    return Response.json(
      { message: "Inventory reconciliation recorded", data: insertData },
      { status: 201, headers: corsHeaders },
    );
  }),
};
