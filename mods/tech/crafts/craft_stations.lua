
---------------------------------------
--Recipes
---- Hand crafts (inv) ----
crafting.register_recipe({ ----craft crafting spot for free
  type   = "inv",
  output = "tech:crafting_spot",
  items  = {},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({ ----craft mixing spot for free
  type   = "inv",
  output = "tech:mixing_spot",
  items  = {},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({ ----craft threshing spot for free
  type   = "inv",
  output = "tech:threshing_spot",
  items  = {},
  level  = 1,
  always_known = true,
  })
---- Boulders ----
--grind a mortar_and_pestle
crafting.register_recipe({
  type   = "grinding_stone",
  output = "tech:mortar_pestle_basalt",
  items  = {'nodes_nature:basalt_boulder', "group:basalt_cobble", 'nodes_nature:sand'},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({
  type   = "grinding_stone",
  output = "tech:mortar_pestle_granite",
  items  = {'nodes_nature:granite_boulder', "group:granite_cobble", 'nodes_nature:sand'},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({
  type   = "grinding_stone",
  output = "tech:mortar_pestle_limestone",
  items  = {'nodes_nature:limestone_boulder', "group:limestone_cobble", 'nodes_nature:sand'},
  level  = 1,
  always_known = true,
  })
----Wood--
crafting.register_recipe({ --chopping_block
  type   = "crafting_spot",
  output = "tech:chopping_block",
  items  = {'group:log'},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({ --brick_makers_bench
  type   = "crafting_spot",
  output = "tech:brick_makers_bench",
  items  = {'tech:stick 24'},
  level  = 1,
  always_known = true,
  })
---- Iron ----
crafting.register_recipe({ --hammer ingots into anvil
  type   = "hammering_block",
  output = "tech:anvil",
  items  = {'tech:iron_ingot 4'},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({
  type   = "anvil",
  output = "tech:anvil",
  items  = {'tech:iron_ingot 4'},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({ --carpentary from logs for bench and iron for tools
  type   = "chopping_block",
  output = "tech:carpentry_bench",
  items  = {'tech:iron_ingot 4', 'nodes_nature:maraka_log 2'},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({
  type   = "carpentry_bench",
  output = "tech:carpentry_bench",
  items  = {'tech:iron_ingot 4', 'nodes_nature:maraka_log 2'},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({ --masonry_bench from logs for bench and iron for tools
  type   = "carpentry_bench",
  output = "tech:masonry_bench",
  items  = {'tech:iron_ingot 4', 'nodes_nature:maraka_log 2'},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({ --spinning wheel. wood,
  type   = "carpentry_bench",
  output = "tech:spinning_wheel",
  items  = {'nodes_nature:maraka_log 2'},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({ --loom. wood, fibre for mechanisms
  type   = "carpentry_bench",
  output = "tech:loom",
  items  = {'nodes_nature:maraka_log 2', 'tech:coarse_fibre 12'},
  level  = 1,
  always_known = true,
  })
crafting.register_recipe({ -- Glass furnace from bricks for the main structure and iron for the tools
  type   = "mortar_bucket",
  output = "tech:glass_furnace",
  items  = {'tech:iron_ingot', 'tech:loose_brick 3', 'tech:lime_mortar'},
  level  = 1,
  always_known = true,
})

crafting.register_recipe({ ----craft clay shaping spot for free
  type   = "inv",
  output = "tech:clay_shaping_spot",
  items  = {},
  level  = 1,
  always_known = true,
  })

--grinding_stone from craft spot
crafting.register_recipe({
  type   = "crafting_spot",
  output = "tech:grinding_stone_granite",
  items  = {'group:granite_cobble 4', 'nodes_nature:sand 8'},
  level  = 1,
  always_known = true,
})
crafting.register_recipe({
  type   = "crafting_spot",
  output = "tech:grinding_stone_limestone",
  items  = {'group:limestone_cobble 4', 'nodes_nature:sand 8'},
  level  = 1,
  always_known = true,
})
crafting.register_recipe({ --weaving_frame
  type   = "crafting_spot",
  output = "tech:weaving_frame",
  items  = {'tech:stick 12', 'group:fibrous_plant 8'},
  level  = 1,
  always_known = true,
})
crafting.register_recipe({ --hammering block
  type   = "chopping_block",
  output = "tech:hammering_block",
  items  = {'group:log', 'inferno:fire_sticks', 'group:basalt_cobble', 'group:fibrous_plant 2'},
  level  = 1,
  always_known = true,
})
