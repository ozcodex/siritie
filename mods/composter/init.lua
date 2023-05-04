-- composter/init.lua

-- Minetest mod: composter
-- See README.txt for licensing and other information.

dofile(minetest.get_modpath("zero_loader").."/init.lua")
zero_load('composter',{"common", "nodes", "crafts"})

-- items that can be composted
compostable_groups = {
    'herbaceous_plant',
    'woody_plant',
    'fibrous_plant',
    'mushroom',
    'tree',
    'log',
    'cane_plant',
    'seed',
    'seedling',
    'flora',
    'bioluminescent',
}

-- seconds before the next composting validation
seconds_to_compost = 5

-- probabilities of composting each time a validation is made
loam_chance = 20
fertilizer_chance = 10

-- composter block

function get_composter_formspec(compost)
    local formspec = "size[8,4.8]"..
        "label[0,0;Composter: "..compost.."%]"..
        "list[current_name;main;0,0.5;3,2]"..
        "list[current_name;output;5,0.5;3,2]"..
        "list[current_player;main;0,3;8,4;]"..
        "listring[current_name;main]"..
        "listring[current_name;output]"..
        "listring[current_player;main]"..
        "image[3.5,1;1,1;composter_arrow.png;]"
    return formspec
end



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
            {-0.5, -0.5, -0.5, -0.4375, 0.5, -0.4375},
            {0.4375, -0.5, -0.5, 0.5, 0.5, -0.4375},
            {-0.5, -0.5, 0.4375, -0.4375, 0.5, 0.5},
            {0.4375, -0.5, 0.4375, 0.5, 0.5, 0.5},
            {-0.5, -0.5, -0.4375, 0.5, 0.5, -0.375},
            {-0.5, -0.5, 0.375, 0.5, 0.5, 0.4375},
            {-0.4375, -0.5, -0.5, -0.375, 0.5, 0.5},
            {0.375, -0.5, -0.5, 0.4375, 0.5, 0.5},
            {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
        }
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



        -- check if items are compostable
        -- if so, add them to the compost and remove them from the inventory
        for _, item in ipairs(main_inv) do
            if item and item:get_count() > 0 then
                local name = item:get_name()
                minetest.chat_send_player("singleplayer", "checando item:"..name)
                local def = minetest.registered_items[name]
                local compostable = false
                for _, group in ipairs(compostable_groups) do
                    if def.groups[group] then
                        compostable = true
                        break
                    end
                end
                if compostable then
                    minetest.chat_send_player("singleplayer", "item is compostable")
                    -- get stack size
                    local stack_size = item:get_count()
                    -- remove item from main inventory
                    inv:remove_item("main", item)
                    -- update compost
                    compost = compost + stack_size
                    if compost > 100 then
                        compost = 100
                    end
                    meta:set_int("compost", compost)
                    meta:set_string("infotext", "Composter ("..compost.."% full)")
                    meta:set_string("formspec", get_composter_formspec(compost))
                end
            end
        end
    end

})
