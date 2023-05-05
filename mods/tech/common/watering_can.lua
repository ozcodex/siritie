--clay watering can with fresh water
liquid_store.register_stored_liquid(
	"nodes_nature:freshwater_source",
	"tech:clay_watering_can_freshwater",
	"tech:clay_watering_can",
	{
		"tech_watering_can_water.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png"
	},
	{
		type = "fixed",
		fixed = {
			-- lid
			{-0.2, 0.2,-0.2, 0.2, 0.3, 0.2},
			-- handle
            {-0.05, 0.05, -0.25, 0.05, 0.15, -0.45}, -- upper
            {-0.05, -0.1, -0.35, 0.05, 0.05, -0.45}, -- mid
            {-0.05, -0.2, -0.25, 0.05, -0.1, -0.45}, -- low
            -- spout
            {-0.1, 0.1, 0.25, 0.1, 0.2, 0.5}, -- upper
            {-0.1, -0.4, 0.25, 0.1, 0.1, 0.4},
            -- body
            {-0.25, -0.4, -0.25, 0.25, 0.2, 0.25},
            -- base
            {-0.3, -0.5,-0.4, 0.3, -0.35, 0.4},
		}
	},
	S("Clay Watering Can with Freshwater"),
	{dig_immediate = 2})
--clay watering can with salt water
liquid_store.register_stored_liquid(
	"nodes_nature:salt_water_source",
	"tech:clay_watering_can_salt_water",
	"tech:clay_watering_can",
	{
		"tech_watering_can_water.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png",
		"tech_pottery.png"
	},
	{
		type = "fixed",
		fixed = {
			-- lid
			{-0.2, 0.2,-0.2, 0.2, 0.3, 0.2},
			-- handle
            {-0.05, 0.05, -0.25, 0.05, 0.15, -0.45}, -- upper
            {-0.05, -0.1, -0.35, 0.05, 0.05, -0.45}, -- mid
            {-0.05, -0.2, -0.25, 0.05, -0.1, -0.45}, -- low
            -- spout
            {-0.1, 0.1, 0.25, 0.1, 0.2, 0.5}, -- upper
            {-0.1, -0.4, 0.25, 0.1, 0.1, 0.4},
            -- body
            {-0.25, -0.4, -0.25, 0.25, 0.2, 0.25},
            -- base
            {-0.3, -0.5,-0.4, 0.3, -0.35, 0.4},
		}
	},
	S("Clay Watering Can with Salt Water"),
	{dig_immediate = 2})


--make Watering can able to water a block on click
minetest.override_item("tech:clay_watering_can_freshwater", {
	on_use = function(itemstack, user, pointed_thing)
		-- if pointed thing is a soil block, water it
		if pointed_thing.type == "node" then
			local pos = pointed_thing.under
			local node = minetest.get_node(pos)
			if minetest.get_item_group(node.name, "sediment") > 0 then
				-- check if block exists
				if minetest.registered_nodes[node.name.."_wet"] then
					-- replace with watered version
					-- keeping the node orientation
					minetest.set_node(pos, {name = node.name.."_wet", param2 = node.param2})
					-- and empty the bucket
					-- remove clay watering can and return empty one
					itemstack:take_item()
					return ItemStack("tech:clay_watering_can")
				else
					-- continue as normal
					return liquid_store.on_use_filled_bucket("nodes_nature:freshwater_source","tech:clay_watering_can",itemstack, user, pointed_thing)
				end
			end
		end
		-- continue as normal
		return liquid_store.on_use_filled_bucket("nodes_nature:freshwater_source","tech:clay_watering_can",itemstack, user, pointed_thing)
	end
})

