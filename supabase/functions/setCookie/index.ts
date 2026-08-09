import "@supabase/functions-js/edge-runtime.d.ts";
import { SESSION_COOKIE_NAME } from "../login/constants.ts";
import { getCorsHeaders } from "../login/cors.ts";
import { getSecondsUntilEndOfDayManila } from "../login/utils.ts";

export default {
  async fetch(req: Request) {
    const corsHeaders = getCorsHeaders(req);
    const headers = new Headers(corsHeaders);
    
    const maxAgeSeconds = getSecondsUntilEndOfDayManila();
    
    headers.set(
      "set-cookie",
      `${SESSION_COOKIE_NAME}=hello_world; Path=/; HttpOnly; SameSite=Lax; Max-Age=${maxAgeSeconds}`,
    );
    
    return Response.json(
      { message: "Hello World", expiresInSeconds: maxAgeSeconds },
      { status: 200, headers }
    );
  },
};