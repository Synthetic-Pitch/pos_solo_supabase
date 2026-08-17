export type StoreSession = {
  id: number;
  branch: string;
  csrf_token: string | null;
  session_expiration: string | null;
};

export type ReconciliationRow = {
  id: number;
  small_cups: number;
  medium_cups: number;
  large_cups: number;
  opening_potatoes: number;
  added_cups: unknown;
  added_potatoes: unknown;
};

export type SaleRow = { flavor: string; size: string; payment_method: string };
export type PriceRow = { small: number; medium: number; large: number };

type CupSize = "small" | "medium" | "large";
type PaymentMethod = "cash" | "gcash" | "paypal";
type CupTotals = Record<CupSize, number>;
type PaymentTotals = Record<PaymentMethod, number>;
type JsonRecord = Record<string, unknown>;

export const PAYMENT_METHODS: readonly PaymentMethod[] = ["cash", "gcash", "paypal"];

const emptyCupTotals = (): CupTotals => ({ small: 0, medium: 0, large: 0 });
const emptyPaymentTotals = (): PaymentTotals => ({ cash: 0, gcash: 0, paypal: 0 });

export function getSessionId(req: Request): string | null {
  const cookieHeader = req.headers.get("cookie");
  if (!cookieHeader) return null;

  for (const cookie of cookieHeader.split(";")) {
    const [name, ...valueParts] = cookie.trim().split("=");
    if (name !== "session_id" && name !== "session_Id") continue;
    const value = valueParts.join("=");
    if (!value) return null;
    try {
      return decodeURIComponent(value);
    } catch {
      return value;
    }
  }
  return null;
}

export function isValidUuid(value: string): boolean {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(value);
}

export function isNonNegativeSmallInt(value: unknown): value is number {
  return typeof value === "number" && Number.isInteger(value) && value >= 0 && value <= 32_767;
}

export function isJsonRecord(value: unknown): value is JsonRecord {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

export function jsonResponse(
  body: Record<string, unknown>,
  status: number,
  corsHeaders: Record<string, string>,
): Response {
  return Response.json(body, { status, headers: corsHeaders });
}

function totalAddedCups(entries: unknown): CupTotals {
  const totals = emptyCupTotals();
  if (!Array.isArray(entries)) return totals;
  for (const entry of entries) {
    if (!isJsonRecord(entry) || !isNonNegativeSmallInt(entry.quantity)) continue;
    const size = typeof entry.cups_size === "string"
      ? entry.cups_size.trim().toLowerCase()
      : typeof entry.cup_size === "string" ? entry.cup_size.trim().toLowerCase() : "";
    if (size === "small" || size === "medium" || size === "large") totals[size] += entry.quantity;
  }
  return totals;
}

function totalAddedPotatoes(entries: unknown): number {
  if (!Array.isArray(entries)) return 0;
  return entries.reduce((total, entry) =>
    isJsonRecord(entry) && typeof entry.kilo === "number" && Number.isFinite(entry.kilo) && entry.kilo >= 0
      ? total + entry.kilo
      : total, 0);
}

export function buildReceipt(
  reconciliation: ReconciliationRow,
  sales: SaleRow[],
  price: PriceRow,
  closing: CupTotals & { potatoes: number },
) {
  const addedCups = totalAddedCups(reconciliation.added_cups);
  const addedPotatoes = totalAddedPotatoes(reconciliation.added_potatoes);
  const payments = Object.fromEntries(PAYMENT_METHODS.map((method) => [method, {
    small_fries: 0, medium_fries: 0, large_fries: 0, total_sales: 0, earned: 0,
  }])) as Record<PaymentMethod, {
    small_fries: number; medium_fries: number; large_fries: number; total_sales: number; earned: number;
  }>;
  const flavors = new Map<string, { total_sales: number; revenue: number; payments: PaymentTotals }>();
  let totalSales = 0;
  let totalRevenue = 0;

  for (const sale of sales) {
    const size = sale.size.trim().toLowerCase();
    const paymentMethod = sale.payment_method.trim().toLowerCase() as PaymentMethod;
    const flavor = sale.flavor.trim();
    if ((size !== "small" && size !== "medium" && size !== "large") || !PAYMENT_METHODS.includes(paymentMethod) || !flavor) continue;
    const amount = price[size];
    const payment = payments[paymentMethod];
    payment[`${size}_fries`] += 1;
    payment.total_sales += 1;
    payment.earned += amount;
    totalSales += 1;
    totalRevenue += amount;
    const flavorSummary = flavors.get(flavor) ?? { total_sales: 0, revenue: 0, payments: emptyPaymentTotals() };
    flavorSummary.total_sales += 1;
    flavorSummary.revenue += amount;
    flavorSummary.payments[paymentMethod] += 1;
    flavors.set(flavor, flavorSummary);
  }

  return {
    inventory_left: { small_cups: closing.small, medium_cups: closing.medium, large_cups: closing.large, potatoes: closing.potatoes },
    inventory_movement: {
      small_cups: { opening: reconciliation.small_cups, added: addedCups.small, sold: reconciliation.small_cups + addedCups.small - closing.small },
      medium_cups: { opening: reconciliation.medium_cups, added: addedCups.medium, sold: reconciliation.medium_cups + addedCups.medium - closing.medium },
      large_cups: { opening: reconciliation.large_cups, added: addedCups.large, sold: reconciliation.large_cups + addedCups.large - closing.large },
      potatoes: { opening: reconciliation.opening_potatoes, added: addedPotatoes, sold: reconciliation.opening_potatoes + addedPotatoes - closing.potatoes },
    },
    payments,
    flavors: [...flavors.entries()].map(([flavor, summary]) => ({ flavor, ...summary }))
      .sort((a, b) => b.total_sales - a.total_sales || a.flavor.localeCompare(b.flavor)),
    total_sales: totalSales,
    total_revenue: totalRevenue,
  };
}
