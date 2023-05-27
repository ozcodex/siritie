--Iron Fittings
-- a catch all item to use in crafts
--e.g. bolts, nails, locks, screws, hinges
--metal content equivalent to enough hinges for one door
minetest.register_craftitem("tech:iron_fittings", {
	description = S("Iron Fittings"),
	inventory_image = "tech_iron_fittings.png",
	stack_max = minimal.stack_max_medium * 2,
})

minetest.register_craftitem("tech:iron_nugget", {
	description = S("Iron Nugget"),
	inventory_image = "tech_iron_nugget.png",
	stack_max = minimal.stack_max_medium * 2,
})
