---- Stations -------------------
--Entry level --equivalent to sitting down to make stuff
--crafting spot--basic crafts
minetest.register_node("tech:crafting_spot", {
  description = S("Crafting Spot"),
  tiles = { "tech_station_crafting_spot.png" },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.5, 0.5, -0.45, 0.5 },
  },
  selection_box = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 },
  },
  stack_max = 1,
  paramtype = "light",
  use_texture_alpha = c_alpha.clip,
  walkable = false,
  buildable_to = true,
  floodable = true,
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, nobones = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  sunlight_propagates = true,
  on_rightclick = crafting.make_on_rightclick("crafting_spot", 2, { x = 8, y = 3 }),
  on_punch = function(pos, node, player)
    minetest.remove_node(pos)
  end,
})

--Threshing spot
--extracting seeds from plants
minetest.register_node("tech:threshing_spot", {
  description = S("Threshing Spot"),
  tiles = { "tech_station_threshing_spot.png" },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.5, 0.5, -0.45, 0.5 },
  },
  selection_box = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 },
  },
  stack_max = 1,
  paramtype = "light",
  use_texture_alpha = c_alpha.clip,
  walkable = false,
  buildable_to = true,
  floodable = true,
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, nobones = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  sunlight_propagates = true,
  on_rightclick = crafting.make_on_rightclick("threshing_spot", 2, { x = 8, y = 3 }),
  on_place = function(itemstack, placer, pointed_thing)
    return on_place_loclim_spot(
      itemstack,
      placer,
      pointed_thing,
      {},
      {},
      "dry ground",
      { { "puts_out_fire", 1 } },
      {}
    )
  end,
  on_punch = function(pos, node, player)
    minetest.remove_node(pos)
  end,
})
--hammering_block
--crude hammering crushing jobs,
minetest.register_node("tech:hammering_spot", {
  description = S("Hammering Spot"),
  tiles = { "tech_station_hammering_spot.png" },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.5, 0.5, -0.45, 0.5 },
  },
  selection_box = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 },
  },
  stack_max = 1,
  paramtype = "light",
  use_texture_alpha = c_alpha.clip,
  walkable = false,
  buildable_to = true,
  floodable = true,
  groups = { dig_immediate = 3, attached_node = 1, temp_pass = 1, nobones = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
  sunlight_propagates = true,
  on_rightclick = crafting.make_on_rightclick("hammering_block", 2, { x = 8, y = 3 }),
  on_place = function(itemstack, placer, pointed_thing)
    return on_place_loclim_spot(
      itemstack,
      placer,
      pointed_thing,
      { { "stone", 1 }, { "masonry", 1 }, { "boulder", 1 }, { "soft_stone", 1 }, { "tree", 1 }, { "log", 1 } },
      {},
      "stone, masonry, tree, or a log"
    )
  end,
  on_punch = function(pos, node, player)
    minetest.remove_node(pos)
  end,
})

-- Clay shaping spot, for making clay items
minetest.register_node("tech:clay_shaping_spot", {
  description = S("Clay Shaping Spot"),
  tiles = { "tech_station_clay_shaping_spot.png" },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.5, 0.5, -0.45, 0.5 },
  },
  selection_box = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.5, 0.5, -0.25, 0.5 },
  },
  stack_max = 1,
  paramtype = "light",
  use_texture_alpha = c_alpha.clip,
  walkable = false,
  buildable_to = true,
  floodable = true,
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, nobones = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  sunlight_propagates = true,
  on_rightclick = crafting.make_on_rightclick("clay_shaping_spot", 2, { x = 8, y = 3 }),
  on_punch = function(pos, node, player)
    minetest.remove_node(pos)
  end,
})

-- mixing

