--CLIMATE

--[[
Uses a markov chain to switch between weather states.
Has seasonal and diurnal fluctations in temperature, which adjust
the probability for which switch will occur (e.g rain more likely in cold)

This is climate rather than "weather" in the sense it treats the whole map
as the same, i.e. not big enough to get regional variation.


A specific locations Temperature and more can be called elsewhere (e.g. for health)

]]



climate = {
	active_weather = {},
	active_temp = {},
	active_sea_temp = {}

}

local modpath = minetest.get_modpath("climate")
local store = minetest.get_mod_storage()


-- Adds weather to register_weathers table
--all possible weather states
local registered_weathers = {}

-- Keeps sound handler references
local sound_handlers = {}

climate.register_weather = function(weather_obj)
	table.insert(registered_weathers, weather_obj)
end

dofile(modpath .. "/particles.lua")
dofile(modpath .. "/temperature.lua")
dofile(modpath .. "/history.lua")
--weathers
dofile(modpath .. "/weathers/clear.lua")
dofile(modpath .. "/weathers/light_cloud.lua")
dofile(modpath .. "/weathers/medium_cloud.lua")
dofile(modpath .. "/weathers/sun_shower.lua")
dofile(modpath .. "/weathers/light_rain.lua")
dofile(modpath .. "/weathers/overcast_light_rain.lua")
dofile(modpath .. "/weathers/overcast.lua")
dofile(modpath .. "/weathers/overcast_rain.lua")
dofile(modpath .. "/weathers/overcast_heavy_rain.lua")
dofile(modpath .. "/weathers/thunderstorm.lua")
dofile(modpath .. "/weathers/superstorm.lua")
dofile(modpath .. "/weathers/light_haze.lua")
dofile(modpath .. "/weathers/haze.lua")
dofile(modpath .. "/weathers/duststorm.lua")
dofile(modpath .. "/weathers/snow_flurry.lua")
dofile(modpath .. "/weathers/light_snow.lua")
dofile(modpath .. "/weathers/overcast_light_snow.lua")
dofile(modpath .. "/weathers/overcast_snow.lua")
dofile(modpath .. "/weathers/overcast_heavy_snow.lua")
dofile(modpath .. "/weathers/snowstorm.lua")
dofile(modpath .. "/weathers/fog.lua")



--setting...for random intervals
local base_interval = 90
local base_int_range = 30

--temp classes for probabilities
local plvl_froz = -1
local plvl_cold = 15
local plvl_mid = 25


