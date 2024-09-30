-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local floraswap = include("lib_floraswap")

floraswap(modname .. ":plant_fibers",		"nc_flora:rush_dry")	

minetest.register_alias("nc_nature:plant_fibers",					"nc_flora:rush_dry")
minetest.register_alias("nc_nature:fern",						modname .. ":fern")
minetest.register_alias("nc_nature:reeds",						modname .. ":reeds")
minetest.register_alias("nc_nature:shrub",						modname .. ":shrub")
minetest.register_alias("nc_nature:shrub_loose",					modname .. ":shrub_loose")
minetest.register_alias("nc_nature:thornbriar",					modname .. ":thornbriar")
minetest.register_alias("nc_nature:starflower",					modname .. ":starflower")
minetest.register_alias("nc_nature:bamboo_living",				modname .. ":bamboo_living_2")
minetest.register_alias("nc_nature:bamboo_pole",					modname .. ":bamboo_dead_2")
minetest.register_alias(modname.. ":bamboo_pole",					modname .. ":bamboo_dead_2")
minetest.register_alias("nc_nature:mushroom",					modname .. ":mushroom")
minetest.register_alias("nc_nature:mushroom_glow",				modname .. ":mushroom_glow")
minetest.register_alias("nc_nature:mushroom_lux",					modname .. ":mushroom_lux")
minetest.register_alias("nc_nature:thatch",						modname .. ":thatch")
minetest.register_alias("nc_nature:lilypad",						modname .. ":lilypad")
minetest.register_alias("nc_nature:grass_1",						modname .. ":grass_1")
minetest.register_alias("nc_nature:grass_2",						modname .. ":grass_2")
minetest.register_alias("nc_nature:grass_3",						modname .. ":grass_3")
minetest.register_alias("nc_nature:grass_4",						modname .. ":grass_4")
minetest.register_alias("nc_nature:grass_5",						modname .. ":grass_5")
minetest.register_alias("nc_nature:mossy_stone",					modname .. ":mossy_stone")
minetest.register_alias("nc_nature:mossy_dirt",					modname .. ":mossy_dirt")
minetest.register_alias("nc_nature:mossy_thatch",					modname .. ":mossy_thatch")
minetest.register_alias("nc_nature:mossy_cobble",					modname .. ":mossy_cobble")
minetest.register_alias("nc_nature:mossy_log",					modname .. ":mossy_log")
minetest.register_alias("nc_nature:mossy_trunk",					modname .. ":mossy_trunk")
minetest.register_alias("nc_nature:mossy_bricks",					modname .. ":mossy_bricks")
minetest.register_alias("nc_nature:mossy_bricks_bonded",			modname .. ":mossy_bricks_bonded")
minetest.register_alias("nc_nature:mossy_adobe",					modname .. ":mossy_adobe")
minetest.register_alias("nc_nature:mossy_adobe_bricks",			modname .. ":mossy_adobe_bricks")
minetest.register_alias("nc_nature:mossy_adobe_bricks_bonded",		modname .. ":mossy_adobe_bricks_bonded")
minetest.register_alias("nc_nature:mossy_sandstone",				modname .. ":mossy_sandstone")
minetest.register_alias("nc_nature:mossy_sandstone_bricks",			modname .. ":mossy_sandstone_bricks")
minetest.register_alias("nc_nature:mossy_sandstone_bricks_bonded",	modname .. ":mossy_sandstone_bricks_bonded")

minetest.register_alias("nc_pebbles:pebble",						modname.. ":pebble")
minetest.register_alias("nc_pebbles:shell",						modname.. ":shell")
minetest.register_alias("nc_pebbles:pearl",						modname.. ":pearl")
minetest.register_alias("nc_pebbles:shard",						modname.. ":shard")
minetest.register_alias("nc_pebbles:adze_glass",					modname.. ":adze_glass")
minetest.register_alias("nc_pebbles:adze_shell",					modname.. ":adze_shell")

if not minetest.settings:get_bool(modname .. ".frost", true) then
	minetest.register_alias(modname.. ":ice",						"nc_terrain:water_source")
	minetest.register_alias(modname.. ":dirt_with_ice",				"nc_terrain:dirt")
	minetest.register_alias(modname.. ":grass_with_frost",			"nc_terrain:dirt_with_grass")
end

if not minetest.settings:get_bool(modname .. ".ivy", true) then
	minetest.register_alias(modname.. ":ivy",						modname.. ":fern")
end