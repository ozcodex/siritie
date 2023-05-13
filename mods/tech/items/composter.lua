minetest.register_craftitem("tech:humus", {
    description = S("Humus"),
    inventory_image = "tech_humus.png",
    stack_max = minimal.stack_max_medium/2,
    groups = { fertilizer = 1 },
    tool_capabilities = {
        groupcaps = {
            agricultural_soil = {},
            sediment = {}
        },
    },
})

minetest.register_craftitem("tech:vermicompost", {
    description = S("Vermicompost"),
    inventory_image = "tech_vermicompost.png",
    stack_max = minimal.stack_max_medium/2,
    groups = { fertilizer = 1 },
    tool_capabilities = {
        groupcaps = {
            agricultural_soil = {},
            sediment = {}
        },
    },
})

minetest.register_craftitem("tech:bonemeal", {
    description = S("Bonemeal"),
    inventory_image = "tech_bonemeal.png",
    stack_max = minimal.stack_max_medium/2,
    groups = { fertilizer = 1 },
    tool_capabilities = {
        groupcaps = {
            agricultural_soil = {},
            sediment = {}
        },
    },
})