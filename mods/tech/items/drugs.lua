------------
--Herbal medicine
-- removes energy cost of plants healing effects
--can heal certain health effects
--a restorative anti-bacterial/anti-parasitic
minetest.register_craftitem("tech:herbal_medicine", {
	description = S("Herbal Medicine"),
	inventory_image = "tech_herbal_medicine.png",
	stack_max = minimal.stack_max_medium *2,
	groups = {flammable = 1},

  on_use = function(itemstack, user, pointed_thing)
    local meta = user:get_meta()
    local effects_list = meta:get_string("effects_list")
    effects_list = minetest.deserialize(effects_list) or {}

    --remove parasites
    if math.random()<0.33 then
  		HEALTH.remove_new_effect(user, {"Intestinal Parasites"})
  	end

    --cure/reduce food poisoning and infections
    --see how effective the dose is
    local cfp = math.random()
    if cfp <0.25 then
      --cure up to severe
      HEALTH.remove_new_effect(user, {"Food Poisoning", 3})
			HEALTH.remove_new_effect(user, {"Fungal Infection", 3})
			HEALTH.remove_new_effect(user, {"Dust Fever", 3})
    elseif cfp < 0.5 then
      --cure up to moderate
      HEALTH.remove_new_effect(user, {"Food Poisoning", 2})
			HEALTH.remove_new_effect(user, {"Fungal Infection", 2})
			HEALTH.remove_new_effect(user, {"Dust Fever", 2})
    elseif cfp < 0.75 then
      --only cure mild
      HEALTH.remove_new_effect(user, {"Food Poisoning", 1})
			HEALTH.remove_new_effect(user, {"Fungal Infection", 1})
			HEALTH.remove_new_effect(user, {"Dust Fever", 1})
    end


    --hp_change, thirst_change, hunger_change, energy_change, temp_change, replace_with_item
    return HEALTH.use_item(itemstack, user, 5, 0, 0, 0, 0)
  end,
})

------------
--Detox?
--for toxins, alcohol, drugs
-- e.g. charcoal? - doesn't work for everything, can itself cause vomiting etc

--[[
How toxins get treated:
Alcohol: wait for it to pass (while helping them not die), pump stomach
Stimulant OD: sedation, wait for it to pass (while helping them not die)
Specific toxins can have anti-toxins (a fairly modern treatment)
]]


------------
--Tiku
-- stimulant drug
-- gets you high
minetest.register_craftitem("tech:tiku", {
  description = S("Tiku (stimulant)"),
  inventory_image = "tech_tiku.png",
  stack_max = minimal.stack_max_medium *2,
  groups = {flammable = 1},

  on_use = function(itemstack, user, pointed_thing)

    --begin the bender
    HEALTH.add_new_effect(user, {S("Tiku High"), 1})

    --hp_change, thirst_change, hunger_change, energy_change, temp_change, replace_with_item
    return HEALTH.use_item(itemstack, user, 0, 0, -24, 96, 0)
  end,
})



