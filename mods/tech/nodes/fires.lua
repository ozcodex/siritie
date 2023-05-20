--wood_ash
minetest.register_node("tech:wood_ash_block", {
	description = S("Wood Ash Block"),
	tiles = { "tech_wood_ash.png" },
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	groups = { crumbly = 3, falling_node = 1, fertilizer = 1 },
	sounds = nodes_nature.node_sound_dirt_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		on_place_fert(itemstack, placer, pointed_thing)
		return itemstack
	end,
})

minetest.register_node("tech:wood_ash", {
	description = S("Wood Ash"),
	tiles = { "tech_wood_ash.png" },
	stack_max = minimal.stack_max_heavy,
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
	},
	groups = { crumbly = 3, falling_node = 1, fertilizer = 1 },
	sounds = nodes_nature.node_sound_dirt_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		on_place_fert(itemstack, placer, pointed_thing)
		return itemstack
	end,
})

--Charcoal
minetest.register_node("tech:charcoal_block", {
	description = S("Charcoal Block"),
	tiles = { "tech_charcoal.png" },
	paramtype = "light",
	stack_max = minimal.stack_max_bulky,
	groups = { crumbly = 3, falling_node = 1, fertilizer = 1, flammable = 1 },
	sounds = nodes_nature.node_sound_dirt_defaults(),
	on_burn = function(pos)
		minimal.switch_node(pos, { name = "tech:large_charcoal_fire" })
		minetest.check_for_falling(pos)
	end,
})

minetest.register_node("tech:crushed_charcoal_block", {
	description = S("Charcoal Powder Block"),
	tiles = { "tech_crushed_charcoal.png" },
	paramtype = "light",
	stack_max = minimal.stack_max_bulky,
	groups = { crumbly = 3, falling_node = 1, fertilizer = 1, flammable = 1 },
	sounds = nodes_nature.node_sound_dirt_defaults(),
	on_burn = function(pos)
		minimal.switch_node(pos, { name = "tech:large_charcoal_fire" })
		minetest.check_for_falling(pos)
	end,
})

minetest.register_node("tech:charcoal", {
	description = S("Charcoal"),
	tiles = { "tech_charcoal.png" },
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
	},
	stack_max = minimal.stack_max_heavy,
	groups = { crumbly = 3, falling_node = 1, fertilizer = 1, flammable = 1 },
	sounds = nodes_nature.node_sound_dirt_defaults(),
	on_burn = function(pos)
		minimal.switch_node(pos, { name = "tech:small_charcoal_fire" })
		minetest.check_for_falling(pos)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		return minimal.slabs_combine(pos, node, itemstack, "tech:charcoal_block")
	end,
})

--unlit wood fires
minetest.register_node("tech:small_wood_fire_unlit", {
	description = S("Small Wood Fire (unlit)\n(Stack two to make a large fire)"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
	},
	tiles = { "tech_wood_fire_unlit.png" },
	stack_max = minimal.stack_max_heavy,
	paramtype = "light",
	groups = { oddly_breakable_by_hand = 3, choppy = 3, falling_node = 1, flammable = 1 },
	sounds = nodes_nature.node_sound_wood_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		return minimal.slabs_combine(pos, node, itemstack, "tech:large_wood_fire_unlit")
	end,
	on_burn = function(pos)
		minimal.switch_node(pos, { name = "tech:small_wood_fire" })
		minetest.check_for_falling(pos)
	end,
})

minetest.register_node("tech:large_wood_fire_unlit", {
	description = S("Large Wood Fire (unlit)"),
	tiles = { "tech_wood_fire_unlit.png" },
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	groups = { oddly_breakable_by_hand = 3, choppy = 3, falling_node = 1, flammable = 1 },
	sounds = nodes_nature.node_sound_wood_defaults(),
	on_burn = function(pos)
		minimal.switch_node(pos, { name = "tech:large_wood_fire" })
		minetest.check_for_falling(pos)
	end,
})

