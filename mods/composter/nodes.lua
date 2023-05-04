minetest.register_node("composter:composter_bin", {
    description = S("Composter Bin"),
    tiles = {"composter_bin_top.png",
    "composter_bin.png",
    "composter_bin.png",
    "composter_bin.png",
    "composter_bin.png"},
    drawtype = "nodebox",
    stack_max = 1,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},
    sounds = nodes_nature.node_sound_wood_defaults(),
    node_box = {
        type = "fixed",
        fixed = {
            -- Base
            {-0.35, -0.5, -0.35, 0.35, 0.3, 0.35},
            -- Placa inferior
            {-0.4, -0.5, -0.4, 0.4, -0.4, 0.4},
            -- Placa intermedia 1
            {-0.4, -0.3, -0.4, 0.4, -0.2, 0.4},
            -- Placa intermedia 2
            {-0.4, -0.1, -0.4, 0.4, 0, 0.4},
            -- Placa intermedia 3
            {-0.4, 0.1, -0.4, 0.4, 0.2, 0.4},
            -- Placa superior (hueca)
            {-0.4, 0.3, -0.4, -0.2, 0.4, 0.4},
            {0.2, 0.3, -0.4, 0.4, 0.4, 0.4},
            {-0.2, 0.3, -0.4, 0.2, 0.4, -0.2},
            {-0.2, 0.3, 0.2, 0.2, 0.4, 0.4},


        },
    },
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_int("compost", 0)
        meta:set_string("infotext", "Composter (0% full)")
         meta:set_string("formspec", get_composter_formspec(0))
        local inv = meta:get_inventory()
        inv:set_size('main', 6)
        inv:set_size('output', 6)
        local timer = minetest.get_node_timer(pos)
        timer:start(seconds_to_compost)
    end,

    on_rightclick = function(pos, node, player, itemstack, pointed_thing)
        local meta = minetest.get_meta(pos)
        local player_name = player:get_player_name()
        local compost = meta:get_int("compost")
        meta:set_string("infotext", "Composter ("..compost.."% full)")

        minetest.show_formspec(player_name, "composter:composter_bin", get_composter_formspec(compost))
    end,

    on_receive_fields = function(pos, formname, fields, sender)
        minetest.chat_send_player("singleplayer", "REcibido!!")
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory():get_list("main")
        local output_inv = meta:get_inventory():get_list("output")
    end,

    on_timer = function(pos, elapsed)
        local timer = minetest.get_node_timer(pos)
        timer:start(seconds_to_compost)

        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        local compost = meta:get_int("compost")
        local main_inv = inv:get_list("main")
        local output_inv = inv:get_list("output")

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

        -- check if items are compostable
        -- if so, add them to the compost and remove them from the inventory
        for _, item in ipairs(main_inv) do
            if item and item:get_count() > 0 then
                local name = item:get_name()
                minetest.chat_send_player("singleplayer", "checando item:"..name)
                local def = minetest.registered_items[name]
                local compostable = false
                if def.groups['compostable'] then
                    minetest.chat_send_player("singleplayer", "item is compostable")
                    -- get stack size
                    local stack_size = item:get_count()
                    if compost < 100 then
                        -- remove item from main inventory
                        inv:remove_item("main", ItemStack(name .. " 1"))
                        -- update compost
                        compost = compost + 1
                    end
                end
            end
        end
        meta:set_int("compost", compost)
        meta:set_string("infotext", "Composter ("..compost.."% full)")
        meta:set_string("formspec", get_composter_formspec(compost))
    end

})