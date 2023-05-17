local clay_amphora_nodebox = {
        {-0.0625, 0.1875, -0.25, 0, 0.25, -0.0625},
    {-0.0625, 0.125, -0.0625, 0.0625, 0.4375, 0.0625},
    {-0.1875, 0.0625, -0.1875, 0.1875, 0.125, 0.1875},
    {-0.25, 0, -0.25, 0.25, 0.0625, 0.25},
    {-0.25, -0.3125, -0.25, 0.25, 0, 0.25},
    {-0.1875, -0.375, -0.1875, 0.1875, -0.3125, 0.1875},
    {-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875},
    {-0.125, -0.4375, -0.125, 0.125, -0.375, 0.125},
    {-0.125, 0.125, -0.125, 0.125, 0.1875, 0.125},
    {-0.125, 0.375, -0.125, 0.125, 0.4375, 0.125},
    {-0.0625, -0.0625, -0.3125, 0, 0.25, -0.25},
    {0, -0.0625, 0.25, 0.0625, 0.25, 0.3125},
    {0, 0.1875, 0.0625, 0.0625, 0.25, 0.25},
    }


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
    fixed = clay_amphora_nodebox
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

-----------------
--Tang, alcoholic drink

--Pot of Tang
minetest.register_node("tech:tang", {
  description = S("Tang"),
  tiles = {
    "tech_pot_tang.png",
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
    fixed = clay_amphora_nodebox
  },
  groups = {dig_immediate=3, pottery = 1, temp_pass = 1},
  sounds = nodes_nature.node_sound_stone_defaults(),
  on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
    --lets skull an entire vat of booze, what could possibly go wrong...
    local meta = clicker:get_meta()
    local thirst = meta:get_int("thirst")
    local hunger = meta:get_int("hunger")
    local energy = meta:get_int("energy")
    --only drink if thirsty
    if thirst < 100 then

      --you're skulling a whole bucket
      thirst = thirst + 100
      if thirst > 100 then
        thirst = 100
      end

      --all energy and half food equivalent of the fruit
      --gets given as energy
      energy = energy + 180
      if energy > 1000 then
        energy = 1000
      end

      hunger = hunger + 60
      if hunger > 1000 then
        hunger = 1000
      end

      --drunkness
      if random() < 0.75 then
        HEALTH.add_new_effect(clicker, {"Drunk", 1})
      end


      meta:set_int("thirst", thirst)
      meta:set_int("energy", energy)
      minetest.swap_node(pos, {name = "tech:clay_water_pot"})
      minetest.sound_play("nodes_nature_slurp", {pos = pos, max_hear_distance = 3, gain = 0.25})
    end
  end

})
