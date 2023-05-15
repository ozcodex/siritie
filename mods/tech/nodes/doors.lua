--Wattle

doors.register("door_wattle", {
		tiles = {{ name = "tech_door_wattle.png", backface_culling = true }},
		description = S("Wattle Door"),
		inventory_image = "tech_door_wattle_item.png",
		groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 1},
		sounds = nodes_nature.node_sound_wood_defaults(),
})


doors.register_trapdoor("tech:trapdoor_wattle", {
	description = S("Wattle Trapdoor"),
	inventory_image = "tech_trapdoor_wattle_inv.png",
	wield_image = "tech_trapdoor_wattle.png",
	tile_front = "tech_trapdoor_wattle.png",
	tile_side = "tech_trapdoor_wattle_side.png",
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 1},
	sounds = nodes_nature.node_sound_wood_defaults(),
})


--------------------------------------


--Wooden

doors.register("door_wooden", {
		tiles = {{ name = "tech_wooden_door.png", backface_culling = true }},
		description = S("Wooden Door"),
		stack_max = minimal.stack_max_bulky *4,
		inventory_image = "tech_wooden_door_item.png",
		groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 1},
		sounds = nodes_nature.node_sound_wood_defaults(),
})


doors.register_trapdoor("tech:trapdoor_wooden", {
	description = S("Wooden Trapdoor"),
	stack_max = minimal.stack_max_bulky *4,
	inventory_image = "tech_wooden_trapdoor.png",
	wield_image = "tech_wooden_trapdoor.png",
	tile_front = "tech_wooden_trapdoor.png",
	tile_side = "tech_trapdoor_wooden_side.png",
	groups = {choppy = 3, oddly_breakable_by_hand = 1, flammable = 1},
	sounds = nodes_nature.node_sound_wood_defaults(),
})


------------------------------------
-- Iron - nonflammable, good for furnaces

doors.register("door_iron", {
		tiles = {{ name = "tech_iron_door.png", backface_culling = true }},
		description = S("Iron Door"),
		protected = true,
		stack_max = minimal.stack_max_bulky *2,
		inventory_image = "tech_iron_door_item.png",
		groups = {cracky = 3, oddly_breakable_by_hand = 1},
		sounds = nodes_nature.node_sound_stone_defaults(),
})

doors.register_trapdoor("tech:trapdoor_iron", {
	description = S("Iron Trapdoor"),
	protected = true,
	stack_max = minimal.stack_max_bulky *2,
	inventory_image = "tech_trapdoor_iron.png",
	wield_image = "tech_trapdoor_iron.png",
	tile_front = "tech_trapdoor_iron.png",
	tile_side = "tech_trapdoor_iron_side.png",
	use_texture_alpha = c_alpha.clip,
	groups = {cracky = 3, oddly_breakable_by_hand = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
})
