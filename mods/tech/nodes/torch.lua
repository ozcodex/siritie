
minetest.register_node("tech:torch", {
	description = S("Torch"),
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	inventory_image = "tech_torch_on_floor.png",
	wield_image = "tech_torch_on_floor.png",
	tiles = {{
		    name = "tech_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	stack_max = minimal.stack_max_medium,
	use_texture_alpha = c_alpha.clip,
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	liquids_pointable = false,
	light_source = torch_light_power,
	temp_effect = torch_temp,
	temp_effect_max = torch_heat,
	groups = {choppy=2, dig_immediate=3, attached_node=1, torch=1, temp_effect = 1, temp_pass = 1},
	drop = "tech:torch",
	on_drop = function(itemstack, dropper, pos)
	   on_throw_troch(itemstack, dropper, pos)
	   local pname = dropper:get_player_name()
	   if not minetest.check_player_privs(pname, {creative = true}) then
	      itemstack:take_item()
	      return itemstack
	   end
	end,
	selection_box = {
		type = "wallmounted",
		wall_bottom = {-1/8, -1/2, -1/8, 1/8, 2/16, 1/8},
	},
	sounds = nodes_nature.node_sound_wood_defaults(),
	on_dig = function(pos, node, digger)
		on_dig_torch(pos, node, digger)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local under = pointed_thing.under
		local node = minetest.get_node(under)
		local innode = minetest.get_node(pointed_thing.above).name
		if minetest.get_item_group(innode, "water") > 0 then
		   on_throw_troch(itemstack, placer, pointed_thing.under)
		   itemstack:take_item(1)
		   return itemstack
		end
		local def = minetest.registered_nodes[node.name]
		if def and def.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
			return def.on_rightclick(under, node, placer, itemstack,
				pointed_thing) or itemstack
		end

		local above = pointed_thing.above
		local wdir = minetest.dir_to_wallmounted(vector.subtract(under, above))
		local fakestack = itemstack
		if wdir == 0 then
			fakestack:set_name("tech:torch_ceiling")
		elseif wdir == 1 then
			fakestack:set_name("tech:torch")
		else
			fakestack:set_name("tech:torch_wall")
		end

		itemstack = minetest.item_place(fakestack, placer, pointed_thing, wdir)
		itemstack:set_name("tech:torch")

		return itemstack
	end,
	floodable = true,
	on_flood = torch_on_flood,
	on_construct = function(pos)
		--duration of burn
		local meta = minetest.get_meta(pos)
		meta:set_int("fuel", torch_base_fuel)
		--fire effects..
		minetest.get_node_timer(pos):start(math.random(torch_base_burn_rate-1,torch_base_burn_rate+1))
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		after_place_torch(pos, placer, itemstack, pointed_thing)
	end,
	on_timer =function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			minetest.set_node(pos, {name = "tech:wood_ash"})
			minetest.check_for_falling(pos)
			return false
		elseif torch_can_burn_air(pos, meta, "tech:wood_ash" ) then
			torch_fire_on(pos)
			meta:set_int("fuel", fuel - 1)
			-- Restart timer
			return true
		end
	end,
})

minetest.register_node("tech:torch_wall", {
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {{
		    name = "tech_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	use_texture_alpha = c_alpha.clip,
	sunlight_propagates = true,
	walkable = false,
	light_source = torch_light_power,
	temp_effect = torch_temp,
	temp_effect_max = torch_heat,
	groups = {choppy=2, dig_immediate=3, not_in_creative_inventory=1,
		  attached_node=1, torch=1, temp_effect = 1, temp_pass = 1},
	drop = "tech:torch",
	selection_box = {
		type = "wallmounted",
		wall_side = {-1/2, -1/2, -1/8, -1/8, 1/8, 1/8},
	},
	sounds = nodes_nature.node_sound_wood_defaults(),
	floodable = true,
	on_flood = torch_on_flood,
	on_dig = function(pos, node, digger)
		on_dig_torch(pos, node, digger)
	end,
	on_construct = function(pos)
		--duration of burn
		local meta = minetest.get_meta(pos)
		meta:set_int("fuel", torch_base_fuel)
		--fire effects..
		minetest.get_node_timer(pos):start(math.random(torch_base_burn_rate-1,torch_base_burn_rate+1))
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		after_place_torch(pos, placer, itemstack, pointed_thing)
	end,
	on_timer =function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			minetest.set_node(pos, {name = "tech:wood_ash"})
			minetest.check_for_falling(pos)
			return false
		elseif torch_can_burn_air(pos, meta, "tech:wood_ash" ) then
			torch_fire_on(pos)
			meta:set_int("fuel", fuel - 1)
			-- Restart timer
			return true
		end
	end,
})

minetest.register_node("tech:torch_ceiling", {
	drawtype = "mesh",
	mesh = "torch_ceiling.obj",
	tiles = {{
		    name = "tech_torch_on_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
	}},
	paramtype = "light",
	paramtype2 = "wallmounted",
	use_texture_alpha = c_alpha.clip,
	sunlight_propagates = true,
	walkable = false,
	light_source = torch_light_power,
	temp_effect = torch_temp,
	temp_effect_max = torch_heat,
	groups = {choppy=2, dig_immediate=3, not_in_creative_inventory=1,
		  attached_node=1, torch=1, temp_effect = 1, temp_pass = 1},
	drop = "tech:torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/8, -1/16, -5/16, 1/8, 1/2, 1/8},
	},
	sounds = nodes_nature.node_sound_wood_defaults(),
	floodable = true,
	on_flood = torch_on_flood,
	on_dig = function(pos, node, digger)
		on_dig_torch(pos, node, digger)
	end,
	on_construct = function(pos)
		--duration of burn
		local meta = minetest.get_meta(pos)
		meta:set_int("fuel", torch_base_fuel)
		--fire effects..
		minetest.get_node_timer(pos):start(math.random(torch_base_burn_rate-1,torch_base_burn_rate+1))
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		after_place_torch(pos, placer, itemstack, pointed_thing)
	end,
	on_timer =function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			minetest.set_node(pos, {name = "tech:wood_ash"})
			minetest.check_for_falling(pos)
			return false
		elseif torch_can_burn_air(pos, meta, "tech:wood_ash" ) then
			torch_fire_on(pos)
			meta:set_int("fuel", fuel - 1)
			-- Restart timer
			return true
		end
	end,
})