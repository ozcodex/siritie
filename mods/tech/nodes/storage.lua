--Clay pot (see pottery for unfired version)
minetest.register_node("tech:clay_storage_pot", {
	description = S("Clay Storage Pot"),
	tiles = {"tech_pottery.png",
	"tech_pottery.png",
	"tech_pottery.png",
	"tech_pottery.png",
	"tech_pottery.png"},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = storage_node_box
		},
	groups = {dig_immediate = 3, pottery = 1, craftedby = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),

	on_construct = function(pos)
		storage_on_construct(pos, 8, 4)
	end,

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		--Update formspec and infotext
		storage_on_construct(pos, 8, 4)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		storage_on_receive_fields(pos,formname,fields, sender, 8, 4)
	end,

	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		local name = ""
		if player then
			name = player:get_player_name()
		end
		return storage_is_owner(pos, name) and inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return count
		end
		return 0
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name())
		and not string.match(stack:get_name(), "backpacks:") then
			return stack:get_count()
		end
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return stack:get_count()
		end
		return 0
	end,

	on_blast = function(pos)
	end,
})


----------------------------------------------------
--primitive wooden chest
minetest.register_node("tech:primitive_wooden_chest", {
	description = S("Primitive Wooden Chest"),
	tiles = {"tech_primitive_wood.png"},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = storage_node_box
		},
	groups = {dig_immediate = 3, craftedby = 1},
	sounds = nodes_nature.node_sound_wood_defaults(),

	on_construct = function(pos)
		storage_on_construct(pos, 8, 4)
	end,

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		--Update formspec and infotext
		storage_on_construct(pos, 8, 4)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		storage_on_receive_fields(pos, formname, fields, sender, 8, 4)
	end,

	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		local name = ""
		if player then
			name = player:get_player_name()
		end
		return storage_is_owner(pos, name) and inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return count
		end
		return 0
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name())
		and not string.match(stack:get_name(), "backpacks:") then
			return stack:get_count()
		end
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return stack:get_count()
		end
		return 0
	end,

	on_blast = function(pos)
	end,
})

----------------------------------------------------
--wicker basket
minetest.register_node("tech:wicker_storage_basket", {
	description = S("Wicker Storage Basket"),
	tiles = {"tech_wicker.png"},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = storage_node_box
		},
	groups = {dig_immediate = 3, craftedby = 1},
	sounds = nodes_nature.node_sound_leaves_defaults(),

	on_construct = function(pos)
		storage_on_construct(pos, 8, 4)
	end,

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		--Update formspec and infotext
		storage_on_construct(pos, 8, 4)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		storage_on_receive_fields(pos, formname, fields, sender, 8, 4)
	end,

	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		local name = ""
		if player then
			name = player:get_player_name()
		end
		return storage_is_owner(pos, name) and inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return count
		end
		return 0
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name())
		and not string.match(stack:get_name(), "backpacks:") then
			return stack:get_count()
		end
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return stack:get_count()
		end
		return 0
	end,

	on_blast = function(pos)
	end,
})

----------------------------------------------------
--woven basket
minetest.register_node("tech:woven_storage_basket", {
	description = S("Woven Storage Basket"),
	tiles = {"tech_woven.png"},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = storage_node_box
		},
	groups = {dig_immediate = 3, craftedby = 1},
	sounds = nodes_nature.node_sound_leaves_defaults(),

	on_construct = function(pos)
		storage_on_construct(pos, 8, 4)
	end,

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		--Update formspec and infotext
		storage_on_construct(pos, 8, 4)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		storage_on_receive_fields(pos, formname, fields, sender, 8, 4)
	end,

	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		local name = ""
		if player then
			name = player:get_player_name()
		end
		return storage_is_owner(pos, name) and inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return count
		end
		return 0
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name())
		and not string.match(stack:get_name(), "backpacks:") then
			return stack:get_count()
		end
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return stack:get_count()
		end
		return 0
	end,

	on_blast = function(pos)
	end,
})

----------------------------------------------------
--Wooden chest
minetest.register_node("tech:wooden_chest", {
	description = S("Wooden Chest"),
	tiles = {"tech_wooden_chest_top.png",
			"tech_wooden_chest_bottom.png",
			"tech_wooden_chest_side.png",
			"tech_wooden_chest_side.png",
			"tech_wooden_chest_back.png",
			"tech_wooden_chest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	use_texture_alpha = c_alpha.clip,
	stack_max = minimal.stack_max_bulky,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = chest_node_box
	},
	groups = {dig_immediate = 3, craftedby = 1},
	sounds = nodes_nature.node_sound_wood_defaults(),

	on_construct = function(pos)
		storage_on_construct(pos, 8, 8)
	end,

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		--Update formspec and infotext
		storage_on_construct(pos, 8, 8)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		storage_on_receive_fields(pos, formname, fields, sender, 8, 8)
	end,

	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		local name = ""
		if player then
			name = player:get_player_name()
		end
		return storage_is_owner(pos, name) and inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return count
		end
		return 0
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name())
		and not string.match(stack:get_name(), "backpacks:") then
			return stack:get_count()
		end
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return stack:get_count()
		end
		return 0
	end,

	on_blast = function(pos)
	end,
})


--iron chest
minetest.register_node("tech:iron_chest", {
	description = S("Iron Chest"),
	tiles = {"tech_iron_chest_top.png",
			"tech_iron_chest_bottom.png",
			"tech_iron_chest_side.png",
			"tech_iron_chest_side.png",
			"tech_iron_chest_back.png",
			"tech_iron_chest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	use_texture_alpha = c_alpha.clip,
	protected = true,
	stack_max = minimal.stack_max_bulky,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = chest_node_box
	},
	groups = {dig_immediate = 3, craftedby = 1},
	sounds = nodes_nature.node_sound_wood_defaults(),

	on_construct = function(pos)
		storage_on_construct(pos, 8, 8)
	end,

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		--Update formspec and infotext
		storage_on_construct(pos, 8, 8)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		storage_on_receive_fields(pos, formname, fields, sender, 8, 8)
	end,

	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		local name = ""
		if player then
			name = player:get_player_name()
		end
		return storage_is_owner(pos, name) and inv:is_empty("main")
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return count
		end
		return 0
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name())
		and not string.match(stack:get_name(), "backpacks:") then
			return stack:get_count()
		end
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if storage_is_owner(pos, player:get_player_name()) then
			return stack:get_count()
		end
		return 0
	end,

	on_blast = function(pos)
	end,
})