--- New one is Masonry Toolset
minetest.register_node("tech:mixing_spot", {
  description = S("Masonry Toolset"),
  tiles = { "tech_stick.png" },
  drawtype = "nodebox",
  inventory_image = "tech_mixing_spot_inv.png",
  node_box = {
    type = "fixed",
    fixed = {
      -- side 1
      { -0.3750, -0.5000, -0.3125, -0.3125, -0.3750, -0.2500 },
      { -0.3125, -0.3750, -0.3125, -0.2500, -0.2500, -0.2500 },
      { -0.2500, -0.2500, -0.3125, -0.1875, -0.1250, -0.2500 },
      { -0.1875, -0.1250, -0.3125, -0.1250, 0.0000, -0.2500 },
      { -0.1250, 0.0000, -0.3125, -0.0625, 0.1250, -0.2500 },

      -- tip
      { -0.0625, 0.1250, -0.3125, 0.0000, 0.1875, -0.2500 },
      -- plummet
      { -0.0625, -0.3750, -0.3125, 0.0000, -0.2500, -0.2500 },

      -- side 2
      { 0.3125, -0.5000, -0.3125, 0.2500, -0.3750, -0.2500 },
      { 0.2500, -0.3750, -0.3125, 0.1875, -0.2500, -0.2500 },
      { 0.1875, -0.2500, -0.3125, 0.1250, -0.1250, -0.2500 },
      { 0.1250, -0.1250, -0.3125, 0.0625, 0.0000, -0.2500 },
      { 0.0625, 0.0000, -0.3125, 0.0000, 0.1250, -0.2500 },

      -- crossbar
      { -0.2500, -0.1875, -0.2500, 0.1875, -0.1250, -0.1875 },
      -- string
      { -0.04125, -0.2500, -0.29125, -0.02125, 0.1250, -0.27125 },

      --Mullet
      { -0.3125, -0.5000, -0.1250, -0.1250, -0.3125, 0.1250 },
      { -0.2500, -0.4375, 0.1250, -0.1875, -0.3750, 0.2500 },

      -- Square
      { 0.0000, -0.5000, -0.1250, 0.2500, -0.46875, -0.0625 },
      { 0.1875, -0.5000, -0.0625, 0.2500, -0.46875, 0.1250 },

      --chisel
      { -0.1250, -0.5000, 0.1875, 0.1250, -0.4375, 0.2500 },
      { 0.1250, -0.47875, 0.1875, 0.1875, -0.45875, 0.2500 },
    },
  },
  stack_max = 1,
  paramtype = "light",
  use_texture_alpha = c_alpha.clip,
  walkable = false,
  buildable_to = true,
  floodable = true,
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, nobones = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  sunlight_propagates = true,
  on_rightclick = crafting.make_on_rightclick("mixing_spot", 2, { x = 8, y = 3 }),
})

------------------------------
--mortar and pestle.
--for grinding food etc
minetest.register_node("tech:mortar_pestle_basalt", {
  description = S("Basalt Mortar and Pestle"),
  drawtype = "nodebox",
  tiles = { "nodes_nature_basalt.png" },
  stack_max = minimal.stack_max_heavy,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { falling_node = 1, dig_immediate = 3, craftedby = 1 },
  node_box = {
    type = "fixed",
    fixed = {
      { -0.3750, -0.5000, -0.3750, 0.3750, -0.4375, 0.3750 },
      { -0.4375, -0.4375, -0.4375, 0.4375, -0.3125, 0.4375 },
      { -0.4375, -0.3125, -0.4375, 0.4375, 0.2500, -0.3125 },
      { -0.4375, -0.3125, 0.3125, 0.4375, 0.2500, 0.4375 },
      { -0.4375, -0.3125, -0.3125, -0.3125, 0.2500, 0.3125 },
      { 0.3125, -0.3125, -0.3125, 0.4375, 0.2500, 0.3125 },
      { -0.2500, -0.3125, 0.1250, -0.0625, 0.4375, 0.3125 },
    },
  },
  sounds = nodes_nature.node_sound_stone_defaults(),
  on_rightclick = crafting.make_on_rightclick("mortar_and_pestle", 2, { x = 8, y = 3 }),
})

