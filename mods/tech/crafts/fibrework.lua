--------------------------------------------
--bundle
crafting.register_recipe({
	type = "spinning_wheel",
	output = "tech:unretted_cana_bundle",
	items = {'nodes_nature:cana 24'},
	level = 1,
	always_known = true,
})


--coarse. cheap.
crafting.register_recipe({
	type = "spinning_wheel",
	output = "tech:coarse_fibre 12",
	items = {'tech:retted_cana_bundle'},
	level = 1,
	always_known = true,
})


--fine. costly.
crafting.register_recipe({
	type = "spinning_wheel",
	output = "tech:fine_fibre 3",
	items = {'tech:retted_cana_bundle'},
	level = 1,
	always_known = true,
})

--coarse.
crafting.register_recipe({
	type = "loom",
	output = "tech:coarse_fabric",
	items = {'tech:coarse_fibre 6'},
	level = 1,
	always_known = true,
})


--fine.
crafting.register_recipe({
	type = "loom",
	output = "tech:fine_fabric",
	items = {'tech:fine_fibre 6'},
	level = 1,
	always_known = true,
})
