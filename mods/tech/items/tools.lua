--
-- Multitool
--

--a crude chipped stone: 1.snap. 2. chop 3.crum
minetest.register_tool("tech:stone_chopper", {
	description = S("Stone Knife"),
	inventory_image = "tech_tool_stone_chopper.png",
	tool_capabilities = {
		full_punch_interval = base_punch_int,
		groupcaps = {
			choppy = { times = { [3] = crude_chop3 }, uses = base_use * 0.75, maxlevel = crude_max_lvl },
			snappy = {
				times = { [1] = crude_snap1, [2] = crude_snap2, [3] = crude_snap3 },
				uses = base_use,
				maxlevel = crude_max_lvl,
			},
			crumbly = { times = { [3] = crude_crum0 }, uses = base_use * 0.5, maxlevel = crude_max_lvl },
		},
		damage_groups = { fleshy = crude_dmg },
	},
	groups = { knife = 1, craftedby = 1 },
	sound = { breaks = "tech_tool_breaks" },
})

--
-- Crumbly
--

-- digging stick... specialist for digging. Can also till
minetest.register_tool("tech:digging_stick", {
	description = S("Digging Stick"),
	inventory_image = "tech_tool_digging_stick.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = base_punch_int * 1.1,
		groupcaps = {
			crumbly = {
				times = { [1] = crude_crum1, [2] = crude_crum2, [3] = crude_crum3 },
				uses = base_use,
				maxlevel = crude_max_lvl,
			},
		},
		damage_groups = { fleshy = crude_dmg },
	},
	groups = { shovel = 1, craftedby = 1 },
	sound = { breaks = "tech_tool_breaks" },
	on_place = function(itemstack, placer, pointed_thing)
		return path_making(itemstack, placer, pointed_thing, base_use)
	end,
})

--
-- multitool
--

--stone adze. best for chopping
minetest.register_tool("tech:adze_granite", {
	description = S("Granite Adze"),
	inventory_image = "tech_tool_adze_granite.png",
	tool_capabilities = {
		full_punch_interval = base_punch_int * 1.1,
		groupcaps = {
			choppy = { times = { [2] = stone_chop2, [3] = stone_chop3 }, uses = stone_use, maxlevel = stone_max_lvl },
			snappy = {
				times = { [1] = stone_snap1, [2] = stone_snap2, [3] = stone_snap3 },
				uses = stone_use * 0.8,
				maxlevel = stone_max_lvl,
			},
			crumbly = { times = { [3] = crude_crum3 }, uses = base_use, maxlevel = crude_max_lvl },
		},
		damage_groups = { fleshy = stone_dmg },
	},
	groups = { axe = 1, craftedby = 1 },
	sound = { breaks = "tech_tool_breaks" },
})

--less uses than granite bc softer stone
minetest.register_tool("tech:adze_basalt", {
	description = S("Basalt Adze"),
	inventory_image = "tech_tool_adze_basalt.png",
	tool_capabilities = {
		full_punch_interval = base_punch_int * 1.1,
		groupcaps = {
			choppy = {
				times = { [2] = stone_chop2, [3] = stone_chop3 },
				uses = stone_use * 0.9,
				maxlevel = stone_max_lvl,
			},
			snappy = {
				times = { [1] = stone_snap1, [2] = stone_snap2, [3] = stone_snap3 },
				uses = stone_use * 0.7,
				maxlevel = stone_max_lvl,
			},
			crumbly = { times = { [3] = crude_crum3 }, uses = base_use * 0.9, maxlevel = crude_max_lvl },
		},
		damage_groups = { fleshy = stone_dmg },
	},
	groups = { axe = 1, craftedby = 1 },
	sound = { breaks = "tech_tool_breaks" },
})

--many more uses than granite.
minetest.register_tool("tech:adze_jade", {
	description = S("Jade Adze"),
	inventory_image = "tech_tool_adze_jade.png",
	tool_capabilities = {
		full_punch_interval = base_punch_int * 1.1,
		groupcaps = {
			choppy = {
				times = { [2] = stone_chop2, [3] = stone_chop3 },
				uses = stone_use * 1.5,
				maxlevel = stone_max_lvl,
			},
			snappy = {
				times = { [1] = stone_snap1, [2] = stone_snap2, [3] = stone_snap3 },
				uses = stone_use,
				maxlevel = stone_max_lvl,
			},
			crumbly = { times = { [3] = crude_crum3 }, uses = base_use, maxlevel = crude_max_lvl },
		},
		damage_groups = { fleshy = stone_dmg },
	},
	groups = { axe = 1, craftedby = 1 },
	sound = { breaks = "tech_tool_breaks" },
})

