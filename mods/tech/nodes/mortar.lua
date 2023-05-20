--[[
Biggest pros:
-ease of use
-no need for stone (cheap)

Mortar
sand + binder + water (modern just uses cement. Ancient is lime)
Lime mortar:
crush limestone - > crushed lime
-> fire @ > 900C ->quicklime
-> + water = slaked lime
3 sand + one lime slaked lime -> lime mortar

]]

--crushed_lime
--broken into gravel
--fire into quicklime
minetest.register_node("tech:crushed_lime", {
	description = S("Crushed Lime"),
	tiles = { "tech_crushed_lime.png" },
	stack_max = minimal.stack_max_heavy,
	groups = { crumbly = 3, falling_node = 1, heatable = 10 },
	sounds = nodes_nature.node_sound_gravel_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		set_roast(pos, 3, 10)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length, heat
		--(realisticallty should be 900, but too hard for fires)
		return roast(pos, "tech:crushed_lime", "tech:quicklime", 3, 850)
	end,
})

--quicklime
--turns back into lime when exposed to air
minetest.register_node("tech:quicklime", {
	description = S("Quicklime"),
	tiles = { "tech_quicklime.png" },
	stack_max = minimal.stack_max_heavy,
	groups = { crumbly = 3, falling_node = 1 },
	sounds = nodes_nature.node_sound_sand_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(10)
	end,

	on_timer = function(pos, elapsed)
		--slake
		--XXX This is a bug; should look harder for the water source.
		local p_water = minetest.find_node_near(pos, 1, { "group:water" })
		if p_water then
			local p_name = minetest.get_node(p_water).name
			--check water type. Salt would ruin it.
			local water_type = minetest.get_item_group(p_name, "water")
			if water_type == 1 then
				minimal.switch_node(pos, { name = "tech:slaked_lime" })
				minetest.set_node(p_water, { name = "air" })
				minetest.sound_play("tech_boil", { pos = pos, max_hear_distance = 8, gain = 1 })
			elseif water_type == 2 then
				minetest.swap_node(pos, { name = "tech:slaked_lime_ruined" })
				minetest.set_node(p_water, { name = "air" })
				minetest.sound_play("tech_boil", { pos = pos, max_hear_distance = 8, gain = 1 })
			end
			return false
		end

		--slowly revert to lime by reacting with the air, or slake by rain
		if minetest.find_node_near(pos, 1, { "air" }) then
			if math.random() > 0.99 then
				if climate.get_rain(pos) then
					minimal.switch_node(pos, { name = "tech:slaked_lime" })
					minetest.sound_play("tech_boil", { pos = pos, max_hear_distance = 8, gain = 1 })
				else
					minimal.switch_node(pos, { name = "tech:crushed_lime" })
					return false
				end
			end
		end

		--it's still here...
		return true
	end,
})

--slaked lime
--turns back into lime when exposed to air
minetest.register_node("tech:slaked_lime", {
	description = S("Slaked Lime"),
	tiles = { "tech_flour.png" },
	stack_max = minimal.stack_max_heavy,
	groups = { crumbly = 3, falling_node = 1 },
	sounds = nodes_nature.node_sound_sand_defaults({
		footstep = { name = "nodes_nature_mud", gain = 0.4 },
		dug = { name = "nodes_nature_mud", gain = 0.4 },
	}),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(60)
	end,

	on_timer = function(pos, elapsed)
		if math.random() > 0.9 then
			--wash it away
			if minetest.find_node_near(pos, 1, { "group:water" }) or climate.get_rain(pos) then
				minetest.set_node(pos, { name = "air" })
				return false
			end

			--slowly revert to lime by reacting with the air
			if minetest.find_node_near(pos, 1, { "air" }) then
				minimal.switch_node(pos, { name = "tech:crushed_lime" })
				return false
			end
		end

		--it's still here...
		return true
	end,
})