minetest.register_node("tech:mortar_pestle_granite", {
  description = S("Granite Mortar and Pestle"),
  drawtype = "nodebox",
  tiles = { "nodes_nature_granite.png" },
  stack_max = minimal.stack_max_heavy,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { falling_node = 1, dig_immediate = 3, craftedby = 1 },
  node_box = {
    type = "fixed",
    fixed = {
      { -0.3750, -0.5000, -0.3750, 0.3750, -0.4375, 0.3750 },
      { -0.4375, -0.4375, -0.4375, 0.4375, -0.3125, 0.4375 },
      { -0.4375, -0.3125, -0.4375, 0.4375, 0.2500, -0.3125 },
      { -0.4375, -0.3125, 0.3125, 0.4375, 0.2500, 0.4375 },
      { -0.4375, -0.3125, -0.3125, -0.3125, 0.2500, 0.3125 },
      { 0.3125, -0.3125, -0.3125, 0.4375, 0.2500, 0.3125 },
      { -0.2500, -0.3125, 0.1250, -0.0625, 0.4375, 0.3125 },
    },
  },
  sounds = nodes_nature.node_sound_stone_defaults(),
  on_rightclick = crafting.make_on_rightclick("mortar_and_pestle", 2, { x = 8, y = 3 }),
})

minetest.register_node("tech:mortar_pestle_limestone", {
  description = S("Limestone Mortar and Pestle"),
  drawtype = "nodebox",
  tiles = { "nodes_nature_limestone.png" },
  stack_max = minimal.stack_max_heavy,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { falling_node = 1, dig_immediate = 3, craftedby = 1 },
  node_box = {
    type = "fixed",
    fixed = {
      { -0.3750, -0.5000, -0.3750, 0.3750, -0.4375, 0.3750 },
      { -0.4375, -0.4375, -0.4375, 0.4375, -0.3125, 0.4375 },
      { -0.4375, -0.3125, -0.4375, 0.4375, 0.2500, -0.3125 },
      { -0.4375, -0.3125, 0.3125, 0.4375, 0.2500, 0.4375 },
      { -0.4375, -0.3125, -0.3125, -0.3125, 0.2500, 0.3125 },
      { 0.3125, -0.3125, -0.3125, 0.4375, 0.2500, 0.3125 },
      { -0.2500, -0.3125, 0.1250, -0.0625, 0.4375, 0.3125 },
    },
  },
  sounds = nodes_nature.node_sound_stone_defaults(),
  on_rightclick = crafting.make_on_rightclick("mortar_and_pestle", 2, { x = 8, y = 3 }),
})

-------------------
--metal working, and things dependant on it
minetest.register_node("tech:anvil", { --anvil--metal  working
  description = S("Anvil"),
  tiles = { "tech_iron.png" },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      { -0.50, -0.5, -0.30, 0.50, -0.4, 0.30 },
      { -0.35, -0.4, -0.25, 0.35, -0.3, 0.25 },
      { -0.30, -0.3, -0.15, 0.30, -0.1, 0.15 },
      { -0.35, -0.1, -0.20, 0.35, 0.1, 0.20 },
    },
  },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, craftedby = 1 },
  sounds = nodes_nature.node_sound_stone_defaults(),
  on_rightclick = crafting.make_on_rightclick("anvil", 2, { x = 8, y = 3 }),
})

minetest.register_node("tech:carpentry_bench", { --carpentry_bench--more sophisticated wood working
  description = S("Carpentry Bench"),
  tiles = { "nodes_nature_maraka_log.png" },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      { -0.5000, 0.000, -0.3125, 0.5000, 0.250, 0.3750 },
      { -0.5000, -0.125, -0.2500, 0.5000, 0.000, 0.3125 },
      { 0.3125, -0.500, -0.2500, 0.4375, -0.125, -0.1250 },
      { 0.3125, -0.500, 0.1875, 0.4375, -0.125, 0.3125 },
      { -0.4375, -0.500, 0.1875, -0.3125, -0.125, 0.3125 },
      { -0.4375, -0.500, -0.2500, -0.3125, -0.125, -0.1250 },
    },
  },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, flammable = 8, craftedby = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = crafting.make_on_rightclick("carpentry_bench", 2, { x = 8, y = 3 }),
})

