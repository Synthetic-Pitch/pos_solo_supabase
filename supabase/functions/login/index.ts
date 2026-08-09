import "@supabase/functions-js/edge-runtime.d.ts";
import { withSupabase } from "@supabase/server";
import { getCorsHeaders } from "./cors.ts";
import { createAuthClient } from "./createAuthClient.ts";
import { getCookie } from "./get_cookie.ts";
import {
  checkAccountLock,
  handleFailedLogin,
  resetLoginAttempts,
} from "./handle_error_login.ts";
import { recordEarliestAttainment } from "./earliest_attainment.ts";
import { resolveStoreSession } from "./returning.ts";
import { buildSessionCookie, jsonResponse,buildCsrfCookie } from "./utils.ts";
import { storesdefault,price } from "./storesdefault_price.ts";

type LoginBody = {
  username?: string;
  password?: string;
  branch?: string;
};

export default {
  fetch: withSupabase({ auth: ["publishable", "secret"] }, async (req, ctx) => {
    const corsHeaders = getCorsHeaders(req);

    if (req.method === "OPTIONS") {
      return new Response(null, { headers: corsHeaders });
    }

    if (req.method !== "POST") {
      return jsonResponse(
        { message: "Method not allowed" },
        405,
        corsHeaders,
      );
    }

    let body: LoginBody;
    try {
      body = await req.json();
    } catch {
      return jsonResponse(
        { message: "Invalid JSON body" },
        400,
        corsHeaders,
      );
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

    // 1) Reject locked accounts before checking the password.
    const lockMessage = await checkAccountLock(supabase, username);
    if (lockMessage) {
      return jsonResponse({ message: lockMessage }, 401, corsHeaders);
    }

    // 2) Verify credentials with Supabase Auth (anon client only).
    const authClient = createAuthClient();
    const { data: loginData, error: authError } = await authClient.auth
      .signInWithPassword({
        email: username,
        password,
      });

    if (authError || !loginData.user) {
      const message = await handleFailedLogin(supabase, username);
      return jsonResponse({ message }, 401, corsHeaders);
    }
    // If the user is an admin, return a welcome message and the role ended.
    if (loginData.user.app_metadata.role === "admin") {
      await recordEarliestAttainment(supabase, username);
      return jsonResponse(
        { message: `Welcome Sir ${username}!`, role: loginData.user.app_metadata.role },
        200,
        corsHeaders,
      );
    }
    // 3) Successful auth — clear failed attempts / lock.
    const resetOk = await resetLoginAttempts(supabase, username);
    if (!resetOk) {
      return jsonResponse(
        { message: "Login failed while updating account state" },
        500,
        corsHeaders,
      );
    }

    // 4) Returning vs fresh store session (daily token).
    const storeSession = await resolveStoreSession(
      supabase,
      cookieSessionId,
      username,
      req,
      branch,
    );

    if ("blocked" in storeSession) {
      return jsonResponse({ message: storeSession.message }, 403, corsHeaders);
    }
    
    if ("error" in storeSession) {
      return jsonResponse({ message: storeSession.error }, 500, corsHeaders);
    }
    
    await recordEarliestAttainment(supabase, username);
    const Stores_default = await storesdefault(supabase, branch);
    const Price = await price(supabase,branch);
    
    const csrfToken = crypto.randomUUID();
    const responseHeaders = new Headers();
    responseHeaders.append("Set-Cookie", buildSessionCookie(storeSession.sessionId));
    responseHeaders.append(
      "Set-Cookie",
      await buildCsrfCookie(csrfToken, storeSession.sessionId, supabase),
    );

    return jsonResponse(
      {
        message: "Login successful",
        email: loginData.user.email,
        isReturning: storeSession.isReturning,
        role:loginData.user.app_metadata.role,
        stores_default:Stores_default,
        price:Price
      },
      200,
      corsHeaders,
      responseHeaders,
    );
  }),
};
