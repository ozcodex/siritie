-------------------------------------
--TECH
------------------------------------
tech = {}

-- Internationalization
tech.S = minetest.get_translator("tech")
tech.FS = function(...)
    return minetest.formspec_escape(tech.S(...))
end

-- Internationalization
S = tech.S

c_alpha = minimal.compat_alpha

local modpath = minetest.get_modpath('tech')

--Register
--some crafts are more convienently registered at the same time as the resource,
--hence why not all are here.
crafting.register_type("crafting_spot")
crafting.register_type("clay_shaping_spot")
crafting.register_type("weaving_frame")
crafting.register_type("grinding_stone")
crafting.register_type("mortar_and_pestle")
crafting.register_type("anvil")
crafting.register_type("carpentry_bench")
crafting.register_type("brick_makers_bench")
crafting.register_type("spinning_wheel")
crafting.register_type("loom")
crafting.register_type("glass_furnace")

dofile(modpath .. "/lightsource_api.lua")
--dofile(modpath..'/craft_stations.lua')
-------------------------------
dofile(minetest.get_modpath("zero_loader").."/init.lua")
zero_load('tech',{"common", "nodes", "crafts", "items", "crafts"})
-------------------------------
dofile(modpath..'/drugs.lua')
dofile(modpath..'/storage.lua')
dofile(modpath..'/earthen_building.lua')
dofile(modpath .. "/beds.lua")
dofile(modpath .. "/doors.lua")
dofile(modpath .. "/torch.lua")
dofile(modpath .. "/ironworking.lua")
dofile(modpath .. "/woodworking.lua")
dofile(modpath .. "/fibreworking.lua")
dofile(modpath .. "/glassworking.lua")
dofile(modpath .. "/clothing.lua")
dofile(modpath .. "/grafitti.lua")
dofile(modpath .. "/bricks_and_mortar.lua")
dofile(modpath .. "/cooking_pot.lua")
dofile(modpath .. "/lantern.lua")
-------------------------------

-----------------------------------------------
-- Dying recipes

crafting.register_recipe({
	type = "crafting_spot",
	output = "ncrafting:dye_pot 1",
	items = {"tech:clay_water_pot 1", "tech:stick 1"},
	level = 1,
	always_known = true,
})

crafting.register_recipe({
	type = "crafting_spot",
	output = "ncrafting:dye_table 1",
	items = {"tech:stick 12"},
	level = 1,
	always_known = true,
})
