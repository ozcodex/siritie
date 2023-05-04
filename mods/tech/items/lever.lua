-- lever
minetest.register_tool("tech:lever", {
	description = S("lever") .. "\n" .. S("(left-click rotates face, right-click rotates axis)"),
	inventory_image = "tech_tool_lever.png",
	groups = {tool = 1},
	_uses = 400,
	on_use = function(itemstack, user, pointed_thing)
		lever.handler(itemstack, user, pointed_thing, lever.ROTATE_FACE)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		lever.handler(itemstack, user, pointed_thing, lever.ROTATE_AXIS)
		return itemstack
	end,
})
