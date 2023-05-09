storage_node_box = {
	{-0.375, -0.5, -0.375, 0.375, -0.375, 0.375},
	{-0.375, 0.375, -0.375, 0.375, 0.5, 0.375},
	{-0.4375, -0.375, -0.4375, 0.4375, -0.25, 0.4375},
	{-0.4375, 0.25, -0.4375, 0.4375, 0.375, 0.4375},
	{-0.5, -0.25, -0.5, 0.5, 0.25, 0.5},
}

chest_node_box = {
	{-0.4375, -0.375, -0.375, 0.4375, 0.375, 0.375}, -- NodeBox1
	{-0.5, 0.375, -0.4375, 0.5, 0.5, 0.4375}, -- NodeBox2
	{0.3125, -0.5, -0.4375, 0.5, -0.375, -0.25}, -- NodeBox3
	{0.3125, -0.5, 0.25, 0.5, -0.375, 0.4375}, -- NodeBox4
	{-0.5, -0.5, 0.25, -0.3125, -0.375, 0.4375}, -- NodeBox5
	{-0.5, -0.5, -0.4375, -0.3125, -0.375, -0.25}, -- NodeBox6
	{0.1875, 0.25, 0.375, 0.3125, 0.375, 0.4375}, -- NodeBox8
	{-0.3125, 0.25, 0.375, -0.1875, 0.375, 0.4375}, -- NodeBox9
	{-0.0625, 0.25, -0.4375, 0.0625, 0.375, -0.375}, -- NodeBox10
}

function get_storage_formspec(pos, w, h, meta)
	local creator = meta:get_string('creator')
	local label = minimal.sanitize_string(meta:get_string('label'))
	minimal.infotext_merge(pos, 'Label: '..label, meta)
	local formspec_size_h = 3.85 + h
	local main_offset = 0.25 + h
	local trash_offset = 0.45 + h + 2
	local label_offset = trash_offset + .35
	local creator_offset_x =  (3*(30-string.len(creator))/30/2) + 5
	local craftedby_offset_x = 6.05 -- 3*(30-string.len('crafted by'))/30/2 + 5

	local formspec = {
		"size[8,"..formspec_size_h.."]",
		"list[current_name;main;0,0;"..w..","..h.."]",
		"list[current_player;main;0,"..main_offset..";8,2]",
		"listring[current_name;main]",
		"listring[current_player;main]",
		"list[detached:creative_trash;main;0,"..trash_offset..";1,1;]",
		"image[0.05,"..(trash_offset+.10)..
		   ";0.8,0.8;creative_trash_icon.png]",
		"field[1.5,"..label_offset..";4,1;label;Label:;"..label.."]",
		"field_close_on_enter[label;false]",
		"label["..craftedby_offset_x..","..trash_offset..";Crafted by:]",
		"label["..creator_offset_x..","..(trash_offset+.35)..";"..creator.."]",
	}
	return table.concat(formspec, "")
end


function storage_is_owner(pos, name)
	local owner = minetest.get_meta(pos):get_string("owner")
	if owner == "" or owner == name or minetest.check_player_privs(name, "protection_bypass") then
		return true
	end
	return false
end


storage_on_construct = function(pos, width, height)
	local meta = minetest.get_meta(pos)

	local form = get_storage_formspec(pos, width, height, meta)
	meta:set_string("formspec", form)

	local inv = meta:get_inventory()
	inv:set_size("main", width*height)
end

storage_on_receive_fields = function(pos, formname, fields, sender, width, height)
		local label = fields.label
		if label and label ~= '' then
		   local meta = minetest.get_meta(pos)
		   local cleanlabel = minimal.sanitize_string(label)
		   meta:set_string('label', cleanlabel)
		   minimal.infotext_merge(pos,'Label: '..cleanlabel, meta)
		   on_construct(pos, width, height)
		end
end

