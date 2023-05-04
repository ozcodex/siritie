
--
--Hand crafts (inv)
--

----craft stone chopper from gravel
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:stone_chopper 1",
	items = {"nodes_nature:gravel"},
	level = 1,
	always_known = true,
})


----digging stick from sticks
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:digging_stick 1",
	items = {"tech:stick 2"},
	level = 1,
	always_known = true,
})

--
--Polished Stone
--

--grind adze
crafting.register_recipe({
	type = "grinding_stone",
	output = "tech:adze_granite",
	items = {"group:granite_cobble", 'tech:stick', 'group:fibrous_plant 4', 'nodes_nature:sand'},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "grinding_stone",
	output = "tech:adze_jade",
	items = {"group:jade_cobble", 'tech:stick', 'group:fibrous_plant 4', 'nodes_nature:sand'},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "grinding_stone",
	output = "tech:adze_basalt",
	items = {"group:basalt_cobble", 'tech:stick', 'group:fibrous_plant 4', 'nodes_nature:sand'},
	level = 1,
	always_known = true,
})


--grind club
crafting.register_recipe({
	type = "grinding_stone",
	output = "tech:stone_club",
	items = {"group:granite_cobble", 'nodes_nature:sand'},
	level = 1,
	always_known = true,
})

--
--Iron tools
--

--axe
crafting.register_recipe({
	type = "anvil",
	output = "tech:axe_iron",
	items = {'tech:iron_ingot', 'tech:stick'},
	level = 1,
	always_known = true,
})

--shovel
crafting.register_recipe({
	type = "anvil",
	output = "tech:shovel_iron",
	items = {'tech:iron_ingot', 'tech:stick'},
	level = 1,
	always_known = true,
})

--mace
crafting.register_recipe({
	type = "anvil",
	output = "tech:mace_iron",
	items = {'tech:iron_ingot 2'},
	level = 1,
	always_known = true,
})

--pickaxe
crafting.register_recipe({
	type = "anvil",
	output = "tech:pickaxe_iron",
	items = {'tech:iron_ingot 2', 'tech:stick'},
	level = 1,
	always_known = true,
})
