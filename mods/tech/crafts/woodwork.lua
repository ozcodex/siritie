--primitive_wooden_chest -- see storage
crafting.register_recipe({
	type = "chopping_block",
	output = "tech:primitive_wooden_chest",
	items = {'group:log 4'},
	level = 1,
	always_known = true,
})


crafting.register_recipe({
	type = "chopping_block",
	output = "tech:wooden_water_pot",
	items = {'group:log 2'},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "carpentry_bench",
	output = "tech:wooden_chest",
	items = {'tech:iron_fittings 2', 'group:log 4', 'tech:vegetable_oil'},
	level = 1,
	always_known = true,
})


crafting.register_recipe({
	type = "carpentry_bench",
	output = "tech:wooden_ladder 4",
	items = {'group:log'},
	level = 1,
	always_known = true,
})



crafting.register_recipe({
	type = "carpentry_bench",
	output = "tech:wooden_floor_boards 4",
	items = {'group:log', 'tech:vegetable_oil'},
	level = 1,
	always_known = true,
})


crafting.register_recipe({
	type = "carpentry_bench",
	output = "tech:wooden_stairs 4",
	items = {'group:log', 'tech:vegetable_oil'},
	level = 1,
	always_known = true,
})
