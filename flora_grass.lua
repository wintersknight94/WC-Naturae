-- LUALOCALS < ---------------------------------------------------------
local include, minetest
    = include, minetest
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local floraswap = include("lib_floraswap")
for i = 1, 5 do
	floraswap(modname .. ":grass_" .. i, "nc_flora:sedge_" .. i)
end

local function register_extra_grass(offset, scale, length)
	minetest.register_decoration({
			label = {"nc_flora:sedge_" .. length},
			deco_type = "simple",
			place_on = {"nc_terrain:dirt_with_grass"},
			sidelen = 16,
			noise_params = {
				offset = offset,
				scale = scale,
				spread = {x = 200, y = 200, z = 200},
				seed = 329,
				octaves = 3,
				persist = 0.4
			},
			y_max = 31000,
			y_min = 1,
			decoration = {modname .. ":grass_" .. length},
			param2 = 2
		})
end
register_extra_grass(-0.03, 0.09, 5)
register_extra_grass(-0.015, 0.075, 4)
register_extra_grass(0, 0.06, 3)
register_extra_grass(0.015, 0.045, 2)
register_extra_grass(0.03, 0.03, 1)
