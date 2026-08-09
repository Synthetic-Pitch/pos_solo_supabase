const ALLOWED_ORIGINS = [
  "https://point-of-sale-account-management.vercel.app",
  "http://localhost:5173",
  "http://127.0.0.1:54321",
];

export function getCorsHeaders(req: Request) {
  const origin = req.headers.get("origin");
  const allowOrigin = ALLOWED_ORIGINS.includes(origin ?? "")
    ? origin ?? ALLOWED_ORIGINS[0]
    : ALLOWED_ORIGINS[0];

  return {
    "Access-Control-Allow-Origin": allowOrigin,
    "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
    "Access-Control-Allow-Methods": "POST, OPTIONS",
    "Access-Control-Allow-Credentials": "true",
  };
}
