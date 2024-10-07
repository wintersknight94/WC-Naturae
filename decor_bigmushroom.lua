-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()



minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"group:soil", "group:mud"},
		sidelen = 16,
		fill_ratio = 0.00002,
		biomes = {"mudflat", "floodland", "rainforest", "old_forest", "ancient_forest"},
		y_min = -31000,
		y_max = 32,
		schematic = nodecore.bigmushroom_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {},
		place_offset_y = -1
	})

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"group:soil", "group:mud"},
		sidelen = 16,
		fill_ratio = 0.00002,
		biomes = {"mudflat", "floodland", "rainforest", "old_forest", "ancient_forest"},
		y_min = -64,
		y_max = 64,
		schematic = nodecore.bigmushroom_honey_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {},
		place_offset_y = -1
	})