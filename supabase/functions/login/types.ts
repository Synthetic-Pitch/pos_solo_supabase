/**
 * Structural type for the admin client from `@supabase/server`.
 * Uses duck typing so it accepts ctx.supabaseAdmin without generic conflicts
 * between JSR (@supabase/server) and esm.sh (@supabase/supabase-js) imports.
 */
export type AdminClient = {
  from: (relation: string) => any;
};

export type AccountRow = {
  email: string;
  failed_attempts: number | null;
  locked_until: string | null;
};

export type StoreRow = {
  id: number;
  session_id: string;
  session_expiration: string;
  username: string;
  branch: string;
  time_in: string;
};

export type StoreSessionResult = {
  sessionId: string;
  isReturning: boolean;
  store: StoreRow;
};

/** Credentials are valid but another device already holds today's session. */
export type StoreSessionBlocked = {
  blocked: true;
  message: string;
};

export type ResolveStoreSessionResult =
  | StoreSessionResult
  | StoreSessionBlocked
  | { error: string };
