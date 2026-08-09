import { MANILA_TIMEZONE, SESSION_COOKIE_NAME } from "./constants.ts";

/** End of the current calendar day in Asia/Manila (23:59:59.999). */
export function getEndOfDayManila(): Date {
  const parts = new Intl.DateTimeFormat("en-CA", {
    timeZone: MANILA_TIMEZONE,
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).formatToParts(new Date());

  const year = parts.find((p) => p.type === "year")?.value;
  const month = parts.find((p) => p.type === "month")?.value;
  const day = parts.find((p) => p.type === "day")?.value;

  return new Date(`${year}-${month}-${day}T23:59:59.999+08:00`);
}

/** Start of the current calendar day in Asia/Manila (00:00:00.000). */
export function getStartOfDayManila(): Date {
  const parts = new Intl.DateTimeFormat("en-CA", {
    timeZone: MANILA_TIMEZONE,
    year: "numeric",
    month: "2-digit",
    day: "2-digit",
  }).formatToParts(new Date());

  const year = parts.find((p) => p.type === "year")?.value;
  const month = parts.find((p) => p.type === "month")?.value;
  const day = parts.find((p) => p.type === "day")?.value;

  return new Date(`${year}-${month}-${day}T00:00:00.000+08:00`);
}

export function getSecondsUntilEndOfDayManila(): number {
  const seconds = Math.floor(
    (getEndOfDayManila().getTime() - Date.now()) / 1000,
  );
  return Math.max(seconds, 1);
}

export function getClientIp(req: Request): string {
  const forwarded = req.headers.get("x-forwarded-for");
  if (forwarded) {
    return forwarded.split(",")[0].trim();
  }

  return req.headers.get("x-real-ip") ?? "unknown";
}

export function buildSessionCookie(sessionId: string): string {
  const maxAge = getSecondsUntilEndOfDayManila();
  return `${SESSION_COOKIE_NAME}=${sessionId}; Path=/; HttpOnly; SameSite=Lax; Max-Age=${maxAge}`;
}

export function isValidUuid(value: string): boolean {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i
    .test(value);
}

export async function buildCsrfCookie(
  csrfToken: string,
  sessionId: string,
  supabase: any,
): Promise<string> {
  const maxAge = getSecondsUntilEndOfDayManila();

  const { error } = await supabase
    .from("STORES")
    .update({ csrf_token: csrfToken })
    .eq("session_id", sessionId);

  if (error) {
    console.error("Error setting CSRF token:", error);
    throw new Error("Failed to create CSRF token");
  }

  return `csrf_token=${csrfToken}; Path=/; SameSite=Strict; Max-Age=${maxAge}`;
}

export function jsonResponse(
  body: Record<string, unknown>,
  status: number,
  corsHeaders: Record<string, string>,
  extraHeaders?: HeadersInit,
): Response {
  const headers = new Headers(corsHeaders);

  if (extraHeaders) {
    // Using append instead of set allows multiple "Set-Cookie" headers to coexist
    new Headers(extraHeaders).forEach((value, key) => headers.append(key, value));
  }

  return Response.json(body, { status, headers });
}
