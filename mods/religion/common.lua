-- Load support for game translation.
local S = minetest.get_translator("religion")

-- calculate the total weight of prayer responses 
local function get_total_weight()
	local total_weight = 0;
	for prayer = 1,#pray_responses do
		total_weight = total_weight + pray_responses[prayer].weight
	end
	return total_weight;
end

local function is_owner(pos, name)
	local owner = minetest.get_meta(pos):get_string("owner")
	if owner == "" or owner == name or minetest.check_player_privs(name, "protection_bypass") then
		return true
	end
	return false
end

local function can_dig(pos, player)
	local inv = minetest.get_meta(pos):get_inventory()
	local name = ""
	if player then
		name = player:get_player_name()
	end
	return init.is_owner(pos, name) and inv:is_empty("main")
end

function bless_attribute(player, attribute, blessing, max_value)
	local player_attr = player:get_attribute(attribute)
	-- update player attributes
  if player_attr then
    player_attr = tonumber(player_attr)
    player_attr = player_attr + (blessing / 100) * max_value
    if player_attr > max_value then
      player_attr = max_value
    end
    if player_attr < 0 then
      player_attr = 0
    end
    player:set_attribute(attribute, player_attr)
  end
end

function raise_prayer(pos, node, player, itemstack, pointed_thing)
	local meta = player:get_meta()
	local current_player = player:get_player_name()
	local total_prayers = meta:get_int("total_prayers")
	local last_prayer = meta:get_int("last_prayer")
	local current_day = minetest.get_day_count()
	local lived_days = current_day - meta:get_int("char_start_date")

	if total_prayers == 0 or last_prayer < current_day then
		-- raise a prayer
		minetest.chat_send_player(current_player, S("You offer up a prayer to your god"))
		meta:set_int("total_prayers", total_prayers + 1)
		meta:set_int("last_prayer", current_day)
		-- wait before define what happens
		minetest.after(pray_time, function()
			local picked = math.random(0,get_total_weight())
			local response = ''
			local accumulator = 0
			for prayer = 1,#pray_responses do
				accumulator = accumulator + pray_responses[prayer].weight
				if picked <= accumulator then
					response = pray_responses[prayer].message
          minetest.chat_send_player(current_player, S(response))
          -- give a blessing
          -- fullfill hunger, thrist and energy
          -- but only the percentage of the blessing
          -- max hunger is 1000
          -- max energy is 1000
          -- max thirst is 100
          bless_attribute(player, "hunger", pray_responses[prayer].blessing, 1000)
          bless_attribute(player, "energy", pray_responses[prayer].blessing, 1000)
          bless_attribute(player, "thirst", pray_responses[prayer].blessing, 100)
					break
				end
			end
		end)
	else
		-- wait for another day
		minetest.chat_send_player(current_player, S("You have already said your prayers for today"))
	end
end
