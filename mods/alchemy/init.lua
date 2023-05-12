-- alchemy/init.lua

-- Minetest mod: alchemy
-- See README.txt for licensing and other information.

--[[
The alembic is a device used to distill products from liquids stored in clay
pots. It can operate at temperatures higher than the given temperature
(default = 100°C), but it can also work at ambient temperature, taking much
longer (default = 300 seconds, 5 minutes).

Each process involves a source, which is the clay pot located under the alembic.
The process takes a specific amount of time and produces a certain number of
products, leaving the subproduct in the clay pot. A single process can produce
multiple products, but only one subproduct.

If there isn't enough space in the alembic's inventory, any additional products
will be lost. The alembic has a set number of inventory slots (default = 4) and
doesn't have a GUI. Products can be retrieved by right-clicking the alembic or
by removing it.
]]


alembic_inv_size = 4 -- slots
alembic_check_interval = 10 -- seconds
alembic_working_temperature = 100 -- celcius
ambient_temperature_time = 300 -- seconds

alembic_processes = {
	-- source: products, subproduct and time in seconds
	["tech:clay_water_pot_salt_water"] = {
		products = {"alchemy:salt 2"},
		subproduct = "tech:clay_water_pot_freshwater",
		time = 120
	},
	["tech:tang"] = {
		products = {"alchemy:alcohol 1","alchemy:salt 1"},
		subproduct = "tech:clay_water_pot_freshwater",
		time = 180
	},
	["tech:clay_water_pot_freshwater"] = {
		products = {},
		subproduct = "tech:clay_water_pot",
		time = 60
	}
}

dofile(minetest.get_modpath("zero_loader").."/init.lua")
zero_load('alchemy',{"common", "nodes", "items", "crafts"})
