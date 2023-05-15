
--lime White

grafitti.register_brush("tech:paint_lime_white", {
    description = S("Painting Kit (lime white)"),
    inventory_image = "tech_paint_brush_white.png",
    wield_image = "tech_paint_brush_white.png^[transformR270",
    palette = "tech:lime_white"
})


crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:paint_lime_white",
	items = {'tech:crushed_lime', 'tech:stick', 'group:fibrous_plant 4', 'tech:vegetable_oil 4'},
	level = 1,
	always_known = true,
})

--glow paint (glowing blue)

grafitti.register_brush("tech:paint_glow_paint", {
    description = S("Painting Kit (glow paint)"),
    inventory_image = "tech_paint_brush_glow.png",
    wield_image = "tech_paint_brush_glow.png^[transformR270",
    palette = "tech:glow_paint"
})

crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:paint_glow_paint",
	items = {'group:bioluminescent 16', 'tech:stick', 'group:fibrous_plant 4', 'tech:vegetable_oil 4'},
	level = 1,
	always_known = true,
})

--carbon black

grafitti.register_brush("tech:paint_carbon_black_paint", {
    description = S("Painting Kit (Carbon black paint)"),
    inventory_image = "tech_paint_brush_black.png",
    wield_image = "tech_paint_brush_black.png^[transformR270",
    palette = "tech:carbon_black_paint"
})

crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:paint_carbon_black_paint",
	items = {'tech:crushed_charcoal_block', 'tech:stick', 'group:fibrous_plant 4', 'tech:vegetable_oil 4'},
	level = 1,
	always_known = true,
})


--red ochre

grafitti.register_brush("tech:paint_red_ochre_paint", {
    description = S("Painting Kit (Red Ochre paint)"),
    inventory_image = "tech_paint_brush_red.png",
    wield_image = "tech_paint_brush_red.png^[transformR270",
    palette = "tech:red_ochre_paint"
})

crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:paint_red_ochre_paint",
	items = {'tech:crushed_iron_ore', 'tech:stick', 'group:fibrous_plant 4', 'tech:vegetable_oil 4'},
	level = 1,
	always_known = true,
})