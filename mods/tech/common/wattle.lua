
--A frame to let wattle walls connect to wattle doors
--TODO: Make it detect wattle or doors and rotate itself to match

function wdf_connect_to_door(pos)
   local pnode = minetest.get_node(pos)
   local door = minetest.find_nodes_in_area(
      {x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
      {x = pos.x + 1, y = pos.y + 2, z = pos.z + 1},
      {"group:door"}  )
   if #door > 0 then
      local vec = vector.round(vector.direction(pos, door[1]))
      local dnode = minetest.get_node(door[1])
      if vec.x == 1 then --east
	 if dnode.param2 == 2 then pnode.param2 = 20 end
	 if dnode.param2 == 0 then pnode.param2 = 2  end
      elseif vec.x == -1 then --west
	 if dnode.param2 == 2 then pnode.param2 = 0  end
	 if dnode.param2 == 0 then pnode.param2 = 22 end
      elseif vec.z == 1 then --north
	 if dnode.param2 == 3 then pnode.param2 = 1  end
	 if dnode.param2 == 1 then pnode.param2 = 21 end
      elseif vec.z == -1 then --south
	 if dnode.param2 == 1 then pnode.param2 = 3  end
	 if dnode.param2 == 3 then pnode.param2 = 23 end
      elseif vec.y == -1 then --straight down
	 if dnode.param2 == 2 then pnode.param2 = 16 end
	 if dnode.param2 == 0 then pnode.param2 = 14 end
	 if dnode.param2 == 3 then pnode.param2 = 5  end
	 if dnode.param2 == 1 then pnode.param2 = 11 end
      elseif vec.y == 1 then --straight up
	 if dnode.param2 == 2 then pnode.param2 = 12 end
	 if dnode.param2 == 0 then pnode.param2 = 18 end
	 if dnode.param2 == 3 then pnode.param2 = 9  end
	 if dnode.param2 == 1 then pnode.param2 = 7  end
      end
   minetest.swap_node(pos, {name = "tech:wattle_door_frame",
			   param1 = pnode.param1,
			   param2 = pnode.param2})
   end
end