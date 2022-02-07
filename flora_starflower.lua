-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()
local starflower = "(nc_flora_flower_color.png^[mask:" ..modname.. "_starstem_mask.png)^" ..modname.. "_starflower.png"

minetest.register_node(modname .. ":starflower", {
		description = "Pinnacle Flower",
		drawtype = 'plantlike',
		waving = 1,
		tiles = {starflower},
		wield_image = starflower,
		inventory_image = starflower,
		sunlight_propagates = true,
		paramtype = 'light',
		paramtype2 = "meshoptions",
		place_param2 = 10,
		light_source = 7,
		walkable = false,
		groups = {
			snappy = 1,
			flora = 1,
			flammable = 1,
			attached_node = 1,
--			decay_to_fibers = 1,
			[modname .. "_spread"] = 1
		},
		sounds = nodecore.sounds("nc_terrain_swishy"),
		selection_box = {
			type = "fixed",
			fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16},
		},
	})

minetest.register_decoration({
		label = {modname .. ":starflower"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.02,
		noise_params = {
			offset = -0.001 + 0.005 * 0.0005,
			scale = 0.001,
			spread = {x = 100, y = 100, z = 100},
			seed = 1572,
			octaves = 3,
			persist = 0.7
		},
		y_max = 31000,
		y_min = 100,
		decoration = {modname .. ":starflower"},
		param2 = 10
	})

minetest.register_decoration({
		label = {modname .. ":starflower"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.02,
		noise_params = {
			offset = -0.001 + 0.005 * 0.005,
			scale = 0.001,
			spread = {x = 100, y = 100, z = 100},
			seed = 1572,
			octaves = 3,
			persist = 0.7
		},
		y_max = 31000,
		y_min = 200,
		decoration = {modname .. ":starflower"},
		param2 = 10
	})
minetest.register_decoration({
		label = {modname .. ":starflower"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.001,
		y_max = 31000,
		y_min = 50,
		decoration = {modname .. ":starflower"},
		biomes = {"rainforest"},
		param2 = 10
	})
