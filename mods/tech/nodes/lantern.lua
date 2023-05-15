
-- Lantern case
minetest.register_node("tech:lantern_case", {
	description = S("Lantern Case"),
	tiles = {
            {name = "tech_lantern_case.png"},
	},
	drawtype = "mesh",
        mesh = "lantern.obj",
	stack_max = minimal.stack_max_medium,
	sunlight_propagates = true,
	--use_texture_alpha = c_alpha.clip,
	paramtype = "light",
	paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, 7/16, 3/16},
        },
        collision_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, 7/16, 3/16},
        },
	groups = {dig_immediate=3, temp_pass = 1, falling_node = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
        on_construct = function(pos)
            local meta = minetest.get_meta(pos)
            minimal.infotext_merge(pos, S("Status: needs a clear glass pane and a wick (coarse fibre)!"), meta)
        end,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            take_item_replace_node(pos, node, clicker, itemstack, pointed_thing, "tech:coarse_fibre", "tech:lantern_case_wick")
            take_item_replace_node(pos, node, clicker, itemstack, pointed_thing, "tech:pane_clear", "tech:lantern_case_glass")
        end,
})

-- Lantern case + wick
minetest.register_node("tech:lantern_case_wick", {
	description = S("Lantern Case with a wick"),
	tiles = {
            {name = "tech_lantern_case.png"},
	},
        overlay_tiles = {
            {name = "tech_lantern_wick.png"},
        },
	drawtype = "mesh",
        mesh = "lantern.obj",
	stack_max = minimal.stack_max_medium,
	sunlight_propagates = true,
	--use_texture_alpha = c_alpha.blend,
	paramtype = "light",
	paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, 7/16, 3/16},
        },
        collision_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, 7/16, 3/16},
        },
	groups = {dig_immediate=3, temp_pass = 1, falling_node = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
        on_construct = function(pos)
            local meta = minetest.get_meta(pos)
            minimal.infotext_merge(pos, S("Status: needs a clear glass pane!"), meta)
        end,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            take_item_replace_node(pos, node, clicker, itemstack, pointed_thing, "tech:pane_clear", "tech:lantern_unlit")
        end,
})

-- Lantern case + glass
minetest.register_node("tech:lantern_case_glass", {
	description = S("Lantern Case with Glass"),
	tiles = {
            {name = "tech_lantern_case_glass.png"},
	},
	drawtype = "mesh",
        mesh = "lantern.obj",
	stack_max = minimal.stack_max_medium,
	sunlight_propagates = true,
	use_texture_alpha = c_alpha.blend,
	paramtype = "light",
	paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, 7/16, 3/16},
        },
        collision_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, 7/16, 3/16},
        },
	groups = {dig_immediate=3, temp_pass = 1, falling_node = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
        on_construct = function(pos)
            local meta = minetest.get_meta(pos)
            minimal.infotext_merge(pos, S("Status: needs a wick (coarse fibre)!"), meta)
        end,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            take_item_replace_node(pos, node, clicker, itemstack, pointed_thing, "tech:coarse_fibre", "tech:lantern_unlit")
        end,
})

-- Lantern case + glass + wick
minetest.register_node("tech:lantern_unlit", {
	description = S("Unlit Lantern"),
	tiles = {
            {name = "tech_lantern_case_glass.png"},
	},
        overlay_tiles = {
            {name = "tech_lantern_wick.png"},
        },
	drawtype = "mesh",
        mesh = "lantern.obj",
	stack_max = minimal.stack_max_medium,
	sunlight_propagates = true,
	use_texture_alpha = c_alpha.blend,
	paramtype = "light",
	paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, 7/16, 3/16},
        },
        collision_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, 7/16, 3/16},
        },
	groups = {dig_immediate=3, temp_pass = 1, falling_node = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
        on_construct = function(pos)
            -- lightsource.restore_from_inventory(pos, itemstack)
            lightsource.update_fuel_infotext(lantern_desc, pos)
        end,
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            lightsource.restore_from_inventory(lantern_desc, pos, itemstack)
            lightsource.update_fuel_infotext(lantern_desc, pos)
        end,
        on_dig = function(pos, node, digger)
            lightsource.save_to_inventory(lantern_desc, pos, digger, false)
        end,
        on_ignite = function(pos, user)
            lightsource.ignite(lantern_desc, pos)
        end,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            lightsource.refill(lantern_desc, pos, clicker, itemstack)
        end,
})

-- Lantern lit
minetest.register_node("tech:lantern_lit", {
	description = S("Lit Lantern"),
	tiles = {
            {name = "tech_lantern_case_glass.png"},
	},
        overlay_tiles = {
            {
                name = "tech_lantern_animation.png",
                animation = {type = "vertical_frames", aspect_w = 48, aspect_h = 48, length = 2}
            },
        },
	drawtype = "mesh",
        mesh = "lantern.obj",
	stack_max = minimal.stack_max_medium,
	sunlight_propagates = true,
	light_source = 11,
	use_texture_alpha = c_alpha.blend, -- flame vanishes on MT 5.3.0
	paramtype = "light",
	paramtype2 = "facedir",
        selection_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, 7/16, 3/16},
        },
        collision_box = {
            type = "fixed",
            fixed = {-3/16, -8/16, -3/16, 3/16, 7/16, 3/16},
        },
	groups = {dig_immediate=3, temp_pass = 1, falling_node = 1},
	sounds = nodes_nature.node_sound_stone_defaults(),
        on_construct = function(pos)
            lightsource.start_burning(lantern_desc, pos)
	end,
        on_timer = function(pos, elapsed)
            return lightsource.burn_fuel(lantern_desc, pos)
	end,
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            lightsource.restore_from_inventory(lantern_desc, pos, itemstack)
        end,
        on_dig = function(pos, node, digger)
            lightsource.save_to_inventory(lantern_desc, pos, digger, true)
        end,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            lightsource.extinguish(lantern_desc, pos)
        end,
})
