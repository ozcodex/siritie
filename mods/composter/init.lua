-- composter/init.lua

-- Minetest mod: composter
-- See README.txt for licensing and other information.

dofile(minetest.get_modpath("zero_loader").."/init.lua")
zero_load('composter',{"common", "nodes", "crafts"})

-- seconds before the next composting validation
seconds_to_compost = 60

-- chance of converting a compostable item into compost
composting_chance = 50

-- items that can be generated by composting
generate_items = {
  {
    name = "nodes_nature:loam",
    chance = 10,
    cost = 1,
  },
  {
    name = "tech:wood_ash_block",
    chance = 20,
    cost = 2,
  },
}
