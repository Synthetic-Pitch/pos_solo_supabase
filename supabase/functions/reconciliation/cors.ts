
const ALLOWED_ORIGINS = [
  "https://pos-solo-frontend.vercel.app/", // production
  "http://localhost:5173","http://127.0.0.1:54321"       // local dev (Vite default port)
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