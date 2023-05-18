crafting.register_recipe({
	type = "pottery_wheel",
	output = "tech:seismoscope_unfired 1",
	items = { "nodes_nature:clay_wet 7" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_mixing",
	output = "nodes_nature:clay 7",
	items = { "tech:seismoscope_unfired" },
	level = 1,
	always_known = true,
})
