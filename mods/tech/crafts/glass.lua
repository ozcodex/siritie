-- Crafts
-- Mix sand and ash 50/50
crafting.register_recipe({
	type = "hammering_block",
	output = "tech:green_glass_mix 2",
	items = { "tech:wood_ash_block 1", "nodes_nature:sand 1" },
	level = 1,
	always_known = true,
})

-- Crafts
-- Mix sand and potash and lime approx 70/15/15 (1/2 + 1/4 sand, 1/8 pearlash, 1/8 lime )
crafting.register_recipe({
	type = "hammering_block",
	output = "tech:clear_glass_mix 8",
	items = { "tech:potash 1", "tech:quicklime 1", "nodes_nature:sand 6" },
	level = 1,
	always_known = true,
})

-- Crafts
crafting.register_recipe({
	type = "anvil",
	output = "tech:pane_tray",
	items = { "tech:iron_ingot 2" },
	level = 1,
	always_known = true,
})

-- Windows from oiled wood frames and glass panes
crafting.register_recipe({
	type = "carpentry_bench",
	output = "tech:window_green 4",
	items = { "group:log", "tech:vegetable_oil", "tech:pane_green 4" },
	level = 1,
	always_known = true,
})
crafting.register_recipe({
	type = "carpentry_bench",
	output = "tech:window_clear 4",
	items = { "group:log", "tech:vegetable_oil", "tech:pane_clear 4" },
	level = 1,
	always_known = true,
})

-- Aluminium Windows

crafting.register_recipe({
	type = "anvil",
	output = "tech:aluminium_window_green 4",
	items = { "tech:aluminium_ingot", "tech:pane_green 4" },
	level = 1,
	always_known = true,
})
crafting.register_recipe({
	type = "anvil",
	output = "tech:aluminium_window_clear 4",
	items = { "tech:aluminium_ingot", "tech:pane_clear 4" },
	level = 1,
	always_known = true,
})

-- Crafting
-- Blown from glass
-- For simplicity, crafts use charcoal as an ingredient, assuming its used for fuel somehow

crafting.register_recipe({
	type = "glass_furnace",
	output = "tech:glass_bottle_green",
	items = { "tech:green_glass_ingot", "tech:charcoal" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "glass_furnace",
	output = "tech:glass_bottle_clear",
	items = { "tech:clear_glass_ingot", "tech:charcoal" },
	level = 1,
	always_known = true,
})
