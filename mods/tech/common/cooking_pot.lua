--[[
Food capacity

Display:
Food %
Cooking progress %

Click with food item to add to pot -> ^food vProgress

Heat to cook

Click with hand to eat -> vFood %


Save to inv meta

]]

-- Import Globals
food_table = food_table
bake_table = bake_table

cook_time = 1
cook_temp = { [""] = 101, ["Soup"] = 100 }
portions = 10 -- TODO: is this sane? Can we adjust it based on contents?


---------------------
pot_nodebox = {
	{-0.375, -0.1875, -0.375, 0.375, -0.0625, 0.375}, -- NodeBox1
	{-0.3125, -0.3125, -0.3125, 0.3125, -0.1875, 0.3125}, -- NodeBox2
	{-0.25, -0.4375, -0.25, 0.25, -0.3125, 0.25}, -- NodeBox3
	{-0.3125, -0.0625, -0.3125, 0.3125, 0, 0.3125}, -- NodeBox4
	{-0.25, 0, -0.25, 0.25, 0.0625, 0.25}, -- NodeBox5
	{-0.125, 0.0625, -0.0625, -0.0625, 0.1875, 0.0625}, -- NodeBox6
	{0.0625, 0.0625, -0.0625, 0.125, 0.1875, 0.0625}, -- NodeBox7
	{-0.0625, 0.125, -0.0625, 0.0625, 0.1875, 0.0625}, -- NodeBox8
	{0.25, -0.4375, 0.25, 0.375, -0.3125, 0.375}, -- NodeBox9
	{0.25, -0.5, 0.25, 0.4375, -0.4375, 0.4375}, -- NodeBox10
	{0.25, -0.5, -0.4375, 0.4375, -0.4375, -0.25}, -- NodeBox11
	{-0.4375, -0.5, -0.4375, -0.25, -0.4375, -0.25}, -- NodeBox12
	{-0.4375, -0.5, 0.25, -0.25, -0.4375, 0.4375}, -- NodeBox13
	{0.25, -0.4375, -0.375, 0.375, -0.3125, -0.25}, -- NodeBox14
	{-0.375, -0.4375, -0.375, -0.25, -0.3125, -0.25}, -- NodeBox15
	{-0.375, -0.4375, 0.25, -0.25, -0.3125, 0.375}, -- NodeBox16
	{-0.4375, -0.0625, -0.0625, -0.3125, 0.0625, 0.0625}, -- NodeBox23
	{0.3125, -0.0625, -0.0625, 0.4375, 0.0625, 0.0625}, -- NodeBox24
}

pot_formspec = "size[8,4.1]"..
   "list[current_name;main;0,0;8,2]"..
   "list[current_player;main;0,2.3;8,4]"..
   "listring[current_name;main]"..
   "listring[current_player;main]"

function clear_cooking_pot(pos)
   local meta = minetest.get_meta(pos)
   minimal.infotext_set(pos,meta,
     "Status: Unprepared pot\nContents: <EMPTY>\nNote: Add water to pot to make soup")
   meta:set_string("formspec", "")
   meta:set_string("type", "")
   meta:set_string("status", "") -- "" = unprepared, "Cooking", "Finished"
   local inv = meta:get_inventory()
   inv:set_size("main", 8)
end

function cooking_pot_rightclick(pos, node, clicker, itemstack, pointed_thing)
   local meta = minetest.get_meta(pos)
   local itemname = itemstack:get_name()
   local status = meta:get_string("status")
   local timer = minetest.get_node_timer(pos)

   if status == "" then  -- unprepared pot
      local liquid = liquid_store.contents(itemname)
      if liquid == "nodes_nature:freshwater_source" then
	 meta:set_string("type", "Soup")
	 minimal.infotext_set(pos,meta,
		"Status: Soup Pot\nContents: Water\n"
		.."Note: Add food to the pot to make soup")
	 meta:set_string("formspec", pot_formspec)
	 meta:set_int("baking", cook_time)
	 timer:start(6)
	 if itemname ~= liquid then -- it's stored in a container
	    return liquid_store.drain_store(clicker, itemstack)
	 else
	    itemstack:take_item()
	 end
      end
      return itemstack
-- XXX Was going to add ability to take water out of a prepared pot but more complicated
-- then expected will try again later
--   elseif ptype == "Soup" then -- Pot has water, but not cooking
   end
   if status ~= "" and timer:is_started() == false then
      timer:start(6) -- timer died somehow? restart it here
   end
   --TODO: use oil for fried food, saltwater for salted food (to preserve it)
end

