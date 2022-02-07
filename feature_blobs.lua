-- LUALOCALS < ---------------------------------------------------------
local minetest
    = minetest
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

-- ================================================================== --
	
minetest.register_ore({
		ore_type = "blob",
		ore  = modname.. ":muck",
		wherein = {"group:soil", "group:sand", "group:gravel"},
		biomes = {"thicket", "floodland", "seabed", "rainforest", "ancient_forest"},
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 12,
		clust_size = 12,
		y_max = 8,
		y_min = -32,
		noise_threshold = 0.0,
		noise_params = {
			offset = 0.5,
			scale = 0.24,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})


minetest.register_ore({
		ore_type = "blob",
		ore  = modname.. ":mycelium",
		wherein = {"group:soil"},
		biomes = {"old_forest", "ancient_forest", "thicket", "mudflat", "rainforest"},
		clust_scarcity = 32 * 32 * 32,
		clust_num_ores = 3,
		clust_size = 7,
		y_max = 50,
		y_min = -50,
		noise_threshold = 0.0,
		noise_params = {
			offset = 0.5,
			scale = 0.25,
			spread = {x = 7, y = 7, z = 7},
			seed = -420,
			octaves = 1,
			persist = 0.0
		},
	})

minetest.register_ore({
		ore_type = "blob",
		ore  = "nc_terrain:gravel",
		wherein = {"group:soil", "group:sand", "group:gravel", "group:stone"},
		biomes = {"stonewaste", "stoneprairie"},
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 8,
		clust_size = 24,
		y_max = 100,
		y_min = -100,
		noise_threshold = 0.1,
		noise_params = {
			offset = 0.42,
			scale = 0.45,
			spread = {x = 32, y = 32, z = 32},
			seed = -221,
			octaves = 1,
			persist = 0.0
		},
	})

minetest.register_ore({
		ore_type = "blob",
		ore  = "nc_terrain:sand",
		wherein = {"group:soil", "group:sand", "group:gravel"},
		biomes = {"floodland", "seabed", "stoneprairie"},
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 8,
		clust_size = 12,
		y_max = 100,
		y_min = -100,
		noise_threshold = 0.25,
		noise_params = {
			offset = 0.71,
			scale = 0.25,
			spread = {x = 24, y = 24, z = 24},
			seed = 968,
			octaves = 1,
			persist = 0.0
		},
	})

minetest.register_ore({
		ore_type = "blob",
		ore  = "nc_concrete:sandstone",
		wherein = {"group:soil", "group:sand", "group:gravel"},
		biomes = {"seabed", "stoneprairie"},
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 3,
		clust_size = 9,
		y_max = 100,
		y_min = -100,
		noise_threshold = 0.1,
		noise_params = {
			offset = 0.36,
			scale = 0.22,
			spread = {x = 8, y = 8, z = 8},
			seed = -420,
			octaves = 1,
			persist = 0.0
		},
	})

minetest.register_ore({
		ore_type = "blob",
		ore  = "nc_tree:humus",
		wherein = {"group:soil"},
		biomes = {"rainforest", "ancient_forest"},
		clust_scarcity = 32 * 32 * 32,
		clust_num_ores = 8,
		clust_size = 16,
		y_max = 50,
		y_min = -50,
		noise_threshold = 0.01,
		noise_params = {
			offset = 0.4,
			scale = 0.21,
			spread = {x = 7, y = 7, z = 7},
			seed = 171,
			octaves = 1,
			persist = 0.0
		},
	})
	
minetest.register_ore({
		ore_type = "blob",
		ore  = modname.. ":mossy_dirt",
		wherein = {"group:soil"},
		biomes = {"rainforest", "ancient_forest"},
		clust_scarcity = 32 * 32 * 32,
		clust_num_ores = 12,
		clust_size = 12,
		y_max = 50,
		y_min = -50,
		noise_threshold = 0.01,
		noise_params = {
			offset = 0.37,
			scale = 0.24,
			spread = {x = 9, y = 11, z = 9},
			seed = 68,
			octaves = 1,
			persist = 0.0
		},
	})
	

