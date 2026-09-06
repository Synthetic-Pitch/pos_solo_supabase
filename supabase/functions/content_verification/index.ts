import "@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const ALLOWED_ORIGINS = new Set([
  "https://pos-solo-frontend.vercel.app",
  "http://localhost:5173",
  "http://127.0.0.1:54321",
]);

const SESSION_ID_PATTERN =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

const supabaseUrl = Deno.env.get("SUPABASE_URL");
const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY");
if (!supabaseUrl || !serviceRoleKey) {
  throw new Error("Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY");
}

// This key stays inside the Edge Function and is never sent to the client.
const supabaseAdmin = createClient(supabaseUrl, serviceRoleKey, {
  auth: { autoRefreshToken: false, persistSession: false },
});

function getCorsHeaders(request: Request): Headers {
  const headers = new Headers({
    "Access-Control-Allow-Credentials": "true",
    "Access-Control-Allow-Headers": "x-csrf-token",
    "Access-Control-Allow-Methods": "GET, OPTIONS",
    "Cache-Control": "no-store",
    "Vary": "Origin",
  });

  const origin = request.headers.get("origin");
  if (origin && ALLOWED_ORIGINS.has(origin)) {
    headers.set("Access-Control-Allow-Origin", origin);
  }

  return headers;
}

function response(
  request: Request,
  body: Record<string, unknown>,
  status: number,
): Response {
  return Response.json(body, { status, headers: getCorsHeaders(request) });
}

/** Returns the sole session_id cookie, rejecting ambiguous duplicate values. */
function getSessionId(request: Request): string | null {
  const cookieHeader = request.headers.get("cookie");
  if (!cookieHeader) return null;
  
  let sessionId: string | null = null;
  for (const part of cookieHeader.split(";")) {
    const separator = part.indexOf("=");
    if (separator < 1 || part.slice(0, separator).trim() !== "session_id") {
      continue;
    }

    if (sessionId !== null) return null;
    const value = part.slice(separator + 1).trim();
    try {
      sessionId = decodeURIComponent(value);
    } catch {
      return null;
    }
  }
  
  return sessionId;
}

Deno.serve(async (req) => {
  const origin = req.headers.get("origin");
  if (origin && !ALLOWED_ORIGINS.has(origin)) {
    return response(req, { message: "Origin not allowed" }, 403);
  }

  // Browsers preflight a credentialed GET containing x-csrf-token.
  if (req.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: getCorsHeaders(req) });
  }
  if (req.method !== "GET") {
    const headers = getCorsHeaders(req);
    headers.set("Allow", "GET, OPTIONS");
    return Response.json({ message: "Method not allowed" }, {
      status: 405,
      headers,
    });
  }

  const sessionId = getSessionId(req);
  const csrfToken = req.headers.get("x-csrf-token");
  if (
    !sessionId ||
    !SESSION_ID_PATTERN.test(sessionId) ||
    !csrfToken
  ) {
    return response(req, { valid: false, message: "Invalid session" }, 401);
  }

  // Keep every authorization condition in the query. This returns no store data
  // and prevents an expired or mismatched session from being considered valid.
  const { data: store, error } = await supabaseAdmin
    .from("STORES")
    .select("id")
    .eq("session_id", sessionId)
    .eq("csrf_token", csrfToken)
    .gt("session_expiration", new Date().toISOString())
    .maybeSingle();

  if (error) {
    console.error("Content verification lookup failed:", error);
    return response(req, { message: "Unable to verify session" }, 500);
  }
  if (!store) {
    return response(req, { valid: false, message: "Invalid session" }, 401);
  }

  return response(req, { valid: true }, 200);
});
