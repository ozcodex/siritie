minetest.register_craftitem("tech:soup", {
	description = S("Soup"),
	inventory_image = "tech_soup.png",
	stack_max = minimal.stack_max_medium,
	on_use = function(itemstack, user, pointed_thing)
	   return exile_eatdrink_playermade(itemstack, user, pointed_thing)
	end
})