-- alembic only accepts salt water
liquid_store.register_stored_liquid(
	"nodes_nature:salt_water_source",
	"alchemy:clay_alembic_salt_water",
	"alchemy:clay_alembic",
	{
		"alchemy_alembic_water.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png"
	},
	{
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
	S("Ceramic alembic with Salt Water"),
	{dig_immediate = 2})