--lit wood fires
minetest.register_node("tech:small_wood_fire", {
	description = S("Small Wood Fire"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
	},
	tiles = { "tech_coal_bed.png" },
	light_source = 7,
	temp_effect = wood_temp_effect,
	temp_effect_max = wood_temp_max,
	paramtype = "light",
	--walkable = false,
	drop = "tech:wood_ash",
	groups = { crumbly = 1, igniter = 1, falling_node = 1, temp_effect = 1, temp_pass = 1 },
	--damage_per_second = 1,
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_punch = function(pos, node, puncher, pointed_thing)
		extinguish_fire(pos, puncher, "tech:small_wood_fire_ext")
	end,

	on_construct = function(pos)
		--duration of burn
		local meta = minetest.get_meta(pos)
		if not meta:contains("fuel") then
			meta:set_int("fuel", base_fuel)
		end

		--fire effects..
		minetest.get_node_timer(pos):start(math.random(base_burn_rate - 1, base_burn_rate + 1))
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			minimal.switch_node(pos, { name = "tech:wood_ash" })
			return false
		elseif can_burn_air(pos, meta, "tech:small_wood_fire_smoldering", "tech:wood_ash") then
			hearth_fire_on(pos)
			meta:set_int("fuel", fuel - 1)
			--add hot air
			climate.air_temp_source(pos, wood_temp_effect, wood_temp_max, wood_air_c, base_burn_rate)
			-- Restart timer
			return true
		end
	end,
})

minetest.register_node("tech:large_wood_fire", {
	description = S("Large Wood Fire"),
	tiles = { "tech_coal_bed.png" },
	light_source = 8,
	paramtype = "light",
	temp_effect = wood_temp_effect * 2,
	temp_effect_max = wood_temp_max * 1.5,
	--walkable = false,
	drop = "tech:wood_ash_block",
	groups = { crumbly = 1, igniter = 1, falling_node = 1, temp_effect = 1, temp_pass = 1 },
	--damage_per_second = 1,
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_punch = function(pos, node, puncher, pointed_thing)
		extinguish_fire(pos, puncher, "tech:large_wood_fire_ext")
	end,

	on_construct = function(pos)
		--duration of burn
		local meta = minetest.get_meta(pos)
		if not meta:contains("fuel") then
			meta:set_int("fuel", base_fuel * 2)
		end
		--fire effects
		minetest.get_node_timer(pos):start(math.random(base_burn_rate - 1, base_burn_rate + 1))
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			minimal.switch_node(pos, { name = "tech:wood_ash_block" })
			return false
		elseif can_burn_air(pos, meta, "tech:large_wood_fire_smoldering", "tech:wood_ash_block") then
			hearth_fire_on(pos)
			meta:set_int("fuel", fuel - 1)
			--add hot air
			climate.air_temp_source(pos, wood_temp_effect * 2, wood_temp_max * 2, wood_air_c - 0.1, base_burn_rate)
			-- Restart timer
			return true
		end
	end,
})

--
-- smoldering wood fires (can turn into charcoal)
--colder and flameless
--
minetest.register_node("tech:small_wood_fire_smoldering", {
	description = S("Small Wood Fire (smoldering)"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
	},
	tiles = { "tech_coal_bed.png" },
	light_source = 3,
	paramtype = "light",
	temp_effect = wood_temp_effect / 3,
	temp_effect_max = wood_temp_max,
	--walkable = false,
	drop = "tech:wood_ash",
	groups = { crumbly = 1, falling_node = 1, temp_effect = 1, temp_pass = 1 },
	--damage_per_second = 1,
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_punch = function(pos, node, puncher, pointed_thing)
		extinguish_fire(pos, puncher, "tech:small_wood_fire_ext")
	end,

	on_construct = function(pos)
		--no meta , should only be made from a pre-existing fire
		--checks
		minetest.get_node_timer(pos):start(base_burn_rate * 1.5)
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			-- Charcoal needs to start with fresh fuel value so no swap_node here
			minetest.set_node(pos, { name = "tech:charcoal" })
			return false
		else
			if can_smolder(pos, meta, "tech:small_wood_fire", "tech:wood_ash") then
				meta:set_int("fuel", fuel - 1)
				--add hot air
				climate.air_temp_source(pos, wood_temp_effect / 3, wood_temp_max, wood_air_c + 0.3, base_burn_rate)
				-- Restart timer
				return true
			end
		end
	end,
})

