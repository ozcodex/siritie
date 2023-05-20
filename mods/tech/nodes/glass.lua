-- Green glass

-- Mix - sand and ash 50/50
minetest.register_node("tech:green_glass_mix", {
	description = S("Green Glass Sand Mix"),
	tiles = { "tech_sand_mix.png" },
	stack_max = minimal.stack_max_large,
	paramtype = "light",
	groups = { crumbly = 3, falling_node = 1, heatable = 20 },
	sounds = nodes_nature.node_sound_sand_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		set_roast_glass(pos, 40, 10)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length, heat, smelt
		return roast_glass(pos, "tech:green_glass_mix", "tech:green_glass_ingot", 1500)
	end,
})

-- Finished Products
-- Glass ingot - 1/4 block
minetest.register_node("tech:green_glass_ingot", {
	description = S("Green Glass Ingot"),
	tiles = { "tech_green_glass.png" },
	inventory_image = "tech_glass_ingot_green_icon.png",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, -0.1, 0.3 },
	},
	stack_max = minimal.stack_max_large,
	paramtype = "light",
	groups = { cracky = 3, oddly_breakable_by_hand = 3, falling_node = 1, temp_pass = 1, heatable = 20 },
	sounds = nodes_nature.node_sound_glass_defaults(),
	use_texture_alpha = c_alpha.blend,
	sunlight_propagates = true,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(20)
	end,
	on_timer = function(pos)
		if pane_cast_check(pos) then
			return false -- end the timer
		else
			return true
		end
	end,
})

-- Clear Glass

-- Potash

