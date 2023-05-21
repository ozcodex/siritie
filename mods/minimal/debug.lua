-- sanitize item recipe
-- removes the space (one or zero spaces) and the number at the end of a recipe item
local function sanitizeItem(item)
    return string.gsub(item, "[_%s]?%d?$", "")
end

-- remove the initial "group:" to get group name
local function sanitizeGroup(group)
    return string.gsub(sanitizeItem(group), "^group:", "")
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
    -- check if global is declared, if not load it
    if all_tools then
        return all_tools
    end
    all_tools = {}

    for item_name, item_def in pairs(minetest.registered_items) do
        if item_def.tool_capabilities then
            insertInto(all_tools, item_name)
        end
    end

    return all_tools
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
    local item_def = minetest.registered_items[node_name]
    local tools = {}

    -- if node def not found, return empty table
    if not item_def then
        return tools
    end

    -- Iterate over the registered tools
    for _, toolName in ipairs(getAllTools()) do
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

-- checks if item is in at least one of the previous tiers
local function isInPreviousTiers(tieredTable, item, tier)
    for i = 0, tier - 1 do
        if findInTable(tieredTable[i], item) then
            return true
        end
    end
    return false
end

-- checks if item is in at least one of the previous tiers
local function isMinableWithPreviousTiers(tieredTable, node, tier)
    for i = 0, tier - 1 do
        for _, tool in ipairs(getAllTools()) do
            if findInTable(tieredTable[i], tool) then
                if toolCanBreakNode(tool, node) then
                    -- if at least one tool can mine this node is minable
                    return true
                end
            end
        end
    end
    return false
end

