
--sleeping_spot is free
crafting.register_recipe({
	type = "inv",
	output = "tech:sleeping_spot",
	items = {},
	level = 1,
	always_known = true,
})


--sleeping_mat from cheap thatch
crafting.register_recipe({
	type = "weaving_frame",
	output = "tech:sleeping_mat",
	items = {"tech:thatch"},
	level = 1,
	always_known = true,
})

--Primitve bed from sticks and mats
crafting.register_recipe({
	type = "weaving_frame",
	output = "tech:primitive_bed",
	items = {"tech:sleeping_mat 4", "tech:stick 36"},
	level = 1,
	always_known = true,
})




--Mattress from fine fabric stuffed with fine fibre
crafting.register_recipe({
	type = "loom",
	output = "tech:mattress",
	items = {"tech:fine_fabric 6", "tech:coarse_fibre 24"},
	level = 1,
	always_known = true,
})

--Bed, nice wood frame, mattress
crafting.register_recipe({
	type = "carpentry_bench",
	output = "tech:bed",
	items = {"tech:mattress", "group:log 4", "tech:vegetable_oil"},
	level = 1,
	always_known = true,
})
