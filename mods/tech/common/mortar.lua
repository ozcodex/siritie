--pre-roast  functions
function set_roast(pos, length, interval)
	-- and firing count
	local meta = minetest.get_meta(pos)
	meta:set_int("roast", length)
	--check heat interval
	minetest.get_node_timer(pos):start(interval)
end

function roast(pos, selfname, name, length, heat)
	local meta = minetest.get_meta(pos)
	local roast = meta:get_int("roast")

	--check if wet stop
	if climate.get_rain(pos) or minetest.find_node_near(pos, 1, {"group:water"}) then
		return true
	end

	--exchange accumulated heat
	climate.heat_transfer(pos, selfname)

	--check if above firing temp
	local temp = climate.get_point_temp(pos)
	local fire_temp = heat

	if roast <= 0 then
		--finished firing
    minimal.switch_node(pos, {name = name})
    minetest.check_for_falling(pos)
    return false
  elseif temp < fire_temp then
    --not lit yet
    return true
	elseif temp >= fire_temp then
    --do firing
    meta:set_int("roast", roast - 1)
    return true
  end
end

mortar_blocks_list = {
	{"claystone", S("Claystone"), 3},
	{"siltstone", S("Siltstone"), 3},
	{"sandstone", S("Sandstone"), 3},
	{"conglomerate", S("Conglomerate"), 3},
	{"limestone", S("Limestone"), 3},
	{"ironstone", S("Ironstone"), 3},
	{"granite", S("Granite"), 1},
	{"basalt", S("Basalt"), 2},
	{"gneiss", S("Gneiss"), 1},
	{"jade", S("Jade"), 1},
}
