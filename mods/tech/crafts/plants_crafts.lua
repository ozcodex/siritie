--
--Hand crafts (inv)
--

--Sticks from woody plants
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:stick 2",
	items = {"group:woody_plant"},
	level = 1,
	always_known = true,
})


--peel tubers
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:peeled_anperla",
	items = {"nodes_nature:anperla_seed"},
	level = 1,
	always_known = true,
})

--
--mortar and pestle
--

crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:peeled_anperla",
	items = {"nodes_nature:anperla_seed"},
	level = 1,
	always_known = true,
})

--mash
crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:mashed_anperla",
	items = {"tech:peeled_anperla 6"},
	level = 1,
	always_known = true,
})

--grind maraka flour
crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:maraka_flour_bitter",
	items = {'nodes_nature:maraka_nut 12'},
	level = 1,
	always_known = true,
})

--make maraka cakes
crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:maraka_bread 6",
	items = {'tech:maraka_flour'},
	level = 1,
	always_known = true,
})

--squeeze oil
crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:vegetable_oil",
	items = {'nodes_nature:vansano_seed 12'},
	level = 1,
	always_known = true,
})

--
--chopping_block
--

--sticks from tree
crafting.register_recipe({
	type = "chopping_block",
	output = "tech:stick 24",
	items = {"group:log"},
	level = 1,
	always_known = true,
})

--sticks from log slabs
crafting.register_recipe({
	type = "chopping_block",
	output = "tech:stick 12",
	items = {"group:woodslab"},
	level = 1,
	always_known = true,
})
