-- creates the ceramic alembic node

local alambic_nodebox = {
    -- bottom pot
    {-0.25, -0.125, -0.25, 0.25, 0, 0.25}, 
    {-0.375, -0.25, -0.375, 0.375, -0.125, 0.375}, 
    {-0.3125, -0.375, -0.3125, 0.3125, -0.25, 0.3125},
    {-0.25, -0.5, -0.25, 0.25, -0.375, 0.25},
	-- Top pot
	{-0.375, 0, -0.375, 0.375, 0.125, 0.375},
	{-0.3125, 0.125, -0.3125, 0.3125, 0.25, 0.3125},
	{-0.1875, 0.25, -0.1875, 0.1875, 0.325, 0.1875}, 
	{-0.0625, 0.325, -0.0625, 0.0625, 0.4, 0.0625},
	-- Tube
	{-0.05, 0.4, -0.475, 0.05, 0.475, 0.025},
	{-0.05, -0.2, -0.475, 0.05, 0.4, -0.4},
	{-0.05, -0.2, -0.475, 0.05, -0.1, 0},
}

minetest.register_node("alchemy:alembic", {
	description = "Ceramic Alembic",
	drawtype = "nodebox",
	tiles = {"tech_pottery.png"},
	node_box = {
		type = "fixed",
		fixed = alambic_nodebox,
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
        inv:set_size('main', alembic_inv_size)
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

--unfired
minetest.register_node("alchemy:alembic_unfired", {
	description = S("Ceramic Alembic (unfired)"),
	tiles = {
		"nodes_nature_clay.png"
	},
	drawtype = "nodebox",
	stack_max = minimal.stack_max_bulky,
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = alambic_nodebox,
	},
	groups = {dig_immediate=3, temp_pass = 1, heatable = 20},
	sounds = nodes_nature.node_sound_stone_defaults(),
	on_construct = function(pos)
		--length(i.e. difficulty of firing), interval for checks (speed)
		ncrafting.set_firing(pos, base_firing, firing_int)
	end,
	on_timer = function(pos, elapsed)
		--finished product, length
		return ncrafting.fire_pottery(pos, "alchemy:alembic_unfired", "alchemy:alembic", base_firing)
	end,
})
