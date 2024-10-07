-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

minetest.register_craftitem(modname .. ":plant_fibers", {
		description = ("Plant Fibers"),
		inventory_image = modname .. "_plant_fibers.png",
		wield_image = modname .. "_plant_fibers.png",
		groups = {snappy = 1, flammable = 1},
		sounds = nodecore.sounds("nc_terrain_swishy"),
	})

