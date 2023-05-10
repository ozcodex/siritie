local sundial_node_box = {
            {-0.375, -0.5, -0.375, 0.375, -0.4375, 0.375},  -- Base
            {-0.250, -0.4375, -0.250, 0.250, -0.375, 0.250},  -- Plate
            {0.0625, -0.4375, 0.0625, 0.125, -0.125, 0.125}, -- gnomon
        }

minetest.register_node("tech:sundial", {
    description = S("Ceramic Sundial"),
    drawtype = "nodebox",
    stack_max = minimal.stack_max_bulky,
    paramtype = "light",
    sunlight_propagates = true,
    tiles = {"tech_sundial_top.png","tech_pottery.png"},
    node_box = {
        type = "fixed",
        fixed = sundial_node_box
    },
    groups = {dig_immediate=3, pottery = 1, temp_pass = 1, falling_node = 1},
    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
      minetest.chat_send_player(player:get_player_name(), exiledatestring())
    end,

})

minetest.register_node("tech:sundial_unfired", {
    description = S("Clay Sundial (unfired)"),
    tiles = { "nodes_nature_clay.png" },
    drawtype = "nodebox",
    stack_max = minimal.stack_max_bulky,
    paramtype = "light",
    node_box = {
        type = "fixed",
        fixed = sundial_node_box
    },
    groups = {dig_immediate=3, temp_pass = 1, heatable = 20},
    sounds = nodes_nature.node_sound_stone_defaults(),
    on_construct = function(pos)
        --length(i.e. difficulty of firing), interval for checks (speed)
        ncrafting.set_firing(pos, base_firing, firing_int)
    end,
    on_timer = function(pos, elapsed)
        --finished product, length
        return ncrafting.fire_pottery(pos, "tech:sundial_unfired", "tech:sundial", base_firing)
    end,
})