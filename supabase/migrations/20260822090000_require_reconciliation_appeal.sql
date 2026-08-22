-- Every reconciliation must permanently record an opening-cash appeal decision.
UPDATE "public"."INVENTORY_RECONCILIATION"
SET "appeal" = jsonb_build_object(
  'opening_cash', false,
  'date', to_char(("created_at" AT TIME ZONE 'Asia/Manila')::date, 'FMDD-FMMM-YY')
)
WHERE "appeal" IS NULL;

ALTER TABLE "public"."INVENTORY_RECONCILIATION"
  ALTER COLUMN "appeal" SET DEFAULT jsonb_build_object(
    'opening_cash', false,
    'date', to_char((CURRENT_TIMESTAMP AT TIME ZONE 'Asia/Manila')::date, 'FMDD-FMMM-YY')
  ),
  ALTER COLUMN "appeal" SET NOT NULL;
