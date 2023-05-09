--
--Hand crafts (clay shaping spot)
--

--Pot from clay
crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "tech:clay_water_pot_unfired 1",
	items = {"nodes_nature:clay_wet 4"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "nodes_nature:clay 4",
	items = {"tech:clay_water_pot_unfired 1"},
	level = 1,
	always_known = true,
})

--storage Pot from clay
crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "tech:clay_storage_pot_unfired 1",
	items = {"nodes_nature:clay_wet 6"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "nodes_nature:clay 6",
	items = {"tech:clay_storage_pot_unfired 1"},
	level = 1,
	always_known = true,
})

--oil lamp
crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "tech:clay_oil_lamp_unfired 1",
	items = {"nodes_nature:clay_wet"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "nodes_nature:clay",
	items = {"tech:clay_oil_lamp_unfired 1"},
	level = 1,
	always_known = true,
})

--Break up pots
crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "tech:broken_pottery",
	items = {"group:pottery"},
	level = 1,
	always_known = true,
})

--Combine broken pottery slabs and vice versa
crafting.register_recipe({
	type = "mixing_spot",
	output = "tech:broken_pottery_block",
	items = {"tech:broken_pottery 2"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mixing_spot",
	output = "tech:broken_pottery 2",
	items = {"tech:broken_pottery_block"},
	level = 1,
	always_known = true,
})
