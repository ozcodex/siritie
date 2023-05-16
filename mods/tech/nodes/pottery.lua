---
--Broken Pottery
--if you smash it up, or from failed firings
--slab
minetest.register_node("tech:broken_pottery", {
	description = S("Broken Pottery"),
	tiles = {"tech_broken_pottery.png"},
	stack_max = minimal.stack_max_bulky *2,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	groups = {cracky = 3, falling_node = 1, oddly_breakable_by_hand = 3},
	sounds = nodes_nature.node_sound_gravel_defaults(),
        on_rightclick = function (pos,node,clicker,itemstack,pointed_thing)
           return minimal.slabs_combine(pos,node,itemstack,"tech:broken_pottery_block")
	end,
})

--Water pot
--for collecting water, catching rain water
--fired
minetest.register_node("tech:clay_water_pot", {
	description = S("Clay Water Pot"),
	tiles = {
		"tech_water_pot_empty.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png"
	},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = clay_pot_nodebox
	},
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		return liquid_store.on_use_empty_bucket(itemstack, user, pointed_thing)
	end,
		--collect rain water
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(30,60))
	end,
	on_timer =function(pos, elapsed)
		return water_pot(pos, "tech:clay_water_pot", elapsed)
	end,
	groups = {dig_immediate = 3, pottery = 1, temp_pass = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),

})

--unfired
minetest.register_node("tech:clay_water_pot_unfired", {
	description = S("Clay Water Pot (unfired)"),
	tiles = {
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png"
	},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = clay_pot_nodebox
	},
	groups = {dig_immediate=3, temp_pass = 1, heatable = 20},
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		ncrafting.set_firing(pos, base_firing, firing_int)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length
		return ncrafting.fire_pottery(pos, "tech:clay_water_pot_unfired", "tech:clay_water_pot", base_firing)
	end,
})


--------------------------------------
--unfired storage pot (see storage for fired version)
minetest.register_node("tech:clay_storage_pot_unfired", {
	description = S("Clay Storage Pot (unfired)"),
	tiles = {
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png"
	},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.375, -0.5, -0.375, 0.375, -0.375, 0.375},
				{-0.375, 0.375, -0.375, 0.375, 0.5, 0.375},
				{-0.4375, -0.375, -0.4375, 0.4375, -0.25, 0.4375},
				{-0.4375, 0.25, -0.4375, 0.4375, 0.375, 0.4375},
				{-0.5, -0.25, -0.5, 0.5, 0.25, 0.5},
			}
		},
	groups = {dig_immediate=3, temp_pass = 1, heatable = 20},
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		ncrafting.set_firing(pos, base_firing+5, firing_int)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length
		return ncrafting.fire_pottery(pos, "tech:clay_storage_pot_unfired", "tech:clay_storage_pot", base_firing+5)
	end,
})

--------------------------------------
--OIL LAMP

--unfired oil clay lamp
minetest.register_node("tech:clay_oil_lamp_unfired", {
	description = S("Clay Oil Lamp (unfired)"),
	tiles = {
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png"
	},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_medium,
	paramtype = "light",
	paramtype2 = "facedir",
	use_texture_alpha = c_alpha.clip,
	node_box = {
		type = "fixed",
		fixed = {
			--{-0.0625, -0.125, 0.25, 0.0625, 0.0625, 0.4375}, -- flame
			{-0.125, -0.5, -0.125, 0.125, -0.4375, 0.125}, -- bottom
			{-0.0625, -0.4375, -0.0625, 0.0625, -0.3125, 0.0625}, -- stand
			{-0.125, -0.3125, -0.125, 0.125, -0.125, 0.125}, -- body
			{-0.0625, -0.25, 0.125, 0.0625, -0.125, 0.25}, -- spout
			{-0.0625, -0.1875, -0.1875, 0.0625, -0.125, -0.125}, -- handle
			{-0.0625, -0.3125, -0.1875, 0.0625, -0.25, -0.125}, -- handle
			{-0.0625, -0.3125, -0.25, 0.0625, -0.125, -0.1875}, -- handle
		}
	},
	groups = {dig_immediate=3, temp_pass = 1, falling_node = 1, heatable = 20},
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		ncrafting.set_firing(pos, base_firing, firing_int)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length
		return ncrafting.fire_pottery(pos, "tech:clay_oil_lamp_unfired", "tech:clay_oil_lamp_empty", base_firing)
	end,
})

