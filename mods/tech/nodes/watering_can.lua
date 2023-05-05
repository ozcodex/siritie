-- watering can
-- can turn a block in it's wet variant
-- fills itselft with rain
-- acts similar to clay_water_pot

minetest.register_node("tech:clay_watering_can", {
	description = S("Clay Watering Can"),
	tiles = {
		"tech_watering_can_empty.png",
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
		fixed = {
			-- lid
			{-0.2, 0.2,-0.2, 0.2, 0.3, 0.2},
			-- handle
            {-0.05, 0.05, -0.25, 0.05, 0.15, -0.45}, -- upper
            {-0.05, -0.1, -0.35, 0.05, 0.05, -0.45}, -- mid
            {-0.05, -0.2, -0.25, 0.05, -0.1, -0.45}, -- low
            -- spout
            {-0.1, 0.1, 0.25, 0.1, 0.2, 0.5}, -- upper
            {-0.1, -0.4, 0.25, 0.1, 0.1, 0.4},
            -- body
            {-0.25, -0.4, -0.25, 0.25, 0.2, 0.25},
            -- base
            {-0.3, -0.5,-0.4, 0.3, -0.35, 0.4},
		}
	},
	liquids_pointable = true,
	groups = {dig_immediate = 3, pottery = 1, temp_pass = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_use = function(itemstack, user, pointed_thing)
		return liquid_store.on_use_empty_bucket(itemstack, user, pointed_thing)
	end,
		--collect rain water
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(30,60))
	end,
	on_timer =function(pos, elapsed)
		return water_pot(pos, "tech:clay_watering_can", elapsed)
	end,

})

--unfired
minetest.register_node("tech:clay_watering_can_unfired", {
	description = S("Clay Watering Can (unfired)"),
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
			-- lid
			{-0.2, 0.2,-0.2, 0.2, 0.3, 0.2},
			-- handle
            {-0.05, 0.05, -0.25, 0.05, 0.15, -0.45}, -- upper
            {-0.05, -0.1, -0.35, 0.05, 0.05, -0.45}, -- mid
            {-0.05, -0.2, -0.25, 0.05, -0.1, -0.45}, -- low
            -- spout
            {-0.1, 0.1, 0.25, 0.1, 0.2, 0.5}, -- upper
            {-0.1, -0.4, 0.25, 0.1, 0.1, 0.4},
            -- body
            {-0.25, -0.4, -0.25, 0.25, 0.2, 0.25},
            -- base
            {-0.3, -0.5,-0.4, 0.3, -0.35, 0.4},
		}
	},
	groups = {dig_immediate=3, temp_pass = 1, heatable = 20},
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		ncrafting.set_firing(pos, base_firing, firing_int)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length
		return ncrafting.fire_pottery(pos, "tech:clay_watering_can_unfired", "tech:clay_watering_can", base_firing)
	end,
})