--ruined slaked lime
--same as above, but got mixed with salt water, I suspect that's bad...
--but can't find what would happen
--turns back into lime when exposed to air
minetest.register_node("tech:slaked_lime_ruined", {
	description = S("Slaked Lime (ruined)"),
	tiles = { "tech_flour.png" },
	stack_max = minimal.stack_max_heavy,
	groups = { crumbly = 3, falling_node = 1 },
	sounds = nodes_nature.node_sound_sand_defaults({
		footstep = { name = "nodes_nature_mud", gain = 0.4 },
		dug = { name = "nodes_nature_mud", gain = 0.4 },
	}),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(60)
	end,

	on_timer = function(pos, elapsed)
		--wash it away
		if minetest.find_node_near(pos, 1, { "group:water" }) or climate.get_rain(pos) then
			minetest.set_node(pos, { name = "air" })
			return false
		end

		--slowly revert to lime by reacting with the air
		if minetest.find_node_near(pos, 1, { "air" }) then
			if math.random() > 0.9 then
				minimal.switch_node(pos, { name = "tech:crushed_lime" })
				return false
			end
		end

		--it's still here...
		return true
	end,
})

--Lime mortar
--Hooray... the product we actually want. Slaked lime with sand
--really should set to something, but creates logical mass balance problems
minetest.register_node("tech:lime_mortar", {
	description = S("Lime Mortar"),
	tiles = { "tech_lime_mortar.png" },
	stack_max = minimal.stack_max_heavy,
	groups = { crumbly = 3, falling_node = 1 },
	sounds = nodes_nature.node_sound_sand_defaults({
		footstep = { name = "nodes_nature_mud", gain = 0.4 },
		dug = { name = "nodes_nature_mud", gain = 0.4 },
	}),
	--[[
  on_construct = function(pos)
		minetest.get_node_timer(pos):start(60)
	end,

	on_timer = function(pos, elapsed)
    --wash it away
    if minetest.find_node_near(pos, 1, {"group:water"}) or climate.get_rain(pos) then
      minetest.set_node(pos, {name = "air"})
      return false
    end

    --slowly revert to limestone by reacting with the air, or slake by rain
    if minetest.find_node_near(pos, 1, {"air"}) then
      if math.random() > 0.9 then
        minetest.set_node(pos, {name = "nodes_nature:limestone"})
        return false
      end
    end

    --it's still here...
    return true
	end,
	]]
})

for i in ipairs(mortar_blocks_list) do
	local name = mortar_blocks_list[i][1]
	local desc = mortar_blocks_list[i][2]
	local hardness = mortar_blocks_list[i][3]

	--blocks and bricks
	--Bricks
	minetest.register_node("tech:" .. name .. "_brick_mortar", {
		description = S("@1 Brick with Mortar", desc),
		tiles = { "nodes_nature_" .. name .. "_brick.png^tech_mortar_brick.png" },
		drop = "nodes_nature:" .. name .. "_brick",
		paramtype2 = "facedir",
		stack_max = minimal.stack_max_large,
		groups = { cracky = hardness, masonry = 1 },
		sounds = nodes_nature.node_sound_stone_defaults(),
	})

	--block
	minetest.register_node("tech:" .. name .. "_block_mortar", {
		description = S("@1 Block with Mortar", desc),
		tiles = { "nodes_nature_" .. name .. "_block.png^tech_mortar_block.png" },
		paramtype2 = "facedir",
		drop = "nodes_nature:" .. name .. "_block",
		stack_max = minimal.stack_max_heavy,
		groups = { cracky = hardness, masonry = 1 },
		sounds = nodes_nature.node_sound_stone_defaults(),
	})

	--stairs and slabs

	--brick
	stairs.register_stair_and_slab(
		name .. "_brick_mortar",
		"tech:" .. name .. "_brick_mortar",
		"masonry_bench",
		"true",
		{ cracky = hardness },
		{ "nodes_nature_" .. name .. "_brick.png^tech_mortar_brick.png" },
		desc .. " Brick with Mortar Stair",
		desc .. " Brick with Mortar Slab",
		minimal.stack_max_large,
		nodes_nature.node_sound_stone_defaults()
	)

	--block
	if i > 4 then
		-- masonry table's cluttered bad, so let's say you can't easily make
		--  block stairs and slabs from the four crumbly sedimentary rocks
		stairs.register_stair_and_slab(
			name .. "_block_mortar",
			"tech:" .. name .. "_block_mortar",
			"masonry_bench",
			"false",
			{ cracky = hardness },
			{ "nodes_nature_" .. name .. "_block.png^tech_mortar_block.png" },
			desc .. " Block with Mortar Stair",
			desc .. " Block with Mortar Slab",
			minimal.stack_max_large,
			nodes_nature.node_sound_stone_defaults()
		)
	end
end
