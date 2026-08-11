SELECT array_agg(column_name ORDER BY ordinal_position)
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'INVENTORY_RECONCILIATION';