------------------------------------------------
-- POTTERY
-- all made from clay
--unfired versions must reach right temperature for long enough to fire.
-----------------------------------------------

--firing difficulty
base_firing = ncrafting.base_firing
firing_int = ncrafting.firing_int
sediment = sediment
lightsource = lightsource
lightsource_description = lightsource_description

-------------------------------------------------------------------
--THIS SHOULD BE MOVED somewhere GENERALIZED to handle non-pottery pots
function water_pot(pos, pot_name, elapsed)
	local light = minimal.get_daylight({ x = pos.x, y = pos.y + 1, z = pos.z }, 0.5)
	--collect rain
	if light == 15 then
		if climate.get_rain(pos, light) or climate.time_since_rain(elapsed) > 0 then
			minetest.swap_node(pos, { name = pot_name .. "_freshwater" })
			return
		end
	else
		--drain wet sediment into the pot
		--or melt snow and ice
		local posa = { x = pos.x, y = pos.y + 1, z = pos.z }
		local name_a = minetest.get_node(posa).name
		if name_a == "air" then
			return true
		--[[-- Water puddles make more sense than this now,
		--especially given disease risks
		elseif minetest.get_item_group(name_a, "wet_sediment") == 1 then
			local nodedef = minetest.registered_nodes[name_a]
			if not nodedef then
				return true
			end
			minetest.set_node(posa, {name = nodedef._dry_name})
			minetest.set_node(pos, {name = "tech:clay_water_pot_freshwater"})
			return
		elseif minetest.get_item_group(name_a, "wet_sediment") == 2 then
			local nodedef = minetest.registered_nodes[name_a]
			if not nodedef then
				return true
			end
			minetest.set_node(posa, {name = nodedef._dry_name})
			minetest.set_node(pos, {name = "tech:clay_water_pot_salt_water"})
			return
			]]
		elseif
			name_a == "nodes_nature:ice"
			or name_a == "nodes_nature:snow_block"
			or name_a == "nodes_nature:freshwater_source"
		then
			if climate.can_thaw(posa) then
				minetest.swap_node(pos, { name = pot_name .. "_freshwater" })
				minetest.remove_node(posa)
				return
			end
		end
	end
	return true
end

oil_lamp_desc = lightsource_description.new({
	lit_name = "tech:clay_oil_lamp",
	unlit_name = "tech:clay_oil_lamp_unlit",
	fuel_name = "tech:vegetable_oil",
	max_fuel = 3100,
	burn_rate = 5,
	refill_ratio = 1 / 2,
	put_out_by_moisture = true,
})
