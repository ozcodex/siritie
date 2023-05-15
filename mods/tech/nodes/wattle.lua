	-----------------------------------------------------------
	--WATTLE

minetest.register_node('tech:wattle', {
	description = S('Wattle'),
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}},
		-- connect_bottom =
		connect_front = {{-1/8, -1/2, -1/2,  1/8, 1/2, -1/8}},
		connect_left = {{-1/2, -1/2, -1/8, -1/8, 1/2,  1/8}},
		connect_back = {{-1/8, -1/2,  1/8,  1/8, 1/2,  1/2}},
		connect_right = {{ 1/8, -1/2, -1/8,  1/2, 1/2,  1/8}},
	},
	connects_to = {
		"group:sediment",
		"group:tree",
		"group:log",
		"group:stone",
		"group:masonry",
		"group:soft_stone",
		'tech:drystack',
		'tech:mudbrick',
		'tech:rammed_earth',
		'tech:wattle_loose',
		'tech:wattle_door_frame',
		'tech:wattle',
		'tech:thatch'
	},
	paramtype = "light",
	use_texture_alpha = c_alpha.clip,
	tiles = {"tech_wattle_top.png",
		 "tech_wattle_top.png",
		 "tech_wattle.png",
		 "tech_wattle.png",
		 "tech_wattle.png",
		 "tech_wattle.png" },
	inventory_image = "tech_wattle_inv.png",
	wield_image = "tech_wattle.png",
	stack_max = minimal.stack_max_bulky * 3,
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = nodes_nature.node_sound_wood_defaults(),
})

--a crude window... or for resource saving
minetest.register_node('tech:wattle_loose', {
	description = S('Loose Wattle'),
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}},
		-- connect_bottom =
		connect_front = {{-1/8, -1/2, -1/2,  1/8, 1/2, -1/8}},
		connect_left = {{-1/2, -1/2, -1/8, -1/8, 1/2,  1/8}},
		connect_back = {{-1/8, -1/2,  1/8,  1/8, 1/2,  1/2}},
		connect_right = {{ 1/8, -1/2, -1/8,  1/2, 1/2,  1/8}},
	},
	connects_to = {
		"group:sediment",
		"group:tree",
		"group:log",
		"group:stone",
		"group:masonry",
		"group:soft_stone",
		'tech:drystack',
		'tech:mudbrick',
		'tech:rammed_earth',
		'tech:wattle_loose',
		'tech:wattle_door_frame',
		'tech:wattle',
		'tech:thatch'
	},
	paramtype = "light",
	use_texture_alpha = c_alpha.clip,
	tiles = {"tech_wattle_top.png",
		 "tech_wattle_top.png",
		 "tech_wattle_loose.png",
		 "tech_wattle_loose.png",
		 "tech_wattle_loose.png",
		 "tech_wattle_loose.png" },
	inventory_image = "tech_wattle_loose.png",
	wield_image = "tech_wattle_loose.png",
	stack_max = minimal.stack_max_bulky * 3,
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2, temp_pass = 1},
	sounds = nodes_nature.node_sound_wood_defaults(),
})


minetest.register_node('tech:wattle_door_frame', {
	description = S('Wattle Door Frame'),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {{-1/2, -1/2, -1/8,  1/2, 1/2, 1/8},
		         {-4/8, -1/2, 1/8,  -3/8, 1/2, 1/2}},
	},
	paramtype = "light",
	paramtype2 = "facedir",
	use_texture_alpha = c_alpha.clip,
	tiles = {"tech_wattle_top.png",
		 "tech_wattle_top.png",
		 "tech_wattle.png",
		 "tech_wattle.png",
		 "tech_wattle.png",
		 "tech_wattle.png",
},
	inventory_image = "tech_wattle_door_frame.png",
	wield_image = "tech_wattle_door_frame.png",
	stack_max = minimal.stack_max_bulky * 3,
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = nodes_nature.node_sound_wood_defaults(),
	on_construct = wdf_connect_to_door,
})
