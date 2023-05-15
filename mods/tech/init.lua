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

-------------------------------
dofile(minetest.get_modpath("zero_loader").."/init.lua")
zero_load('tech',{"common", "nodes", "items", "crafts"})
-------------------------------
dofile(modpath ..'/earthen_building.lua')
dofile(modpath .. "/torch.lua")
dofile(modpath .. "/ironworking.lua")
dofile(modpath .. "/woodworking.lua")
dofile(modpath .. "/fibreworking.lua")
dofile(modpath .. "/glassworking.lua")
dofile(modpath .. "/grafitti.lua")
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
