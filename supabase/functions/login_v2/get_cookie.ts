import { SESSION_COOKIE_NAME } from "./constants.ts";

export function getCookie(req: Request, cookieName = SESSION_COOKIE_NAME): string | null {
  const cookieHeader = req.headers.get("cookie");
  if (!cookieHeader) {
    return null;
  }

  const legacyName = "session_Id";
  const cookies = cookieHeader.split(";").map((cookie) => cookie.trim());

  for (const cookie of cookies) {
    const separatorIndex = cookie.indexOf("=");
    if (separatorIndex === -1) {
      continue;
    }

    const name = cookie.slice(0, separatorIndex);
    const rawValue = cookie.slice(separatorIndex + 1);

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
