function alembic_process(pos, elapsed)
	-- get block under alembic
	local below_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
	local below_node = minetest.get_node(below_pos)
	local below_name = below_node.name
	-- get current temperature of the below block
	local temp = climate.get_point_temp(below_pos)

	-- only continue if the block below is a clay water pot with water
	if not (below_name == "tech:clay_water_pot_salt_water" or below_name == "tech:clay_water_pot_freshwater") then
		-- stop the execution and try again later
		return true
	end

	-- determine time based on temperature
	local time
	if temp > 70 then
		time = 30 -- seconds
	elseif temp > 50 then
		time = 60 -- seconds
	else
		time = 120 -- seconds
	end

	-- decrease time elapsed
	local meta = minetest.get_meta(pos)
	local remaining = meta:get_float("remaining") or time
	remaining = remaining - elapsed

	-- if time elapsed, replace below block
	if remaining <= 0 then
		if below_name == "tech:clay_water_pot_salt_water" then
			minetest.swap_node(below_pos, {name = "tech:clay_water_pot_freshwater"})
			local inv = meta:get_inventory()
			inv:add_item("main", "alchemy:salt 1")
			update_alembic_infotext(pos)
		elseif below_name == "tech:clay_water_pot_freshwater" then
			minetest.swap_node(below_pos, {name = "tech:clay_water_pot"})
		end
		meta:set_float("remaining", time)
	else
		meta:set_float("remaining", remaining)
	end

	-- keep the timer running
	return true
end

function update_alembic_infotext(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local infotext = "Contents: "
	
	if inv:is_empty("main") then
		infotext = infotext.."empty"
	else
		--loop through each slot in the alembic inventory
		for i = 1, inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				infotext = infotext..stack:get_count().." "..minetest.registered_items[stack:get_name()].description..". "
			end
		end
	end
	minimal.infotext_set(pos,meta,infotext)
end