minetest.register_node("tech:masonry_bench", { --masonry_bench--more sophisticated stone crafts
  description = S("Masonry Bench"),
  tiles = { "nodes_nature_maraka_log.png" },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      { -0.5000, 0.0000, -0.5000, 0.5000, 0.25, 0.5000 },
      { -0.5000, -0.5000, -0.5000, -0.3125, 0.00, -0.3125 },
      { 0.3125, -0.5000, -0.5000, 0.5000, 0.00, -0.3125 },
      { 0.3125, -0.5000, 0.3125, 0.5000, 0.00, 0.5000 },
      { -0.5000, -0.5000, 0.3125, -0.3125, 0.00, 0.5000 },
      { -0.4375, -0.1875, -0.3125, -0.3125, 0.00, 0.3125 },
      { 0.3125, -0.1875, -0.3125, 0.4375, 0.00, 0.3125 },
      { -0.3750, -0.1875, -0.4375, 0.3125, 0.00, -0.3125 },
      { -0.3750, -0.1875, 0.3125, 0.3750, 0.00, 0.4375 },
    },
  },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, craftedby = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = crafting.make_on_rightclick("masonry_bench", 2, { x = 8, y = 3 }),
})

--brick_makers_bench
--for fired bricks and associated crafts
minetest.register_node("tech:brick_makers_bench", {
  description = S("Brickworks Bench"),
  tiles = { "nodes_nature_maraka_log.png" },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      -- table top
      { -0.4375, -0.250, -0.3750, 0.4375, -0.1250, 0.3750 }, -- NodeBox1
      -- legs
      { -0.3750, -0.500, -0.3125, -0.2500, -0.2500, -0.1875 }, -- NodeBox2
      { 0.2500, -0.500, -0.3125, 0.3750, -0.2500, -0.1875 }, -- NodeBox3
      { 0.2500, -0.500, 0.1875, 0.3750, -0.2500, 0.3125 }, -- NodeBox4
      { -0.3750, -0.500, 0.1875, -0.2500, -0.2500, 0.3125 }, -- NodeBox5
      -- under table aprons
      { -0.3750, -0.375, -0.1875, -0.2500, -0.2500, 0.1875 }, -- NodeBox6
      { 0.2500, -0.375, -0.1875, 0.3750, -0.2500, 0.1875 }, -- NodeBox7
      { -0.2500, -0.375, -0.3125, 0.2500, -0.2500, -0.1875 }, -- NodeBox8
      { -0.2500, -0.375, 0.1875, 0.2500, -0.2500, 0.3125 }, -- NodeBox9
      -- table details
      { -0.2500, -0.125, 0.1875, 0.2500, 0.0000, 0.2500 }, -- NodeBox10
      { -0.2500, -0.125, -0.0625, 0.2500, 0.0000, 0.0000 }, -- NodeBox11
      { -0.3125, -0.125, -0.0625, -0.2500, 0.0000, 0.2500 }, -- NodeBox12
      { 0.2500, -0.125, -0.0625, 0.3125, 0.0000, 0.2500 }, -- NodeBox13
      { 0.1875, -0.125, -0.3125, 0.2500, -0.0625, -0.1250 }, -- NodeBox14
    },
  },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, flammable = 8, craftedby = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = crafting.make_on_rightclick("brick_makers_bench", 2, { x = 8, y = 3 }),
})

--spinning_wheel
--turn raw fibres into spun fibre
--including steps here that in reality would require their own equipment
minetest.register_node("tech:spinning_wheel", {
  description = S("Spinning Wheel"),
  tiles = { "nodes_nature_maraka_log.png" },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      { -0.2500, -0.5000, -0.1875, 0.5000, -0.2500, 0.1875 }, -- NodeBox1
      { -0.2500, -0.2500, -0.1875, -0.0625, 0.1875, -0.0625 }, -- NodeBox2
      { -0.2500, -0.2500, 0.0625, -0.0625, 0.1875, 0.1875 }, -- NodeBox3
      { -0.1875, -0.1875, -0.0625, -0.1250, 0.5000, 0.0625 }, -- NodeBox4
      { -0.5000, 0.1250, -0.0625, -0.2500, 0.1875, 0.0625 }, -- NodeBox5
      { -0.0625, 0.1250, -0.0625, 0.1875, 0.1875, 0.0625 }, -- NodeBox6
      { 0.3750, -0.2500, -0.0625, 0.5000, -0.1250, 0.0625 }, -- NodeBox7
    },
  },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, flammable = 8, craftedby = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = crafting.make_on_rightclick("spinning_wheel", 2, { x = 8, y = 3 }),
})

