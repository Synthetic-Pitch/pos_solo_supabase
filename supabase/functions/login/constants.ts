/** Cookie name used by the browser and this function. Keep frontend in sync. */
export const SESSION_COOKIE_NAME = "session_id";

/** Failed logins allowed before a temporary lock. */
export const MAX_FAILED_ATTEMPTS = 5;

/** How long the account stays locked after too many failures. */
export const LOCK_DURATION_MS = 5 * 60 * 1000;

/** Business timezone for daily session expiry (11:59 PM local). */
export const MANILA_TIMEZONE = "Asia/Manila";
