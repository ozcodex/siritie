-- alchemy/init.lua

-- Minetest mod: alchemy
-- See README.txt for licensing and other information.

alembic_inv_size = 4

dofile(minetest.get_modpath("zero_loader").."/init.lua")
zero_load('alchemy',{"common", "nodes", "items", "crafts"})
