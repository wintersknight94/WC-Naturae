-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()

-----=====-----

minetest.register_node(modname .. ":shell", {
		description = "Shell",
		drawtype = "nodebox",
		tiles = {"(nc_optics_glass_frost.png^[colorize:pink:200)^nc_sponge_living.png"},
		inventory_image = "nc_stonework_stone.png^[colorize:pink:100",
		wield_image = "[combine:16x16:0,2=nc_stonework_stone.png^[colorize:pink:100",
		wield_scale = {x = 1.25, y = 1.25, z = 1.75},
		color = pink,
		paramtype = "light",
		node_box = {
		type = "fixed",
--			fixed = {
--				{-0.125, -0.5, -0.1875, 0.125, -0.4375, 0.1875}, -- Basic Pebble
--				{-0.1875, -0.5, -0.125, 0.1875, -0.4375, 0.125},
--			},
--			fixed = {
--				{-0.1875, -0.5, -0.25, 0.25, -0.4375, 0.125}, -- Awkward Curved Shell
--				{0, -0.5, -0.25, 0.25, -0.375, 0.1875},
--				{0.0625, -0.5, -0.0625, 0.1875, -0.375, 0.3125},
--				{-0.125, -0.5, -0.1875, 0.1875, -0.375, 0.0625},
--			},
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875}, -- More Realistic Shell
			{-0.125, -0.5, -0.25, 0.125, -0.4375, 0.1875},
			{-0.25, -0.5, -0.125, 0.25, -0.4375, 0.1875},
			{-0.125, -0.4375, -0.0625, 0.125, -0.375, 0.25},
		}
		},
		sunlight_propagates = true,
		walkable = false,
		groups = {
			snappy = 1,
			pebble = 1,
			falling_node = 1
		},
		sounds = nodecore.sounds("nc_optics_glassy"),
		selection_box = nodecore.fixedbox({-3/8, -1/2, -3/8, 3/8, 1/4, 3/8}),
		drop = modname .. ":shell",
		paramtype2 = "facedir",
		on_place = minetest.rotate_node
	})

--register_shells(	"Pretty Pink",		pink)
--register_shells(	"Sea-Weathered",	teal)
--register_shells(	"Beautiful",		seashell)
--register_shells(	"Wonder",			azure)

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"nc_terrain:sand"},
	sidelen = 4,
	fill_ratio = 0.005,
	y_max = 100,
	y_min = -31000,
	flags = "all_floors",
	decoration = modname ..":shell",
	rotation = "random",
})


