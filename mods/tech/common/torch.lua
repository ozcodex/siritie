--interval
torch_base_burn_rate = 6
--how much to burn
torch_base_fuel = 60
--brightness
torch_light_power = 8
torch_temp = 2
torch_heat = 450

-------------------------------------------
--save usage into inventory, to prevent infinite torch supply
on_dig_torch = function(pos, node, digger)

	if not digger then return false end

	if minetest.is_protected(pos, digger:get_player_name()) then
		return false
	end

	local meta = minetest.get_meta(pos)
	local fuel = meta:get_int("fuel")
	--round off fuel numbers for better stacking: 10-15 = 10
	--16-20 = 20, lean a bit towards reducing fuel for balance
	fuel = math.floor((fuel+4)/10)*10

	local new_stack = ItemStack("tech:torch")
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

-------------------------------------------
--set saved fuel
after_place_torch = function(pos, placer, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	local stack_meta = itemstack:get_meta()
	local fuel = stack_meta:get_int("fuel")
	if fuel >0 then
		meta:set_int("fuel", fuel)
	end
end

-------------------------------------------
--converts flaming torch into ash
function torch_can_burn_air(pos, meta, ash_name)
	--extinguish
	if climate.get_rain(pos) or minetest.find_node_near(pos, 1, {"group:water"}) then
		minetest.set_node(pos, {name = ash_name})
		minetest.check_for_falling(pos)
		return false
	end

	--check for the presence of air
	if minetest.find_node_near(pos, 1, {"air"}) then
		return true
	else
		--go out
		minetest.set_node(pos, {name = ash_name})
		return false
	end
end

--Particle Effects
function torch_fire_on(pos)
	if math.random()<0.8 then
		minetest.sound_play("tech_fire_small",{pos=pos, max_hear_distance = 10, loop=false, gain=0.1})
		--Smoke
		minetest.add_particlespawner(ncrafting.particle_smokesmall(pos))
	end
end


-------------------------------------------
--handles dropping the torch

function on_throw_troch(itemstack, dropper, pos)
-- newpos = {x = pos.x, y = pos.y+1.5, z=pos.z} -- Add vector to put it forward
   local obj = minetest.add_entity({x = pos.x, y = pos.y+1.5, z = pos.z},
      "tech:torch_entity")
   local fuel = itemstack:get_meta():get_int("fuel")
   if fuel then
      obj:get_luaentity(obj):set_fuel(fuel)
   end
   local vectors = dropper:get_look_dir()
   local velocity = 10
   obj:set_velocity({x = vectors.x * velocity,
		     y = vectors.y * velocity,
		     z = vectors.z * velocity})
   obj:set_acceleration({ x = vectors.x * -5, y = -10, z = vectors.z * -5})
end

-------------------------------------------

function torch_on_flood(pos, oldnode, newnode)
	minetest.add_item(pos, ItemStack("tech:torch 1"))
	-- Play flame-extinguish sound if liquid is not an 'igniter'
					--[[
	local nodedef = minetest.registered_items[newnode.name]
	if not (nodedef and nodedef.groups and
			nodedef.groups.igniter and nodedef.groups.igniter > 0) then
		minetest.sound_play(
			"default_cool_lava",
			{pos = pos, max_hear_distance = 16, gain = 0.1}
		)
	end
			]]
	-- Remove the torch node
	return false
end


-------------------------------------------
-- entity

local torch_entity = {
   initial_properties = {
      visual = "sprite",
      textures = {"tech_torch_on_floor.png"},
      physical = true,
      collisionbox = {-0.125, 0.0, -0.125, 0.125, .25, 0.125}
   },
   fuel = 60 -- default to a new torch
}

function torch_entity:on_step(dtime, moveresult)
      local vel = self.object:get_velocity()
      if vel.y == 0 then

	 local pos = self.object:get_pos()
	 local here = minetest.get_node(pos)
	 local def = minetest.registered_nodes[here.name]
	 if not here.name then -- we're in an unloaded spot, just forget it
	    self.remove()
	    return
	 end
	 if def.groups.water and def.groups.water > 0 then
	    minetest.sound_play("nodes_nature_cool_lava",
				{pos = pos, max_hear_distance = 16, gain = 0.1})
	 elseif def.groups.igniter and def.groups.igniter > 0 then
	    minetest.sound_play("inferno_extinguish_flame.2",
				{pos = pos, max_hear_distance = 16, gain = 0.1})
	 elseif not def.buildable_to then
	    local torchent = ItemStack("tech:torch")
	    torchent:get_meta():set_int("fuel", self.fuel)
	    minetest.item_drop(torchent, nil, pos)
	 else
	    minetest.place_node(pos, {name = "tech:torch"})
	    local heremeta = minetest.get_meta(pos)
	    heremeta:set_int("fuel", self.fuel)
	 end
	 self.object:remove()
      end
   end
function torch_entity:get_fuel()
   return self.fuel
end
function torch_entity:set_fuel(val)
   self.fuel = val
end

minetest.register_entity("tech:torch_entity", torch_entity)
