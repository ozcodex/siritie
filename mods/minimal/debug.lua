-- sanitize item recipe
-- removes the space and the number at the end of a recipe item
local function sanitizeItem(item)
    return string.gsub(item, " %d+$", "")
end

local function areTableEqual(table1, table2)
    -- Check if the tables have the same number of elements
    if #table1 ~= #table2 then
        return false
    end

    -- Iterate over the key-value pairs in table1
    for key, value in pairs(table1) do
        -- Check if the corresponding key exists in table2
        if table2[key] == nil then
            return false
        end

        -- Check if the values are equal
        -- if the value is a table use areTableEqual to compare
        if type(value) == "table" then
            if not areTableEqual(value, table2[key]) then
                return false
            end
        end
        if value ~= table2[key] then
            return false
        end
    end

    -- Tables are equal
    return true
end

-- function that inserts a value into a table if it is not already in it
local function insertInto(table, value)
    -- if value is a table use areTableEqual to compare
    if type(value) == "table" then
        for _, v in ipairs(table) do
            if areTableEqual(v, value) then
                return
            end
        end
    else
        for _, v in ipairs(table) do
            if v == value then
                return
            end
        end
    end

    table[#table + 1] = value
end

-- Merge tables
local function mergeTables(table1, table2)
    local mergedTable = {}
    for _, value in ipairs(table1) do
        insertInto(mergedTable, value)
    end
    for _, value in ipairs(table2) do
        insertInto(mergedTable, value)
    end
    return mergedTable
end

-- Helper function to check if a node is the output of any recipe
local function isOutputNode(node, craftingData)
    for _, craftingType in pairs(craftingData) do
        for _, recipe in ipairs(craftingType) do
            if sanitizeItem(recipe.output) == sanitizeItem(node) then
                return true
            end
        end
    end
    return false
end

-- Helper function that checks if all nodes in a table are in a given table
-- using sanitizeItem before comparing names
local function allNodesInTable(nodes, nodes_table)
    for _, node in ipairs(nodes) do
        local found = false
        for _, table_node in ipairs(nodes_table) do
            if sanitizeItem(node) == sanitizeItem(table_node.output) then
                found = true
                break
            end
        end
        if not found then
            return false
        end
    end
    return true
end

-- Helper function that checks if is a group (starts by "group:")
local function isGroup(item)
    return string.match(item, "^group:")
end

-- get the tools required for a node
local function getAllTools()
    local tools = {}

    for item_name, item_def in pairs(minetest.registered_items) do
        if item_def.tool_capabilities then
            insertInto(tools, item_name)
        end
    end

    return tools
end

-- Helper function that tells if a tool can break a given node
local function toolCanBreakNode(tool_name, node_name)
    local item_def = minetest.registered_items[node_name]
    local toolGroups = minetest.registered_items[tool_name].tool_capabilities.groupcaps

    -- if node def not found, return false
    if not item_def then
        return false
    end

    -- Iterate over the groups
    for group, group_level in pairs(item_def.groups) do
        if toolGroups and toolGroups[group] ~= nil then
            -- check if the level of the tool is the adequate
            if toolGroups[group] and toolGroups[group]["times"] and toolGroups[group]["times"][group_level] ~= nil then
                return true
            end
        end
    end

    return false
end

-- get the tools required for a node
local function getToolsForNode(node_name)
    -- check if global is declared, if not load it
    if not all_tools then
        all_tools = getAllTools()
    end

    local item_def = minetest.registered_items[node_name]
    local tools = {}

    -- if node def not found, return empty table
    if not item_def then
        return tools
    end

    -- Iterate over the registered tools
    for _, toolName in ipairs(all_tools) do
        -- check if tool can break the node
        if toolCanBreakNode(toolName, node_name) then
            insertInto(tools, toolName)
        end
    end
    return tools
end

-- find in a table
local function findInTable(table, value)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

-- return all the nodes of a given group
local function getGroupedNodes(group)
    local nodes
    -- iterate over all items
    for item_name, item_def in pairs(minetest.registered_items) do
        -- if the item is a group and the group is the one we are looking for
        if item_def.groups and item_def.groups[group] then
            if not nodes then
                nodes = {}
            end
            insertInto(nodes, item_name)
        end
    end
    return nodes
end
--------------------------------------------------------------------------------

local function processTier0Item(tool, item, tieredTable, tier)
    -- special case: is a group
    if isGroup(item) then
        -- remove the "group:" at the beginning of the name
        local group = (string.sub(sanitizeItem(item), 7))

        -- get all the nodes in the group
        local group_nodes = getGroupedNodes(group)

        -- for each node, check if it is breakable by hand
        for node_name, _ in pairs(group_nodes) do
            -- only add nodes breakable by hand
            local tools = getToolsForNode(node_name)
            if findInTable(tools, tool) then
                insertInto(tieredTable["tier_" .. tier], {
                    output = sanitizeItem(node_name),
                    items = { "player_api:hand" },
                    type = "gathering",
                })
            end
        end
    else
        -- only add nodes breakable by the given tool
        local tools = getToolsForNode(item)
        if findInTable(tools, tool) then
            insertInto(tieredTable["tier_" .. tier], {
                output = sanitizeItem(item),
                items = { "player_api:hand" },
                type = "gathering",
            })
        end
    end
end

-- Recursive function to build the hierarchical table
local function buildTieredTable(tieredTable, craftingData, tier)
    -- build the previous tier nodes mergin all the previous tiers tables
    local previous_tier_nodes
    for i = 0, tier - 1 do
        if previous_tier_nodes then
            previous_tier_nodes = mergeTables(previous_tier_nodes, tieredTable["tier_" .. i])
        else
            previous_tier_nodes = tieredTable["tier_" .. i]
        end
    end
    -- for each crafting recipe in craftingData chack if all the items are in the previous tier nodes list
    -- if so, add the recipe output to the current tier, excluding the items that currently are in a previous tier
    for craftingType, craftingRecipes in pairs(craftingData) do
        for _, recipe in ipairs(craftingRecipes) do
            -- for each item in the recipe
            for _, item in ipairs(recipe.items) do
                -- Check if item is not the output of any recipe (like tier 0)
                if not isOutputNode(item, craftingData) then
                    -- only add nodes breakable by tools defined on previous tiers
                    -- loop over all the tools and check if they are defined in the previous tier nodes list
                    for _, tool in ipairs(all_tools) do
                        if findInTable(previous_tier_nodes, tool) then
                            processTier0Item(tool, item, tieredTable, 0)
                        end
                    end
                end
            end

            -- check if the recipe output is not already in the previous tier nodes list
            if not allNodesInTable({ recipe.output }, previous_tier_nodes) then
                -- check if all the items of the recipe are in the previous tier nodes list
                if allNodesInTable(recipe.items, previous_tier_nodes) then
                    if not tieredTable["tier_" .. tier] then
                        tieredTable["tier_" .. tier] = {} -- Initialize the table for the current tier
                    end
                    insertInto(tieredTable["tier_" .. tier], {
                        output = sanitizeItem(recipe.output),
                        items = recipe.items,
                        type = craftingType,
                    })
                end
                -- make it work for groups
                -- if all the items are not in the previous tier nodes list, check if they are groups
                -- then find if at least one of the items of the group is in the previous tier nodes list
                local crafteable = true
                for _, item in ipairs(recipe.items) do
                    -- Check if item is a group
                    if isGroup(item) then
                        -- remove the "group:" at the beginning of the name
                        local group = (string.sub(sanitizeItem(item), 7))

                        -- get all the nodes in the group
                        local group_nodes = getGroupedNodes(group)

                        -- for each node, check if it is in the previous tier nodes list
                        -- if none of the nodes in the group is in the previous tier nodes list, the recipe is not crafteable
                        -- but if at least one is in the list, the recipe is crafteable
                        local group_crafteable = false
                        for node_name, _ in pairs(group_nodes) do
                            if findInTable(previous_tier_nodes, node_name) then
                                group_crafteable = true
                            end
                        end
                        -- if the group is not crafteable, the recipe is not crafteable
                        if not group_crafteable then
                            crafteable = false
                        end
                    else
                        -- check if the item is in the previous tier nodes list
                        if not findInTable(previous_tier_nodes, item) then
                            crafteable = false
                        end
                    end
                end
                -- if the recipe is crafteable, add it to the current tier
                if crafteable then
                    if not tieredTable["tier_" .. tier] then
                        tieredTable["tier_" .. tier] = {} -- Initialize the table for the current tier
                    end
                    insertInto(tieredTable["tier_" .. tier], {
                        output = sanitizeItem(recipe.output),
                        items = recipe.items,
                        type = craftingType,
                    })
                end
            end
        end
    end
    -- if current tier went empty, stop the recursion
    -- else continue building the table for next tier
    if tieredTable["tier_" .. tier] and #tieredTable["tier_" .. tier] > 0 then
        return buildTieredTable(tieredTable, craftingData, tier + 1)
    else
        return tieredTable
    end
end

-- Main function to create the tiered table
local function createTieredTable(craftingData)
    local tieredTable = {
        tier_0 = {},
    }

    for craftingType, craftingRecipes in pairs(craftingData) do
        for _, recipe in ipairs(craftingRecipes) do
            for _, item in ipairs(recipe.items) do
                -- Check if item is not the output of any recipe (tier 0)
                if not isOutputNode(item, craftingData) then
                    -- only add nodes breakable by hand
                    local tool = "player_api:hand_pale"
                    processTier0Item(tool, item, tieredTable, 0)
                end
            end
        end
    end

    -- Build the hierarchical table starting from tier 0
    tieredTable = buildTieredTable(tieredTable, craftingData, 1)

    return tieredTable
end

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-- write to files after all has been loaded
minetest.after(0, function()
    --declare all tools as global
    all_tools = getAllTools()

    local items = minetest.registered_items
    local item_file = io.open(minetest.get_worldpath() .. "/items.txt", "w")
    local recipes_file = io.open(minetest.get_worldpath() .. "/recipes.txt", "w")
    if item_file then
        for name, def in pairs(items) do
            item_file:write(name .. "\n")
        end
        item_file:close()
        print("Items exported to 'items.txt'")
    else
        print("Failed to export items files")
    end
    if recipes_file then
        -- Create the tiered table
        local tieredTable = createTieredTable(crafting.recipes)
        for tier, nodes in pairs(tieredTable) do
            recipes_file:write("-----------------------------------------\n\n")
            recipes_file:write(tier .. ":\n\n")
            for _, node in ipairs(nodes) do
                local recipeItems = table.concat(node.items or { "nothing" }, ", ")
                recipes_file:write(
                    "\t" .. node.output .. " crafted through " .. node.type .. " using " .. recipeItems .. "\n"
                )
            end
        end
        recipes_file:close()
        print("Crafting recipes exported to 'recipes.txt'")
    else
        print("Failed to export crafting recipes")
    end
end)
