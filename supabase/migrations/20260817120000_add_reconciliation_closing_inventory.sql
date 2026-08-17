ALTER TABLE "public"."INVENTORY_RECONCILIATION"
  ADD COLUMN IF NOT EXISTS "closing_small_cups" smallint,
  ADD COLUMN IF NOT EXISTS "closing_medium_cups" smallint,
  ADD COLUMN IF NOT EXISTS "closing_large_cups" smallint,
  ADD COLUMN IF NOT EXISTS "closing_potatoes" smallint;
