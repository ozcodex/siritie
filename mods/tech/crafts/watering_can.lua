-- clay watering
crafting.register_recipe({
	type = "pottery_wheel",
	output = "tech:clay_watering_can_unfired 1",
	items = {"nodes_nature:clay_wet 5"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_mixing",
	output = "nodes_nature:clay 5",
	items = {"tech:clay_watering_can_unfired 1"},
	level = 1,
	always_known = true,
})