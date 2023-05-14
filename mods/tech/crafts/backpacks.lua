----woven from fibrous_plant
crafting.register_recipe({
	type = "weaving_frame",
	output = "backpacks:backpack_woven_bag 1",
	items = {"group:fibrous_plant 48"},
	level = 1,
	always_known = true,
})

----wicker from sticks
crafting.register_recipe({
	type = "wattle_workstation",
	output = "backpacks:backpack_wicker_bag 1",
	items = {"tech:stick 48"},
	level = 1,
	always_known = true,
})

----fabric from...fabric
crafting.register_recipe({
	type = "loom",
	output = "backpacks:backpack_fabric_bag 1",
	items = {"tech:coarse_fabric 6"},
	level = 1,
	always_known = true,
})
