
----Wattle from sticks
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:wattle",
	items = {"tech:stick 6"},
	level = 1,
	always_known = true,
})


--recycle wattle with some loss
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:stick 4",
	items = {"tech:wattle"},
	level = 1,
	always_known = true,
})

----Loose Wattle from sticks
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:wattle_loose",
	items = {"tech:stick 3"},
	level = 1,
	always_known = true,
})

--recycle loose wattle with some loss
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:stick 2",
	items = {"tech:wattle_loose"},
	level = 1,
	always_known = true,
})

--convert loose wattle to wattle
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:wattle",
	items = {"tech:wattle_loose 2"},
	level = 1,
	always_known = true,
})

--convert wattle to loose wattle
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:wattle_loose 2",
	items = {"tech:wattle"},
	level = 1,
	always_known = true,
})

----Wattle door frame from sticks
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:wattle_door_frame",
	items = {"tech:stick 6"},
	level = 1,
	always_known = true,
})
--convert wattle to wattle door frame
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:wattle_door_frame",
	items = {"tech:wattle"},
	level = 1,
	always_known = true,
})
--convert wattle door frame to wattle
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:wattle",
	items = {"tech:wattle_door_frame"},
	level = 1,
	always_known = true,
})

----Wicker basket from sticks
crafting.register_recipe({
	type = "wattle_workstation",
	output = "tech:wicker_storage_basket",
	items = {"tech:stick 96"},
	level = 1,
	always_known = true,
})
