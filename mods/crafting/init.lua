-- Crafting Mod - semi-realistic crafting in minetest
-- Copyright (C) 2018 rubenwardy <rw@rubenwardy.com>
--
-- This library is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
--
-- This library is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
--
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library; if not, write to the Free Software
-- Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

--Register
--some crafts are more convienently registered at the same time as the resource,
--hence why not all are here.

dofile(minetest.get_modpath("crafting") .. "/api.lua")
dofile(minetest.get_modpath("crafting") .. "/async_craft.lua")
dofile(minetest.get_modpath("crafting") .. "/gui.lua")
dofile(minetest.get_modpath("crafting") .. "/stations.lua")

crafting.register_type("mixing_spot")
crafting.register_type("mixing_bucket")
crafting.register_type("mortar_bucket")
crafting.register_type("threshing_spot")
crafting.register_type("hammering_block")
crafting.register_type("chopping_block")
crafting.register_type("masonry_bench")
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
crafting.register_type("wattle_workstation")
crafting.register_type("clay_mixing")

if minetest.global_exists("awards") then
	awards.register_on_unlock(function(name, award)
		if award.unlocks_crafts then
			crafting.unlock(name, award.unlocks_crafts)
		end
	end)

	crafting.register_on_craft(function(name, recipe)
		local player = minetest.get_player_by_name(name)
		if player then
			awards.notify_craft(player, recipe.output, recipe.output_n or 1)
		end
	end)
end