minetest.register_node("tech:potash_block", {
	description = S("Potash Block"),
	tiles = { "tech_potash.png" },
	stack_max = minimal.stack_max_bulky,
	groups = { crumbly = 3, falling_node = 1, fertilizer = 1 },
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

minetest.register_node("tech:potash", {
	description = S("Potash"),
	tiles = { "tech_potash.png" },
	stack_max = minimal.stack_max_heavy,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
	},
	groups = { crumbly = 3, falling_node = 1, fertilizer = 1 },
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

-- Potash solution (More like lye in this case)
minetest.register_node("tech:potash_source", {
	description = S("Potash Solution Source"),
	drawtype = "liquid",
	tiles = { "tech_potash.png" },
	--	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "tech:potash_flowing",
	liquid_alternative_source = "tech:potash_source",
	liquid_viscosity = 1,
	liquid_range = 2,
	liquid_renewable = false,
	post_effect_color = { a = post_alpha_glass, r = 30, g = 60, b = 90 },
	groups = { water = 2, cools_lava = 1, puts_out_fire = 1 },
	sounds = nodes_nature.node_sound_water_defaults(),
})

minetest.register_node("tech:potash_flowing", {
	description = S("Flowing Potash Solution"),
	drawtype = "flowingliquid",
	tiles = { "tech_potash.png" },
	special_tiles = { "tech_potash.png" },
	use_texture_alpha = c_alpha.blend,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	liquid_move_physics = false,
	move_resistance = 0,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_range = 2,
	liquid_alternative_flowing = "tech:potash_flowing",
	liquid_alternative_source = "tech:potash_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	post_effect_color = { a = post_alpha_glass, r = 30, g = 60, b = 90 },
	groups = { water = 2, not_in_creative_inventory = 1, puts_out_fire = 1, cools_lava = 1 },
	sounds = nodes_nature.node_sound_water_defaults(),
})

-- Solution in pot
liquid_store.register_stored_liquid("tech:potash_source", "tech:clay_water_pot_potash", "tech:clay_water_pot", {
	"tech_water_pot_potash.png",
	"tech_pottery.png",
	"tech_pottery.png",
	"tech_pottery.png",
	"tech_pottery.png",
	"tech_pottery.png",
}, {
	type = "fixed",
	fixed = {
		{ -0.25, 0.375, -0.25, 0.25, 0.5, 0.25 }, -- NodeBox1
		{ -0.375, -0.25, -0.375, 0.375, 0.3125, 0.375 }, -- NodeBox2
		{ -0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125 }, -- NodeBox3
		{ -0.25, -0.5, -0.25, 0.25, -0.375, 0.25 }, -- NodeBox4
		{ -0.3125, 0.3125, -0.3125, 0.3125, 0.375, 0.3125 }, -- NodeBox5
	},
}, S("Clay Water Pot with Potash Solution"), { dig_immediate = 2 })

-- The actual glassmaking... finally

-- Mix - sand, potash and lime
minetest.register_node("tech:clear_glass_mix", {
	description = S("Clear Glass Sand Mix"),
	tiles = { "tech_sand_mix.png" },
	stack_max = minimal.stack_max_large,
	paramtype = "light",
	groups = { crumbly = 3, falling_node = 1, heatable = 20 },
	sounds = nodes_nature.node_sound_sand_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		set_roast_glass(pos, 40, 10)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length, heat, smelt
		return roast_glass(pos, "tech:clear_glass_mix", "tech:clear_glass_ingot", 1500)
	end,
})

-- Finished Products
-- Glass ingot - 1/4 block
minetest.register_node("tech:clear_glass_ingot", {
	description = S("Clear Glass Ingot"),
	tiles = { "tech_clear_glass.png" },
	inventory_image = "tech_glass_ingot_clear_icon.png",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, -0.1, 0.3 },
	},
	stack_max = minimal.stack_max_large,
	paramtype = "light",
	groups = { cracky = 3, oddly_breakable_by_hand = 3, falling_node = 1, temp_pass = 1, heatable = 20 },
	sounds = nodes_nature.node_sound_glass_defaults(),
	use_texture_alpha = c_alpha.blend,
	sunlight_propagates = true,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(20)
	end,
	on_timer = function(pos)
		if pane_cast_check(pos) then
			return false -- end the timer
		else
			return true
		end
	end,
})

-- Pane casting tray - heat up a glass ingot above it to cast a pane
minetest.register_node("tech:pane_tray", {
	description = S("Pane Casting Tray"),
	tiles = { "tech_iron.png" },
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.4, 0.5 },
			{ -0.5, -0.4, -0.5, -0.4, -0.3, 0.5 },
			{ 0.5, -0.4, -0.5, 0.4, -0.3, 0.5 },
			{ -0.5, -0.4, -0.5, 0.5, -0.3, -0.4 },
			{ -0.5, -0.4, 0.5, 0.5, -0.3, 0.4 },
		},
	},
	stack_max = minimal.stack_max_heavy,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { cracky = 3, oddly_breakable_by_hand = 3 },
	sunlight_propagates = true,
})

-- Trays with glass panes
minetest.register_node("tech:pane_tray_green", {
	description = S("Pane Casting Tray With Green Glass Pane"),
	tiles = {
		"tech_tray_green.png",
		"tech_iron.png",
		"tech_iron.png",
		"tech_iron.png",
		"tech_iron.png",
		"tech_iron.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.3, 0.5 },
			{ -0.5, -0.4, -0.5, -0.4, -0.3, 0.5 },
			{ 0.5, -0.4, -0.5, 0.4, -0.3, 0.5 },
			{ -0.5, -0.4, -0.5, 0.5, -0.3, -0.4 },
			{ -0.5, -0.4, 0.5, 0.5, -0.3, 0.4 },
		},
	},
	stack_max = minimal.stack_max_heavy,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { dig_immediate = 3 },
	sunlight_propagates = true,
	on_dig = function(pos, node, digger)
		local inv = digger:get_inventory()
		if inv:room_for_item("main", "tech:pane_green") then
			inv:add_item("main", "tech:pane_green")
		else
			minetest.add_item(pos, "tech:pane_green")
		end
		minetest.swap_node(pos, { name = "tech:pane_tray" })
	end,
})

