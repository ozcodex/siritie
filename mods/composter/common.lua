function get_composter_formspec(compost)
    local formspec = "size[8,4.8]"..
        "label[0,0;Composter: "..compost.."%]"..
        "list[current_name;main;0,0.5;2,2]"..
        "list[current_name;output;4,0.5;4,2]"..
        "list[current_player;main;0,3;8,4;]"..
        "listring[current_name;main]"..
        "listring[current_name;output]"..
        "listring[current_player;main]"..
        "image[2.5,1;1,1;composter_arrow.png;]"
    return formspec
end

function generate_compost(inv, compost)
    -- Check the chances of generating items
    for _, item in ipairs(generate_items) do
        if compost >= item.cost and math.random(1, 100) <= item.chance then
            if inv:room_for_item("output", item.name) then
                -- add the item to the output inventory
                inv:add_item("output", item.name)
                -- decrease compost level
                compost = compost - item.cost
            end
        end
    end
    return compost
end

function process_compostable_items(inv, compost)
    -- check if items are compostable
    -- if so, add them to the compost and remove them from the inventory
    for _, item in ipairs(inv:get_list("main")) do
        if item and item:get_count() > 0 then
            local name = item:get_name()
            local def = minetest.registered_items[name]
            if def and def.groups and def.groups.compostable then
                if compost < 100 then
                    inv:remove_item("main", ItemStack(name .. " 1"))
                    compost = compost + 1
                end
            end
        end
    end
    return compost
end
