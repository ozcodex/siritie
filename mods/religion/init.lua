-- religion/init.lua

-- Minetest mod: religion
-- See README.txt for licensing and other information.

local modpath = minetest.get_modpath('religion')

dofile(modpath .. "/common.lua")
dofile(modpath .. "/nodes.lua")
dofile(modpath .. "/crafts.lua")

-- reset prayers counter on respawn
minetest.register_on_respawnplayer(function(player)
	local meta = player:get_meta()
	meta:set_int("total_prayers", 0)
	meta:set_int("last_prayer", 0)
end)