
----------------------------------------------------------------------
--NODES

--Steps
--this is a simplified version of bloomery furnace method.
--leaves out steps that involve keeping a temporarily hot item in inventory,
--because that is annoying to code e.g. quenching and hammering hot metal

--1: Get ore
--2: crush ore into 'tech:crushed_iron_ore'
--3: roast 'tech:crushed_iron_ore' at wood fire heat into 'tech:roasted_iron_ore'
--4. powder into 'tech:roasted_iron_ore_powder'
--5. mix with x charcoal for 'tech:iron_smelting_mix'
--6. heat to smelt temp to create iron_slag_mix
--7. keep hot enough for X minutes (and a drainage space), for molten slag to run off.
--8. leaves behind small iron bloom (plus cooling slag nearby)
--9. hammer bloom into ingots
--10. make iron anvil out of many ingots
--11. make iron tools at anvil


--------------------------------------


--molten slag
lava_light_molten_slag = 6
lava_temp_effect_molten_slag = 6
lava_heater_molten_slag = 1350


--pre-roast and smelting functions
function set_roast_iron(pos, length, interval)
	-- and firing count
	local meta = minetest.get_meta(pos)
	meta:set_int("roast", length)
	--check heat interval
	minetest.get_node_timer(pos):start(interval)
end


function roast_iron(pos, selfname, name, length, heat, smelt)
	local meta = minetest.get_meta(pos)
	local roast = meta:get_int("roast")

	--check if wet stop
	if climate.get_rain(pos) or minetest.find_node_near(pos, 1, {"group:water"}) then
		return true
	end

	--exchange accumulated heat
	climate.heat_transfer(pos, selfname)

	--check if above firing temp
	local temp = climate.get_point_temp(pos)
	local fire_temp = heat

	if roast <= 0 then
		--finished firing
		--need to transfer heat to smelt
		--for others doesn't matter
		if name == "tech:iron_and_slag" then
			temp = meta:get_float("temp")
			minimal.switch_node(pos, {name = name})
			meta:set_float("temp", temp)
			minetest.check_for_falling(pos)
			return false
		else
			minimal.switch_node(pos, {name = name})
			minetest.check_for_falling(pos)
			return false
		end
  elseif temp < fire_temp then
    --not lit yet
    return true
	elseif temp >= fire_temp then
    if smelt then -- #TODO: eliminate directional bias
      --smelting requires release of slag
      --position below
      local posb = {
        {x = pos.x, y = pos.y - 1, z = pos.z},
        {x = pos.x +1, y = pos.y - 1, z = pos.z},
        {x = pos.x -1, y = pos.y - 1, z = pos.z},
        {x = pos.x, y = pos.y - 1, z = pos.z +1},
        {x = pos.x +1, y = pos.y - 1, z = pos.z +1},
        {x = pos.x -1, y = pos.y - 1, z = pos.z +1},
        {x = pos.x, y = pos.y - 1, z = pos.z -1},
        {x = pos.x +1, y = pos.y - 1, z = pos.z -1},
        {x = pos.x -1, y = pos.y - 1, z = pos.z -1}
      }
      local cn = 0
      for _, p in pairs(posb) do
        local n = minetest.get_node(p).name
				--must drain into air or other slag mix
	local target = p
	local tn = n
	if tn == "tech:molten_slag_flowing" then
	   repeat -- add a tail onto existing slag plumes
	      target = vector.add(target, {x = 0, y = -1, z = 0})
	      tn = minetest.get_node(target).name
	   until tn ~= 'tech:molten_slag_flowing'
	end
        if tn == 'air' or tn == 'climate:air_temp' or
	   tn == 'tech:iron_and_slag' then
	   minetest.sound_play("nodes_nature_cool_lava",	{pos = pos, max_hear_distance = 8, gain = 0.1})
	   if tn ~= 'tech:iron_and_slag' then
	      minetest.set_node(target, {name = 'tech:molten_slag_flowing'})
	      --only drain to one place (i.e. so they all drain the same amount)
	      cn = cn + 1
	      break
	   else
	      --undo progress of the one it is draining into.
	      local meta_under = minetest.get_meta(target)
	      local roast_under = meta_under:get_int("roast")
	      --only if still has room (i.e. can't infinitely fill it)
	      if roast_under < 100 then
		 meta_under:set_int("roast", roast_under + 1)
		 --only drain to one place (i.e. so they all drain the same amount)
		 cn = cn + 1
		 break
	      end
	   end
        end
      end
      --only makes smelt progress if able to drain
      if cn > 0 then
        --do firing
        meta:set_int("roast", roast - 1)
        return true
      else
				--try again later
        return true
      end

    else
      --do non-smelting firing
      meta:set_int("roast", roast - 1)
      return true
    end
  end

end

---------------------
--save usage into inventory, to prevent infinite supply
on_dig_iron_and_slag = function(pos, node, digger)
	if not digger then return end
	if minetest.is_protected(pos, digger:get_player_name()) then
		return false
	end

	local meta = minetest.get_meta(pos)
	local roast = meta:get_int("roast")

	local new_stack = ItemStack("tech:iron_and_slag")
	local stack_meta = new_stack:get_meta()
	stack_meta:set_int("roast", roast)

	minetest.remove_node(pos)
	local player_inv = digger:get_inventory()
	if player_inv:room_for_item("main", new_stack) then
		player_inv:add_item("main", new_stack)
	else
		minetest.add_item(pos, new_stack)
	end
end

--set saved
after_place_iron_and_slag = function(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local stack_meta = itemstack:get_meta()
	local roast = stack_meta:get_int("roast")
	if roast >0 then
		meta:set_int("roast", roast)
	end
end