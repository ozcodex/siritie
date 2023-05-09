--save usage into inventory, to prevent infinite supply
on_dig_tang = function(pos, node, digger)
  if minetest.is_protected(pos, digger:get_player_name()) then
    return false
  end

  local meta = minetest.get_meta(pos)
  local ferment = meta:get_int("ferment")

  local new_stack = ItemStack("tech:tang_unfermented")
  local stack_meta = new_stack:get_meta()
  stack_meta:set_int("ferment", ferment)


  minetest.remove_node(pos)
  local player_inv = digger:get_inventory()
  if player_inv:room_for_item("main", new_stack) then
    player_inv:add_item("main", new_stack)
  else
    minetest.add_item(pos, new_stack)
  end
end

--set saved
after_place_tang = function(pos, placer, itemstack, pointed_thing)
  local meta = minetest.get_meta(pos)
  local stack_meta = itemstack:get_meta()
  local ferment = stack_meta:get_int("ferment")
  if ferment >0 then
    meta:set_int("ferment", ferment)
  end
end