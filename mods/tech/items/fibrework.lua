----------------------------------------------------------
--Two types of fabric:
--coarse: cheaper. used for ropes, bags etc
--fine: more raw material (because would be discarding a lot), used for clothes, beds etc

--processed and spun
--coarse fibre
minetest.register_craftitem("tech:coarse_fibre", {
	description = S("Coarse Fibre"),
	inventory_image = "tech_coarse_fibre.png",
	stack_max = minimal.stack_max_medium *4,
	groups = {flammable = 1, fibrous_plant = 1},
})

--fine fibre
minetest.register_craftitem("tech:fine_fibre", {
	description = S("Fine Fibre"),
	inventory_image = "tech_fine_fibre.png",
	stack_max = minimal.stack_max_medium *4,
	groups = {flammable = 1, fibrous_plant = 1},
})


--woven
--coarse fabric
minetest.register_craftitem("tech:coarse_fabric", {
	description = S("Coarse Fabric"),
	inventory_image = "tech_coarse_fabric.png",
	stack_max = minimal.stack_max_medium,
	groups = {flammable = 1},
})

--fine fabric
minetest.register_craftitem("tech:fine_fabric", {
	description = S("Fine Fabric"),
	inventory_image = "tech_fine_fabric.png",
	stack_max = minimal.stack_max_medium,
	groups = {flammable = 1},
})


