minetest.register_node("tech:cooking_pot", {
	description = S("Cooking Pot"),
	tiles = {"tech_pottery.png",
	"tech_pottery.png",
	"tech_pottery.png",
	"tech_pottery.png",
	"tech_pottery.png"},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = pot_nodebox,
	},
	groups = {dig_immediate = 3, pottery = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
	   clear_cooking_pot(pos)
	end,
	on_rightclick = function(...)
	   return cooking_pot_rightclick(...)
	end,
	on_dig = function(pos, node, digger)
	   local meta = minetest.get_meta(pos)
	   local inv = meta:get_inventory()
	   local ptype = meta:get_string("type")
	   if ( not inv:is_empty("main")
	      or ptype ~= "") then -- type is empty on uprepared pot
	      return false
	   end
	   minetest.node_dig(pos, node, digger)
	end,
	on_receive_fields = function(...)
	   cooking_pot_receive_fields(...)
	end,
	on_timer = function(pos, elapsed)
	   cooking_pot_cook(pos, elapsed)
	   return true
	end,
	allow_metadata_inventory_put = function(
	      pos, listname, index, stack, player)
	   local fname = stack:get_name()
	   if not food_table[fname] and not bake_table[fname] then
	      return 0
	   end
	   local meta = minetest.get_meta(pos)
	   if meta:get_string("status") == "finished" then
		--prevent adding items after cooking is complete
		return 0
	   end
	   local inv = meta:get_inventory():get_list(listname)
	   local count = stack:get_count()
	   --if we put new items in during cook, extend "baking" time further
	   meta:set_int("baking", meta:get_int("baking")
			+ cooking_pot_calc_baking_time(stack))
	   for i = 1, #inv do
	      -- Only allow one stack of a given item
	      if not (i == index) and inv[i]:get_name() == stack:get_name() then
		 return 0
	      end
	   end
	   return count
	end,
	allow_metadata_inventory_take = function(
	      pos, listname, index, stack, player)
	   local meta = minetest.get_meta(pos)
	   local status = meta:get_string("status")
	   --prevent removing items once cooking begins
	   if status ~= "" and status ~= "finished" then -- "" means cooking never started.
		return 0
	   end
	   meta:set_int("baking", meta:get_int("baking")
			- cooking_pot_calc_baking_time(stack))
	   return stack:get_count()
	end,
})

minetest.register_node("tech:cooking_pot_unfired", {
	description = S("Cooking Pot (unfired)"),
	tiles = {"nodes_nature_clay.png",
		 "nodes_nature_clay.png",
		 "nodes_nature_clay.png",
		 "nodes_nature_clay.png",
		 "nodes_nature_clay.png",
		 "nodes_nature_clay.png"},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = pot_nodebox,
	},
	groups = {dig_immediate=3, temp_pass = 1, falling_node = 1, heatable = 20},
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
	   ncrafting.set_firing(pos, ncrafting.base_firing, ncrafting.firing_int)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length
		return ncrafting.fire_pottery(pos, "tech:cooking_pot_unfired", "tech:cooking_pot", ncrafting.base_firing)
	end,

})