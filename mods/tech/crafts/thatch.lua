
----Thatch from  fibre
crafting.register_recipe({
	type = "weaving_frame",
	output = "tech:thatch",
	items = {"group:fibrous_plant 8"},
	level = 1,
	always_known = true,
})

----woven basket from fibrous_plant
crafting.register_recipe({
	type = "weaving_frame",
	output = "tech:woven_storage_basket",
	items = {"group:fibrous_plant 96"},
	level = 1,
	always_known = true,
})
