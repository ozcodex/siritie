
minetest.register_node("religion:efigy", {
	description = S("Effigy"),
	inventory_image = "tech_efigy_inv.png",
	wield_image = "tech_efigy_inv.png",
	tiles = {"tech_thatch.png"},
	stack_max = 1,
	drawtype = "nodebox",
	node_box = {
			type = "fixed",
			fixed = {
				{-0.3000, -0.5000, -0.3000,  0.3000, -0.4500,  0.3000}, -- NodeBox1
				{-0.2000, -0.4500, -0.2000,  0.2000, -0.4000,  0.2000}, -- NodeBox2
				{-0.0500, -0.1500, -0.0500,  0.0500,  0.3000,  0.0500}, -- NodeBox3
				{-0.3000,  0.0500, -0.0500,  0.3000,  0.1500,  0.0500}, -- NodeBox4
				{-0.1500, -0.4500, -0.0500, -0.0500, -0.0500,  0.0500}, -- NodeBox5
				{ 0.0500, -0.4500, -0.0500,  0.1500, -0.0500,  0.0500}, -- NodeBox6
				{-0.2500,  0.2500, -0.0250,  0.2500,  0.3000,  0.0250}, -- NodeBox7
				{-0.2500, -0.2500, -0.0250,  0.2500, -0.2000,  0.0250}, -- NodeBox8
				{ 0.2500, -0.2500, -0.0250,  0.3000,  0.3000,  0.0250}, -- NodeBox9
				{-0.2500, -0.2500, -0.0250, -0.3000,  0.3000,  0.0250}, -- NodeBox10
			}
		},
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = 1,
	sunlight_propagates = true,
	walkable = true,
	drop = "tech:stick 6",
	groups = {snappy=3, flammable=1, falling_node = 1},
	sounds = nodes_nature.node_sound_wood_defaults(),

	can_dig = can_dig,
	on_rightclick = raise_prayer,

})
