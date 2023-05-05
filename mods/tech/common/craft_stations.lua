-- location limit craft spots --------------------
-- grouplist/banlistg {{group1, group_number}, {'stone', 1}}
-- nodelist/banlistn {node_name, 'nodes_nature:sandstone'}
-- msg string "stone or sandstone"
function on_place_loclim_spot(itemstack, placer, pointed_thing, grouplist, nodelist, msg, banlistg, banlistn)
   local ground = minetest.get_node(pointed_thing.under)

   --check lists to see if it's a valid substrate
   local valid = false
   local vcheck = false

   if grouplist and #grouplist >= 1 then
     vcheck = true
     for i in ipairs(grouplist) do
       local group = grouplist[i][1]
       local num = grouplist[i][2]
       if minetest.get_item_group(ground.name,group) == num then
         valid = true
         break
       end
     end
   end

   if nodelist and #nodelist >= 1 then
     vcheck = true
     local gname = ground.name
     for i in ipairs(nodelist) do
        local name = nodelist[i]
      if gname == name then
        valid = true
        break
      end
    end
  end

  local banned
  if banlistg and #banlistg >= 1 then
    for i in ipairs(banlistg) do
     local group = banlistg[i][1]
     local num = banlistg[i][2]
     if minetest.get_item_group(ground.name,group) == num then
       banned = true
       break
     end
   end
  end

  if banlistn and #banlistn >= 1 then
    local gname = ground.name
    for i in ipairs(banlistn) do
     local name = banlistn[i]
     if gname == name then
       banned = true
       break
     end
   end
 end


  --block invalid
  if banned == true
  --or above.name ~= "air"
  or (vcheck == true and valid == false) then

    minetest.chat_send_player(placer:get_player_name(),
    "Cannot place here! Needs: "..msg..".")

    local udef = minetest.registered_nodes[ground.name]
    if udef and udef.on_rightclick and
    not (placer and placer:is_player() and placer:get_player_control().sneak) then
      return udef.on_rightclick(pointed_thing.under, ground,
      placer, itemstack, pointed_thing) or itemstack
    else
      return itemstack
    end
  end

  return minetest.item_place_node(itemstack,placer,pointed_thing)
end

