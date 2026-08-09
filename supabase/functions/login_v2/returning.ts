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
  "id, session_id, session_expiration, username, branch, time_in, csrf_token";

const SESSION_IN_USE_MESSAGE =
  "This account is already active on another device. Sign in again from the device that started today's session.";

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
    return { blocked: true, message: SESSION_IN_USE_MESSAGE };
  }

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

export const user_returning = resolveStoreSession;
