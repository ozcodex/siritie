
----------------------------------------------------------------
--PRIMITIVE
--from crude woven fibres,

--Hat
player_api.register_cloth("tech:woven_hat", {
	description = S("Woven Hat"),
	inventory_image = "tech_inv_woven_hat.png",
	texture = "tech_uv_woven_hat.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 1, clothing_hat = 1,},
	customfields= {temp_min = 1, temp_max = 1}
})

--Cape
player_api.register_cloth("tech:woven_cape", {
	description = S("Woven Cape"),
	inventory_image = "tech_inv_woven_cape.png",
	texture = "tech_uv_woven_cape.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 5, cape = 1, clothing_cape=1},
	customfields= {temp_min = 2, temp_max = 1}
})

--Poncho
player_api.register_cloth("tech:woven_poncho", {
	description = S("Woven Poncho"),
	inventory_image = "tech_inv_woven_poncho.png",
	texture = "tech_uv_woven_poncho.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 2, clothing_shirt = 1,},
	customfields= {temp_min = 2, temp_max = 1}
})


--Leggings
player_api.register_cloth("tech:woven_leggings", {
	description = S("Woven Leggings"),
	inventory_image = "tech_inv_woven_leggings.png",
	texture = "tech_uv_woven_leggings.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 3, clothing_pants=1},
	customfields= {temp_min = 1, temp_max = 0}
})

--Blanket
player_api.register_cloth("tech:woven_blanket", {
	description = S("Woven Blanket"),
	inventory_image = "tech_woven_blanket.png",
	texture = "tech_woven_blanket.png",
	stack_max = minimal.stack_max_bulky,
	groups = {blanket=1, clothing_blanket=1, cloth=6},
	customfields = {temp_min = 3, temp_max = -2}
})

----------------------------------------------------------------
--FABRIC
--from loom woven fabric
--two types:
-- thick: better for winter, but needs more material, bad in summer
--light: better for summer

--Light Hat
player_api.register_cloth("tech:light_fabric_hat", {
	description = S("Light Fabric Hat"),
	inventory_image = "tech_inv_light_fabric_hat.png",
	texture = "tech_uv_light_fabric_hat.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 1, clothing_hat = 1,},
	customfields= {temp_min = 2, temp_max = 1}
})

--Thick Hat
player_api.register_cloth("tech:thick_fabric_hat", {
	description = S("Thick Fabric Hat"),
	inventory_image = "tech_inv_thick_fabric_hat.png",
	texture = "tech_uv_thick_fabric_hat.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 1, clothing_hat = 1,},
	customfields= {temp_min = 4, temp_max = -1}
})

--light Cape
player_api.register_cloth("tech:light_fabric_cape", {
	description = S("Light Fabric Cape"),
	inventory_image = "tech_inv_light_fabric_cape.png",
	texture = "tech_uv_light_fabric_cape.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 5, cape = 1, clothing_cape=1},
	customfields= {temp_min = 3, temp_max = 3}
})
--Thick Cape
player_api.register_cloth("tech:thick_fabric_cape", {
	description = S("Thick Fabric Cape"),
	inventory_image = "tech_inv_thick_fabric_cape.png",
	texture = "tech_uv_thick_fabric_cape.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 5, cape = 1, clothing_cape=1},
	customfields= {temp_min = 6, temp_max = -2}
})

--Light Trousers
player_api.register_cloth("tech:light_fabric_trousers", {
	description = S("Light Fabric Trousers"),
	inventory_image = "tech_inv_light_fabric_trousers.png",
	texture = "tech_uv_light_fabric_trousers.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 3, clothing_pants=1},
	customfields= {temp_min = 3, temp_max = 2}
})

--Thick Trousers
player_api.register_cloth("tech:thick_fabric_trousers", {
	description = S("Thick Fabric Trousers"),
	inventory_image = "tech_inv_thick_fabric_trousers.png",
	texture = "tech_uv_thick_fabric_trousers.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 3, clothing_pants=1},
	customfields= {temp_min = 6, temp_max = -2}
})

--Light Tunic
player_api.register_cloth("tech:light_fabric_tunic", {
	description = S("Light Fabric Tunic"),
	inventory_image = "tech_inv_light_fabric_tunic.png",
	texture = "tech_uv_light_fabric_tunic.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 2, clothing_shirt = 1,},
	customfields= {temp_min = 3, temp_max = 2}
})

--Thick Tunic
player_api.register_cloth("tech:thick_fabric_tunic", {
	description = S("Thick Fabric Tunic"),
	inventory_image = "tech_inv_thick_fabric_tunic.png",
	texture = "tech_uv_thick_fabric_tunic.png",
	stack_max = minimal.stack_max_bulky,
	groups = {cloth = 2, clothing_shirt = 1,},
	customfields= {temp_min = 6, temp_max = -2}
})