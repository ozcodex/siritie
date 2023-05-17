--
--mortar and pestle
--

--make herbal_medicine
crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:herbal_medicine",
	items = {'nodes_nature:hakimi', 'nodes_nature:merki', 'nodes_nature:moss'},
	level = 1,
	always_known = true,
})

--make tiku
crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:tiku",
	items = {'nodes_nature:tikusati_seed 12', 'nodes_nature:wiha', "tech:vegetable_oil"},
	level = 1,
	always_known = true,
})

--make tang_unfermented
crafting.register_recipe({
	type = "mortar_and_pestle",
	output = "tech:tang_unfermented",
	items = {'nodes_nature:tangkal_fruit 12', "tech:clay_amphora_freshwater"},
	level = 1,
	always_known = true,
})
