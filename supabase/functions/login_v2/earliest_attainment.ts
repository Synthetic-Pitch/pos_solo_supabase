import type { AdminClient, AccountRow } from "./types.ts";
import { getEndOfDayManila, getStartOfDayManila } from "./utils.ts";

const EARLIEST_ATTAINMENT_COLUMN = "earliest-attainment";

export async function recordEarliestAttainment(
  supabase: AdminClient,
  email: string,
  account: AccountRow | null,
  loginTime: Date = new Date(),
): Promise<boolean> {
  let stored: string | null = null;

  if (account) {
    stored = account[EARLIEST_ATTAINMENT_COLUMN] as string | null;
  }

  if (!account || stored === undefined) {
    const { data, error } = await supabase
      .from("ACCOUNTS")
      .select(`${EARLIEST_ATTAINMENT_COLUMN}`)
      .eq("email", email)
      .maybeSingle();

    if (error || !data) {
      console.error("Failed to fetch account for earliest-attainment:", error);
      return false;
    }

    stored = data[EARLIEST_ATTAINMENT_COLUMN] as string | null;
  }

  const startOfDay = getStartOfDayManila();
  const endOfDay = getEndOfDayManila();

  if (stored) {
    const storedTime = new Date(stored);
    const isFromToday = storedTime >= startOfDay && storedTime <= endOfDay;
    if (isFromToday && loginTime >= storedTime) {
      return true;
    }
  }

  const { error: updateError } = await supabase
    .from("ACCOUNTS")
    .update({ [EARLIEST_ATTAINMENT_COLUMN]: loginTime.toISOString() } as never)
    .eq("email", email);
  
  if (updateError) {;
    console.error("Failed to update earliest-attainment:", updateError);
    return false;
  }

  return true;
}
