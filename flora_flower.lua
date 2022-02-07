-- LUALOCALS < ---------------------------------------------------------
local include, minetest
    = include, minetest
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local floraswap = include("lib_floraswap")
------------------------------------------------------------------------
floraswap(modname .. ":flower_red", "nc_flora:flower_1_2")
floraswap(modname .. ":flower_yellow", "nc_flora:flower_2_3")
floraswap(modname .. ":flower_white", "nc_flora:flower_3_4")
floraswap(modname .. ":flower_blue", "nc_flora:flower_4_5")
floraswap(modname .. ":flower_violet", "nc_flora:flower_5_6")
------------------------------------------------------------------------
for p = 1, 5 do
for c = 1, 9 do
	minetest.register_decoration({
		label = {"rainforest flowers"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.0001,
		biomes = {"rainforest"},
		y_max = 75,
		y_min = -10,
		decoration = {"nc_flora:flower_" ..p.. "_" ..c},
	})
end
end
