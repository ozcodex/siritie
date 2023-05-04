minetest.register_node("tech:stick", {
  description = S("Stick"),
  drawtype = "nodebox",
  node_box = {
   type ="fixed",
   fixed = {{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}},
  },
  tiles = {"tech_stick.png"},
  stack_max = minimal.stack_max_medium,
  paramtype = "light",
  paramtype2 = "wallmounted",
  climbable = true,
  floodable = true,
  on_flood = function(pos, oldnode, newnode)
    minetest.add_item(pos, ItemStack("tech:stick"))
    return false
  end,
  sunlight_propagates = true,
  groups = {choppy=2, dig_immediate=2, flammable=1, attached_node=1, temp_pass = 1, temp_flow = 100},
  override_sneak = true,
  drop = "tech:stick",
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
    --Extend or place on top, nothing else. This could be generalized
    -- for other attached nodes
    local itemname = itemstack:get_name()
    if itemname == node.name then
      local flipdir = (node.param2 % 2) * -2 + node.param2 + 1
      local enddir = minetest.wallmounted_to_dir(flipdir)
      local newpos = vector.add(pos,enddir)
      local stickend = minetest.get_node(newpos)
      if stickend.name == "air" then -- extend an existing stick
        minetest.item_place_node(itemstack, clicker,
      	{type = "node", under=pos, above=newpos}, node.param2)
        return itemstack
      end
    else -- only allow placing things on top of a stick, for support beams etc
        if not pointed_thing then return itemstack end
        local facing = vector.direction(pos, pointed_thing.above)
        if  vector.equals(facing, { x=0, y=1, z=0}) then
          if itemstack:get_definition().type == "node" then
            return minetest.item_place_node(itemstack, clicker, pointed_thing)
          end
        end
      end
  end
})

--bitter maraka flour
-- unusable flour. Requires water treatment.
minetest.register_node('tech:maraka_flour_bitter', {
	description = S('Bitter Maraka Flour'),
  tiles = {"tech_flour_bitter.png"},
	stack_max = minimal.stack_max_bulky * 4,
	paramtype = "light",
	groups = {crumbly = 3, dig_immediate = 3, falling_node = 1, flammable = 1},
	sounds = nodes_nature.node_sound_dirt_defaults(),
  on_construct = function(pos)
    --length(i.e. difficulty of wash), interval for checks (speed)
    ncrafting.start_soak(pos, 60, 10)
  end,
  on_timer = function(pos, elapsed)
    --finished product, length
    return ncrafting.do_soak(pos, "tech:maraka_flour", 60)
  end,
})

-- maraka flour
--usable flour.
minetest.register_node('tech:maraka_flour', {
	description = S('Maraka Flour'),
  tiles = {"tech_flour.png"},
	stack_max = minimal.stack_max_bulky * 4,
	paramtype = "light",
	groups = {crumbly = 3, dig_immediate = 3, falling_node = 1, flammable = 1},
	sounds = nodes_nature.node_sound_dirt_defaults(),
})


--maraka cake, prior to baking
minetest.register_node("tech:maraka_bread", {
	description = S("Unbaked Maraka Cake"),
	tiles = {"tech_flour.png"},
	stack_max = minimal.stack_max_medium,
  paramtype = "light",
  paramtype2 = "wallmounted",
  sunlight_propagates = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, -0.3, 0.3},
	},
	groups = {crumbly = 3, dig_immediate = 3, temp_pass = 1, heatable = 80, edible = 1},
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

--maraka cake,baked
minetest.register_node("tech:maraka_bread_cooked", {
	description = S("Maraka Cake"),
	tiles = {"tech_flour_bitter.png"},
	stack_max = minimal.stack_max_medium * 4,
  paramtype = "light",
  sunlight_propagates = true,
  --paramtype2 = "wallmounted",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-0.28, -0.5, -0.28, 0.28, -0.32, 0.28},
	},
	groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, heatable = 80, edible = 1},
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

--maraka cake, burned
minetest.register_node("tech:maraka_bread_burned", {
  description = S("Maraka Cake Burned"),
  tiles = {"tech_flour_burned.png"},
  stack_max = minimal.stack_max_medium * 4,
  paramtype = "light",
  sunlight_propagates = true,
  --paramtype2 = "wallmounted",
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-0.28, -0.5, -0.28, 0.28, -0.32, 0.28},
  },
  groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, flammable = 1,  temp_pass = 1, edible = 1},
  sounds = nodes_nature.node_sound_dirt_defaults(),
})

-----------
--Anperla
minetest.register_node("tech:peeled_anperla", {
	description = S("Peeled Anperla Tuber"),
	tiles = {"tech_flour.png"},
	stack_max = minimal.stack_max_medium,
  paramtype = "light",
  sunlight_propagates = true,
	drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-0.15, -0.5, -0.15,  0.15, -0.35, 0.15},
  },
	groups = {snappy = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, heatable = 70, edible = 1},
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

minetest.register_node("tech:peeled_anperla_burned", {
	description = S("Burned Anperla Tuber"),
	tiles = {"tech_flour_burned.png"},
	stack_max = minimal.stack_max_medium * 2,
  paramtype = "light",
  sunlight_propagates = true,
	drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-0.15, -0.5, -0.15,  0.15, -0.35, 0.15},
  },
	groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, flammable = 1,  temp_pass = 1, edible = 1},
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

minetest.register_node("tech:peeled_anperla_cooked", {
	description = S("Cooked Anperla Tuber"),
	tiles = {"tech_flour_bitter.png"},
	stack_max = minimal.stack_max_medium * 2,
  paramtype = "light",
  sunlight_propagates = true,
	drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-0.15, -0.5, -0.15,  0.15, -0.35, 0.15},
  },
	groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, heatable = 70,  temp_pass = 1, edible = 1},
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

--mash (a way to bulk cook tubers - 6 at once)
minetest.register_node("tech:mashed_anperla", {
	description = S("Mashed Anperla (uncooked)"),
	tiles = {"tech_flour.png"},
	stack_max = minimal.stack_max_medium/6,
  paramtype = "light",
  --sunlight_propagates = true,
	drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-6/16, -0.5, -6/16, 6/16, 1/16, 6/16},
  },
	groups = {snappy = 3, falling_node = 1, dig_immediate = 3, temp_pass = 1, heatable = 70, edible = 1},
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

minetest.register_node("tech:mashed_anperla_cooked", {
	description = S("Mashed Anperla"),
	tiles = {"tech_flour_bitter.png"},
	stack_max = minimal.stack_max_medium/3,
  paramtype = "light",
  --sunlight_propagates = true,
	drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-5/16, -0.5, -5/16, 5/16, -1/16, 5/16},
  },
	groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, heatable = 70,  temp_pass = 1, edible = 1},
	sounds = nodes_nature.node_sound_dirt_defaults(),
})

minetest.register_node("tech:mashed_anperla_burned", {
  description = S("Burned Anperla"),
  tiles = {"tech_flour_burned.png"},
  stack_max = minimal.stack_max_medium/3,
  paramtype = "light",
  --sunlight_propagates = true,
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {-5/16, -0.5, -5/16, 5/16, -1/16, 5/16},
  },
  groups = {crumbly = 3, falling_node = 1, dig_immediate = 3, flammable = 1,  temp_pass = 1, edible = 1},
  sounds = nodes_nature.node_sound_dirt_defaults(),
})