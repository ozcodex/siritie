---------------------------------
--DRYSTACK
-- walls made from stacked stones (no mortar, hence dry)
-- made from loose found stones

minetest.register_node("tech:drystack", {
	description = S("Drystack"),
	tiles = { "tech_drystack.png" },
	stack_max = minimal.stack_max_bulky,
	groups = { cracky = 3, crumbly = 1, falling_node = 1, oddly_breakable_by_hand = 1 },
	sounds = nodes_nature.node_sound_stone_defaults(),
})

-- Stairs and slab for drystack
stairs.register_stair_and_slab(
	"drystack",
	"tech:drystack",
	"mixing_spot",
	"true",
	{ cracky = 3, crumbly = 1, oddly_breakable_by_hand = 1, falling_node = 1 },
	{ "tech_drystack.png" },
	"Drystack Stair",
	"Drystack Slab",
	minimal.stack_max_large,
	nodes_nature.node_sound_stone_defaults()
)

------------------------------------------
--MUDBRICK

minetest.register_node("tech:mudbrick", {
	description = S("Mudbrick"),
	tiles = { "tech_mudbrick.png" },
	drop = "nodes_nature:clay",
	stack_max = minimal.stack_max_heavy,
	groups = { crumbly = 2, cracky = 3, oddly_breakable_by_hand = 1 },
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

stairs.register_stair_and_slab(
	"mudbrick",
	"tech:mudbrick",
	"brick_makers_bench",
	"true",
	{ crumbly = 2, cracky = 3, oddly_breakable_by_hand = 1 },
	{ "tech_mudbrick.png" },
	"Mudbrick Stair",
	"Mudbrick Slab",
	minimal.stack_max_large,
	nodes_nature.node_sound_dirt_defaults(),
	nil,
	"nodes_nature:clay"
)

------------------------------------------
--RAMMED EARTH

minetest.register_node("tech:rammed_earth", {
	description = S("Rammed Earth"),
	tiles = {
		"tech_rammed_earth.png",
		"tech_rammed_earth_side.png",
		"tech_rammed_earth_side.png",
		"tech_rammed_earth_side.png",
		"tech_rammed_earth_side.png",
		"tech_rammed_earth_side.png",
	},
	stack_max = minimal.stack_max_bulky,
	groups = { crumbly = 1, cracky = 3, falling_node = 1 },
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

stairs.register_stair_and_slab(
	"rammed_earth",
	"tech:rammed_earth",
	"brick_makers_bench",
	"true",
	{ crumbly = 1, cracky = 3, falling_node = 1 },
	{
		"tech_rammed_earth.png",
		"tech_rammed_earth_side.png",
		"tech_rammed_earth_side.png",
		"tech_rammed_earth_side.png",
		"tech_rammed_earth_side.png",
		"tech_rammed_earth_side.png",
	},
	"Rammed Earth Stair",
	"Rammed Earth Slab",
	minimal.stack_max_large,
	nodes_nature.node_sound_dirt_defaults()
)
