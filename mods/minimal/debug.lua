-- sanitize item recipe
-- removes the space and the number at the end of a recipe item
local function sanitizeItem(item)
    return string.gsub(item, " %d+$", "")
end

-- Merge tables
local function mergeTables(table1, table2)
    local mergedTable = {}
    for _, value in ipairs(table1) do
        table.insert(mergedTable, value)
    end
    for _, value in ipairs(table2) do
        table.insert(mergedTable, value)
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
            -- check if the recipe output is not already in the previous tier nodes list
            if not allNodesInTable({ recipe.output }, previous_tier_nodes) then
                -- check if all the recipe items are in the previous tier nodes list
                if allNodesInTable(recipe.items, previous_tier_nodes) then
                    if not tieredTable["tier_" .. tier] then
                        tieredTable["tier_" .. tier] = {} -- Initialize the table for the current tier
                    end
                    table.insert(tieredTable["tier_" .. tier], {
                        output = recipe.output,
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
                    table.insert(tieredTable["tier_0"], {
                        output = item,
                        items = {},
                        type = "gathering",
                    })
                end
            end
        end
    end

    -- Build the hierarchical table starting from tier 0
    tieredTable = buildTieredTable(tieredTable, craftingData, 1)

    return tieredTable
end

-- get the tools required for a node
local function getToolsForNode(node_name)
    local tools = {}
    local drops = minetest.get_node_drops(node_name, "")
    for _, item_name in ipairs(drops) do
        local item_def = minetest.registered_items[item_name]
        if item_def and item_def.tool_capabilities then
            tools[item_name] = item_def.tool_capabilities
        end
    end
    return tools
end

-- write to files after all has been loaded
minetest.after(0, function()
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
