minetest.register_node("tech:pottery_wheel", {
    description = "Pottery Wheel",
    tiles = {
        "tech_pottery_wheel_top.png",
        "tech_pottery_wheel_bottom.png",
        "tech_pottery_wheel_side.png", --right
        "tech_pottery_wheel_left.png",
        "tech_pottery_wheel_side.png", -- front
        "tech_pottery_wheel_side.png" -- back
        },
    drawtype = "nodebox",
    paramtype = "light",
    node_box = {
        type = "fixed",
        fixed = {
            -- Base
            {-7/16, -8/16, -7/16, 7/16, -7/16, 7/16},
            {-6/16, -7/16, -6/16, 6/16, -6/16, 6/16},
            -- flywheel
            {-4/16, -6/16, -4/16, 4/16, -2/16, 4/16},
            -- axis
            {-1/16, -7/16, -1/16, 1/16, 2/16, 1/16},
            -- arm
            {-5/16, -7/16, -1/16, -4/16, 2/16, 1/16},
            {-5/16, 2/16, -1/16, -2/16, 3/16, 1/16},
            -- working platform
            {-2/16, 2/16, -2/16, 2/16, 3/16, 2/16},
            --inner arm
            {-5/16, -2/16, -1/16, -2/16, -1/16, 1/16},
            {-2/16, -2/16, -2/16, 2/16, -1/16, 2/16},

        },
    },
    stack_max     = minimal.stack_max_bulky,
    paramtype     = "light",
    paramtype2    = "facedir",
    groups        = {falling_node = 1, dig_immediate = 3, craftedby = 1},
    sounds        = nodes_nature.node_sound_stone_defaults(),
    on_rightclick = crafting.make_on_rightclick("pottery_wheel", 2, { x = 8, y = 3 }),
})