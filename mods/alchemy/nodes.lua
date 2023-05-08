-- creates the ceramic alembic node

minetest.register_node("alchemy:alembic", {
	description = "Ceramic alembic",
	drawtype = "nodebox",
	tiles = {
		"alchemy_alembic_empty.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
		    -- bottom pot
		    {-0.25, -0.125, -0.25, 0.25, 0, 0.25}, 
		    {-0.375, -0.25, -0.375, 0.375, -0.125, 0.375}, 
		    {-0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125},
		    {-0.25, -0.5, -0.25, 0.25, -0.375, 0.25}, -- base
			-- Top pot
			{-0.375, 0, -0.375, 0.375, 0.125, 0.375},
			{-0.3125, 0.125, -0.3125, 0.3125, 0.25, 0.3125},
			{-0.1875, 0.25, -0.1875, 0.1875, 0.325, 0.1875}, 
		},
	},
	liquids_pointable = true,
	groups = {cracky=3, oddly_breakable_by_hand=3},
	paramtype = "light",
	paramtype2 = "facedir",
	sounds = nodes_nature.node_sound_stone_defaults(),
	groups = {cracky=3, oddly_breakable_by_hand=3},

	on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("status", "")
        local inv = meta:get_inventory()
        inv:set_size('main', 1)
        minimal.infotext_set(pos,meta,
     	"Note: put over a clay pot with salt water and apply heat to dasanilizate it")
        local timer = minetest.get_node_timer(pos)
        timer:start(10)
    end,

    on_timer = alembic_process,

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        local player_inv = clicker:get_inventory()

        -- loop through each slot in the alembic inventory
        for i = 1, inv:get_size("main") do
            local stack = inv:get_stack("main", i)
            if not stack:is_empty() then
                -- add the item stack to the player inventory
                local leftover = player_inv:add_item("main", stack)
                -- if there are leftover items, put them back in the alembic inventory
                if not leftover:is_empty() then
                    inv:set_stack("main", i, leftover)
                else
                    inv:set_stack("main", i, ItemStack(""))
                end
            end
        end
        --update the infotext
        update_alembic_infotext(pos)
    end,

    on_destruct = function(pos)
    	-- drops its contents when broken
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        if inv then
            local items = inv:get_list("main")
            for _, item in ipairs(items) do
                if not item:is_empty() then
                    minetest.add_item(pos, item)
                end
            end
        end
    end,

})
