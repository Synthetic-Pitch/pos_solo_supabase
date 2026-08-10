const SESSION_COOKIE_NAME = "session_id";

export function getCookie(req: Request, cookieName = SESSION_COOKIE_NAME): string | null {
  const cookieHeader = req.headers.get("cookie");
  if (!cookieHeader) return null;

  const legacyName = "session_Id";
  const cookies = cookieHeader.split(";").map((c) => c.trim());

  for (const cookie of cookies) {
    const idx = cookie.indexOf("=");
    if (idx === -1) continue;
    const name = cookie.slice(0, idx);
    const rawValue = cookie.slice(idx + 1);
    if (name === cookieName || name === legacyName) {
      try {
        return decodeURIComponent(rawValue);
      } catch {
        return rawValue;
      }
    }
  }

  return null;
}

export function isValidUuid(value: string): boolean {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(value);
}

export function jsonResponse(
  body: Record<string, unknown>,
  status: number,
  corsHeaders: Record<string, string>,
  extraHeaders?: HeadersInit,
): Response {
  const headers = new Headers(corsHeaders);
  if (extraHeaders) {
    new Headers(extraHeaders).forEach((v, k) => headers.append(k, v));
  }
  return Response.json(body, { status, headers });
}
