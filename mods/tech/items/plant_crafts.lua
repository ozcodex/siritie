--vegetable oil
minetest.register_craftitem("tech:vegetable_oil", {
	description = S("Vegetable Oil"),
	inventory_image = "tech_vegetable_oil.png",
	stack_max = minimal.stack_max_medium *2,
	groups = {flammable = 1},

  --yes... we are letting you drink cooking oil...
  --...although it is worse than just eating the seeds
  on_use = function(itemstack, user, pointed_thing)
    -- hp_change, thirst_change, hunger_change, energy_change, temp_change, replace_with_item
    return HEALTH.use_item(itemstack, user, 0, 0, 8, -32, 0)
  end,
})