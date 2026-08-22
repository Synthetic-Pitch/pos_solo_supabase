export async function storesdefault(supabase: any, branch: string) {
  const { data, error } = await supabase
    .from("STORE_DEFAULT")
    .select("small_cups,medium_cups,large_cups,opening_cash,opening_potatoes,flavors")
    .eq("branch", branch)
    .maybeSingle();

  if (error) throw error;
  return data;
}
