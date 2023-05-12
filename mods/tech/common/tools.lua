
base_use = 500
base_punch_int = minimal.hand_punch_int

-----------------------------------

--Till soil
function till_soil(itemstack, placer, pointed_thing, uses)
	--agriculture
	if pointed_thing.type ~= "node" then
		return
	end

	local under = minetest.get_node(pointed_thing.under)
	-- am I clicking on something with existing on_rightclick function?
	local def = minetest.registered_nodes[under.name]
	if def and def.on_rightclick then
		return def.on_rightclick(pointed_thing.under, under, placer, itemstack)
	end

	local p = {x=pointed_thing.under.x, y=pointed_thing.under.y+1, z=pointed_thing.under.z}
	local above = minetest.get_node(p)

	-- return if any of the nodes is not registered
	local node_name = under.name
	local nodedef = minetest.registered_nodes[node_name]

	if not nodedef then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end

	-- check if the node above the pointed thing is air
	if above.name ~= "air" then
		return
	end

	--living surface level sediment

	if minetest.get_item_group(node_name, "spreading") ~= 0 then

		--figure out what soil it is from dropped
		local ag_soil = nodedef._ag_soil

		minetest.swap_node(pointed_thing.under, {name = ag_soil})
		minetest.sound_play("nodes_nature_dig_crumbly", {pos = pointed_thing.under, gain = 0.5,})


		itemstack:add_wear(65535/(uses-1))

		return itemstack
	end

end

function path_making(itemstack, placer, pointed_thing, uses)
	if pointed_thing.type ~= "node" then
		return
	end



	local under = minetest.get_node(pointed_thing.under)
	-- am I clicking on something with existing on_rightclick function?
	local def = minetest.registered_nodes[under.name]
	if def and def.on_rightclick then
		return def.on_rightclick(pointed_thing.under, under, placer, itemstack)
	end

	local p = {x=pointed_thing.under.x, y=pointed_thing.under.y+1, z=pointed_thing.under.z}
	local above = minetest.get_node(p)

	-- return if any of the nodes is not registered
	local node_name = under.name
	local nodedef = minetest.registered_nodes[node_name]

	if not nodedef then
		return
	end
	if not minetest.registered_nodes[above.name] then
		return
	end

	-- check if the node above the pointed thing is air
	if above.name ~= "air" then
		return
	end

	--living surface level sediment

	local sediments = {
	    [1] = 'loam', [2] = 'clay', [3] = 'silt', [4] = 'sand', [5] = 'gravel'
	}
	if nodedef.groups['sediment'] then
		local path_node = "nodes_nature:"..sediments[nodedef.groups['sediment']].."_path"
		if minetest.registered_nodes[path_node] then
			minetest.swap_node(pointed_thing.under, {name = path_node})
			minetest.sound_play("nodes_nature_dig_crumbly", {pos = pointed_thing.under, gain = 0.5,})
			itemstack:add_wear(65535/(uses-1))
			return itemstack
		end
	end

end
--------------------------
--1st level
--Crude emergency tools

hand_max_lvl = minimal.hand_max_lvl
crude = 0.8
crude_max_lvl = hand_max_lvl

--damage
crude_dmg = minimal.hand_dmg * 2
--snappy
crude_snap3 = minimal.hand_snap * crude
crude_snap2 = crude_snap3 * minimal.t_scale2
crude_snap1 = crude_snap3 * minimal.t_scale1
crude_snap0 = 100 -- really long dig time - effectively disabled
--crumbly
crude_crum3 = minimal.hand_crum * crude
crude_crum2 = crude_crum3 * minimal.t_scale2
crude_crum1 = crude_crum3 * minimal.t_scale1
crude_crum0 = 100 -- really long dig time - effectively disabled
--choppy
crude_chop3 = minimal.hand_chop * crude
crude_chop2 = crude_chop3 * minimal.t_scale2
--cracky
--none at this level



--------------------------
--2nd level
--polished stone tools. Sophisticated stone age tools

--[[
note: we have multiple rock types
Granite is harder than basalt.
]]--

stone = 0.8
stone_use = base_use * 2
stone_max_lvl = hand_max_lvl

--damage
stone_dmg = crude_dmg * 2
--snappy
stone_snap3 = crude_snap3 * stone
stone_snap2 = crude_snap2 * stone
stone_snap1 = crude_snap1 * stone
--crumbly
stone_crum3 = crude_crum3 * stone
stone_crum2 = crude_crum2 * stone
stone_crum1 = crude_crum1 * stone
--choppy
stone_chop3 = crude_chop3 * stone
stone_chop2 = crude_chop2 * stone
--cracky
--none at this level



--------------------------
--3rd level
--iron tools.



iron = 0.9
iron_use = base_use * 4
iron_max_lvl = hand_max_lvl + 1

--damage
iron_dmg = stone_dmg * 2
--snappy
iron_snap3 = stone_snap3 * iron
iron_snap2 = stone_snap2 * iron
iron_snap1 = stone_snap1 * iron
--crumbly
iron_crum3 = stone_crum3 * iron
iron_crum2 = stone_crum2 * iron
iron_crum1 = stone_crum1 * iron
--choppy
iron_chop3 = stone_chop3 * iron
iron_chop2 = stone_chop2 * iron
iron_chop1 = (minimal.hand_chop * minimal.t_scale1) * crude * stone * iron
--cracky
iron_crac3 = minimal.hand_crac * crude * stone * iron
iron_crac2 = (minimal.hand_crac * minimal.t_scale2) * crude * stone * iron