minetest.register_node("tech:pane_tray_clear", {
	description = S("Pane Casting Tray With Clear Glass Pane"),
	tiles = {
		"tech_tray_clear.png",
		"tech_iron.png",
		"tech_iron.png",
		"tech_iron.png",
		"tech_iron.png",
		"tech_iron.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.3, 0.5 },
			{ -0.5, -0.4, -0.5, -0.4, -0.3, 0.5 },
			{ 0.5, -0.4, -0.5, 0.4, -0.3, 0.5 },
			{ -0.5, -0.4, -0.5, 0.5, -0.3, -0.4 },
			{ -0.5, -0.4, 0.5, 0.5, -0.3, 0.4 },
		},
	},
	stack_max = minimal.stack_max_heavy,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { dig_immediate = 3 },
	sunlight_propagates = true,
	on_dig = function(pos, node, digger)
		local inv = digger:get_inventory()
		if inv:room_for_item("main", "tech:pane_clear") then
			inv:add_item("main", "tech:pane_clear")
		else
			minetest.add_item(pos, "tech:pane_clear")
		end
		minetest.swap_node(pos, { name = "tech:pane_tray" })
	end,
})

-- Stuff made from glass

-- Panes - raw, cast from glass with no framing
minetest.register_node("tech:pane_green", {
	description = S("Green Glass Pane"),
	tiles = { "tech_green_glass.png" },
	inventory_image = "tech_green_pane_icon.png",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { { -1 / 2 + 1 / 10, -1 / 2, -1 / 32, 1 / 2 - 1 / 10, 1 / 2 - 2 / 10, 1 / 32 } }, -- Modified from xpanes
	},
	stack_max = minimal.stack_max_medium * 2,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { cracky = 3, oddly_breakable_by_hand = 3 },
	use_texture_alpha = c_alpha.blend,
	sunlight_propagates = true,
	sounds = nodes_nature.node_sound_glass_defaults(),
	after_place_node = minimal.protection_after_place_node,
})

minetest.register_node("tech:pane_clear", {
	description = S("Clear Glass Pane"),
	tiles = { "tech_clear_glass.png" },
	inventory_image = "tech_clear_pane_icon.png",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { { -1 / 2 + 1 / 10, -1 / 2, -1 / 32, 1 / 2 - 1 / 10, 1 / 2 - 2 / 10, 1 / 32 } }, -- Modified from xpanes
	},
	stack_max = minimal.stack_max_medium * 2,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { cracky = 3, oddly_breakable_by_hand = 3 },
	use_texture_alpha = c_alpha.blend,
	sunlight_propagates = true,
	sounds = nodes_nature.node_sound_glass_defaults(),
	after_place_node = minimal.protection_after_place_node,
})

-- Windows - glass panes with framing

minetest.register_node("tech:window_green", {
	description = S("Green Glass Window"),
	tiles = {
		"tech_oiled_wood.png",
		"tech_oiled_wood.png",
		"tech_oiled_wood.png",
		"tech_oiled_wood.png",
		"tech_green_glass_window.png",
		"tech_green_glass_window.png",
	},
	inventory_image = "tech_green_glass_window.png^[noalpha",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { { -1 / 2, -1 / 2, -1 / 32, 1 / 2, 1 / 2, 1 / 32 } }, -- From xpanes
	},
	stack_max = minimal.stack_max_medium * 2,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { cracky = 3, oddly_breakable_by_hand = 3 },
	use_texture_alpha = c_alpha.blend,
	sunlight_propagates = true,
	sounds = nodes_nature.node_sound_glass_defaults(),
	after_place_node = minimal.protection_after_place_node,
})

minetest.register_node("tech:window_clear", {
	description = S("Clear Glass Window"),
	tiles = {
		"tech_oiled_wood.png",
		"tech_oiled_wood.png",
		"tech_oiled_wood.png",
		"tech_oiled_wood.png",
		"tech_clear_glass_window.png",
		"tech_clear_glass_window.png",
	},
	inventory_image = "tech_clear_glass_window.png^[noalpha",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { { -1 / 2, -1 / 2, -1 / 32, 1 / 2, 1 / 2, 1 / 32 } }, -- From xpanes
	},
	stack_max = minimal.stack_max_medium * 2,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { cracky = 3, oddly_breakable_by_hand = 3 },
	use_texture_alpha = c_alpha.blend,
	sunlight_propagates = true,
	sounds = nodes_nature.node_sound_glass_defaults(),
	after_place_node = minimal.protection_after_place_node,
})

