-- The login function stores the per-session CSRF token on STORES. Keep this
-- nullable because a new session is inserted before its token is issued.
ALTER TABLE "public"."STORES"
  ADD COLUMN IF NOT EXISTS "csrf_token" "text";

-- Content verification always starts with session_id and checks expiration.
CREATE INDEX IF NOT EXISTS "STORES_session_verification_idx"
  ON "public"."STORES" ("session_id", "session_expiration")
  INCLUDE ("id")
  WHERE "csrf_token" IS NOT NULL;
