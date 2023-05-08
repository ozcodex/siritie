-- creates the ceramic alembic node

minetest.register_node("alchemy:alembic", {
	description = "Ceramic alembic",
	drawtype = "nodebox",
	tiles = {
		"alchemy_alembic_empty.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
		    -- bottom pot
		    {-0.25, -0.125, -0.25, 0.25, 0, 0.25}, -- NodeBox1
		    {-0.375, -0.25, -0.375, 0.375, -0.125, 0.375}, -- NodeBox2
		    {-0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125}, -- NodeBox3
		    {-0.25, -0.5, -0.25, 0.25, -0.375, 0.25}, -- NodeBox4

			-- Top pot

			{-0.375, 0, -0.375, 0.375, 0.125, 0.375}, -- NodeBox2
			{-0.3125, 0.125, -0.3125, 0.3125, 0.25, 0.3125}, -- NodeBox3
			{-0.125, 0.25, -0.125, 0.125, 0.375, 0.125}, -- NodeBox4
			{-0.1875, 0.375, -0.1875, 0.1875, 0.4375, 0.1875}, -- NodeBox5
		},
	},
	liquids_pointable = true,
	groups = {cracky=3, oddly_breakable_by_hand=3},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = nodes_nature.node_sound_stone_defaults(),
	groups = {cracky=3, oddly_breakable_by_hand=3},
})

minetest.register_node("alchemy:alembic_with_salt", {
	description = "Ceramic alembic with Salt",
	drawtype = "nodebox",
	tiles = {
		"alchemy_alembic_salt.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
		    -- bottom pot
		    {-0.25, -0.125, -0.25, 0.25, 0, 0.25}, -- NodeBox1
		    {-0.375, -0.25, -0.375, 0.375, -0.125, 0.375}, -- NodeBox2
		    {-0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125}, -- NodeBox3
		    {-0.25, -0.5, -0.25, 0.25, -0.375, 0.25}, -- NodeBox4

	-- Top pot

	{-0.375, 0, -0.375, 0.375, 0.125, 0.375}, -- NodeBox2
	{-0.3125, 0.125, -0.3125, 0.3125, 0.25, 0.3125}, -- NodeBox3
	{-0.125, 0.25, -0.125, 0.125, 0.375, 0.125}, -- NodeBox4
	{-0.1875, 0.375, -0.1875, 0.1875, 0.4375, 0.1875}, -- NodeBox5
		},
	},
	liquids_pointable = true,
	groups = {cracky=3, oddly_breakable_by_hand=3},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = nodes_nature.node_sound_stone_defaults(),
	groups = {cracky=3, oddly_breakable_by_hand=3},
})