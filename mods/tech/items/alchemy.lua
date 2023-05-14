minetest.register_craftitem("tech:salt", {
	description = S("Salt"),
	inventory_image = "tech_salt.png",
	stack_max = minimal.stack_max_medium,
})

minetest.register_craftitem("tech:alcohol", {
	description = S("Alcohol"),
	inventory_image = "tech_alcohol.png",
	stack_max = minimal.stack_max_medium,
})

minetest.register_craftitem("tech:mashed_wiha", {
	description = S("Mashed Wiha"),
	inventory_image = "tech_mashed_wiha.png",
	stack_max = minimal.stack_max_medium/2,
	groups = {compostable = 1},
})

minetest.register_craftitem("tech:sugar", {
	description = S("Sugar"),
	inventory_image = "tech_sugar.png",
	stack_max = minimal.stack_max_medium,
})

minetest.register_craftitem("tech:wiha_dregs", {
	description = S("Wiha Dregs"),
	inventory_image = "tech_wiha_dregs.png",
	stack_max = minimal.stack_max_medium/2,
	groups = {compostable = 1},
})