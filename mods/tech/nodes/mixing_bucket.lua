bucket_nodebox = {
        -- BASE
        { -0.2500, -0.5000,  0.0625, -0.1875, -0.4375, -0.0625},  -- Base 1
        { -0.1875, -0.5000, -0.1875, -0.0625, -0.4375,  0.1875},  -- Base 2
        { -0.0625, -0.5000, -0.2500,  0.0625, -0.4375,  0.2500},  -- Base 3
        {  0.0625, -0.5000, -0.1875,  0.1875, -0.4375,  0.1875},  -- Base 4
        {  0.1875, -0.5000, -0.0625,  0.2500, -0.4375,  0.0625},  -- Base 5
        -- SIDES
        { -0.3125, -0.5000, -0.0625, -0.2500, -0.1250,  0.0625}, -- Table 1
        { -0.2500, -0.5000, -0.1875, -0.1875, -0.1250, -0.0625}, -- Table 2
        { -0.2500, -0.5000,  0.0625, -0.1875, -0.1250,  0.1875}, -- Table 3
        { -0.1875, -0.5000, -0.2500, -0.0625, -0.1250, -0.1875}, -- Table 4
        { -0.1875, -0.5000,  0.1875, -0.0625, -0.1250,  0.2500}, -- Table 5
        { -0.0625, -0.5000, -0.3125,  0.0625, -0.1250, -0.2500}, -- Table 6
        { -0.0625, -0.5000,  0.2500,  0.0625, -0.1250,  0.3125}, -- Table 7
        {  0.0625, -0.5000, -0.2500,  0.1875, -0.1250, -0.1875}, -- Table 8
        {  0.0625, -0.5000,  0.1875,  0.1875, -0.1250,  0.2500}, -- Table 9
        {  0.1875, -0.5000, -0.1875,  0.2500, -0.1250, -0.0625}, -- Table 10
        {  0.1875, -0.5000,  0.0625,  0.2500, -0.1250,  0.1875}, -- Table 11
        {  0.2500, -0.5000, -0.0625,  0.3125, -0.1250,  0.0625}, -- Table 12
        -- TOP PART
        { -0.1875, -0.1250,  0.2500,  0.1875,  0.0625,  0.3125}, -- Table 1
        { -0.2500, -0.1250,  0.1875, -0.1875,  0.0625,  0.2500}, -- Table 2
        {  0.1875, -0.1250,  0.1875,  0.2500,  0.0625,  0.2500}, -- Table 3
        { -0.3125, -0.1250, -0.1875, -0.2500,  0.0625,  0.1875}, -- Table 4
        {  0.2500, -0.1250, -0.1875,  0.3125,  0.0625,  0.1875}, -- Table 5
        { -0.2500, -0.1250, -0.2500, -0.1875,  0.0625, -0.1875}, -- Table 6
        {  0.2500, -0.1250, -0.2500,  0.1875,  0.0625, -0.1875}, -- Table 7
        { -0.1875, -0.1250, -0.3125,  0.1875,  0.0625, -0.2500}, -- Table 8
      }

filled_bucket_nodebox = table.copy(bucket_nodebox)
table.insert(filled_bucket_nodebox, { -0.24999,  0.0000,  -0.24999, 0.24999,  0.0000,  0.24999})

minetest.register_node("tech:mixing_bucket", {
  description   = S("Mixing Bucket"),
  tiles         = {"tech_stick.png"},
  drawtype      = "nodebox",
  node_box      = {
    type  = "fixed",
    fixed = bucket_nodebox
    },
  stack_max     = 1,
  paramtype     = "light",
  groups        = {dig_immediate=3, falling_node = 1, temp_pass = 1},
  sounds        = nodes_nature.node_sound_wood_defaults(),
  sunlight_propagates = true,
  on_rightclick = crafting.make_on_rightclick("mixing_bucket", 2, { x = 8, y = 3 }),
  })

minetest.register_node("tech:lime_mortar_bucket", {
  description   = S("Mortar Bucket"),
  tiles         = {"tech_mortar_bucket_top.png","tech_chopping_block.png"},
  drawtype      = "nodebox",
  node_box      = {
    type  = "fixed",
    fixed = filled_bucket_nodebox
    },
  stack_max     = 1,
  paramtype     = "light",
  groups        = {dig_immediate=3, falling_node = 1, temp_pass = 1},
  sounds        = nodes_nature.node_sound_wood_defaults(),
  sunlight_propagates = true,
  on_rightclick = crafting.make_on_rightclick("mortar_bucket", 2, { x = 8, y = 3 }),
  })

minetest.register_node("tech:clay_mixing_bucket", {
  description   = S("Clay Mixing Bucket"),
  tiles         = {"tech_clay_bucket_top.png","tech_chopping_block.png"},
  drawtype      = "nodebox",
  node_box      = {
    type  = "fixed",
    fixed = filled_bucket_nodebox
    },
  stack_max     = 1,
  paramtype     = "light",
  groups        = {dig_immediate=3, falling_node = 1, temp_pass = 1},
  sounds        = nodes_nature.node_sound_wood_defaults(),
  sunlight_propagates = true,
  on_rightclick = crafting.make_on_rightclick("clay_mixing", 2, { x = 8, y = 3 }),
  })