--Loom--turn fibre into fabric items
minetest.register_node("tech:loom", {
  description = S("Loom"),
  tiles = { "nodes_nature_maraka_log.png" },
  drawtype = "nodebox",
  paramtype = "light",
  node_box = {
    type = "fixed",
    fixed = {
      { -0.5000, -0.5000, -0.1250, -0.3750, 0.5000, 0.1875 }, -- NodeBox1
      { 0.3750, -0.5000, -0.1250, 0.5000, 0.5000, 0.1875 }, -- NodeBox3
      { -0.3750, -0.5000, -0.5000, 0.3750, -0.4375, 0.5000 }, -- NodeBox4
      { -0.5000, 0.0000, -0.1250, 0.5000, 0.0625, 0.1875 }, -- NodeBox5
      { -0.5000, 0.3125, 0.1875, 0.5000, 0.5000, 0.2500 }, -- NodeBox6
      { -0.5000, 0.3125, -0.1875, 0.5000, 0.5000, -0.1250 }, -- NodeBox7
      { -0.3750, -0.1875, -0.5000, -0.3125, -0.1250, 0.5000 }, -- NodeBox8
      { 0.3125, -0.1875, -0.5000, 0.3750, -0.1250, 0.5000 }, -- NodeBox9
      { -0.4375, -0.1875, -0.5000, 0.4375, -0.1250, -0.4375 }, -- NodeBox10
      { -0.4375, -0.1875, 0.4375, 0.4375, -0.1250, 0.5000 }, -- NodeBox11
      { -0.3750, -0.5000, 0.3750, -0.3125, -0.1250, 0.4375 }, -- NodeBox12
      { 0.3125, -0.5000, 0.3750, 0.3750, -0.1250, 0.4375 }, -- NodeBox13
      { -0.3750, -0.5000, -0.4375, -0.3125, -0.1250, -0.3750 }, -- NodeBox14
      { 0.3125, -0.5000, -0.4375, 0.3750, -0.1250, -0.3750 }, -- NodeBox15
      { -0.3125, -0.4375, -0.2500, 0.3125, 0.0000, 0.2500 }, -- NodeBox16
    },
  },
  paramtype2 = "facedir",
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, flammable = 8, craftedby = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = crafting.make_on_rightclick("loom", 2, { x = 8, y = 3 }),
})

