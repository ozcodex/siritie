----craft unlit fire from Sticks, tinder
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:small_wood_fire_unlit",
	items = { "tech:stick 6", "group:fibrous_plant 1" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "chopping_block",
	output = "tech:large_wood_fire_unlit 2",
	items = { "group:log", "group:fibrous_plant 4" },
	level = 1,
	always_known = true,
})

--
--Hand crafts (Mixing spot)
--

--ash  / block
crafting.register_recipe({
	type = "mixing_bucket",
	output = "tech:wood_ash 2",
	items = { "tech:wood_ash_block" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mixing_bucket",
	output = "tech:wood_ash_block",
	items = { "tech:wood_ash 2" },
	level = 1,
	always_known = true,
})

--charcoal  / block
crafting.register_recipe({
	type = "mixing_spot",
	output = "tech:charcoal 2",
	items = { "tech:charcoal_block" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mixing_spot",
	output = "tech:charcoal_block",
	items = { "tech:charcoal 2" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "grinding_stone",
	output = "tech:crushed_charcoal_block",
	items = { "tech:charcoal_block" },
	level = 1,
	always_known = true,
})

--fires  / block
crafting.register_recipe({
	type = "mixing_spot",
	output = "tech:small_wood_fire_unlit 2",
	items = { "tech:large_wood_fire_unlit" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mixing_spot",
	output = "tech:large_wood_fire_unlit",
	items = { "tech:small_wood_fire_unlit 2" },
	level = 1,
	always_known = true,
})
