
--wattle panels plus something to tie them on
crafting.register_recipe({
	type = "wattle_workstation",
	output = "doors:door_wattle",
	items = {"tech:wattle 2", "group:fibrous_plant 2", "tech:stick 2"},
	level = 1,
	always_known = true,
})

--wattle panels plus something to tie them on
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:trapdoor_wattle",
	items = {"tech:wattle", "group:fibrous_plant", "tech:stick"},
	level = 1,
	always_known = true,
})


--recycle with some loss
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:wattle 2",
	items = {"doors:door_wattle"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:wattle",
	items = {"tech:trapdoor_wattle"},
	level = 1,
	always_known = true,
})


--------------------
crafting.register_recipe({
	type = "carpentry_bench",
	output = "doors:door_wooden",
	items = {'tech:iron_fittings 2', 'group:log 2', 'tech:vegetable_oil'},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "carpentry_bench",
	output = "tech:trapdoor_wooden",
	items = {'tech:iron_fittings', 'group:log', 'tech:vegetable_oil'},
	level = 1,
	always_known = true,
})

-- Iron
crafting.register_recipe({
	type = "anvil",
	output = "doors:door_iron",
	items = {'tech:iron_fittings 2', 'tech:iron_ingot 4'},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "anvil",
	output = "tech:trapdoor_iron",
	items = {'tech:iron_fittings', 'tech:iron_ingot 2'},
	level = 1,
	always_known = true,
})
