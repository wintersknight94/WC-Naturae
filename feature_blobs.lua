-- LUALOCALS < ---------------------------------------------------------
local minetest
    = minetest
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

-- ================================================================== --
	
minetest.register_ore({
		ore_type = "blob",
		ore  = modname.. ":muck",
		wherein = {"nc_terrain:dirt_with_grass", "nc_terrain:dirt", "nc_terrain:sand", "nc_terrain:gravel"},
		biomes = {"thicket", "floodland", "seabed"},
		clust_scarcity = 16 * 16 * 16,
		clust_num_ores = 12,
		clust_size = 12,
		y_max = 8,
		y_min = -32,
		noise_threshold = 0.0,
		noise_params = {
			offset = 0.5,
			scale = 0.2,
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
		biomes = {"old_forest", "ancient_forest", "thicket"},
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


