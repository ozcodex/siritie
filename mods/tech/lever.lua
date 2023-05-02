--------------------------------------------------------------------------
-- lever
--rotate tool

-- Internationalization
local S = tech.S

-- Declare global
creative = creative

-- Set up namespace
lever = {}

lever.ROTATE_FACE = 1
lever.ROTATE_AXIS = 2
lever.disallow = function(pos, node, user, mode, new_param2)
	return false
end
lever.rotate_simple = function(pos, node, user, mode, new_param2)
	if mode ~= lever.ROTATE_FACE then
		return false
	end
end

local function should_rotate(ndef, node, pos, itemstack, user, new_param2, mode)
	-- Node provides a handler, so let the handler decide instead if the node can be rotated
	if ndef.on_rotate then
		-- Copy pos and node because callback can modify it
		local result = ndef.on_rotate(vector.new(pos),
				{name = node.name, param1 = node.param1, param2 = node.param2},
				user, mode, new_param2)
		return result
	elseif ndef.on_rotate == false then
		return false
	elseif ndef.can_dig and not ndef.can_dig(pos, user) then
		return false
	end
	return true
end

-- For attached wallmounted nodes: returns true if rotation is valid
-- simplified version of minetest:builtin/game/falling.lua#L148.
local function check_attached_node(pos, rotation)
	local d = minetest.wallmounted_to_dir(rotation)
	local p2 = vector.add(pos, d)
	local n = minetest.get_node(p2).name
	local def2 = minetest.registered_nodes[n]
	if def2 and not def2.walkable then
		return false
	end
	return true
end

lever.rotate = {}

local facedir_tbl = {
	[lever.ROTATE_FACE] = {
		[0] = 1, [1] = 2, [2] = 3, [3] = 0,
		[4] = 5, [5] = 6, [6] = 7, [7] = 4,
		[8] = 9, [9] = 10, [10] = 11, [11] = 8,
		[12] = 13, [13] = 14, [14] = 15, [15] = 12,
		[16] = 17, [17] = 18, [18] = 19, [19] = 16,
		[20] = 21, [21] = 22, [22] = 23, [23] = 20,
	},
	[lever.ROTATE_AXIS] = {
		[0] = 4, [1] = 4, [2] = 4, [3] = 4,
		[4] = 8, [5] = 8, [6] = 8, [7] = 8,
		[8] = 12, [9] = 12, [10] = 12, [11] = 12,
		[12] = 16, [13] = 16, [14] = 16, [15] = 16,
		[16] = 20, [17] = 20, [18] = 20, [19] = 20,
		[20] = 0, [21] = 0, [22] = 0, [23] = 0,
	},
}

lever.rotate.facedir = function(pos, node, mode)
	local rotation = node.param2 % 32 -- get first 5 bits
	local other = node.param2 - rotation
	rotation = facedir_tbl[mode][rotation] or 0
	return rotation + other
end

lever.rotate.colorfacedir = lever.rotate.facedir

local wallmounted_tbl = {
	[lever.ROTATE_FACE] = {[2] = 5, [3] = 4, [4] = 2, [5] = 3, [1] = 0, [0] = 1},
	[lever.ROTATE_AXIS] = {[2] = 5, [3] = 4, [4] = 2, [5] = 1, [1] = 0, [0] = 3}
}

lever.rotate.wallmounted = function(pos, node, mode)
	local rotation = node.param2 % 8 -- get first 3 bits
	local other = node.param2 - rotation
	rotation = wallmounted_tbl[mode][rotation] or 0
	if minetest.get_item_group(node.name, "attached_node") ~= 0 then
		-- find an acceptable orientation
		for i = 1, 5 do
			if not check_attached_node(pos, rotation) then
				rotation = wallmounted_tbl[mode][rotation] or 0
			else
				break
			end
		end
	end
	return rotation + other
end

lever.rotate.colorwallmounted = lever.rotate.wallmounted

