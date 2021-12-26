-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local floraswap = include("lib_floraswap")

floraswap(modname .. ":plant_fibers",		"nc_flora:sedge_1")
floraswap(":nc_nature:plant_fibers",		"nc_flora:sedge_1")

floraswap(":nc_nature:fern",				modname .. ":fern")
floraswap(":nc_nature:reeds",				modname .. ":reeds")
floraswap(":nc_nature:shrub",				modname .. ":shrub")
floraswap(":nc_nature:shrub_loose",		modname .. ":shrub_loose")
floraswap(":nc_nature:thornbriar",			modname .. ":thornbriar")
floraswap(":nc_nature:starflower",			modname .. ":starflower")
floraswap(":nc_nature:bamboo_living",		modname .. ":bamboo_living")
floraswap(":nc_nature:bamboo_pole",		modname .. ":bamboo_pole")
floraswap(":nc_nature:mushroom",			modname .. ":mushroom")
floraswap(":nc_nature:mushroom_glow",		modname .. ":mushroom_glow")
floraswap(":nc_nature:mushroom_lux",		modname .. ":mushroom_lux")
floraswap(":nc_nature:thatch",			modname .. ":thatch")
floraswap(":nc_nature:lilypad",			modname .. ":lilypad")

