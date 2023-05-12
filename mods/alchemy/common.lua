function get_alembic_formspec(pos)
    local below_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
    local below_node = minetest.get_node(below_pos)
    if alembic_processes[below_node.name] then
        process = minetest.registered_items[below_node.name].description
    else 
        process = "Nothing"
    end
    local formspec = "size[8,4.8]"..
        "label[0,0;Processing: "..process.."]"..
        "list[current_name;main;3,0.7;2,2]"..
        "list[current_player;main;0,3;8,4;]"..
        "listring[current_name;main]"..
        "listring[current_player;main]"
    return formspec
end

function alembic_process(pos, elapsed)
    -- get block under alembic
    local below_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
    local below_node = minetest.get_node(below_pos)

    -- get current temperature of the below block
    local temp = climate.get_point_temp(below_pos, below_node)

    -- only continue if the block below is a clay pot with a valid source
    local process = alembic_processes[below_node.name]
    if not process then
        update_alembic_infotext(pos)
        -- stop the execution and try again later
        return true
    end

    -- determine time based on temperature
    local time
    if temp > alembic_working_temperature then
        time = process.time
    else
        time = ambient_temperature_time
    end

    -- take meta and inventory
    local meta = minetest.get_meta(pos)
    local remaining = math.max(0, (meta:get_float("remaining") or time) - elapsed)
    local inv = meta:get_inventory()

    -- if time elapsed, replace below block
    if remaining <= 0 then
        for _, product in ipairs(process.products) do
            inv:add_item("main", product)
        end
        minetest.swap_node(below_pos, {name = process.subproduct})
        meta:set_float("remaining", time)
    else
        meta:set_float("remaining", remaining)
    end
    update_alembic_infotext(pos)
	-- keep the timer running
	return true
end

function update_alembic_infotext(pos)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local infotext = ""
    -- get block under alembic
    local below_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
    local below_node = minetest.get_node(below_pos)
    -- if below node is processable add info to infotext
    if alembic_processes[below_node.name] then
        infotext = "Processing: "..minetest.registered_items[below_node.name].description..". "
    else 
        -- if below node is not processable add default note to infotext
        infotext = "Note: To distill products, place the alembic over a clay pot filled with liquids and apply heat. "
    end
    -- add inventory info to the infotext
    infotext = infotext.."\nContents: "
    if inv:is_empty("main") then
        infotext = infotext.."empty"
    else
        --loop through each slot in the alembic inventory
        for i = 1, inv:get_size("main") do
            local stack = inv:get_stack("main", i)
            if not stack:is_empty() then
                infotext = infotext..stack:get_count().." "..minetest.registered_items[stack:get_name()].description..". "
            end
        end
    end
    minimal.infotext_set(pos,meta,infotext)
end


