--recipe
crafting.register_recipe({
	type = "hammering_block",
	output = "tech:crushed_iron_ore",
	items = { "group:ironstone_cobble 16" },
	level = 1,
	always_known = true,
})

--recipe
crafting.register_recipe({
	type = "grinding_stone",
	output = "tech:roasted_iron_ore_powder",
	items = { "tech:roasted_iron_ore 2" },
	level = 1,
	always_known = true,
})

--recipe
crafting.register_recipe({
	type = "hammering_block",
	output = "tech:iron_smelting_mix",
	items = { "tech:roasted_iron_ore_powder", "tech:charcoal_block 4" },
	level = 1,
	always_known = true,
})

--recipe
crafting.register_recipe({
	type = "hammering_block",
	output = "tech:iron_ingot",
	items = { "tech:iron_bloom 2" },
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "anvil",
	output = "tech:iron_ingot",
	items = { "tech:iron_bloom 2" },
	level = 1,
	always_known = true,
})

------------------------------------------

crafting.register_recipe({
	type = "anvil",
	output = "tech:iron_fittings 8",
	items = { "tech:iron_ingot" },
	level = 1,
	always_known = true,
})

--Chest ...see storage
crafting.register_recipe({
	type = "anvil",
	output = "tech:iron_chest",
	items = { "tech:iron_fittings 2", "tech:iron_ingot 4", "tech:vegetable_oil" },
	level = 1,
	always_known = true,
})

-- Protection Nails
minetest.register_craftitem("tech:nails", {
	description = S("Protection Nails - Click 3 times"),
	inventory_image = "tech_iron_nails.png",
	stack_max = minimal.stack_max_light,
	on_use = minimal.protection_nail_use,
})

crafting.register_recipe({
	type = "anvil",
	output = "tech:nails 8",
	items = { "tech:iron_ingot 1" },
	level = 1,
	always_known = true,
})

-- aluminium recipes

crafting.register_recipe({
	type = "anvil",
	output = "tech:aluminium_water_pot",
	items = { "tech:aluminium_ingot 4" },
	level = 1,
	always_known = true,
})