--Glassworking Furnace
--Glassblowing and similar
minetest.register_node("tech:glass_furnace", {
  description = S("Glass furnace"),
  tiles = {
    "tech_bricks_and_mortar.png",
    "tech_bricks_and_mortar.png",
    "tech_bricks_and_mortar.png",
    "tech_bricks_and_mortar.png",
    "tech_bricks_and_mortar.png",
    "tech_glassfurnace_front.png",
  },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = { -0.47, -0.5, -0.47, 0.47, 0.31, 0.47 },
  },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, craftedby = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = crafting.make_on_rightclick("glass_furnace", 2, { x = 8, y = 3 }),
})
minetest.register_node("tech:weaving_frame", {
  description = S("Weaving Frame"),
  drawtype = "nodebox",
  tiles = { "tech_stick.png" },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { falling_node = 1, dig_immediate = 3, craftedby = 1 },
  node_box = {
    type = "fixed",
    fixed = {
      { -0.3750, -0.3750, -0.3750, 0.3750, -0.2500, -0.2500 }, -- NodeBox1
      { -0.5000, -0.5000, -0.3750, -0.3750, -0.1250, -0.2500 }, -- NodeBox2
      { 0.3750, -0.5000, -0.3750, 0.5000, -0.1250, -0.2500 }, -- NodeBox3
      { 0.3750, -0.5000, 0.3750, 0.5000, 0.0625, 0.5000 }, -- NodeBox4
      { -0.5000, -0.5000, 0.3750, -0.3750, 0.0625, 0.5000 }, -- NodeBox5
      { -0.3750, -0.0625, 0.3750, 0.3750, 0.0625, 0.5000 }, -- NodeBox6
      { -0.3125, -0.5000, 0.3750, -0.2500, -0.0625, 0.4375 }, -- NodeBox7
      { 0.2500, -0.5000, 0.3750, 0.3125, -0.0625, 0.4375 }, -- NodeBox8
      { 0.1250, -0.5000, 0.3750, 0.1875, -0.0625, 0.4375 }, -- NodeBox9
      { -0.1875, -0.5000, 0.3750, -0.1250, -0.0625, 0.4375 }, -- NodeBox10
      { -0.0625, -0.5000, 0.3750, 0.0625, -0.0625, 0.5000 }, -- NodeBox11
      { -0.5000, -0.0625, 0.3125, 0.5000, 0.0000, 0.3750 }, -- NodeBox12
      { -0.5000, -0.4375, 0.3125, 0.5000, -0.3750, 0.3750 }, -- NodeBox13
      { -0.4375, -0.3750, -0.3000, -0.3750, -0.3000, 0.3750 }, -- NodeBox14
      { 0.4375, -0.3750, -0.3000, 0.3750, -0.3000, 0.3750 }, -- NodeBox15
    },
  },
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = crafting.make_on_rightclick("weaving_frame", 2, { x = 8, y = 3 }),
})
--grinding stone
--for grinding stone tools
minetest.register_node("tech:grinding_stone_granite", {
  description = S("Granite grinding stone"),
  drawtype = "nodebox",
  tiles = { "nodes_nature_granite.png" },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { falling_node = 1, dig_immediate = 3, craftedby = 1 },
  node_box = {
    type = "fixed",
    fixed = {
      { -0.3750, -0.5000, -0.3125, 0.3750, -0.4375, 0.3125 },
      { -0.4375, -0.4375, -0.3750, 0.4375, -0.1875, 0.3750 },
      { -0.1875, -0.1875, 0.0000, 0.0000, -0.0625, 0.2500 },
      { 0.4375, -0.3750, -0.3125, 0.5000, -0.1875, 0.3125 },
      { -0.5000, -0.3750, -0.3125, -0.4375, -0.1875, 0.3125 },
      { -0.3750, -0.3750, -0.4375, 0.3750, -0.1875, -0.3750 },
      { -0.3750, -0.3750, 0.3750, 0.3750, -0.1875, 0.4375 },
    },
  },
  sounds = nodes_nature.node_sound_stone_defaults(),
  on_rightclick = crafting.make_on_rightclick("grinding_stone", 2, { x = 8, y = 3 }),
})
minetest.register_node("tech:grinding_stone_limestone", {
  description = S("Limestone grinding stone"),
  drawtype = "nodebox",
  tiles = { "nodes_nature_limestone.png" },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { falling_node = 1, dig_immediate = 3, craftedby = 1 },
  node_box = {
    type = "fixed",
    fixed = {
      { -0.3750, -0.5000, -0.3125, 0.3750, -0.4375, 0.3125 },
      { -0.4375, -0.4375, -0.3750, 0.4375, -0.1875, 0.3750 },
      { -0.1875, -0.1875, 0.0000, 0.0000, -0.0625, 0.2500 },
      { 0.4375, -0.3750, -0.3125, 0.5000, -0.1875, 0.3125 },
      { -0.5000, -0.3750, -0.3125, -0.4375, -0.1875, 0.3125 },
      { -0.3750, -0.3750, -0.4375, 0.3750, -0.1875, -0.3750 },
      { -0.3750, -0.3750, 0.3750, 0.3750, -0.1875, 0.4375 },
    },
  },
  sounds = nodes_nature.node_sound_stone_defaults(),
  on_rightclick = crafting.make_on_rightclick("grinding_stone", 2, { x = 8, y = 3 }),
})
--chopping_block --crude wood crafts,
minetest.register_node("tech:chopping_block", {
  description = S("Chopping Log"),
  tiles = {
    "tech_chopping_block_top.png",
    "tech_chopping_block_top.png",
    "tech_chopping_block.png",
    "tech_chopping_block.png",
    "tech_chopping_block.png",
    "tech_chopping_block.png",
  },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      { -0.4375, -0.5, -0.4375, 0.4375, 0.35, 0.4375 },
      { -0.375, -0.5, 0.4375, 0.375, 0.35, 0.5 },
      { -0.375, -0.5, -0.5, 0.375, 0.35, -0.4375 },
      { 0.4375, -0.5, -0.375, 0.5, 0.35, 0.375 },
      { -0.5, -0.5, -0.375, -0.4375, 0.35, 0.375 },
    },
  },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, craftedby = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = crafting.make_on_rightclick("chopping_block", 2, { x = 8, y = 3 }),
})

