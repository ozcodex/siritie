--------------

--crushed_iron_ore
--raw ore broken into gravel
minetest.register_node("tech:crushed_iron_ore", {
	description = S("Crushed Iron Ore"),
	tiles = { "tech_crushed_iron_ore.png" },
	stack_max = minimal.stack_max_bulky * 2,
	paramtype = "light",
	groups = { crumbly = 3, falling_node = 1, heatable = 10 },
	sounds = nodes_nature.node_sound_gravel_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		set_roast_iron(pos, 10, 10)
	end,
	on_timer = function(pos, elapsed)
		--selfname, finished product, length, heat, smelt
		return roast_iron(pos, "tech:crushed_iron_ore", "tech:roasted_iron_ore", 10, 300, false)
	end,
})

--roasted_iron_ore
--crushed ore pre-roasted
minetest.register_node("tech:roasted_iron_ore", {
	description = S("Roasted Iron Ore"),
	tiles = { "tech_roasted_iron_ore.png" },
	stack_max = minimal.stack_max_bulky * 2,
	paramtype = "light",
	groups = { crumbly = 3, falling_node = 1 },
	sounds = nodes_nature.node_sound_gravel_defaults(),
})

--roasted iron ore powder
--more smelting prep
minetest.register_node("tech:roasted_iron_ore_powder", {
	description = S("Roasted Iron Ore Powder"),
	tiles = { "tech_roasted_iron_ore_powder.png" },
	stack_max = minimal.stack_max_bulky * 4,
	paramtype = "light",
	groups = { crumbly = 3, falling_node = 1 },
	sounds = nodes_nature.node_sound_gravel_defaults(),
})

--iron smelting mix
--mix of charcoal blocks and roasted iron ore powder, ready for smelting
--initial heating turns it into slag and iron mix, which continues actual smelt
minetest.register_node("tech:iron_smelting_mix", {
	description = S("Iron Smelting Mix"),
	tiles = { "tech_iron_smelting_mix.png" },
	stack_max = minimal.stack_max_bulky * 4,
	paramtype = "light",
	groups = { crumbly = 3, falling_node = 1, heatable = 20 },
	sounds = nodes_nature.node_sound_gravel_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		set_roast_iron(pos, 2, 10)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length, heat, smelt
		return roast_iron(pos, "tech:iron_smelting_mix", "tech:iron_and_slag", 2, 1350, false)
	end,
})

--iron and slag
--unseperated iron and impurities
minetest.register_node("tech:iron_and_slag", {
	description = S("Iron and Slag"),
	tiles = { "tech_iron_and_slag.png" },
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	groups = { cracky = 3, crumbly = 1, falling_node = 1, heatable = 20 },
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		set_roast_iron(pos, 50, 10)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length, heat, smelt
		return roast_iron(pos, "tech:iron_and_slag", "tech:iron_bloom", 50, 1350, true)
	end,

	on_dig = function(pos, node, digger)
		on_dig_iron_and_slag(pos, node, digger)
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		after_place_iron_and_slag(pos, placer, itemstack, pointed_thing)
	end,
})

--------------------
--iron bloom
--smelted iron seperated from bulk of slag, but still not useable
minetest.register_node("tech:iron_bloom", {
	description = S("Iron Bloom"),
	tiles = { "tech_iron_and_slag.png" },
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, -0.1, 0.3 },
	},
	stack_max = minimal.stack_max_bulky * 4,
	paramtype = "light",
	groups = { cracky = 3, falling_node = 1, oddly_breakable_by_hand = 2, temp_pass = 1 },
	sounds = nodes_nature.node_sound_stone_defaults(),
})

----------------
--iron ingot
--iron seperated from remainder of slag, finished product
minetest.register_node("tech:iron_ingot", {
	description = S("Iron Ingot"),
	tiles = { "tech_iron.png" },
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.1, -0.5, -0.2, 0.1, -0.3, 0.2 },
	},
	stack_max = minimal.stack_max_bulky * 8,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { falling_node = 1, dig_immediate = 3, temp_pass = 1 },
	sounds = nodes_nature.node_sound_stone_defaults(),
})

-----------------
--slag
--waste product (cooled)
minetest.register_node("tech:slag", {
	description = S("Slag"),
	tiles = { "tech_iron_and_slag.png" },
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	groups = { cracky = 3, falling_node = 1, crumbly = 1 },
	sounds = nodes_nature.node_sound_stone_defaults(),
})

minetest.register_node("tech:molten_slag_source", {
	description = S("Molten Slag"),
	drawtype = "liquid",
	tiles = {
		{
			name = "nodes_nature_lava_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
		{
			name = "nodes_nature_lava_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	paramtype = "light",
	light_source = lava_light_molten_slag,
	temp_effect = lava_temp_effect_molten_slag,
	temp_effect_max = lava_heater_molten_slag,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "tech:molten_slag_flowing",
	liquid_alternative_source = "tech:molten_slag_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = { a = 191, r = 255, g = 64, b = 0 },
	groups = { igniter = 1, temp_effect = 1 },
	--cooling
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(10)
	end,
	on_timer = function(pos, elapsed)
		if math.random() > 0.87 then
			minetest.sound_play("nodes_nature_cool_lava", { pos = pos, max_hear_distance = 8, gain = 0.1 })
			minetest.set_node(pos, { name = "tech:slag" })
			minetest.check_for_falling(pos)
			return false
		else
			return true
		end
	end,
})

minetest.register_node("tech:molten_slag_flowing", {
	description = S("Flowing Molten Slag"),
	drawtype = "flowingliquid",
	tiles = { "nodes_nature_lava.png" },
	special_tiles = {
		{
			name = "nodes_nature_lava_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "nodes_nature_lava_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = lava_light_molten_slag,
	temp_effect = lava_temp_effect_molten_slag,
	temp_effect_max = lava_heater_molten_slag,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "tech:molten_slag_flowing",
	liquid_alternative_source = "tech:molten_slag_source",
	liquid_viscosity = 3,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = { a = 191, r = 255, g = 64, b = 0 },
	groups = { igniter = 1, not_in_creative_inventory = 1, temp_effect = 1, temp_pass = 1 },
	--cooling
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(1)
	end,
	on_timer = function(pos, elapsed)
		if math.random() > 0.95 then
			minetest.sound_play("nodes_nature_cool_lava", { pos = pos, max_hear_distance = 8, gain = 0.1 })
			minetest.set_node(pos, { name = "tech:slag" })
			minetest.check_for_falling(pos)
			return false
		else
			return true
		end
	end,
})

--- new metal aluminium

minetest.register_node("tech:aluminium_mix", {
	description = S("Aluminium Mix"),
	tiles = { "tech_aluminium_mix.png" },
	stack_max = minimal.stack_max_bulky,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -4 / 16, -0.5, -4 / 16, 4 / 16, 0 / 16, 4 / 16 },
	},
	paramtype = "light",
	groups = { cracky = 3, crumbly = 1, falling_node = 1, heatable = 20 },
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		set_roast_iron(pos, 30, 3)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length, heat, smelt
		return roast_iron(pos, "tech:aluminium_mix", "tech:aluminium_ingot", 30, 660, true)
	end,
})

minetest.register_node("tech:aluminium_ingot", {
	description = S("Aluminium Ingot"),
	tiles = { "tech_aluminium.png" },
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.1, -0.5, -0.2, 0.1, -0.35, 0.2 },
	},
	stack_max = minimal.stack_max_bulky * 8,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = { falling_node = 1, dig_immediate = 3, temp_pass = 1 },
	sounds = nodes_nature.node_sound_stone_defaults(),
})
