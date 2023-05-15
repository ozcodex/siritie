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
dofile(modpath .. "/woodworking.lua")
dofile(modpath .. "/lantern.lua")
-------------------------------
