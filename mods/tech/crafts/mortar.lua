
--crush lime
crafting.register_recipe({
	type = "hammering_block",
	output = "tech:crushed_lime",
	items = {"group:limestone_cobble 8"},
	level = 1,
	always_known = true,
})

--mix mortar
crafting.register_recipe({
	type = "grinding_stone",
	output = "tech:lime_mortar 4",
	items = {"tech:slaked_lime", "nodes_nature:sand 3"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "mortar_bucket",
	output = "tech:lime_mortar 4",
	items = {"tech:slaked_lime", "nodes_nature:sand 3"},
	level = 1,
	always_known = true,
})


for i in ipairs(mortar_blocks_list) do
	local name = mortar_blocks_list[i][1]

	crafting.register_recipe({
		type = "masonry_bench",
		output = "tech:"..name.."_brick_mortar 4",
		items = {"nodes_nature:"..name.."_brick 3", "tech:lime_mortar"},
		level = 1,
		always_known = true,
	})

	crafting.register_recipe({
		type = "masonry_bench",
		output = "tech:"..name.."_block_mortar 4",
		items = {"nodes_nature:"..name.."_block 3", "tech:lime_mortar"},
		level = 1,
		always_known = true,
	})

	crafting.register_recipe({
		type = "mortar_bucket",
		output = "tech:"..name.."_block_mortar 4",
		items = {"nodes_nature:"..name.."_block 3", "tech:lime_mortar"},
		level = 1,
		always_known = true,
	})

end
