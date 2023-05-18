local seismoscope_nodebox = {
    { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }, -- Base
    { -0.25, 0.5, -0.25, 0.25, 1.5, 0.25 }, -- Vertical Arm
    { -0.5, 1.5, -0.5, 0.5, 1.75, 0.5 }, -- Horizontal Arm
    { -0.25, 1.75, -0.25, 0.25, 2, 0.25 }, -- Pivot
    { -0.125, 2, -0.125, 0.125, 2.25, 0.125 }, -- Sensor
}

minetest.register_node("tech:seismoscope", {
    description = "Ceramic Pendular Seismoscope",
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
                strength = "strong"
            elseif distance > seismoscope_far_threshold then
                strength = "weak"
            else
                strength = "moderate"
            end
            message = "The seismoscope detected a " .. strength .. " earthquake in the " .. direction .. " direction."
        else
            -- if not earth quake is detected
            message = "The seismoscope has not detected any activity yet."
        end
        minetest.show_formspec(
            clicker:get_player_name(),
            "tech:seismoscope",
            "size[8,4]" .. "label[0.5,1.5;" .. message .. "]" .. "button_exit[2,3;4,1;exit;OK]"
        )
    end,
})
