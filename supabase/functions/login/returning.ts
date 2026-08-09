import type {
  AdminClient,
  ResolveStoreSessionResult,
  StoreRow,
} from "./types.ts";
import {
  getClientIp,
  getEndOfDayManila,
  getStartOfDayManila,
  isValidUuid,
} from "./utils.ts";

const STORE_COLUMNS =
  "id, session_id, session_expiration, username, branch, time_in,csrf_token";

const SESSION_IN_USE_MESSAGE =
  "This account is already active on another device. Sign in again from the device that started today's session.";

/**
 * Resolves the user's STORES session after auth succeeds.
 *
 * Single-device policy (one active session per account per day):
 *
 * Returning login (same device):
 *   cookie session_id matches today's STORES row for this username
 *   and session_expiration is still in the future.
 *
 * Fresh login (first device of the day):
 *   no active row for today → insert a new row + issue session_id cookie.
 *
 * Blocked (different device / no cookie):
 *   today's row already exists but the cookie does not match → reject.
 *   Correct password alone is not enough to take over another session.
 */
export async function resolveStoreSession(
  supabase: AdminClient,
  cookieSessionId: string | null,
  username: string,
  req: Request,
  branch: string,
): Promise<ResolveStoreSessionResult> {
  const nowIso = new Date().toISOString();
  const sessionExpiration = getEndOfDayManila().toISOString();
  const startOfDay = getStartOfDayManila().toISOString();
  const endOfDay = getEndOfDayManila().toISOString();

  // 1) Returning login — cookie proves this is the same device/session.
  if (cookieSessionId && isValidUuid(cookieSessionId)) {
    const { data, error } = await supabase
      .from("STORES")
      .select(STORE_COLUMNS)
      .eq("session_id", cookieSessionId)
      .eq("username", username)
      .gt("session_expiration", nowIso)
      .maybeSingle();

    if (error) {
      console.error("STORES returning lookup error:", error);
      return { error: "Unable to verify store session." };
    }

    if (data) {
      return {
        sessionId: data.session_id,
        isReturning: true,
        store: data as StoreRow,
      };
    }
  }
  
  // 2) No valid returning session — only allow a fresh row if none exists today.
  const { data: existingToday, error: todayLookupError } = await supabase
    .from("STORES")
    .select("id, session_id")
    .eq("username", username)
    .gte("time_in", startOfDay)
    .lte("time_in", endOfDay)
    .maybeSingle();

  if (todayLookupError) {
    console.error("STORES today lookup error:", todayLookupError);
    return { error: "Unable to verify store session." };
  }

  if (existingToday) {
    // Password was correct, but this client does not hold today's session_id.
    console.warn(
      "Blocked login: account already active",
      { username, hasCookie: Boolean(cookieSessionId) },
    );
    return { blocked: true, message: SESSION_IN_USE_MESSAGE };
  }

  // 3) First login of the day — claim the single daily session slot.
  const sessionId = crypto.randomUUID();
  const ipv4 = getClientIp(req);

  const { data, error } = await supabase
    .from("STORES")
    .insert({
      time_in: nowIso,
      username,
      ipv4,
      branch,
      session_id: sessionId,
      session_expiration: sessionExpiration,
    } as never)
    .select(STORE_COLUMNS)
    .single();

  if (error || !data) {
    console.error("STORES insert error:", error);
    return { error: "Unable to create store session." };
  }

  return {
    sessionId,
    isReturning: false,
    store: data as StoreRow,
  };
}

// Keep old import name working.
export const user_returning = resolveStoreSession;
