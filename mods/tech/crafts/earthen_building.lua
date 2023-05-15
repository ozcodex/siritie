
--
--Hand crafts (Cradting spot)
--

----craft drystack from gravel
crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:drystack 2",
	items = {"nodes_nature:gravel 3"},
	level = 1,
	always_known = true,
})

--recycle drystack with some loss
crafting.register_recipe({
	type = "brick_makers_bench",
	output = "nodes_nature:gravel",
	items = {"tech:drystack"},
	level = 1,
	always_known = true,
})


----mudbrick from clay and fibre
crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:mudbrick",
	items = {"nodes_nature:clay_wet", "group:fibrous_plant"},
	level = 1,
	always_known = true,
})

----Rammed earth by compacting clay
crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:rammed_earth 2",
	items = {"nodes_nature:clay 3"},
	level = 1,
	always_known = true,
})

--recycle rammed_earth with some loss
crafting.register_recipe({
	type = "brick_makers_bench",
	output = "nodes_nature:clay",
	items = {"tech:rammed_earth"},
	level = 1,
	always_known = true,
})
