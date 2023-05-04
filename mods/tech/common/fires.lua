------------------------------------
--TEMPERATURE CRAFTS
--crafts for temperature changing things (and associated things)
--e.g. fires
-----------------------------------

--inferno = inferno
--#TODO: circular dependency: tech and inferno each use things from the other

--interval
base_burn_rate = 4
--how much to burn (for small fire)
base_fuel = 300
--how much fuel is lost when water touches a fire
wet_loss = 75

--temperatures
--blocks are x 1.5 temp max, 2x temp effect,
--smouldering is 1/3 temp effect, but same temp max
wood_temp_effect = 15
wood_temp_max = 600
wood_air_c = 0.65
--charchoal has higher max, and more effective output
--i.e. char is for smelting etc, wood for personal heating, kilns
char_temp_effect = wood_temp_effect * 2
char_temp_max = wood_temp_max * 2
char_air_c = 0.45

inferno = inferno

-------------------------------
--Functions

--converts smoldering fire into full fire if air is present
function can_smolder(pos, meta, fire_name, ash_name)
        local f = meta:get_int("fuel")
	--extinguish in water
	if climate.get_rain(pos) or minetest.find_node_near(pos, 1, {"group:puts_out_fire"}) then
	        f = f - wet_loss
		if f <= 0 then
		   minimal.switch_node(pos, {name = ash_name})
		else
		   local ext_name = minetest.get_node(pos).name:gsub(
		      "_smoldering",
		      "_ext")
		   minimal.switch_node(pos, {name = ext_name})
		end
		minetest.sound_play("nodes_nature_cool_lava",	{pos = pos, max_hear_distance = 16, gain = 0.25})
		return false
	end

	--check for the presence of air
	if minetest.find_node_near(pos, 1, {"air"}) then
		--air, roar back to full flame
		minimal.switch_node(pos, {name = fire_name})
		return false
	else
		return true
	end
end

--converts fire into smoldering fire if air not present
function can_burn_air(pos, meta, smolder_name, ash_name)
        local f = meta:get_int("fuel")
	--extinguish
	if climate.get_rain(pos) or minetest.find_node_near(pos, 1, {"group:puts_out_fire"}) then
	        f = f - wet_loss
		if f <= 0 then
		   minimal.switch_node(pos, {name = ash_name})
		else
		   local ext_name = minetest.get_node(pos).name.."_ext"
		   minimal.switch_node(pos, {name = ext_name})
		end
		minetest.sound_play("nodes_nature_cool_lava",	{pos = pos, max_hear_distance = 16, gain = 0.25})
		return false
	end

	--check for the presence of air
	if minetest.find_node_near(pos, 1, {"air"}) then
		return true
	else
		--smolder
		minimal.switch_node(pos, {name = smolder_name})
		return false
	end
end

--Particle Effects

function hearth_fire_on(pos)
	if math.random()<0.6 then
		minetest.sound_play("tech_fire_small",{pos=pos, max_hear_distance = 15, loop=false, gain=0.2})
		--Smoke
		minetest.add_particlespawner({
			amount = 4,
			time = 0.5,
			minpos = {x = pos.x - 0.1, y = pos.y + 0.5, z = pos.z - 0.1},
			maxpos = {x = pos.x + 0.1, y = pos.y + 1, z = pos.z + 0.1},
			minvel = {x= 0, y= 0, z= 0},
			maxvel = {x= 0.01, y= 0.07, z= 0.01},
			minacc = {x= 0, y= 0, z= 0},
			maxacc = {x= 0.01, y= 0.2, z= 0.01},
			minexptime = 5,
			maxexptime = 20,
			minsize = 1,
			maxsize = 8,
			collisiondetection = true,
			vertical = true,
			texture = "tech_smoke.png",
		})

	end

	--flames
	minetest.add_particlespawner({
		amount = 6,
		time = 1,
		minpos = {x = pos.x - 0.1, y = pos.y + 0.1, z = pos.z - 0.1},
		maxpos = {x = pos.x + 0.1, y = pos.y + 0.7, z = pos.z + 0.1},
		minvel = {x= 0, y= 0, z= 0},
		maxvel = {x= 0.001, y= 0.001, z= 0.001},
		minacc = {x= 0, y= 0, z= 0},
		maxacc = {x= 0.001, y= 0.001, z= 0.001},
		minexptime = 3,
		maxexptime = 5,
		minsize = 4,
		maxsize = 8,
		collisiondetection = false,
		vertical = true,
		texture = "tech_flame_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		},
		glow = 13,
	})


end


--------------------------------------------------
--Combustion Products

--on_place
--players will be using wood ash to punch depleted agricultural soil
--make sure they can't accidentally right click and crush their crops
function on_place_fert(itemstack, placer, pointed_thing)
   local onnode = minetest.get_node(pointed_thing.under)
   local innode = minetest.get_node(pointed_thing.above)
   if minetest.get_item_group(onnode.name, "attached_node") > 0
   or minetest.get_item_group(innode.name,  "attached_node") > 0 then
      return itemstack
   else
      minetest.item_place(itemstack, placer, pointed_thing)
      return itemstack
   end
end





--------------------------------------------------
-- extinguish on punch
--

function extinguish_fire(pos, puncher, ext_name)
	--you must be holding something to smother it with or you get burned
	--hit it with fertilizer to restore
	local itemstack = puncher:get_wielded_item()
	local ist_name = itemstack:get_name()
	 -- make slabs/etc work too
	local nn = "nodes_nature:"
	ist_name = ist_name:gsub("stairs:slab_",nn)
	ist_name = ist_name:gsub("stairs:stair_inner_",nn)
	ist_name = ist_name:gsub("stairs:stair_outer_",nn)
	ist_name = ist_name:gsub("stairs:stair_",nn)

	if minetest.get_item_group(ist_name, "sediment") >= 1
	then
		minimal.switch_node(pos, {name = ext_name})
		minetest.sound_play("nodes_nature_cool_lava",	{pos = pos, max_hear_distance = 16, gain = 0.25})

	else
		local hp = puncher:get_hp()
		puncher:set_hp(hp-1)
	end

end


--save usage into inventory
on_dig_fire = function(pos, node, digger)
	if not digger or minetest.is_protected(pos, digger:get_player_name()) then
		return false
	end

	local meta = minetest.get_meta(pos)
	local fuel = meta:get_int("fuel")

	local new_stack = ItemStack(node.name)
	local stack_meta = new_stack:get_meta()
	stack_meta:set_int("fuel", fuel)


	minetest.remove_node(pos)
	local player_inv = digger:get_inventory()
	if player_inv:room_for_item("main", new_stack) then
		player_inv:add_item("main", new_stack)
	else
		minetest.add_item(pos, new_stack)
	end
end

--set saved fuel
after_place_fire = function(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local stack_meta = itemstack:get_meta()
	local fuel = stack_meta:get_int("fuel")
	if fuel >0 then
		meta:set_int("fuel", fuel)
	end
end