minetest.register_node("tech:large_wood_fire_smoldering", {
	description = S("Large Wood Fire (smoldering)"),
	tiles = { "tech_coal_bed.png" },
	light_source = 3,
	paramtype = "light",
	temp_effect = (wood_temp_effect * 2) / 3,
	temp_effect_max = (wood_temp_max * 1.5),
	--walkable = false,
	drop = "tech:wood_ash_block",
	groups = { crumbly = 1, falling_node = 1, temp_effect = 1, temp_pass = 1 },
	--damage_per_second = 1,
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_punch = function(pos, node, puncher, pointed_thing)
		extinguish_fire(pos, puncher, "tech:large_wood_fire_ext")
	end,

	on_construct = function(pos)
		--no meta , should only be made from a pre-existing fire
		--checks
		minetest.get_node_timer(pos):start(base_burn_rate * 1.5)
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			-- Charcoal needs to start with fresh fuel value so no swap_node here
			minetest.set_node(pos, { name = "tech:charcoal_block" })
			return false
		else
			if can_smolder(pos, meta, "tech:large_wood_fire", "tech:wood_ash_block") then
				meta:set_int("fuel", fuel - 1)
				--add hot air
				climate.air_temp_source(
					pos,
					(wood_temp_effect * 2) / 3,
					wood_temp_max * 2,
					wood_air_c + 0.15,
					base_burn_rate
				)
				-- Restart timer
				return true
			end
		end
	end,
})

--------------------------------------------------

--Charcoal fires
--hotter than wood
--
minetest.register_node("tech:small_charcoal_fire", {
	description = S("Small Charcoal Fire"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
	},
	tiles = { "tech_coal_bed.png" },
	light_source = 7,
	temp_effect = char_temp_effect,
	temp_effect_max = char_temp_max,
	paramtype = "light",
	--walkable = false,
	drop = "tech:wood_ash",
	groups = { crumbly = 1, igniter = 1, falling_node = 1, temp_effect = 1, temp_pass = 1 },
	--damage_per_second = 1,
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_punch = function(pos, node, puncher, pointed_thing)
		extinguish_fire(pos, puncher, "tech:small_charcoal_fire_ext")
	end,

	on_construct = function(pos)
		--duration of burn ...less than wood due to loss
		local meta = minetest.get_meta(pos)
		if not meta:contains("fuel") then
			meta:set_int("fuel", base_fuel * 0.75)
		end
		--fire effects...more consistent burn.
		minetest.get_node_timer(pos):start(base_burn_rate)
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			minimal.switch_node(pos, { name = "tech:wood_ash" })
			return false
		elseif can_burn_air(pos, meta, "tech:small_charcoal_fire_smoldering", "tech:wood_ash") then
			hearth_fire_on(pos)
			meta:set_int("fuel", fuel - 1)
			--add hot air
			climate.air_temp_source(pos, char_temp_effect, char_temp_max, char_air_c, base_burn_rate)
			-- Restart timer
			return true
		end
	end,
})

minetest.register_node("tech:large_charcoal_fire", {
	description = S("Large Charcoal Fire"),
	tiles = { "tech_coal_bed.png" },
	light_source = 8,
	temp_effect = char_temp_effect * 2,
	temp_effect_max = char_temp_max * 1.5,
	paramtype = "light",
	--walkable = false,
	drop = "tech:wood_ash_block",
	groups = { crumbly = 1, igniter = 1, falling_node = 1, temp_effect = 1, temp_pass = 1 },
	--damage_per_second = 1,
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_punch = function(pos, node, puncher, pointed_thing)
		extinguish_fire(pos, puncher, "tech:large_charcoal_fire_ext")
	end,

	on_construct = function(pos)
		--duration of burn
		local meta = minetest.get_meta(pos)
		if not meta:contains("fuel") then
			meta:set_int("fuel", base_fuel * 2 * 0.75)
		end

		--fire effects
		minetest.get_node_timer(pos):start(base_burn_rate)
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			minimal.switch_node(pos, { name = "tech:wood_ash_block" })
			return false
		elseif can_burn_air(pos, meta, "tech:large_charcoal_fire_smoldering", "tech:wood_ash_block") then
			hearth_fire_on(pos)
			meta:set_int("fuel", fuel - 1)
			--add hot air
			climate.air_temp_source(pos, char_temp_effect * 2, char_temp_max * 2, char_air_c - 0.1, base_burn_rate)
			-- Restart timer
			return true
		end
	end,
})

--
-- smoldering charcoal fires
--colder and flameless...reduce to ash
--
minetest.register_node("tech:small_charcoal_fire_smoldering", {
	description = S("Small Charcoal Fire (smoldering)"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
	},
	tiles = { "tech_coal_bed.png" },
	light_source = 3,
	temp_effect = char_temp_effect / 3,
	temp_effect_max = char_temp_max,
	paramtype = "light",
	--walkable = false,
	drop = "tech:wood_ash",
	groups = { crumbly = 1, falling_node = 1, temp_effect = 1, temp_pass = 1 },
	--damage_per_second = 1,
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_punch = function(pos, node, puncher, pointed_thing)
		extinguish_fire(pos, puncher, "tech:small_charcoal_fire_ext")
	end,

	on_construct = function(pos)
		--no meta , should only be made from a pre-existing fire
		--checks
		minetest.get_node_timer(pos):start(base_burn_rate * 1.5)
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			minimal.switch_node(pos, { name = "tech:wood_ash" })
			return false
		else
			if can_smolder(pos, meta, "tech:small_charcoal_fire", "tech:wood_ash") then
				meta:set_int("fuel", fuel - 1)
				--add hot air
				climate.air_temp_source(pos, char_temp_effect / 3, char_temp_max, char_air_c + 0.3, base_burn_rate)
				-- Restart timer
				return true
			end
		end
	end,
})

