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
        local inv = meta:get_inventory()
        inv:set_size('main', alembic_inv_size)
        meta:set_string("formspec", get_alembic_formspec(pos))
		
		minimal.infotext_set(pos,meta,"Note: To distill products, place the alembic over a clay pot and apply heat.")
        
        local timer = minetest.get_node_timer(pos)
        timer:start(alembic_check_interval)
    end,

    on_timer = alembic_process,

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
    	local player_name = clicker:get_player_name()
        minetest.show_formspec(player_name, "composter:alembic", get_alembic_formspec(pos))
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

    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        return 0
    end,

    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        return 0
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