--fired oil clay lamp
minetest.register_node("tech:clay_oil_lamp_unlit", {
	description = S("Clay Oil Lamp"),
	tiles = {
		"tech_oil_lamp_top.png",
		"tech_oil_lamp_bottom.png",
		"tech_oil_lamp_side.png",
		"tech_oil_lamp_side2.png",
		"tech_oil_lamp_front.png",
		"tech_oil_lamp_front.png"
	},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_medium,
	paramtype = "light",
	paramtype2 = "facedir",
	use_texture_alpha = c_alpha.clip,
	node_box = {
		type = "fixed",
		fixed = {
			--{-0.0625, -0.125, 0.25, 0.0625, 0.0625, 0.4375}, -- flame
			{-0.125, -0.5, -0.125, 0.125, -0.4375, 0.125}, -- bottom
			{-0.0625, -0.4375, -0.0625, 0.0625, -0.3125, 0.0625}, -- stand
			{-0.125, -0.3125, -0.125, 0.125, -0.125, 0.125}, -- body
			{-0.0625, -0.25, 0.125, 0.0625, -0.125, 0.25}, -- spout
			{-0.0625, -0.1875, -0.1875, 0.0625, -0.125, -0.125}, -- handle
			{-0.0625, -0.3125, -0.1875, 0.0625, -0.25, -0.125}, -- handle
			{-0.0625, -0.3125, -0.25, 0.0625, -0.125, -0.1875}, -- handle
		}
	},
	groups = {dig_immediate=3, pottery = 1, temp_pass = 1, falling_node = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
	floodable = true,
	on_flood = function(pos, oldnode, newnode)
            minetest.add_item(pos, ItemStack("tech:clay_oil_lamp_unlit 1"))
            return false
	end,
        on_construct = function(pos)
            lightsource.update_fuel_infotext(oil_lamp_desc, pos)
        end,
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            lightsource.restore_from_inventory(oil_lamp_desc, pos, itemstack)
            lightsource.update_fuel_infotext(oil_lamp_desc, pos)
        end,
        on_dig = function(pos, node, digger)
            lightsource.save_to_inventory(oil_lamp_desc, pos, digger, false)
        end,
        on_ignite = function(pos, user)
            lightsource.ignite(oil_lamp_desc, pos)
        end,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            lightsource.refill(oil_lamp_desc, pos, clicker, itemstack)
        end,
})


--full oil clay lamp
minetest.register_node("tech:clay_oil_lamp", {
	description = S("Clay Oil Lamp (lit)"),
	tiles = {
		"tech_oil_lamp_top.png",
		"tech_oil_lamp_bottom.png",
		{
                    name = "tech_oil_lamp_side_animated.png",
                    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
		},
		{
                    name = "tech_oil_lamp_side2_animated.png",
                    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
		},
		"tech_oil_lamp_front.png",
		"tech_oil_lamp_front.png"
	},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_medium,
	sunlight_propagates = true,
	light_source = 7,
	use_texture_alpha = c_alpha.clip,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.125, 0.25, 0.0625, 0.0625, 0.4375}, -- flame
			{-0.125, -0.5, -0.125, 0.125, -0.4375, 0.125}, -- bottom
			{-0.0625, -0.4375, -0.0625, 0.0625, -0.3125, 0.0625}, -- stand
			{-0.125, -0.3125, -0.125, 0.125, -0.125, 0.125}, -- body
			{-0.0625, -0.25, 0.125, 0.0625, -0.125, 0.25}, -- spout
			{-0.0625, -0.1875, -0.1875, 0.0625, -0.125, -0.125}, -- handle
			{-0.0625, -0.3125, -0.1875, 0.0625, -0.25, -0.125}, -- handle
			{-0.0625, -0.3125, -0.25, 0.0625, -0.125, -0.1875}, -- handle
		}
	},
	groups = {dig_immediate=3, pottery = 1, temp_pass = 1, falling_node = 1, not_in_creative_inventory = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
	floodable = true,
	on_flood = function(pos, oldnode, newnode)
            minetest.add_item(pos, ItemStack("tech:clay_oil_lamp_unlit 1"))
            return false
	end,
        on_construct = function(pos)
            lightsource.start_burning(oil_lamp_desc, pos)
	end,
        on_timer = function(pos, elapsed)
            return lightsource.burn_fuel(oil_lamp_desc, pos)
	end,
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            lightsource.restore_from_inventory(oil_lamp_desc, pos, itemstack)
        end,
        on_dig = function(pos, node, digger)
            lightsource.save_to_inventory(oil_lamp_desc, pos, digger, false)
        end,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
	   lightsource.extinguish(oil_lamp_desc, pos)
	   lightsource.update_fuel_infotext(oil_lamp_desc, pos)
        end,
})

--Water pot
--for collecting water, catching rain water
--fired
minetest.register_node("tech:clay_amphora", {
	description = S("Clay Amphora"),
	tiles = {
		"tech_amphora_top.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png"
	},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = clay_amphora_nodebox
	},
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		return liquid_store.on_use_empty_bucket(itemstack, user, pointed_thing)
	end,
		--collect rain water
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(30,60))
	end,
	on_timer =function(pos, elapsed)
		return water_pot(pos, "tech:clay_amphora", elapsed)
	end,
	groups = {dig_immediate = 3, pottery = 1, temp_pass = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),

})

--unfired
minetest.register_node("tech:clay_amphora_unfired", {
	description = S("Clay Amphora (unfired)"),
	tiles = {
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png",
		"nodes_nature_clay.png"
	},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = clay_amphora_nodebox
	},
	groups = {dig_immediate=3, temp_pass = 1, heatable = 20},
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		ncrafting.set_firing(pos, base_firing, firing_int)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length
		return ncrafting.fire_pottery(pos, "tech:clay_amphora_unfired", "tech:clay_amphora", base_firing)
	end,
})

