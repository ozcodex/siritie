----------------------------------------
-- Lantern
-- a great light source for you and your entire family!
----------------------------------------


lantern_desc = lightsource_description.new(
    {lit_name = "tech:lantern_lit", unlit_name = "tech:lantern_unlit",
     fuel_name = "tech:vegetable_oil", max_fuel = 3000,
     burn_rate = 5, refill_ratio = 1/8, put_out_by_moisture = false})


-- to minimal?
-- right click on a node with an item to craft another node
function take_item_replace_node(pos, node, clicker, itemstack, pointed_thing, item_name, node_name)
    local stack_name = itemstack:get_name()
    local meta = minetest.get_meta(pos)
    if stack_name == item_name then
        local name = clicker:get_player_name()
        if not minetest.is_creative_enabled(name) then
            itemstack:take_item()
        end
        minetest.set_node(pos, {name = node_name})
        return itemstack
    end
end