-- Glass Vessels
-- More portable liquid storage than clay pots
-- Need inventory images, otherwise clear glass ones will be invisible

minetest.register_node("tech:glass_bottle_green", {
	description = S("Green Glass Bottle"),
	tiles = { "tech_green_glass.png" },
	inventory_image = "tech_bottle_green_icon.png",
	drawtype = "mesh",
	mesh = "tech_bottle.obj",
	stack_max = minimal.stack_max_heavy,
	paramtype = "light",
	liquids_pointable = true,
	sunlight_prpagates = true,
	on_use = function(itemstack, user, pointed_thing)
		return liquid_store.on_use_empty_bucket(itemstack, user, pointed_thing)
	end,
	--collect rain water
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(30, 60))
	end,
	groups = { dig_immediate = 2, pottery = 1, temp_pass = 1 },
	sounds = nodes_nature.node_sound_stone_defaults(),
	use_texture_alpha = c_alpha.blend,
	selection_box = {
		type = "fixed",
		fixed = { -0.275, -0.5, -0.225, 0.25, 0.35, 0.275 },
	},
})

minetest.register_node("tech:glass_bottle_clear", {
	description = S("Clear Glass Bottle"),
	tiles = { "tech_clear_glass.png" },
	inventory_image = "tech_bottle_clear_icon.png",
	drawtype = "mesh",
	mesh = "tech_bottle.obj",
	stack_max = minimal.stack_max_heavy,
	paramtype = "light",
	liquids_pointable = true,
	sunlight_prpagates = true,
	on_use = function(itemstack, user, pointed_thing)
		return liquid_store.on_use_empty_bucket(itemstack, user, pointed_thing)
	end,
	--collect rain water
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(30, 60))
	end,
	groups = { dig_immediate = 2, pottery = 1, temp_pass = 1 },
	sounds = nodes_nature.node_sound_stone_defaults(),
	use_texture_alpha = c_alpha.blend,
	selection_box = {
		type = "fixed",
		fixed = { -0.275, -0.5, -0.225, 0.25, 0.35, 0.275 },
	},
})

-- Water stores for the jars
-- Salt Water
liquid_store.register_stored_liquid(
	"nodes_nature:salt_water_source",
	"tech:glass_bottle_green_saltwater",
	"tech:glass_bottle_green",
	{
		"tech_bottle_green_water.png",
	},
	{
		type = "fixed",
		fixed = {
			{ -0.2, -0.5, -0.2, 0.2, -0.4, 0.2 }, -- base
			{ -0.3, -0.5, -0.2, -0.2, 0.2, 0.2 }, -- z-wall
			{ 0.3, -0.5, 0.2, 0.2, 0.2, -0.2 }, -- z-wall
			{ -0.3, -0.5, -0.3, 0.3, 0.2, -0.2 }, --x-wall
			{ 0.3, -0.5, 0.3, -0.3, 0.2, 0.2 }, --x-wall
			{ -0.3, 0.2, -0.3, -0.1, 0.3, 0.3 }, -- top
			{ 0.3, 0.2, 0.3, 0.1, 0.3, -0.3 }, -- top
			{ 0.1, 0.2, 0.3, -0.1, 0.3, 0.1 }, -- top
			{ -0.1, 0.2, -0.3, 0.1, 0.3, -0.1 }, -- top

			{ -0.2, 0.3, -0.2, -0.1, 0.5, 0.2 }, -- lip
			{ 0.2, 0.3, 0.2, 0.1, 0.5, -0.2 }, -- lip
			{ 0.1, 0.3, 0.2, -0.1, 0.5, 0.1 }, -- lip
			{ 0.1, 0.3, -0.2, -0.1, 0.5, -0.1 }, -- lip
		},
	},
	S("Green Glass Bottle With Salt Water"),
	{ dig_immediate = 2 }
)