local function buildTieredTable(tieredTable, craftingRecipes, tier)
    if not tieredTable[tier] then
        -- Initialize the table for the current tier
        tieredTable[tier] = {}
    end
    for _, craftingType in pairs(craftingRecipes) do
        -- loop through all recipes
        for _, recipe in ipairs(craftingType) do
            -- assume recipe is crafteable
            local isRecipeCrafteable = true
            -- loop over the items
            for _, item in ipairs(recipe.items) do
                local item = sanitizeItem(item)
                -- assume item is crafteable
                local isItemCrafteable = true
                -- check if item is group
                if isGroup(item) then
                    local group = sanitizeGroup(item)
                    local isGroupCrafteable = false
                    for _, node in ipairs(getGroupedNodes(group)) do
                        local node = sanitizeItem(node)
                        -- if at least one node is crafteable then the group is crafteable
                        if isInPreviousTiers(tieredTable, node, tier) then
                            isGroupCrafteable = true
                        end
                        -- check if item is minable with tools in previous tiers
                        if
                            isMinableWithPreviousTiers(tieredTable, node, tier)
                            and not isOutputNode(node, craftingRecipes)
                            and not isInPreviousTiers(tieredTable, node, tier)
                        then
                            -- add it to current tier
                            insertInto(tieredTable[tier], node)
                        end
                    end
                    -- if group is not crafteable then recipe is not crafteable
                    if not isGroupCrafteable then
                        print("no " .. group .. " nodes available")
                        isItemCrafteable = false
                    end
                else
                    -- is a normal item, check for they in previous tiers
                    if not isInPreviousTiers(tieredTable, item, tier) then
                        isItemCrafteable = false
                    end
                    -- check if item is minable, so it can be added to current tier
                    if
                        isMinableWithPreviousTiers(tieredTable, item, tier)
                        and not isOutputNode(item, craftingRecipes)
                        and not isInPreviousTiers(tieredTable, item, tier)
                    then
                        -- add it to current tier
                        insertInto(tieredTable[tier], item)
                    end
                end
                if not isItemCrafteable then
                    -- with at least one item in the recipe that is not obteinable
                    isRecipeCrafteable = false
                end
            end
            if isRecipeCrafteable then
                local item = sanitizeItem(recipe.output)
                -- if the recipe can be completed, add the output item to tier
                -- only add it if it doesn't exist in previous tiers
                if not isInPreviousTiers(tieredTable, item, tier) then
                    insertInto(tieredTable[tier], item)
                end
            end
        end
    end

    print("tier_" .. tier .. ":" .. #tieredTable[tier] .. " items")
    -- if tier is empty finish the recursion
    if #tieredTable[tier] == 0 or tier > 20 then
        return tieredTable
    else
        return buildTieredTable(tieredTable, craftingRecipes, tier + 1)
    end
end

local function createTieredTable(craftingRecipes)
    local tieredTable = {
        -- starting with tier 0
        [0] = {
            -- basic tool
            "player_api:hand_pale",
            -- nature items
            "nodes_nature:alaf",
            "nodes_nature:anperla",
            "nodes_nature:basalt_boulder",
            "nodes_nature:bronach",
            "nodes_nature:claystone_block",
            "nodes_nature:conglomerate_block",
            "nodes_nature:damo",
            "nodes_nature:galanta",
            "nodes_nature:gitiri",
            "nodes_nature:gneiss_boulder",
            "nodes_nature:granite_boulder",
            "nodes_nature:hakimi",
            "nodes_nature:ironstone_boulder",
            "nodes_nature:jade_boulder",
            "nodes_nature:lambakap",
            "nodes_nature:limestone_boulder",
            "nodes_nature:mahal",
            "nodes_nature:marbhan",
            "nodes_nature:merki",
            "nodes_nature:momo",
            "nodes_nature:moss",
            "nodes_nature:nebiyi",
            "nodes_nature:reshedaar",
            "nodes_nature:sand_wet",
            "nodes_nature:sandstone_block",
            "nodes_nature:sari",
            "nodes_nature:siltstone_block",
            "nodes_nature:tanai",
            "nodes_nature:tashvish",
            "nodes_nature:thoka",
            "nodes_nature:tikusati",
            "nodes_nature:vansano",
            "nodes_nature:wiha",
            "nodes_nature:zufani",
            "nodes_nature:silt_wet",
            "nodes_nature:gravel",
            "nodes_nature:volcanic_ash",
            "nodes_nature:sand",
            "nodes_nature:silt",
            "nodes_nature:loam",
            "nodes_nature:basalt_cobble",
            "nodes_nature:gneiss_cobble",
            "nodes_nature:jade_cobble",
            "nodes_nature:cana",
            "nodes_nature:chalin",
            "nodes_nature:gravel_wet",
            "nodes_nature:loam_wet",
            "nodes_nature:loam_wet_salty",
            "nodes_nature:volcanic_ash_wet",
            "nodes_nature:volcanic_ash_wet_salty",
            "nodes_nature:gravel_wet_salty",
            "nodes_nature:sand_wet_salty",
            "nodes_nature:silt_wet_salty",
            "nodes_nature:limestone_cobble",
            "nodes_nature:ironstone_cobble",
            "nodes_nature:granite_cobble",
            "nodes_nature:gemedi",
            "nodes_nature:tiken",
            "nodes_nature:kelp",
            "nodes_nature:clay",
            -- stairs
            "stairs:stair_clay",
            "stairs:stair_inner_clay",
            "stairs:stair_outer_clay",
            "stairs:slab_clay",
            -- tech
            "tech:clear_glass_ingot",
            "tech:green_glass_ingot",
            "tech:maraka_flour",
            "tech:potash",
            "tech:quicklime",
            "tech:retted_cana_bundle",
            "tech:roasted_iron_ore",
            "tech:roof_tile_loose",
            "tech:slaked_lime",
            -- free starting recipes
            "tech:sleeping_spot",
            "tech:crafting_spot",
            "tech:threshing_spot",
            "tech:clay_shaping_spot",
        },
    }
    --recursively add tiers
    return buildTieredTable(tieredTable, craftingRecipes, 1)
end

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

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
                recipes_file:write(node .. "\n")
            end
        end
        recipes_file:close()
        print("Crafting recipes exported to 'recipes.txt'")
    else
        print("Failed to export crafting recipes")
    end
end)
