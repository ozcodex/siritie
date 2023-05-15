
minetest.register_node("tech:bricks_and_mortar", {
	description = S("Brick and Mortar"),
	tiles = {"tech_bricks_and_mortar.png"},
	stack_max = minimal.stack_max_medium/2,
	paramtype2 = "facedir",
	drop = "tech:loose_brick",
	groups = {cracky = 2, masonry = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
})


stairs.register_stair_and_slab(
	"bricks_and_mortar",
	"tech:bricks_and_mortar",
	"mortar_bucket",
	"true",
	{cracky = 2},
	{"tech_bricks_and_mortar.png"},
	"Brick and Mortar Stair",
	"Brick and Mortar Slab",
	minimal.stack_max_medium,
	nodes_nature.node_sound_stone_defaults(),
	nil,
	"tech:loose_brick"
)

--unfired
crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:loose_brick_unfired 6",
	items = {'nodes_nature:clay_wet 3', 'nodes_nature:sand_wet'},
	level = 1,
	always_known = true,
})

-- bricks cannot be undone, since they are mixed with sand

--mix with mortar
crafting.register_recipe({
	type = "mortar_bucket",
	output = "tech:bricks_and_mortar 12",
	items = {"tech:lime_mortar", "tech:loose_brick 12"},
	level = 1,
	always_known = true,
})


--unfired
crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:roof_tile_loose_unfired",
	items = {'nodes_nature:clay_wet 6'},
	level = 1,
	always_known = true,
})

-- roof tiles canbe undone, since they are done with pure clay
crafting.register_recipe({
	type = "clay_mixing",
	output = "nodes_nature:clay 6",
	items = {'tech:roof_tile_loose_unfired'},
	level = 1,
	always_known = true,
})

--usable tile
crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:roof_tile 6",
	items = {'tech:roof_tile_loose'},
	level = 1,
	always_known = true,
})


--switch inner/outer
crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:roof_tile_ic",
	items = {"tech:roof_tile"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:roof_tile_oc",
	items = {"tech:roof_tile"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:roof_tile",
	items = {"tech:roof_tile_ic"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:roof_tile",
	items = {"tech:roof_tile_oc"},
	level = 1,
	always_known = true,
})

--switch inner/outer
crafting.register_recipe({
	type = "brick_makers_bench",
	output = "tech:roof_ridge_tile",
	items = {"tech:roof_tile"},
	level = 1,
	always_known = true,
})