--stone club. A weapon. Not very good for anything else
--can stun catch animals
minetest.register_tool("tech:stone_club", {
	description = S("Stone Club"),
	inventory_image = "tech_tool_stone_club.png",
	tool_capabilities = {
		full_punch_interval = base_punch_int * 1.2,
		groupcaps = {
			choppy = { times = { [3] = crude_chop3 }, uses = base_use * 0.5, maxlevel = crude_max_lvl },
			snappy = { times = { [3] = crude_snap3 }, uses = base_use * 0.5, maxlevel = crude_max_lvl },
			crumbly = { times = { [3] = crude_crum3 }, uses = base_use * 0.5, maxlevel = crude_max_lvl },
		},
		damage_groups = { fleshy = stone_dmg * 2 },
	},
	groups = { club = 1, craftedby = 1 },
	sound = { breaks = "tech_tool_breaks" },
})

--Axe. best for chopping, snappy
minetest.register_tool("tech:axe_iron", {
	description = S("Iron Axe"),
	inventory_image = "tech_tool_axe_iron.png",
	tool_capabilities = {
		full_punch_interval = base_punch_int * 1.1,
		groupcaps = {
			choppy = {
				times = { [1] = iron_chop1, [2] = iron_chop2, [3] = iron_chop3 },
				uses = iron_use,
				maxlevel = iron_max_lvl,
			},
			snappy = {
				times = { [1] = iron_snap1, [2] = iron_snap2, [3] = iron_snap3 },
				uses = iron_use,
				maxlevel = iron_max_lvl,
			},
			crumbly = { times = { [3] = crude_crum3 }, uses = stone_use, maxlevel = stone_max_lvl },
		},
		damage_groups = { fleshy = iron_dmg },
	},
	groups = { axe = 1, craftedby = 1 },
	sound = { breaks = "tech_tool_breaks" },
})

-- shovel... best for digging. Can also till
minetest.register_tool("tech:shovel_iron", {
	description = S("Iron Shovel"),
	inventory_image = "tech_tool_shovel_iron.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = base_punch_int * 1.1,
		groupcaps = {
			crumbly = {
				times = { [1] = iron_crum1, [2] = iron_crum2, [3] = iron_crum3 },
				uses = iron_use,
				maxlevel = iron_max_lvl,
			},
			snappy = { times = { [3] = stone_snap3 }, uses = iron_use * 0.8, maxlevel = iron_max_lvl },
		},
		damage_groups = { fleshy = iron_dmg },
	},
	groups = { shovel = 1, craftedby = 1 },
	sound = { breaks = "tech_tool_breaks" },
	on_place = function(itemstack, placer, pointed_thing)
		return till_soil(itemstack, placer, pointed_thing, iron_use)
	end,
})

--Mace.  A weapon. Not very good for anything else
--can stun catch animals
minetest.register_tool("tech:mace_iron", {
	description = S("Iron Mace"),
	inventory_image = "tech_tool_mace_iron.png",
	tool_capabilities = {
		full_punch_interval = base_punch_int * 1.2,
		groupcaps = {
			choppy = { times = { [3] = crude_chop3 }, uses = base_use * 0.5, maxlevel = crude_max_lvl },
			snappy = { times = { [3] = crude_snap3 }, uses = base_use * 0.5, maxlevel = crude_max_lvl },
			crumbly = { times = { [3] = crude_crum3 }, uses = base_use * 0.5, maxlevel = crude_max_lvl },
		},
		damage_groups = { fleshy = iron_dmg * 2 },
	},
	groups = { club = 1, craftedby = 1 },
	sound = { breaks = "tech_tool_breaks" },
})

--Pick Axe. mining, digging
minetest.register_tool("tech:pickaxe_iron", {
	description = S("Iron Pickaxe"),
	inventory_image = "tech_tool_pickaxe_iron.png",
	tool_capabilities = {
		full_punch_interval = base_punch_int * 1.1,
		groupcaps = {
			choppy = { times = { [3] = stone_chop3 }, uses = iron_use * 0.8, maxlevel = iron_max_lvl },
			snappy = { times = { [3] = stone_snap3 }, uses = iron_use * 0.8, maxlevel = iron_max_lvl },
			crumbly = { times = { [2] = stone_crum2, [3] = stone_crum3 }, uses = iron_use, maxlevel = iron_max_lvl },
			cracky = { times = { [2] = iron_crac2, [3] = iron_crac3 }, uses = iron_use, maxlevel = iron_max_lvl },
		},
		damage_groups = { fleshy = iron_dmg },
	},
	groups = { pickaxe = 1, craftedby = 1 },
	sound = { breaks = "tech_tool_breaks" },
})
