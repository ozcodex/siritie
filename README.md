# Siritie

Siritie is a challenging survival game that will put your skills to the test as
you fight to survive in a harsh and mystical world. Created by Ozcodex, Siritie
is a derivation of the original game _Exile v0.3.9e_ by Dokimi, with
contributions from Mantar. The game is designed for `Minetest 5.3+` and offers
an immersive and exciting gameplay experience.

## Installation

To get started with Siritie, simply clone the repository into your
`minetest/games` folder and you're good to go!

## Gameplay

In Siritie, you'll find yourself in a wilderness survival scenario with limited resources, simple technology, and dynamic weather conditions. You'll need to rely on your wits to find food, water, and shelter, while exploring the mysterious world and developing your skills to endure your exile. You'll need to be careful, however, as the world is full of dangers, and one wrong move could spell the end of your adventure.

### Features

*Player physical conditions* - Battle against the elements, the hunger and 
various illnesses, including hypothermia, exhaustion, and disease, as you strive
to survive.
*Dynamic living world* - Immerse yourself in a world with ever-changing seasonal
weather patterns, erosion, and water flows through soil, adding to the realism
and challenge.
*Realistic building materials* - Build your own shelter from the rain, create
kilns and smelters, and use realistic and sustainable materials to craft your
tools and equipment.
*Authentic crafting* - Gather natural resources and materials to create tools,
clothing, and food that are crucial for your survival, making your experience
more immersive.
*A Hint of Mysticism* -  Explore the mystical realm of alchemy, and seek
blessings by offering prayers to the gods. It's uncertain whether these gods
truly exist, or if the magical elements even hold any real power.
*Unique Characters* - Each character in Siritie is unique, born with a
backstory, name, and land of origin, with distinctive characteristics that shape
their journey through the game.

### Tips and Tricks

As you explore and survive in Siritie, you will discover that there are many different strategies that may work, and part of the fun is figuring out what does, and catastrophically does not, work. Here are some early advices you might pass through to ensure your survival:

The first step is to find a comfortable shelter that will help regulate your body temperature and protect you from hypothermia or heat stroke.

Once you have a shelter, it's important to conserve your energy by doing tasks such as crafting, organizing, and planning while you rest. Extreme weather can sap your energy quickly, so avoid walking around in snowstorms or other dangerous weather.

If you're in a situation where you need to build a shelter, it's essential to have a fireplace or plenty of torches to regulate temperature. Consider going underground in caves that are deep enough to be safe from the weather. Collect water in pots from cave drips or rainwater, and seek out plants and food that quench your thirst. As a last resort, you can try to melt ice or dig a pit in wet ground and wait for water to flow into it.

To sustain yourself, you can catch animals with clubs and explore farming for a sustainable food source. Simple grass clothing can be woven quickly and can be a lifesaver, while better clothes can be made by soaking bundles of the right kind of plants. Keep an eye on "health effects," as you may have eaten something bad or have a terrible disease. Some plants have useful medicinal effects, but be careful not to overdose.

Fibrous plants, sticks and stones are fine as initial tools, but woodcutting requires better tools for harder woods. Build stairs and shelters around your base to save energy and protect you from extremes. Use sticks to build a ladder or pole to shimmy up, to get to high places or descend carefully.

Not every step in crafting can be done at a work station, so consider the environment and industry you need to create to advance. Build ovens, kilns, and furnaces just as you would in real life, and start a fire with access to air and a sealed chamber that gets heated up. Blocks are hotter than slabs, and charcoal is hotter than wood. Fires can be temporarily extinguished by punching while holding sediment, and charcoal can be made by creating a wood fire sealed up to limit airflow.

If you're looking to make green or clear glass, sand and wood-ash can be made into green glass, but clear glass requires the ash to be soaked, dried, and roasted. Glass can be melted onto iron trays to make panes for real windows! Iron smelting is hard and requires plenty of charcoal and a space below the iron mixture for slag to drain out.

Overall, surviving in extreme weather conditions is all about being prepared and knowing what to do. With the right knowledge, anyone can make it through even the toughest situations.

## World Settings

Valleys is the standard `mapgen` for _Siritie_. `Carpathian` is also supported,
for a somewhat more difficult and slower-paced game.

## Settings for Multiplayer
The variable `time_speed` defaults to `72`, and at this rate a player who logs
on at 8:00 AM every day will get a change in season every 2.5 days.

Changing speed to `60` will make days last 24 minutes and a new season every 
real-world day, but he will see the seasons in reverse. At `time_speed` of `96`,
days last only 15 minutes, but the player might see spring (year 1) on day 1,
summer (year 2) on day 2, etc.

Set `exile_hud_update` to `1.0` second for multiplayer servers on the Internet;
a LAN server can probably handle `0.2` seconds.

## Mods for Multiplayer
- [Wield3d](https://github.com/stujones11/wield3d) is recommended.

## Development
_Siritie_ is open-source software - that means the game is as good as you choose
to make it. It also means development can be erratic and haphazard at times, so be patient!

_Siritie_ is currently in “Alpha,” therefore you can expect that there may be bugs, missing features, performance issues, and perhaps compatibility-breaking updates.
Despite this, _Siritie_ does have enough features to be a playable game and should be stable and mostly bug-free.

## Credits
I would like to express our heartfelt gratitude to Dokimi for creating the original game Exile, which served as the foundation for Siritie's development. Also, thanks to Mantar for updating and contributing to the original game, which has indirectly contributed to the development of Siritie. 

Gratitude is due to all those whose mods have been adapted for use in _Siritie_ (see `./mod/` folders for details).

Thanks also to all who have given feedback, fixes, etc. 

## License

Copyright (C) 2019-2023 Dokimi, Mantar and OzCodex

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.