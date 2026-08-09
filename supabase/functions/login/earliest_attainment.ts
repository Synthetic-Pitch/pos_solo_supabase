import type { AdminClient } from "./types.ts";
import { getEndOfDayManila, getStartOfDayManila } from "./utils.ts";

const EARLIEST_ATTAINMENT_COLUMN = "earliest-attainment";

/**
 * Records the earliest login time for the current Manila calendar day.
 * Updates only when login is earlier than the stored value (or when starting a new day).
 */
export async function recordEarliestAttainment(
  supabase: AdminClient,
  email: string,
  loginTime: Date = new Date(),
): Promise<boolean> {
  const { data: account, error: fetchError } = await supabase
    .from("ACCOUNTS")
    .select(`email, ${EARLIEST_ATTAINMENT_COLUMN}`)
    .eq("email", email)
    .maybeSingle();

  if (fetchError || !account) {
    console.error("Failed to fetch account for earliest-attainment:", fetchError);
    return false;
  }

  const loginIso = loginTime.toISOString();
  const startOfDay = getStartOfDayManila();
  const endOfDay = getEndOfDayManila();
  const stored = account[EARLIEST_ATTAINMENT_COLUMN] as string | null;

  if (stored) {
    const storedTime = new Date(stored);
    const isFromToday = storedTime >= startOfDay && storedTime <= endOfDay;

    // Already recorded an earlier (or equal) login today — keep it.
    if (isFromToday && loginTime >= storedTime) {
      return true;
    }
  }

  const { error: updateError } = await supabase
    .from("ACCOUNTS")
    .update({ [EARLIEST_ATTAINMENT_COLUMN]: loginIso } as never)
    .eq("email", email);

  if (updateError) {
    console.error("Failed to update earliest-attainment:", updateError);
    return false;
  }

  return true;
}
