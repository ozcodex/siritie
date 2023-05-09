--Pot of new Tang, must be left to ferment
minetest.register_node("tech:tang_unfermented", {
  description = S("Tang (unfermented)"),
  tiles = {
    "tech_pot_tang_uf.png",
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
    fixed = {
      {-0.25, 0.375, -0.25, 0.25, 0.5, 0.25}, -- NodeBox1
      {-0.375, -0.25, -0.375, 0.375, 0.3125, 0.375}, -- NodeBox2
      {-0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125}, -- NodeBox3
      {-0.25, -0.5, -0.25, 0.25, -0.375, 0.25}, -- NodeBox4
      {-0.3125, 0.3125, -0.3125, 0.3125, 0.375, 0.3125}, -- NodeBox5
    }
  },
  groups = {dig_immediate=3, pottery = 1, temp_pass = 1},
  sounds = nodes_nature.node_sound_stone_defaults(),

  on_dig = function(pos, node, digger)
    on_dig_tang(pos, node, digger)
  end,

  on_construct = function(pos)
    --duration of ferment
    local meta = minetest.get_meta(pos)
    meta:set_int("ferment", math.random(300,360))
    --ferment
    minetest.get_node_timer(pos):start(5)
  end,

  after_place_node = function(pos, placer, itemstack, pointed_thing)
    after_place_tang(pos, placer, itemstack, pointed_thing)
  end,

  on_timer =function(pos, elapsed)
    local meta = minetest.get_meta(pos)
    local ferment = meta:get_int("ferment")
    if ferment < 1 then
      minetest.swap_node(pos, {name = "tech:tang"})
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
