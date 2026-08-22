import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { getCorsHeaders } from "./cors.ts";
import { createAuthClient } from "./createAuthClient.ts";
import { getCookie } from "./get_cookie.ts";
import {
  checkAccountLock,
  fetchAccountState,
  handleFailedLogin,
  resetLoginAttempts,
} from "./handle_error_login.ts";
import { recordEarliestAttainment } from "./earliest_attainment.ts";
import { resolveStoreSession } from "./returning.ts";
import { buildSessionCookie, jsonResponse, buildCsrfCookie } from "./utils.ts";
import { storesdefault } from "./storesdefault_price.ts";

const DEBUG = Deno.env.get("DEBUG_LOGIN") === "true";

type LoginBody = {
  username?: string;
  password?: string;
  branch?: string;
};

async function fetchSales(supabase: any, storeId: number): Promise<unknown[]> {
  const { data, error } = await supabase
    .from("SALES")
    .select("*")
    .eq("stores_id", storeId)
    .order("created_at", { ascending: true });

  if (error) {
    console.error("SALES lookup error:", error);
    return [];
  }

  return data ?? [];
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

    let body: LoginBody;
    try {
      body = await req.json();
    } catch {
      return jsonResponse({ message: "Invalid JSON body" }, 400, corsHeaders);
    }
    
    const username = body.username?.trim().toLowerCase();
    const password = body.password;
    const branch = body.branch?.trim();
    
    if (!username || !password || !branch) {
      return jsonResponse(
        { message: "username, password, and branch are required" },
        400,
        corsHeaders,
      );
    }

    const supabase = ctx.supabaseAdmin;
    const cookieSessionId = getCookie(req);
    const tStart = performance.now();

    const account = await fetchAccountState(supabase, username);

    const lockMessage = await checkAccountLock(supabase, username, account);
    if (lockMessage) {
      return jsonResponse({ message: lockMessage }, 401, corsHeaders);
    }

    const tBeforeAuth = performance.now();
    const authClient = createAuthClient();
    const { data: loginData, error: authError } = await authClient.auth
      .signInWithPassword({ email: username, password });
    const tAfterAuth = performance.now();

    if (authError || !loginData.user) {
      const message = await handleFailedLogin(supabase, username, account);
      return jsonResponse({ message }, 401, corsHeaders);
    }

    if (loginData.user.app_metadata.role === "admin") {
      (async () => {
        try {
          await recordEarliestAttainment(supabase, username, account);
        } catch (e) {
          console.error("earliest-attainment background error:", e);
        }
      })();

      return jsonResponse(
        { message: `Welcome Sir ${username}!`, role: loginData.user.app_metadata.role },
        200,
        corsHeaders,
      );
    }

    const resetOk = await resetLoginAttempts(supabase, username);
    if (!resetOk) {
      return jsonResponse(
        { message: "Login failed while updating account state" },
        500,
        corsHeaders,
      );
    }

    const tBeforeResolve = performance.now();
    const storeSession = await resolveStoreSession(
      supabase,
      cookieSessionId,
      username,
      req,
      branch,
    );
    const tAfterResolve = performance.now();

    if ("blocked" in storeSession) {
      return jsonResponse({ message: storeSession.message }, 403, corsHeaders);
    }

    if ("error" in storeSession) {
      return jsonResponse({ message: storeSession.error }, 500, corsHeaders);
    }
    
    (async () => {
      try {
        await recordEarliestAttainment(supabase, username, account);
      } catch (e) {
        console.error("earliest-attainment background error:", e);
      }
    })();
    
    const tBeforeFetch = performance.now();
    const [Stores_Default, Sales] = await Promise.all([
      storesdefault(supabase, branch),
      fetchSales(supabase, storeSession.store.id),
    ]);
    const tAfterFetch = performance.now();

    const csrfToken = crypto.randomUUID();
    const responseHeaders = new Headers();
    responseHeaders.append("Set-Cookie", buildSessionCookie(storeSession.sessionId));
    responseHeaders.append(
      "Set-Cookie",
      await buildCsrfCookie(csrfToken, storeSession.sessionId, supabase),
    );

    const tEnd = performance.now();

    const timings = {
      total_ms: Math.round(tEnd - tStart),
      auth_ms: Math.round((tAfterAuth ?? tEnd) - (tBeforeAuth ?? tStart)),
      resolve_store_ms: Math.round((tAfterResolve ?? tEnd) - (tBeforeResolve ?? tStart)),
      fetch_defaults_ms: Math.round((tAfterFetch ?? tEnd) - (tBeforeFetch ?? tStart)),
    };
    
    if (DEBUG) {
      return jsonResponse(
        {
          message: "Login successful",
          email: loginData.user.email,
          isReturning: storeSession.isReturning,
          role: loginData.user.app_metadata.role,
          stores_default: Stores_Default,
          sales: storeSession.isReturning ? Sales : undefined,
          debug: timings,
        },
        200,
        corsHeaders,
        responseHeaders,
      );
    }

    console.debug("login timings:", timings);

    return jsonResponse(
      {
        message: "Login successful",
        email: loginData.user.email,
        isReturning: storeSession.isReturning,
        role: loginData.user.app_metadata.role,
        stores_default: Stores_Default,
        sales: storeSession.isReturning ? Sales : undefined,
      },
      200,
      corsHeaders,
      responseHeaders,
    );
  }),
};
