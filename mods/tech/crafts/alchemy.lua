crafting.register_recipe({
	type = "pottery_wheel",
	output = "tech:alembic_unfired 1",
	items = {"nodes_nature:clay_wet 5", "tech:stick 2"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_mixing",
	output = "nodes_nature:clay 5",
	items = {"tech:alembic_unfired"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:mashed_wiha 1",
	items = {"nodes_nature:wiha 12"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:wiha_must_pot 1",
	items = {"tech:mashed_wiha","nodes_nature:nebiyi 6","tech:clay_water_pot_freshwater"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "hammering_block",
	output = "tech:crushed_basalt",
	items = {"group:basalt_cobble 8"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "hammering_block",
	output = "tech:crushed_gneiss",
	items = {"group:gneiss_cobble 8"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "grinding_stone",
	output = "tech:quartz_powder",
	items = {"tech:crushed_gneiss"},
	level = 1,
	always_known = true,
})
