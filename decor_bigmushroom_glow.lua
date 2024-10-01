-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"group:soil", "group:humus"},
		sidelen = 16,
		fill_ratio = 0.00001,
		biomes = {"mudflat", "floodland", "rainforest", "old_forest", "ancient_forest"},
		y_min = -31000,
		y_max = 32,
		schematic = nodecore.bigmushroom_glow_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {},
		place_offset_y = -1
	})
minetest.register_decoration({
		deco_type = "schematic", 
		place_on = {"group:soil", "group:humus", "group:gravel", "group:sand", "group:stone"},
		sidelen = 16,
		fill_ratio = 0.0002,
		y_min = -2000,
		y_max = -512,
		schematic = nodecore.bigmushroom_glow_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {},
		place_offset_y = -1
	})