minetest.register_node("tech:large_charcoal_fire_smoldering", {
	description = S("Large Charcoal Fire (smoldering)"),
	tiles = { "tech_coal_bed.png" },
	light_source = 3,
	temp_effect = (char_temp_effect * 2) / 3,
	temp_effect_max = (char_temp_max * 1.5),
	paramtype = "light",
	--walkable = false,
	drop = "tech:wood_ash_block",
	groups = { crumbly = 1, falling_node = 1, temp_effect = 1, temp_pass = 1 },
	--damage_per_second = 1,
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_punch = function(pos, node, puncher, pointed_thing)
		extinguish_fire(pos, puncher, "tech:large_charcoal_fire_ext")
	end,

	on_construct = function(pos)
		--duration of burn
		minetest.get_node_timer(pos):start(base_burn_rate * 1.5)
	end,
	on_timer = function(pos, elapsed)
		local meta = minetest.get_meta(pos)
		local fuel = meta:get_int("fuel")
		if fuel < 1 then
			minimal.switch_node(pos, { name = "tech:wood_ash_block" })
			return false
		else
			if can_smolder(pos, meta, "tech:large_charcoal_fire", "tech:wood_ash_block") then
				meta:set_int("fuel", fuel - 1)
				--add hot air
				climate.air_temp_source(
					pos,
					(char_temp_effect * 2) / 3,
					char_temp_max * 2,
					char_air_c + 0.15,
					base_burn_rate
				)
				-- Restart timer
				return true
			end
		end
	end,
})

-- wood fires
minetest.register_node("tech:small_wood_fire_ext", {
	description = S("Small Wood Fire (extinguished)"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
	},
	tiles = { "tech_fire_ext.png" },
	paramtype = "light",
	groups = { crumbly = 3, oddly_breakable_by_hand = 1, falling_node = 1, temp_pass = 1, flammable = 3 },
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_dig = on_dig_fire,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		return minimal.slabs_combine(pos, node, itemstack, "tech:large_wood_fire_ext")
	end,
	after_place_node = after_place_fire,

	on_burn = function(pos)
		inferno.ignite(pos)
	end,
})

minetest.register_node("tech:large_wood_fire_ext", {
	description = S("Large Wood Fire (extinguished)"),
	tiles = { "tech_fire_ext.png" },
	groups = { crumbly = 3, oddly_breakable_by_hand = 1, falling_node = 1, temp_pass = 1, flammable = 3 },
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_dig = on_dig_fire,
	after_place_node = after_place_fire,
	on_burn = function(pos)
		inferno.ignite(pos)
	end,
})

-- charcoal fires
minetest.register_node("tech:small_charcoal_fire_ext", {
	description = S("Small Charcoal Fire (extinguished)"),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 },
	},
	tiles = { "tech_fire_ext.png" },
	paramtype = "light",
	groups = { crumbly = 3, oddly_breakable_by_hand = 1, falling_node = 1, temp_pass = 1, flammable = 3 },
	sounds = nodes_nature.node_sound_dirt_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		return minimal.slabs_combine(pos, node, itemstack, "tech:large_charcoal_fire_ext")
	end,
	on_dig = on_dig_fire,
	after_place_node = after_place_fire,
	on_burn = function(pos)
		inferno.ignite(pos)
	end,
})

minetest.register_node("tech:large_charcoal_fire_ext", {
	description = S("Large Charcoal Fire (extinguished)"),
	tiles = { "tech_fire_ext.png" },
	groups = { crumbly = 3, oddly_breakable_by_hand = 1, falling_node = 1, temp_pass = 1, flammable = 3 },
	sounds = nodes_nature.node_sound_dirt_defaults(),

	on_dig = on_dig_fire,
	after_place_node = after_place_fire,
	on_burn = function(pos)
		inferno.ignite(pos)
	end,
})
