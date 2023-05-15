----------------------------------------------------------
--GLASS WORKING


--[[
>>> making glass
1800C will fuse sand itself.

Soda lime glass
Soda ash. - melting agent (1200C)
Sand -vitrifying
Calcium - stabilizing (potentially in the sand)

Two types of glass - green and clear

Green - made from ash and sand. Ash contains potash/soda ash and lime,
        but also iron impurities that color the glass green.
	Good for things where clarity doesn't matter, like bottler
Clear - made from refined potash (pearl ash), lime and sand. More expensive,
        as have to work to refine potash. Good for windows.

Potash - in this case get from wood ash.
Process:
	1. Soak in water
	2. Put water into pot
	3. Evaporate water to get potash (still with impurities, makes green glass)
	4. Roast potash in kiln to get pearl ash

>>>make things from glass:
Reheat so it is workable, then shape.
Small glass workshop furnace.

Vessels: glass blowing

Panes: cast on to an iron tray, then polished. Only get small panes.


]]
-----------------------------------------------------------

post_alpha_glass = 140

liquid_store.register_liquid("tech:potash_source", "tech:potash_flowing", false)


-- Pre-roast  functions
function set_roast_glass(pos, length, interval)
	-- and firing count
	local meta = minetest.get_meta(pos)
	meta:set_int("roast", length)
	--check heat interval
	minetest.get_node_timer(pos):start(interval)
end



function roast_glass(pos, selfname, name, heat)
	local meta = minetest.get_meta(pos)
	local roasting = meta:get_int("roast")

	--check if wet stop
	if climate.get_rain(pos) or
	   minetest.find_node_near(pos, 1, {"group:water"}) then
		return true
	end

	--exchange accumulated heat
	climate.heat_transfer(pos, selfname)

	--check if above firing temp
	local temp = climate.get_point_temp(pos)
	local fire_temp = heat

	if roasting <= 0 then
		--finished firing
    minimal.switch_node(pos, {name = name})
    if minetest.get_item_group(name,"heatable") > 0 then
       meta:set_float("temp", temp)
    end
    minetest.check_for_falling(pos)
    return false
  elseif temp < fire_temp then
    --not lit yet
    return true
	elseif temp >= fire_temp then
    --do firing
    meta:set_int("roast", roasting - 1)
    return true
  end

end

-- Pane Casting function
function pane_cast_check(pos)

	local pbelow = {x = pos.x, y = pos.y - 1, z = pos.z}
	if minetest.get_node(pbelow).name == "tech:pane_tray" and
	   climate.get_point_temp(pos) >= 1800 then
	   -- Melting temperature of glass is approx 1800 C
		local name = minetest.get_node(pos).name
		if name == "tech:green_glass_ingot" then
			minetest.set_node(pos, {name = "air"})
			minetest.swap_node(pbelow, {name = "tech:pane_tray_green"})
			minetest.sound_play("tech_boil", {pos = pos, max_hear_distance = 8, gain = 1})
			return true
		elseif name == "tech:clear_glass_ingot" then
			minetest.set_node(pos, {name = "air"})
			minetest.swap_node(pbelow, {name = "tech:pane_tray_clear"})
			minetest.sound_play("tech_boil", {pos = pos, max_hear_distance = 8, gain = 1})
			return true
		end
	end
	return false
end


-- Soak Ash
local function potash_soak_check(pos, node)

	local p_water = minetest.find_node_near(pos, 1, {"nodes_nature:freshwater_source"})
	if p_water then
		local p_name = minetest.get_node(p_water).name
		--check water type. Salt wouldn't work probably
		local water_type = minetest.get_item_group(p_name, "water")
		if water_type == 1 then
		   minetest.set_node(pos, {name = "tech:potash_source"})
		   minetest.set_node(p_water, {name = "air"})
		   minetest.sound_play("tech_boil",
				       {pos = pos,
					max_hear_distance = 8, gain = 1})
		elseif water_type == 2 then
			return false
		end
	end
end

minetest.register_abm(
{
	label = "Ash Dissolve",
	nodenames = {"tech:wood_ash_block"},
	neighbours = {"nodes_nature:freshwater_source"},
	interval = 15,
	chance = 1,
	action = function(...)
		potash_soak_check(...)
	end
})