--what weather is on, and how long it will last, and temp
--random values that should get overriden by mod storage
climate.active_weather = registered_weathers[math.random(#registered_weathers)]
climate.active_temp = math.random(15,25)
climate.sea_temp = climate.active_temp * math.random(0.6,8)
local active_weather_interval = 1


--random walk, for temp
local ran_walk_range = 10
local ran_walk = math.random(-ran_walk_range,ran_walk_range)

--------------------------
-- Functions
--------------------------

--------------------
--create a random interval for the weather to last
local function set_active_interval()
  local intv = base_interval + math.random(-base_int_range, base_int_range)
  return intv
end

local function get_seasonal_waves()
   --get seasonal wave
   local dc = minetest.get_day_count() - 10
   --diff +/- from yearly mean (seasonal variation)
   local dc_amp = 17
   --~80 day year, 20 day seasons
   local dc_period = (2*math.pi)/80
   --yearly average,
   local dc_mean = 13
   local dc_wav = dc_amp * math.sin(dc * dc_period) + dc_mean
   --seawater temp change has lower amplitude, behind 2 days from mass of water
   --Fudged loosely from McCombie's 1959 "Some Relations Between Air
   --  Temperatures and the Surface Temperature of Lakes", Wiley Online Library
   local sea_wav = (dc_amp-5) * math.sin((dc - 2) * dc_period) + dc_mean
   return dc_wav, sea_wav
end

-----------------
--set the sky, for on join and when new weather set
local function set_sky_clouds(player)
	local active_weather = climate.active_weather

	player:set_sky(active_weather.sky_data)
	player:set_clouds(active_weather.cloud_data)
	local wth = table.copy(active_weather)
	local actmp, _ = get_seasonal_waves()
	actmp = actmp - 15 -- move centerpoint
	wth.moon_data.scale = wth.moon_data.scale + (-actmp / 50 + 0.3)
	wth.sun_data.scale = wth.sun_data.scale + (actmp / 50 + 0.3)
	player:set_moon(wth.moon_data)
	player:set_sun(wth.sun_data)
	player:set_stars(active_weather.star_data)
end

-----------------
local function get_weather_table(name, registered_weathers)
	for i, reg_weather in ipairs(registered_weathers) do
	   if name == reg_weather.name then
	      local active_weather = reg_weather
	      return active_weather
	   end
	end
	--error, got a name it can't find
	--currently will likely make it crash
	minetest.log("error", "Climate: "..name.." not found")
	return

end

-------------------------
--SAVE AND LOAD

--[[
--on_leave seems incapable of saving stuff :-(
minetest.register_on_leaveplayer(function(player)
	--save climate info it your the last one out
	local num_p = minetest.get_connected_players()
	if #num_p <=1 then
		local name = climate.active_weather.name
		local t = climate.active_temp
		store:set_string("weather", name)
		store:set_float("temp", t)
	end
end)
]]--

minetest.register_on_joinplayer(function(player)
   --get weather from storage, override random start values
   local num_p = minetest.get_connected_players()
   if #num_p <=1 then

      local w_name = store:get_string("weather")

      if w_name ~= "" then
	 --check valid
	 local weather = get_weather_table(w_name, registered_weathers)
	 if weather then
	    climate.active_weather = weather
	    minetest.log("action", "Loaded a valid weather: "..w_name)
	 else
	    minetest.log("error", "Invalid weather loaded: "..w_name)
	 end
      else
	 minetest.log("warning", "No previous weather could be loaded")
      end

      --same again, but for temperature
      local temp = store:get_float("temp")
      if temp then
	 climate.active_temp = temp
      end
      local stemp = store:get_float("sea_temp")
      if stemp then
	 climate.active_sea_temp = stemp
      end

      --same again, but for ran_walk
      local ranw = store:get_float("ran_walk")
      if ranw then
	 ran_walk = ranw
      end

      --load climate_history
      local ch = store:get_string("climate_history")
      if ch ~= nil then
	 load_climate_history(ch)
      end

   end

   --set weather effects for this player
   set_sky_clouds(player)
   local p_name = player:get_player_name()
   if climate.active_weather.sound_loop then
      sound_handlers[p_name] = minetest.sound_play(
	 climate.active_weather.sound_loop, {to_player = p_name, loop = true})
   end
   minetest.chat_send_player(p_name, exiledatestring())
end)

local function select_new_active_weather()
    --select a new active_weather from probabilities
    --it will loop through and try to change the weather
    local new_weather_name
    for n, next in pairs(climate.active_weather.chain) do
      --roll dice
      local c = math.random()
      --use temperature adjusted probability
      if climate.active_temp < plvl_froz then
	 --frozen temperature
	 if next[2] > c then
	    new_weather_name = next[1]
	 end
      elseif climate.active_temp < plvl_cold then
	 --cold temperature
	 if next[3] > c then
	    new_weather_name = next[1]
	 end
      elseif climate.active_temp < plvl_mid then
	 --mid temperature
	 if next[4] > c then
	    new_weather_name = next[1]
	 end
      else
	 --hot temperature
	 if next[5] > c then
	    new_weather_name = next[1]
	 end
      end
    end

    --did it succeed in getting a new state?
    if new_weather_name and new_weather_name ~= climate.active_weather.name then

      --we need to update the sky and set the new
       climate.active_weather = get_weather_table(new_weather_name,
						  registered_weathers)
    end
    --do for each player
    for _,player in ipairs(minetest.get_connected_players()) do
       --set sky and clouds for new state using the new active_weather
       set_sky_clouds(player)
    end
end

local function set_world_temperature()
    --this is a universal temperature for the whole map
    --we treat the whole map as one coherent region, with a single climate
    --specific player temp adjusted from this (e.g. by altitude)

    --get day night wave
    local tod = minetest.get_timeofday()
    --diff between day and night is this x2
    local dn_amp = -8
    local dn_period = (2*math.pi)/1 ---match day length
    local dn_wav = dn_amp * math.cos(tod * dn_period)

    --random walk...an incremental fluctuation that is capped
    ran_walk = ran_walk + math.random(-2, 2)
    if ran_walk > ran_walk_range or ran_walk < -ran_walk_range then
       ran_walk = ran_walk/1.04
    end
    local dc_wav, sea_wav = get_seasonal_waves()
    --sum waves plus some random noise
    climate.active_temp =  dc_wav + dn_wav + ran_walk
    climate.active_sea_temp = sea_wav + ((dn_wav + ran_walk) * 0.3)
    --save state so can be reloaded.
    --only actually needed on log out,... but that doesn't work
    store:set_string("weather", climate.active_weather.name)
    store:set_float("temp", climate.active_temp)
    store:set_float("sea_temp", climate.active_sea_temp)
    store:set_float("ran_walk", ran_walk)
end

local function update_player_sounds(p_name)
   --remove old sounds
   local sound = sound_handlers[p_name]
   if sound ~= nil then
      minetest.sound_stop(sound)
      sound_handlers[p_name] = nil
   end
   --add new loop
   if climate.active_weather.sound_loop then
      sound_handlers[p_name] = minetest.sound_play(
	 climate.active_weather.sound_loop, {to_player = p_name, loop = true})
   end
end

--------------------------
-- Main step
--------------------------

local timer = 0
local timer_p = 0
local timer_r = 0

minetest.register_globalstep(function(dtime)
  local updatesound = false
  timer = timer + dtime
  timer_r = timer_r + dtime
  --update weather state
  if timer > active_weather_interval then
     --timer has expired, switch to a new weather state
     --print(" Updating weather at "..minetest.get_gametime())
     --reset timer and interval
     timer = 0
     active_weather_interval = set_active_interval()
     --save interval
     --mod_storage:set_float('active_weather_interval', active_weather_interval)
     set_world_temperature()
     select_new_active_weather()
     updatesound = true
  end
  if timer_r >= 60 then -- it's time to record changes
     record_climate_history(climate)
     store:set_string("climate_history", get_climate_history())
     timer_r = 0
  end
  timer_p = timer_p + dtime
  for _,player in ipairs(minetest.get_connected_players()) do
     local pos = player:get_pos()
     local p_name = player:get_player_name()
     local sound = sound_handlers[p_name]
     if pos.y > -12 then
	if updatesound or sound == nil then
	   update_player_sounds(p_name)
	end
	--fast weather effects for aboveground players
	if (climate.active_weather.particle_interval and
	    timer_p > climate.active_weather.particle_interval) then
	   -- do particle effects for current weather
	   climate.active_weather.particle_function(player)
	end
     elseif pos.y < -11 and sound then
	local x = 1-(-1*pos.y-12)/5
	if x < 0 then
	   minetest.sound_stop(sound)
	   sound_handlers[p_name] = nil
	else
	   minetest.sound_fade(sound, 0.5, x)
	end
     elseif pos.y > -17 and not sound then
	sound_handlers[p_name] =
	   minetest.sound_play(climate.active_weather.sound_loop,
			       {to_player = p_name, loop = true, gain = 0.1})
     end
  end

  if (climate.active_weather.particle_interval and
      timer_p > climate.active_weather.particle_interval) then
     timer_p = 0
  end

end)

--------------------------------------------------------------------
--CHAT COMMANDS


minetest.register_privilege("set_temp", {
	description = "Set the Climate active temperature",
	give_to_singleplayer = false
})


minetest.register_chatcommand("set_temp", {
  params = "<temp>",
  description = "Set the Climate active temperature",
  privs = {privs=true},
  func = function(name, param)
     local newtemp = tonumber(param)
     if not newtemp then
	return false, ("Unadjusted base temp: "..climate.active_temp)
     end
     if newtemp < -100 or newtemp > 100 then
	return false, "Invalid temperature"
     end
     if minetest.check_player_privs(name, {set_temp = true}) then
	climate.active_temp = newtemp

	--only actually needed on log out,... but that doesn't work
	store:set_float("temp", climate.active_temp)

	return true, "Climate active temperature set to: "..newtemp

     else
	return false, "You need the set_temp privilege to use this command."
     end
  end,
})



-------------

minetest.register_privilege("set_weather", {
	description = "Set the Climate active weather",
	give_to_singleplayer = false
})


minetest.register_chatcommand("set_weather", {
 params = "<weather> or help",
 description = "Set the Climate active weather",
 privs = {privs=true},
 func = function(name, param)
    if minetest.check_player_privs(name, {set_weather = true}) then
       --check valid
       if param == "help" then
	  local wlist = "Available weather states:\n"
	  for i = 1,#registered_weathers do
	     wlist = wlist..registered_weathers[i].name.."\n"
	  end
	  return false, wlist
       end

       local weather = get_weather_table(param, registered_weathers)
       if weather then
	  climate.active_weather = weather
	  --do for each player
	  for _,player in ipairs(minetest.get_connected_players()) do
	     --set sky and clouds for new state using the new active_weather

	     set_sky_clouds(player)

	     --remove old sounds
	     local p_name = player:get_player_name()
	     local sound = sound_handlers[p_name]
	     if sound ~= nil then
		minetest.sound_stop(sound)
		sound_handlers[p_name] = nil
	     end
	     --add new loop
	     if climate.active_weather.sound_loop then
		sound_handlers[p_name] = minetest.sound_play(climate.active_weather.sound_loop, {to_player = p_name, loop = true})
	     end

	  end
	  --only actually needed on log out,... but that doesn't work
	  store:set_string("weather", climate.active_weather.name)

	  return true, "Climate active weather set to: "..param
       else
	  return false, ("Current weather is "..climate.active_weather.name)
       end

    else
       return false, "You need the set_temp privilege to use this command."
    end
 end,
})

-------------

minetest.register_chatcommand("set_tempscale", {
    params = "f, c, or k",
    description = "Sets the temperature scale used for your own display",
    func = function(name, param)
       if param == "" or param == "help" then
	  local wlist = "/set_tempscale:\n"..
	  "Sets the temperature scale used for your own display.\n" ..
	  "Valid settings are f for Fahrenheit, c for Celsius, and "..
	  "k for Kelvin."
	  return false, wlist
       end
       if param ~= "f" and param ~= "c" and param ~= "k" then
	  return false, "Invalid scale. Use f, c, or k."
       end
       local player = minetest.get_player_by_name(name)
       local meta = player:get_meta()
       if param == "f" then
	  meta:set_string("TempScalePref", "Fahrenheit")
       elseif param == "k" then
	  meta:set_string("TempScalePref", "Kelvin")
       else
	  meta:set_string("TempScalePref", "Celsius")
       end
    end,
})
