
------------------------------------------
--THATCH

minetest.register_node('tech:thatch', {
	description = S('Thatch'),
	tiles = {"tech_thatch.png"},
	stack_max = minimal.stack_max_bulky * 4,
	groups = {snappy=3, flammable=1, fall_damage_add_percent = -30},
	sounds = nodes_nature.node_sound_leaves_defaults(),
	on_burn = function(pos)
		if math.random()<0.5 then
			minimal.switch_node(pos, {name = "tech:small_wood_fire"})
			minetest.check_for_falling(pos)
		else
			minetest.remove_node(pos)
		end
	end,
})

stairs.register_slab(
	"thatch",
	"tech:thatch",
	"weaving_frame",
	"false",
	{snappy=3, flammable=1, fall_damage_add_percent = -15},
	{"tech_thatch.png"},
	"Thatch Slab",
	minimal.stack_max_bulky * 8,
	nodes_nature.node_sound_leaves_defaults()
)

minetest.override_item("stairs:slab_thatch",
		{ on_rightclick = function(pos, node, clicker,
					   itemstack, pointed_thing)
		     return minimal.slabs_combine(pos, node, itemstack, "tech:thatch")
		end,
})
