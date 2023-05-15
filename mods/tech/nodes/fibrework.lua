----------------------------------------------------------
--FIBRE WORKING
--production of fabrics etc

--[[
Historical big four: Flax, wool, cotton, silk.

Basics steps
-detach it from unwanted material
-clean it/sort it/etc
-spin



e.g. linen
-strip seeds
-soak bundles for 2wks (in a trough) retting.
-dry
-pound fibres in flax brake
-scrape with stick
-brush (through iron nails)
-spin
-loom for items



e.g. cotton
-seperate seeds
-skips straight to carding/spinning

]]

-----------------------------------------------------------
--Plenty of plants can provide fibre in a pinch (hence group:fibrous_plant),
--but only some are preffered...for us it shall be cana

--[[
Huge simplification of an otherwise tediuous process
1. cana bundle
2. retting (soak in water)
3. make into fibre (coarse, or fine)
]]

--Requires retting ie soak and semi-rot
minetest.register_node('tech:unretted_cana_bundle', {
	description = S('Unretted Cana Bundle'),
	tiles = {"tech_unretted_cana_bundle.png"},
	stack_max = minimal.stack_max_bulky * 2,
	groups = {snappy=3, flammable=1, falling_node=1 },
	sounds = nodes_nature.node_sound_leaves_defaults(),
	on_burn = function(pos)
		if math.random()<0.5 then
			minimal.switch_node(pos, {name = "tech:small_wood_fire"})
			minetest.check_for_falling(pos)
		else
			minetest.remove_node(pos)
		end
	end,
  on_construct = function(pos)
    --length(i.e. difficulty of wash), interval for checks (speed)
    ncrafting.start_soak(pos, 60, 10)
  end,
  on_timer = function(pos, elapsed)
    --finished product, length
    return ncrafting.do_soak(pos, 'tech:retted_cana_bundle', 60)
  end,
})


--Retted, ie. has removed unwanted plant matter
minetest.register_node('tech:retted_cana_bundle', {
	description = S('Retted Cana Bundle'),
	tiles = {"tech_retted_cana_bundle.png"},
	stack_max = minimal.stack_max_bulky * 2,
	groups = {snappy=3, flammable=1, falling_node=1 },
	sounds = nodes_nature.node_sound_leaves_defaults(),
})
