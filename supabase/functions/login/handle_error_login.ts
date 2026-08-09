import { LOCK_DURATION_MS, MAX_FAILED_ATTEMPTS } from "./constants.ts";
import type { AccountRow, AdminClient } from "./types.ts";

function formatLockMessage(lockedUntil: Date): string {
  const retryAt = lockedUntil.toLocaleTimeString("en-PH", {
    hour: "2-digit",
    minute: "2-digit",
    timeZone: "Asia/Manila",
  });

  return `Too many failed attempts. Try again after ${retryAt} (PH time).`;
}

async function fetchAccount(
  supabase: AdminClient,
  email: string,
): Promise<AccountRow | null> {
  const { data, error } = await supabase
    .from("ACCOUNTS")
    .select("email, failed_attempts, locked_until")
    .eq("email", email)
    .maybeSingle();

  if (error || !data) {
    return null;
  }

  return data as AccountRow;
}

/**
 * Block login when the account is still locked.
 * Call this before attempting Supabase Auth.
 */
export async function checkAccountLock(
  supabase: AdminClient,
  email: string,
): Promise<string | null> {
  const account = await fetchAccount(supabase, email);
  if (!account) {
    return null;
  }

  if (!account.locked_until) {
    return null;
  }

  const lockedUntil = new Date(account.locked_until);
  const now = new Date();

  if (lockedUntil > now) {
    return formatLockMessage(lockedUntil);
  }

  // Lock expired — clear it so the user can try again.
  await supabase
    .from("ACCOUNTS")
    .update({
      locked_until: null,
      failed_attempts: 0,
    } as never)
    .eq("email", email);

  return null;
}

/**
 * Runs after Supabase Auth rejects the password.
 * Tracks failed attempts and locks the account after MAX_FAILED_ATTEMPTS.
 */
export async function handleFailedLogin(
  supabase: AdminClient,
  email: string,
): Promise<string> {
  const account = await fetchAccount(supabase, email);

  // Same message whether the email exists or not (security best practice).
  if (!account) {
    return "Invalid credentials";
  }

  const now = new Date();

  if (account.locked_until) {
    const lockedUntil = new Date(account.locked_until);
    if (lockedUntil > now) {
      return formatLockMessage(lockedUntil);
    }
  }

  const currentAttempts = Number(account.failed_attempts ?? 0);
  const nextFailedAttempts = currentAttempts + 1;

  if (nextFailedAttempts >= MAX_FAILED_ATTEMPTS) {
    const lockedUntil = new Date(now.getTime() + LOCK_DURATION_MS);

    const { error } = await supabase
      .from("ACCOUNTS")
      .update({
        locked_until: lockedUntil.toISOString(),
        failed_attempts: 0,
      } as never)
      .eq("email", account.email);

    if (error) {
      console.error("Failed to lock account:", error);
      return "Unable to process login. Please try again.";
    }

    return formatLockMessage(lockedUntil);
  }

  const { error } = await supabase
    .from("ACCOUNTS")
    .update({ failed_attempts: nextFailedAttempts } as never)
    .eq("email", account.email);

  if (error) {
    console.error("Failed to record login attempt:", error);
    return "Unable to process login. Please try again.";
  }

  const remaining = MAX_FAILED_ATTEMPTS - nextFailedAttempts;
  return `Invalid credentials. ${remaining} attempt(s) remaining.`;
}

/** Clears lock state after a successful login. */
export async function resetLoginAttempts(
  supabase: AdminClient,
  email: string,
): Promise<boolean> {
  const { error } = await supabase
    .from("ACCOUNTS")
    .update({
      failed_attempts: 0,
      locked_until: null,
    } as never)
    .eq("email", email);

  if (error) {
    console.error("Failed to reset login attempts:", error);
    return false;
  }

  return true;
}

// Keep old import name working if anything else references it.
export const handle_error_login = handleFailedLogin;
