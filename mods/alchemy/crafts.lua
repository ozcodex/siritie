crafting.register_recipe({
	type = "clay_shaping_spot",
	output = "alchemy:alembic_unfired 1",
	items = {"nodes_nature:clay_wet 5", "tech:stick 2"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mixing_spot",
	output = "nodes_nature:clay 5",
	items = {"alchemy:alembic_unfired"},
	level = 1,
	always_known = true,
})