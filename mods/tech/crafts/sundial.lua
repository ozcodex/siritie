--Pot from clay
crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "tech:sundial_unfired 1",
	items = {"nodes_nature:clay_wet 3"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_mixing",
	output = "nodes_nature:clay 3",
	items = {"tech:sundial_unfired 1"},
	level = 1,
	always_known = true,
})