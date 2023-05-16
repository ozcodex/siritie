-- creates the ceramic alembic node

local alambic_nodebox = {
    -- bottom pot
    {-0.25, -0.125, -0.25, 0.25, 0, 0.25}, 
    {-0.375, -0.25, -0.375, 0.375, -0.125, 0.375}, 
    {-0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125},
    {-0.25, -0.5, -0.25, 0.25, -0.375, 0.25},
	-- Top pot
	{-0.375, 0, -0.375, 0.375, 0.125, 0.375},
	{-0.3125, 0.125, -0.3125, 0.3125, 0.25, 0.3125},
	{-0.1875, 0.25, -0.1875, 0.1875, 0.325, 0.1875}, 
	{-0.0625, 0.325, -0.0625, 0.0625, 0.4, 0.0625},
	-- Tube
	{-0.05, 0.4, -0.475, 0.05, 0.475, 0.025},
	{-0.05, -0.2, -0.475, 0.05, 0.4, -0.4},
	{-0.05, -0.2, -0.475, 0.05, -0.1, 0},
}

local pot_nodebox = {
	{-0.25, 0.375, -0.25, 0.25, 0.5, 0.25}, -- NodeBox1
    {-0.375, -0.25, -0.375, 0.375, 0.3125, 0.375}, -- NodeBox2
    {-0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125}, -- NodeBox3
    {-0.25, -0.5, -0.25, 0.25, -0.375, 0.25}, -- NodeBox4
    {-0.3125, 0.3125, -0.3125, 0.3125, 0.375, 0.3125}, -- NodeBox5
}

local mash_pile_nodebox = {
  {-0.3, -0.5, -0.3, 0.3, -0.3, 0.3},
  {-0.25, -0.3, -0.25, 0.25, -0.1, 0.25}, 
  {-0.2, -0.1, -0.2, 0.2, 0, 0.2},
}

local smaller_mash_pile_nodebox = {
  {-0.25, -0.45, -0.25, 0.25, -0.3, 0.25},
  {-0.2, -0.3, -0.2, 0.2, -0.15, 0.2},
  {-0.15, -0.15, -0.15, 0.15, -0.05, 0.15},
}

minetest.register_node("tech:alembic", {
	description = "Ceramic Alembic",
	drawtype = "nodebox",
	tiles = {"tech_pottery.png"},
	node_box = {
		type = "fixed",
		fixed = alambic_nodebox,
	},
	liquids_pointable = true,
	groups = {cracky=3, oddly_breakable_by_hand=3},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = nodes_nature.node_sound_stone_defaults(),
	groups = {cracky=3, oddly_breakable_by_hand=3},

	on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size('main', alembic_inv_size)
        meta:set_string("formspec", get_alembic_formspec(pos))
		
		update_alembic_infotext(pos)
        
        local timer = minetest.get_node_timer(pos)
        timer:start(alembic_check_interval)
    end,

    on_timer = alembic_process,

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
    	local player_name = clicker:get_player_name()
        minetest.show_formspec(player_name, "composter:alembic", get_alembic_formspec(pos))
    end,

    on_destruct = function(pos)
    	-- drops its contents when broken
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        if inv then
            local items = inv:get_list("main")
            for _, item in ipairs(items) do
                if not item:is_empty() then
                    minetest.add_item(pos, item)
                end
            end
        end
    end,

    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        return 0
    end,

    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        return 0
    end,

})

--unfired
minetest.register_node("tech:alembic_unfired", {
	description = S("Ceramic Alembic (unfired)"),
	tiles = {
		"nodes_nature_clay.png"
	},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = alambic_nodebox,
	},
	groups = {dig_immediate=3, temp_pass = 1, heatable = 20},
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		ncrafting.set_firing(pos, base_firing, firing_int)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length
		return ncrafting.fire_pottery(pos, "tech:alembic_unfired", "tech:alembic", base_firing)
	end,
})

--Pot of wiha must, must be left to ferment
minetest.register_node("tech:wiha_must_pot", {
  description = S("Wiha Must (unfermented)"),
  tiles = {
    "tech_pot_wiha_must.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png"
  },
  drawtype = "nodebox",
  stack_max = 1,--minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = pot_nodebox
  },
  groups = {dig_immediate=3, pottery = 1, temp_pass = 1},
  sounds = nodes_nature.node_sound_stone_defaults(),

  on_dig = function(pos, node, digger)
    -- save ferment progress
    if minetest.is_protected(pos, digger:get_player_name()) then
	    return false
	  end

	  local meta = minetest.get_meta(pos)
	  local ferment = meta:get_int("ferment")

	  local new_stack = ItemStack("tech:wiha_must_pot")
	  local stack_meta = new_stack:get_meta()
	  stack_meta:set_int("ferment", ferment)


	  minetest.remove_node(pos)
	  local player_inv = digger:get_inventory()
	  if player_inv:room_for_item("main", new_stack) then
	    player_inv:add_item("main", new_stack)
	  else
	    minetest.add_item(pos, new_stack)
	  end
  end,

  on_construct = function(pos)
    --duration of ferment
    local meta = minetest.get_meta(pos)
    meta:set_int("ferment", math.random(300,360))
    --ferment
    minetest.get_node_timer(pos):start(5)
  end,

  after_place_node = function(pos, placer, itemstack, pointed_thing)
      local meta = minetest.get_meta(pos)
	  local stack_meta = itemstack:get_meta()
	  local ferment = stack_meta:get_int("ferment")
	  if ferment >0 then
	    meta:set_int("ferment", ferment)
	  end
  end,

  on_timer =function(pos, elapsed)
    local meta = minetest.get_meta(pos)
    local ferment = meta:get_int("ferment")
    if ferment < 1 then
      minetest.swap_node(pos, {name = "tech:wiha_cider_pot"})
      --minetest.check_for_falling(pos)
      return false
    else
      --ferment if at right temp
      local temp = climate.get_point_temp(pos)
      if temp > 10 and temp < 34 then
        meta:set_int("ferment", ferment - 1)
      end
      return true
    end
  end,
})

