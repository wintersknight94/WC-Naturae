-- LUALOCALS < ---------------------------------------------------------
local include, minetest
    = include, minetest
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local floraswap = include("lib_floraswap")

floraswap(modname .. ":flower_red", "nc_flora:flower_1_2")
floraswap(modname .. ":flower_yellow", "nc_flora:flower_2_3")
floraswap(modname .. ":flower_white", "nc_flora:flower_3_4")
floraswap(modname .. ":flower_blue", "nc_flora:flower_4_5")
floraswap(modname .. ":flower_violet", "nc_flora:flower_5_6")