local function register_hammering_block(material)
  minetest.register_node("tech:hammering_block_" .. material, {
    description = S("Hammering Log"),
    tiles = {
      "tech_hammering_block_top_" .. material .. ".png",
      "tech_chopping_block_top.png",
      "tech_hammering_block_right_" .. material .. ".png",
      "tech_hammering_block_left_" .. material .. ".png",
      "tech_hammering_block_back_" .. material .. ".png",
      "tech_hammering_block_front_" .. material .. ".png",
    },
    drawtype = "nodebox",
    node_box = {
      type = "fixed",
      fixed = {
        -- log
        { -0.375, -0.5, -0.375, 0.375, 0.250, 0.375 },
        { -0.3125, -0.5, 0.375, 0.3125, 0.250, 0.4375 },
        { -0.3125, -0.5, -0.4375, 0.3125, 0.250, -0.375 },
        { 0.375, -0.5, -0.3125, 0.4375, 0.250, 0.3125 },
        { -0.4375, -0.5, -0.3125, -0.375, 0.250, 0.3125 },
        -- hammer
        { -0.0625, 0.23, 0.0000, 0.0625, 0.36, 0.3125 },
        { -0.0625, 0.23, 0.1250, 0.2500, 0.3125, 0.1875 },
      },
    },
    stack_max = minimal.stack_max_bulky,
    paramtype = "light",
    groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, craftedby = 1 },
    sounds = nodes_nature.node_sound_wood_defaults(),
    on_rightclick = crafting.make_on_rightclick("hammering_block", 2, { x = 8, y = 3 }),
  })
end

register_hammering_block("basalt")
register_hammering_block("granite")

minetest.register_node("tech:wattle_workstation", {
  description = S("Wattle Workstation"),
  tiles = { "tech_stick.png" },
  drawtype = "nodebox",
  node_box = {
    type = "fixed",
    fixed = {
      { -0.4375, -0.5, 0.3125, -0.3125, 0.1875, 0.4375 }, -- NodeBox1
      { 0.1875, -0.5, 0.125, 0.3125, 0.125, 0.25 }, -- NodeBox2
      { 0.3125, -0.5, -0.4375, 0.4375, 0.0625, -0.3125 }, -- NodeBox3
      { -0.4375, -0.5, -0.4375, -0.3125, 0.125, -0.3125 }, -- NodeBox4
      { 0, -0.5, -0.25, 0.125, 0.0625, -0.125 }, -- NodeBox5
      { -0.5, -0.0625, 0.25, 0.375, 0, 0.3125 }, -- NodeBox6
      { -0.5, -0.3125, 0.25, 0.375, -0.25, 0.3125 }, -- NodeBox7
      { 0.125, -0.1875, -0.3125, 0.1875, -0.125, 0.375 }, -- NodeBox8
      { -0.5, -0.375, -0.3125, 0.5, -0.3125, -0.25 }, -- NodeBox9
      { -0.5, -0.0625, -0.3125, 0.5, 0, -0.25 }, -- NodeBox10
      { -0.3125, -0.5, -0.0625, -0.1875, -0.125, 0.0625 }, -- NodeBox11
      { -0.375, -0.25, -0.125, 0.25, -0.1875, -0.0625 }, -- NodeBox12
      { 0.25, -0.5, 0.3125, 0.375, -0.125, 0.4375 }, -- NodeBox14
    },
  },
  selection_box = {
    type = "fixed",
    fixed = {
      { -0.3125, -0.5, -0.3125, 0.25, -0.0625, 0.3125 },
    },
  },
  stack_max = minimal.stack_max_bulky,
  paramtype = "light",
  groups = { dig_immediate = 3, falling_node = 1, temp_pass = 1, craftedby = 1 },
  sounds = nodes_nature.node_sound_wood_defaults(),
  on_rightclick = crafting.make_on_rightclick("wattle_workstation", 2, { x = 8, y = 3 }),
})
