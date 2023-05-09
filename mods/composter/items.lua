minetest.register_craftitem("composter:humus", {
    description = S("Humus"),
    inventory_image = "composter_humus.png",
    stack_max = minimal.stack_max_medium/2,
    groups = { fertilizer = 1 },
    tool_capabilities = {
        groupcaps = {
            agricultural_soil = {},
        },
    },
})

minetest.register_craftitem("composter:vermicompost", {
    description = S("Vermicompost"),
    inventory_image = "composter_vermicompost.png",
    stack_max = minimal.stack_max_medium/2,
    groups = { fertilizer = 1 },
    tool_capabilities = {
        groupcaps = {
            agricultural_soil = {},
        },
    },
})

minetest.register_craftitem("composter:bonemeal", {
    description = S("Bonemeal"),
    inventory_image = "composter_bonemeal.png",
    stack_max = minimal.stack_max_medium/2,
    groups = { fertilizer = 1 },
    tool_capabilities = {
        groupcaps = {
            agricultural_soil = {},
        },
    },
})