minetest.override_item("tech:glass_bottle_green_saltwater", {
	use_texture_alpha = c_alpha.blend,
	sunlight_propagates = true,
	stack_max = minimal.stack_max_heavy,
	drawtype = "mesh",
	mesh = "tech_bottle_liquid.obj",
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.35, 0.25 },
	},
	inventory_image = "tech_bottle_green_icon.png",
})

liquid_store.register_stored_liquid(
	"nodes_nature:salt_water_source",
	"tech:glass_bottle_clear_saltwater",
	"tech:glass_bottle_clear",
	{
		"tech_bottle_clear_water.png",
	},
	{
		type = "fixed",
		fixed = {
			{ -0.2, -0.5, -0.2, 0.2, -0.4, 0.2 }, -- base
			{ -0.3, -0.5, -0.2, -0.2, 0.2, 0.2 }, -- z-wall
			{ 0.3, -0.5, 0.2, 0.2, 0.2, -0.2 }, -- z-wall
			{ -0.3, -0.5, -0.3, 0.3, 0.2, -0.2 }, --x-wall
			{ 0.3, -0.5, 0.3, -0.3, 0.2, 0.2 }, --x-wall
			{ -0.3, 0.2, -0.3, -0.1, 0.3, 0.3 }, -- top
			{ 0.3, 0.2, 0.3, 0.1, 0.3, -0.3 }, -- top
			{ 0.1, 0.2, 0.3, -0.1, 0.3, 0.1 }, -- top
			{ -0.1, 0.2, -0.3, 0.1, 0.3, -0.1 }, -- top

			{ -0.2, 0.3, -0.2, -0.1, 0.5, 0.2 }, -- lip
			{ 0.2, 0.3, 0.2, 0.1, 0.5, -0.2 }, -- lip
			{ 0.1, 0.3, 0.2, -0.1, 0.5, 0.1 }, -- lip
			{ 0.1, 0.3, -0.2, -0.1, 0.5, -0.1 }, -- lip
		},
	},
	S("Clear Glass Bottle With Salt Water"),
	{ dig_immediate = 2 }
)

minetest.override_item("tech:glass_bottle_clear_saltwater", {
	use_texture_alpha = c_alpha.blend,
	sunlight_propagates = true,
	stack_max = minimal.stack_max_heavy,
	drawtype = "mesh",
	mesh = "tech_bottle_liquid.obj",
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.35, 0.25 },
	},

	inventory_image = "tech_bottle_clear_icon.png",
})

liquid_store.register_stored_liquid(
	"nodes_nature:freshwater_source",
	"tech:glass_bottle_green_freshwater",
	"tech:glass_bottle_green",
	{
		"tech_bottle_green_water.png",
	},
	{
		type = "fixed",
		fixed = {
			{ -0.2, -0.5, -0.2, 0.2, -0.4, 0.2 }, -- base
			{ -0.3, -0.5, -0.2, -0.2, 0.2, 0.2 }, -- z-wall
			{ 0.3, -0.5, 0.2, 0.2, 0.2, -0.2 }, -- z-wall
			{ -0.3, -0.5, -0.3, 0.3, 0.2, -0.2 }, --x-wall
			{ 0.3, -0.5, 0.3, -0.3, 0.2, 0.2 }, --x-wall
			{ -0.3, 0.2, -0.3, -0.1, 0.3, 0.3 }, -- top
			{ 0.3, 0.2, 0.3, 0.1, 0.3, -0.3 }, -- top
			{ 0.1, 0.2, 0.3, -0.1, 0.3, 0.1 }, -- top
			{ -0.1, 0.2, -0.3, 0.1, 0.3, -0.1 }, -- top

			{ -0.2, 0.3, -0.2, -0.1, 0.5, 0.2 }, -- lip
			{ 0.2, 0.3, 0.2, 0.1, 0.5, -0.2 }, -- lip
			{ 0.1, 0.3, 0.2, -0.1, 0.5, 0.1 }, -- lip
			{ 0.1, 0.3, -0.2, -0.1, 0.5, -0.1 }, -- lip
		},
	},
	S("Green Glass Bottle With Fresh Water"),
	{ dig_immediate = 2 }
)