minetest.register_node("tech:wiha_cider_pot", {
  description = S("Wiha Cider"),
  tiles = {
    "tech_pot_wiha_cider.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png"
  },
  drawtype = "nodebox",
  stack_max = 1,--minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = pot_nodebox
  },
  groups = {dig_immediate=3, pottery = 1, temp_pass = 1},
  sounds = nodes_nature.node_sound_stone_defaults(),
})

minetest.register_node("tech:vinegar_pot", {
  description = S("Vinegar Pot"),
  tiles = {
    "tech_pot_vinegar.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png",
    "tech_pottery.png"
  },
  drawtype = "nodebox",
  stack_max = 1,--minimal.stack_max_bulky,
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = pot_nodebox
  },
  groups = {dig_immediate=3, pottery = 1, temp_pass = 1},
  sounds = nodes_nature.node_sound_stone_defaults(),
})

-- wiha
minetest.register_node("tech:mashed_wiha", {
  description = S("Mashed Wiha"),
  tiles = {"tech_mashed_wiha.png"},
  inventory_image = "tech_mashed_wiha_inv.png",
  stack_max = minimal.stack_max_medium/2,
  paramtype = "light",
  sunlight_propagates = true,
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = mash_pile_nodebox,
  },
  groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, edible = 1, compostable = 12},
  sounds = nodes_nature.node_sound_dirt_defaults(),

  on_construct = function(pos)
    minetest.get_node_timer(pos):start(math.random(10,20))
  end,
  on_timer = function(pos, elapsed)
    if climate.get_point_temp(pos) > 90 then
      minetest.swap_node(pos, {name = "tech:burnt_dregs"})
      return false
    end
    if math.random() > 0.9 then
      minimal.switch_node(pos, {name = "tech:wiha_dregs"})
      return false
    end
    return true
  end,
})

minetest.register_node("tech:wiha_dregs", {
  description = S("Wiha Dregs"),
  tiles = {"tech_wiha_dregs.png"},
  inventory_image = "tech_wiha_dregs_inv.png",
  stack_max = minimal.stack_max_medium/2,
  paramtype = "light",
  sunlight_propagates = true,
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = smaller_mash_pile_nodebox,
  },
  groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, heatable=100, compostable = 6},
  sounds = nodes_nature.node_sound_dirt_defaults(),

  on_construct = function(pos)
    minetest.get_node_timer(pos):start(math.random(30,60))
  end,
  on_timer = function(pos, elapsed)
    if climate.get_point_temp(pos) > 90 then
      minetest.swap_node(pos, {name = "tech:burnt_dregs"})
      return false
    end
    return true
  end,
})


minetest.register_node("tech:burnt_dregs", {
  description = S("Burnt Dregs"),
  tiles = {"tech_burnt_dregs.png"},
  inventory_image = "tech_burnt_dregs_inv.png",
  stack_max = minimal.stack_max_medium/2,
  paramtype = "light",
  sunlight_propagates = true,
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = smaller_mash_pile_nodebox,
  },
  groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, compostable = 9, flammable=1},
  sounds = nodes_nature.node_sound_dirt_defaults(),
  
  on_burn = function(pos)
    if math.random()<0.5 then
      minimal.switch_node(pos, {name = "tech:wood_ash"})
      minetest.check_for_falling(pos)
    else
      minetest.remove_node(pos)
    end
  end,
})

minetest.register_node("tech:crushed_basalt", {
  description = S("Crushed Basalt"),
  tiles = {"tech_crushed_basalt.png"},
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  sunlight_propagates = true,
  groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, compostable = 9},
  sounds = nodes_nature.node_sound_dirt_defaults()
})

minetest.register_node("tech:crushed_gneiss", {
  description = S("Crushed Gneiss"),
  tiles = {"tech_crushed_gneiss.png"},
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  sunlight_propagates = true,
  groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, compostable = 9},
  sounds = nodes_nature.node_sound_dirt_defaults()
})

minetest.register_node("tech:quartz_powder", {
  description = S("Quartz Powder"),
  tiles = {"tech_quartz_powder.png"},
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  sunlight_propagates = true,
  groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, compostable = 9},
  sounds = nodes_nature.node_sound_dirt_defaults()
})
