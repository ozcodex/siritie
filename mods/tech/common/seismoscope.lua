--[[
Based on the Seismoscope by Zhang Heng

The original seismoscope was a large bronze vessel, resembling a samovar,
with eight dragon heads facing the eight principal directions of the compass.
Below the dragons were eight bronze toads, with open mouths and back legs
squatting on the floor. When an earthquake occurred, a ball would drop out
of the mouth of the dragon corresponding to the direction of the earthquake.

In this version, the seismoscope is a ceramic vessel whit a pendulum inside.

At a random time interval, the seismoscope will detect the nearest volcano
and change its status, when right clicked it will show a message with the
direction (north, south, east, west, northeast, northwest, southeast, southwest).
--]]

seismoscope_min_time = 60 * 5 -- 5 minutes
seismoscope_max_time = 60 * 10 -- 10 minutes

-- the status of the nearest volcano will be affect the seismoscope
-- chances of detecting an earthquake
seismoscope_detection_chance = {
	extinct = 0.1,
	dormant = 0.3,
	active = 0.5,
}

-- if volcano distances are less than near_threshold, the seismoscope will
-- sense a strong earthquake, if distances are less than far_threshold, the
-- seismoscope will sense a weak earthquake

seismoscope_near_threshold = 1000
seismoscope_far_threshold = 3000

seismoscope_on_timer = function(pos, elapsed) end

get_cardinal_direction = function(initial_pos, target_pos)
	local dx = target_pos.x - initial_pos.x
	local dz = target_pos.z - initial_pos.z

	if dx == 0 and dz == 0 then
		return "zenit"
	end

	local angle = math.atan2(dz, dx) * (180 / math.pi)
	print(angle)
	local index = (math.floor((angle + 22.5) / 45) % 8) + 1

	local directions = {
		"east",
		"northeast",
		"north",
		"northwest",
		"west",
		"southwest",
		"south",
		"southeast",
	}

	return directions[index]
end
