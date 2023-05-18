local seismoscope_nodebox = {
    { -0.3125, -0.5, -0.25, 0.25, -0.4375, 0.3125 }, -- base
    { -0.375, -0.4375, -0.3125, 0.3125, -0.375, 0.375 }, -- plate1
    { -0.4375, -0.4375, -0.25, 0.375, -0.375, 0.3125 }, -- plate2
    { -0.3125, -0.4375, -0.375, 0.25, -0.375, 0.4375 }, -- plate3
    { -0.375, -0.375, 0, -0.3125, -0.3125, 0.0625 }, -- west1
    { -0.3125, -0.375, 0.25, -0.25, -0.3125, 0.3125 }, -- northwest1
    { -0.0625, -0.375, 0.3125, 0, -0.3125, 0.375 }, -- north1
    { 0.1875, -0.375, 0.25, 0.25, -0.3125, 0.3125 }, -- northeast1
    { 0.25, -0.375, 0, 0.3125, -0.3125, 0.0625 }, -- east1
    { 0.1875, -0.375, -0.25, 0.25, -0.3125, -0.1875 }, -- southeast1
    { -0.0625, -0.375, -0.3125, 0, -0.3125, -0.25 }, -- south1
    { -0.3125, -0.375, -0.25, -0.25, -0.3125, -0.1875 }, -- southwest1
    { -0.125, -0.375, -0.0625, 0.0625, -0.3125, 0.125 }, -- vessel1
    { -0.1875, -0.3125, -0.125, 0.125, -0.1875, 0.1875 }, -- vessel2
    { -0.25, -0.1875, -0.1875, 0.1875, 0.125, 0.25 }, -- vessel3
    { -0.1875, 0.125, -0.125, 0.125, 0.1875, 0.1875 }, -- vessel4
    { -0.3125, 0, -0.0625, 0.25, 0.0625, 0.125 }, -- eastwest2
    { 0.125, -0.0625, 0.1875, 0.25, 0, 0.3125 }, -- northeast2
    { -0.125, 0, -0.25, 0.0625, 0.0625, 0.3125 }, -- northsouth2
    { -0.3125, -0.0625, 0.1875, -0.1875, 0, 0.3125 }, -- northwest2
    { -0.3125, -0.0625, -0.25, -0.1875, 0, -0.125 }, -- southwest2
    { 0.125, -0.0625, -0.25, 0.25, 0, -0.125 }, -- southeast2
}

minetest.register_node("tech:seismoscope", {
    description = S("Ceramic Pendular Seismoscope"),
    drawtype = "nodebox",
    tiles = { "tech_pottery.png" },
    node_box = {
        type = "fixed",
        fixed = seismoscope_nodebox,
    },
    groups = { cracky = 3, oddly_breakable_by_hand = 3 },
    paramtype = "light",
    paramtype2 = "facedir",
    sounds = nodes_nature.node_sound_stone_defaults(),
    groups = { cracky = 3, oddly_breakable_by_hand = 3 },

    on_construct = function(pos)
        -- initialize detection status
        local meta = minetest.get_meta(pos)
        meta:set_string("detection_status", "inactive")
        -- find the nearest volcano
        local near = find_nearest_volcano(pos)
        print(dump(near))
        if near then
            -- saves the volcano data
            meta:set_string("direction", get_cardinal_direction(pos, near.location))
            meta:set_string("state", near.state)
            meta:set_int("distance", near.distance)
            -- puts the seismoscope on wait of a earthquake
            meta:set_string("detection_status", "idle")
            -- only starts the timer if there are nearby volcanoes
            local timer = minetest.get_node_timer(pos)
            timer:start(math.ceil(math.random(seismoscope_min_time, seismoscope_max_time)))
        end
    end,

    on_timer = function(pos, elapsed)
        local meta = minetest.get_meta(pos)
        local state = meta:get_string("state")
        -- random event to control earthquake probability
        if math.random() < seismoscope_detection_chance[state] then
            -- if an earthquake is detected, change the status
            meta:set_string("detection_status", "active")
            -- stop the timer
            return false
        end
        -- if no earthquakes were detected, continue the timer
        return true
    end,

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- show a formpect with the result of the detection
        local meta = minetest.get_meta(pos)
        local status = meta:get_string("detection_status")
        local message
        if status == "active" then
            -- if an earth quake is detected inform
            local direction = meta:get_string("direction")
            local state = meta:get_string("state")
            local distance = meta:get_int("distance")
            local strength

            if distance < seismoscope_near_threshold then
                strength = S("strong")
            elseif distance > seismoscope_far_threshold then
                strength = S("weak")
            else
                strength = s("moderate")
            end
            message = S("The seismoscope detected a")
                .. " "
                .. strength
                .. " "
                .. S("earthquake in the")
                .. " "
                .. S(direction)
                .. " "
                .. "direction."
        else
            -- if not earth quake is detected
            message = S("The seismoscope has not detected any activity yet.")
        end
        minetest.show_formspec(
            clicker:get_player_name(),
            "tech:seismoscope",
            "size[8,4]" .. "label[0.5,1.5;" .. message .. "]" .. "button_exit[2,3;4,1;exit;OK]"
        )
    end,
})

minetest.register_node("tech:seismoscope_unfired", {
    description = S("Clay Seismoscope (unfired)"),
    tiles = {
        "nodes_nature_clay.png",
    },
    drawtype = "nodebox",
    stack_max = minimal.stack_max_bulky,
    paramtype = "light",
    node_box = {
        type = "fixed",
        fixed = seismoscope_nodebox,
    },
    groups = { dig_immediate = 3, temp_pass = 1, heatable = 20 },
    sounds = nodes_nature.node_sound_stone_defaults(),
    on_construct = function(pos)
        --length(i.e. difficulty of firing), interval for checks (speed)
        ncrafting.set_firing(pos, base_firing, firing_int)
    end,
    on_timer = function(pos, elapsed)
        --finished product, length
        return ncrafting.fire_pottery(pos, "tech:seismoscope_unfired", "tech:seismoscope", base_firing)
    end,
})
