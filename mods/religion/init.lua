-- religion/init.lua

-- Minetest mod: religion
-- See README.txt for licensing and other information.

dofile(minetest.get_modpath("zero_loader").."/init.lua")

zero_load('religion',{"common", "nodes", "crafts"})

-- time in seconds before getting a responce from god, random
pray_time = math.random(2, 5)

-- the higher the weight, higher is the probability of getting it 
-- blessing idicates the percentage of the total restored
pray_responses = {
  {weight=200, message="and nothing happens", blessing=0},
  {weight=20, message="a voice inside you tells you that god is dead, but you decide to ignore it", blessing=0},
  {weight=20, message="you feel how your faith is strengthened", blessing=5},
  {weight=25, message="you feel a cool breeze and a sense of calmness wash over you", blessing=10},
  {weight=15, message="you see a shooting star in the sky and make a wish", blessing=20},
  {weight=15, message="you see a dark cloud passing over you, and it feels like a bad omen", blessing=-15},
  {weight=10, message="and you feel refreshed", blessing=20},
  {weight=10, message="something inside you tells you that this is not working", blessing=-1},
  {weight=10, message="and you feel a soft breeze that comforts you", blessing=20},
  {weight=10, message="your hearth is full of joy and you fill in you the blessings from your god" , blessing=50},
  {weight=10, message="and you hear a mocking laughter in your mind", blessing=-10},
  {weight=5, message="you feel that the Force is with", blessing=60},
  {weight=5, message="and you start to doubt your faith", blessing=-5},
  {weight=5, message="you sense a feeling of emptiness and despair wash over you", blessing=-35},
  {weight=1, message="you hear a voice saying: You are not worthy of my attention", blessing=-50},
}

-- reset prayers counter on respawn
minetest.register_on_respawnplayer(function(player)
  local meta = player:get_meta()
  meta:set_int("total_prayers", 0)
  meta:set_int("last_prayer", 0)
end)