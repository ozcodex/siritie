
crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "tech:cooking_pot_unfired 1",
	items = {"nodes_nature:clay_wet 4"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "nodes_nature:clay 4",
	items = {"tech:cooking_pot_unfired 1"},
	level = 1,
	always_known = true,
})
