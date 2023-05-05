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

-- Broken pottery full blocks and soil
local broken_pottery =
   sediment.new({name = "broken_pottery_block",
		 description = S("Broken Pottery"),
		 hardness = sediment.hardness.soft,
		 fertility = 5, sound = sediment.sounds.gravel,
		 sound_wet = sediment.sounds.gravel_wet,
		 texture_name = "tech_broken_pottery.png", mod_name = "tech"})
sediment.register_dry(broken_pottery)
sediment.register_wet(broken_pottery)
sediment.register_wet_salty(broken_pottery)
sediment.register_agri_soil_variants(broken_pottery)

-------------------------------------------------------------------
--THIS SHOULD BE MOVED somewhere GENERALIZED to handle non-pottery pots
function water_pot(pos, pot_name, elapsed)
	local light = minimal.get_daylight({x=pos.x, y=pos.y + 1, z=pos.z}, 0.5)
	--collect rain
	if light == 15 then
	   if climate.get_rain(pos, light) or
	      climate.time_since_rain(elapsed) > 0 then
	          minetest.swap_node(pos, {name = pot_name.."_freshwater"})
		  return
	   end
	else
		--drain wet sediment into the pot
		--or melt snow and ice
		local posa = 	{x = pos.x, y = pos.y+1, z = pos.z}
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
		elseif (name_a == "nodes_nature:ice" or
			name_a == "nodes_nature:snow_block" or
			name_a == "nodes_nature:freshwater_source" ) then
			if climate.can_thaw(posa) then
				minetest.swap_node(pos, {name = pot_name.."_freshwater"})
				minetest.remove_node(posa)
				return
			end
		end
	end
	return true
end

local oil_lamp_desc = lightsource_description.new(
    {lit_name = "tech:clay_oil_lamp", unlit_name = "tech:clay_oil_lamp_unlit",
     fuel_name = "tech:vegetable_oil", max_fuel = 3100,
     burn_rate = 5, refill_ratio = 1/2, put_out_by_moisture = true})

-----------------------------------------------
--Register water stores
--source, nodename, nodename_empty, tiles, node_box, desc, groups

--clay pot with salt water
liquid_store.register_stored_liquid(
	"nodes_nature:salt_water_source",
	"tech:clay_water_pot_salt_water",
	"tech:clay_water_pot",
	{
		"tech_water_pot_water.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png"
	},
	{
		type = "fixed",
		fixed = {
			{-0.25, 0.375, -0.25, 0.25, 0.5, 0.25}, -- NodeBox1
			{-0.375, -0.25, -0.375, 0.375, 0.3125, 0.375}, -- NodeBox2
			{-0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125}, -- NodeBox3
			{-0.25, -0.5, -0.25, 0.25, -0.375, 0.25}, -- NodeBox4
			{-0.3125, 0.3125, -0.3125, 0.3125, 0.375, 0.3125}, -- NodeBox5
		}
	},
	S("Clay Water Pot with Salt Water"),
	{dig_immediate = 2})


--clay pot with freshwater
liquid_store.register_stored_liquid(
	"nodes_nature:freshwater_source",
	"tech:clay_water_pot_freshwater",
	"tech:clay_water_pot",
	{
		"tech_water_pot_water.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png"
	},
	{
		type = "fixed",
		fixed = {
			{-0.25, 0.375, -0.25, 0.25, 0.5, 0.25}, -- NodeBox1
			{-0.375, -0.25, -0.375, 0.375, 0.3125, 0.375}, -- NodeBox2
			{-0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125}, -- NodeBox3
			{-0.25, -0.5, -0.25, 0.25, -0.375, 0.25}, -- NodeBox4
			{-0.3125, 0.3125, -0.3125, 0.3125, 0.375, 0.3125}, -- NodeBox5
		}
	},
	S("Clay Water Pot with Freshwater"),
	{dig_immediate = 2})

--make freshwater Pot drinkable on click
minetest.override_item("tech:clay_water_pot_freshwater",{
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
			minimal.switch_node(pos, {name = "tech:clay_water_pot"})
			minetest.sound_play("nodes_nature_slurp",	{pos = pos, max_hear_distance = 3, gain = 0.25})
		end
	end
})