function cooking_pot_receive_fields(pos, formname, fields, sender)
   local meta = minetest.get_meta(pos)
   local inv = meta:get_inventory():get_list("main")
   if not inv then -- This is a bugged pot from before commit 851e0ec744
      meta:get_inventory():set_size("main", 8) -- So, fix it
      inv = meta:get_inventory():get_list("main")
   end
   local total = { 0, 0, 0, 0, 0 }
   if meta:get_string("status") == "finished" then -- reset the pot for next cook
      if meta:get_inventory():is_empty("main") then
	 clear_cooking_pot(pos)
      end
      return
   end
   local contents="" -- String containing list of pot contents
   if meta:get_string('type') == 'Soup' then
	   contents="Water, "
   end
   for i = 1, #inv do
      local fname = inv[i]:get_name()
      if fname and fname ~= '' then
	      local fcount = inv[i]:get_count()
	      local fdesc = minetest.registered_nodes[fname].description
	      contents=contents..' '..fdesc..' ('..fcount..'), '
      end
      if food_table[fname] or food_table[fname.."_cooked"] then
	 local result = food_table[fname.."_cooked"]
	 if result == nil then -- prefer the cooked version, use raw if none
	    result = food_table[fname]
	 end
	 if result then
	    local count = inv[i]:get_count()
	    for j = 1, 5 do
	       total[j] = total[j] + result[j] * count
	    end
	 end
      end
   end
   contents=contents:sub(1, #contents - 2) -- take last ', ' from contents
   minimal.infotext_merge(pos, {
	   "Contents: "..contents,
	   "Note:",   -- Clear note about adding food
   }, meta)

   local length = meta:get_int("baking")
   if length <= (cook_time - 4) then
      length = length + 4 -- don't open a cooking pot, you'll let the heat out
      --TODO: Can we drain current temp while the formspec's open? Groups?
      meta:set_int("baking", length)
   end
   meta:set_string("pot_contents", minetest.serialize(total))
end

local function divide_portions(total)
   local result = total
   for i = 1, #total do
      result[i] = math.floor(total[i] / portions)
   end
   return result
end

function cooking_pot_cook(pos, elapsed)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory():get_list("main")
	local total = ( minetest.deserialize(meta:get_string("pot_contents")) or
		      { 0, 0, 0, 0 } )
	local kind = meta:get_string("type")
	climate.heat_transfer(pos, "tech:cooking_pot")
	local temp = climate.get_point_temp(pos)
	local baking = meta:get_int("baking")
	local status = meta:get_string("status")
	if status == "finished" then
		-- Handle burning food here
	    --TODO: burned: reduce th value of pot_contents, emit more smoke
	else
		if kind == "Soup" then -- or kind == "etc"; this only runs if we're cooking
		      if baking <= 0 then
			 local firstingr
			 for i = 1, #inv do
			    local ingr = inv[i]:get_description()
			    if ingr ~= "" then
			       firstingr = ingr
			       break
			    end
			 end
			 if firstingr then
			    firstingr = firstingr:gsub(" %(uncooked%)","")
			    firstingr = firstingr:gsub("Unbaked ","")
			    firstingr = firstingr:gsub(" Carcass","")
			    firstingr = firstingr.." "
			 end
			 for i = 1, #inv do
			    inv[i]:clear()
			 end
			 inv[1]:replace(ItemStack("tech:soup "..portions))
			 local imeta = inv[1]:get_meta()
			 local portion = divide_portions(total)
			 portion[2] = portion[2] + (100 / portions)
			 imeta:set_string("eat_value", minetest.serialize(portion))
			 imeta:set_string("description", S("@1 soup",firstingr))
			 meta:get_inventory(pos):set_list("main", inv)
			 minimal.infotext_merge(pos, {
				"Contents: "..S("@1 soup",firstingr),
				"Status: "..kind.." pot (finished)"
			}, meta)
			 meta:set_string("status", "finished")
			 return
		      elseif temp < cook_temp[kind] then
			      if status ~= 'cooling' then
				      meta:set_string("status", "cooling")
				      minimal.infotext_merge(pos, 'Status: '..kind.." pot", meta)
			      end
			      return
		      elseif temp >= cook_temp[kind] then
			 if meta:get_inventory():is_empty("main") then
			    return
			 end
			 if status ~= 'cooking' then
				 meta:set_string('status', 'cooking')
				 minimal.infotext_merge(pos, "Status: "..kind.." pot (cooking)", meta)
			 end
			 meta:set_int("baking", baking - 1)
		      end
		end -- Soup
	end -- status == finished
end

function cooking_pot_calc_baking_time(stack)
   local fname = stack:get_name()
   if not food_table[fname] then return 0 end -- removing finished, etc
   local time -- #TODO: Check if we're adding to a stack, don't alter
   if bake_table[fname] then
      time = bake_table[fname][2] -- using baking time
   elseif fname:gsub("_cooked","") ~= fname then
      time = 1 -- this is already cooked
   else -- use half of nutrition unit value
      time = 1 + math.floor(food_table[fname][3] / 2)
   end
   return time
end