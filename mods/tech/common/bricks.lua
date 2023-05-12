--[[

Bricks:
clay + sand -> unfired loose brick (using brick mold etc)
Fire @ >600 (more like 1000?. Depends on the clay. We'll do within range of our wood fire)
-> fired loose brick
Plus mortar -> bricks and mortar

]]

--Pottery firing functions
function set_firing(pos, length, interval)
	-- and firing count
	local meta = minetest.get_meta(pos)
	meta:set_int("firing", length)
	--check heat interval
	minetest.get_node_timer(pos):start(interval)
end



function fire_pottery(pos, selfname, name, length)
	local meta = minetest.get_meta(pos)
	local firing = meta:get_int("firing")

	--check if wet, falls to bits and thats it for your pot
	if climate.get_rain(pos) or minetest.find_node_near(pos, 1, {"group:water"}) then
		minimal.swap_node(pos, {name = 'nodes_nature:clay'})
		return false
	end

	--exchange accumulated heat
	climate.heat_transfer(pos, selfname)

	--check if above firing temp
	local temp = climate.get_point_temp(pos)
	local fire_temp = 850

	if firing <= 0 then
		--finished firing
		minetest.swap_node(pos, {name = name})
		return false
	elseif temp < fire_temp then
		if firing < length and temp < fire_temp/2 then
			--firing began but is now interupted
			--causes firing to fail
			minetest.swap_node(pos, {name = "tech:broken_pottery"})
			return false
		else
			--no fire lit yet
			return true
		end
	elseif temp >= fire_temp then
		--do firing
		meta:set_int("firing", firing - 1)
		return true
	end

end

