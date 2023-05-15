crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:mixing_bucket",
	items = {"tech:stick 24"},
	level = 1,
	always_known = true,
})
crafting.register_recipe({
	type = "mixing_bucket",
	output = "tech:lime_mortar_bucket",
	items = {"tech:mixing_bucket", "tech:lime_mortar"},
	level = 1,
	always_known = true,
})
crafting.register_recipe({
	type = "mixing_bucket",
	output = "tech:clay_mixing_bucket",
	items = {"tech:mixing_bucket", "nodes_nature:clay"},
	level = 1,
	always_known = true,
})