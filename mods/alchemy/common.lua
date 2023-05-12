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

	-- keep the timer running
	return true
end