-- Handles rotation
lever.handler = function(itemstack, user, pointed_thing, mode)
	if pointed_thing.type ~= "node" then
		return
	end

	local pos = pointed_thing.under
	local player_name = user and user:get_player_name() or ""

	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return
	end

	local node = minetest.get_node(pos)
	local ndef = minetest.registered_nodes[node.name]
	if not ndef then
		return itemstack
	end
	-- can we rotate this paramtype2?
	local fn = lever.rotate[ndef.paramtype2]
	if not fn and not ndef.on_rotate then
		return itemstack
	end

	local new_param2
	if fn then
		new_param2 = fn(pos, node, mode)
	else
		new_param2 = node.param2
	end

	if should_rotate(ndef, node, pos, itemstack, user,
			 new_param2, mode) then
	   if new_param2 ~= node.param2 then
		node.param2 = new_param2
		minetest.swap_node(pos, node)
		minetest.check_for_falling(pos)
		if not (creative and creative.is_enabled_for and
			creative.is_enabled_for(player_name)) then
		   itemstack:add_wear(65535 / ((ndef._uses or 200) - 1))
		end
	   end
	end
	return itemstack
end

-- lever
minetest.register_tool("tech:lever", {
	description = S("lever") .. "\n" .. S("(left-click rotates face, right-click rotates axis)"),
	inventory_image = "tech_tool_lever.png",
	groups = {tool = 1},
	_uses = 400,
	on_use = function(itemstack, user, pointed_thing)
		lever.handler(itemstack, user, pointed_thing, lever.ROTATE_FACE)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		lever.handler(itemstack, user, pointed_thing, lever.ROTATE_AXIS)
		return itemstack
	end,
})


----stick from sticks
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:lever 1",
	items = {"tech:stick 2"},
	level = 1,
	always_known = true,
})

-- aligner

local function aligner(itemstack, user, pointed_thing, grab)
   if pointed_thing.type ~= "node" then
      return
   end

   local pos = pointed_thing.under
   local player_name = user and user:get_player_name() or ""

   if minetest.is_protected(pos, player_name) then
      minetest.record_protection_violation(pos, player_name)
      return
   end

   local node = minetest.get_node(pos)
   local ndef = minetest.registered_nodes[node.name]
   if not ndef then
      return itemstack
   end
   local p2type = ndef.paramtype2
   local p2 = node.param2
   local color = minetest.strip_param2_color(p2, p2type) or 0
   local nocolor = node.param2 - color
   local meta = itemstack:get_meta()
   if grab then
      meta:set_string("aligner_type", p2type)
      meta:set_string("aligner_value", nocolor)
   else
      local altype = meta:get_string("aligner_type")
      local alp2 = meta:get_string("aligner_value")
      if altype ~= p2type or alp2 == nil then
	 return -- Not the same type of param2, can't safely copy to this
      end
      local new_param2 = color + alp2 -- combine our node color with the new p2
      if should_rotate(ndef, node, pos, itemstack, user, new_param2) then
	 node.param2 = new_param2
	 minetest.swap_node(pos, node) -- and set it
	 if not (creative and creative.is_enabled_for and
		 creative.is_enabled_for(player_name)) then
	    itemstack:add_wear(65535 / ((ndef._uses or 200) - 1))
	 end
      end
      return itemstack
   end
end

minetest.register_tool("tech:aligner", {
	  description = S("alignment tool") .. "\n" ..
	     S("(right-click samples a node, left-click "..
	       "applies its facing to others)"),
	inventory_image = "tech_tool_lever.png^[transformFX",
	groups = {tool = 1},
	_uses = 400,
	on_use = function(itemstack, user, pointed_thing)
		aligner(itemstack, user, pointed_thing, false)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		aligner(itemstack, user, pointed_thing, true)
		return itemstack
	end,
})


----stick from sticks
crafting.register_recipe({
	type = "crafting_spot",
	output = "tech:aligner 1",
	items = {"tech:stick 2"},
	level = 1,
	always_known = true,
})