minetest.override_item("tech:glass_bottle_green_freshwater", {
	drawtype = "mesh",
	mesh = "tech_bottle_liquid.obj",
	use_texture_alpha = c_alpha.blend,
	sunlight_propagates = true,
	stack_max = minimal.stack_max_heavy,
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.35, 0.25 },
	},
	inventory_image = "tech_bottle_green_icon.png",
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local meta = clicker:get_meta()
		local thirst = meta:get_int("thirst")
		--only drink if thirsty
		if thirst < 100 then
			local water = 100 --you're skulling a whole bucket
			thirst = thirst + water
			if thirst > 100 then
				thirst = 100
			end

			--could add disease risk, but different sources have different risks
			--e.g. rain vs mud puddle

			meta:set_int("thirst", thirst)
			minimal.switch_node(pos, { name = "tech:glass_bottle_green" })
			minetest.sound_play("nodes_nature_slurp", { pos = pos, max_hear_distance = 3, gain = 0.25 })
		end
	end,
})

liquid_store.register_stored_liquid(
	"nodes_nature:freshwater_source",
	"tech:glass_bottle_clear_freshwater",
	"tech:glass_bottle_clear",
	{
		"tech_bottle_clear_water.png",
	},
	{
		type = "fixed",
		fixed = {
			{ -0.2, -0.5, -0.2, 0.2, -0.4, 0.2 }, -- base
			{ -0.3, -0.5, -0.2, -0.2, 0.2, 0.2 }, -- z-wall
			{ 0.3, -0.5, 0.2, 0.2, 0.2, -0.2 }, -- z-wall
			{ -0.3, -0.5, -0.3, 0.3, 0.2, -0.2 }, --x-wall
			{ 0.3, -0.5, 0.3, -0.3, 0.2, 0.2 }, --x-wall
			{ -0.3, 0.2, -0.3, -0.1, 0.3, 0.3 }, -- top
			{ 0.3, 0.2, 0.3, 0.1, 0.3, -0.3 }, -- top
			{ 0.1, 0.2, 0.3, -0.1, 0.3, 0.1 }, -- top
			{ -0.1, 0.2, -0.3, 0.1, 0.3, -0.1 }, -- top

			{ -0.2, 0.3, -0.2, -0.1, 0.5, 0.2 }, -- lip
			{ 0.2, 0.3, 0.2, 0.1, 0.5, -0.2 }, -- lip
			{ 0.1, 0.3, 0.2, -0.1, 0.5, 0.1 }, -- lip
			{ 0.1, 0.3, -0.2, -0.1, 0.5, -0.1 }, -- lip
		},
	},
	S("Clear Glass Bottle With Fresh Water"),
	{ dig_immediate = 2 }
)

minetest.override_item("tech:glass_bottle_clear_freshwater", {
	drawtype = "mesh",
	mesh = "tech_bottle_liquid.obj",
	use_texture_alpha = c_alpha.blend,
	sunlight_propagates = true,
	stack_max = minimal.stack_max_heavy,
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.35, 0.25 },
	},
	inventory_image = "tech_bottle_clear_icon.png",
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local meta = clicker:get_meta()
		local thirst = meta:get_int("thirst")
		--only drink if thirsty
		if thirst < 100 then
			local water = 100 --you're skulling a whole bucket
			thirst = thirst + water
			if thirst > 100 then
				thirst = 100
			end

			--could add disease risk, but different sources have different risks
			--e.g. rain vs mud puddle

			meta:set_int("thirst", thirst)
			minimal.switch_node(pos, { name = "tech:glass_bottle_clear" })
			minetest.sound_play("nodes_nature_slurp", { pos = pos, max_hear_distance = 3, gain = 0.25 })
		end
	end,
})
