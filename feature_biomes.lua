-- LUALOCALS < ---------------------------------------------------------
local minetest
    = minetest
-- LUALOCALS > ---------------------------------------------------------

minetest.register_biome({
		name = "grassland",
		node_top = "nc_terrain:dirt_with_grass",
		depth_top = 1,
		node_filler = "nc_terrain:dirt",
		depth_filler = 2,
		node_riverbed = "nc_terrain:sand",
		depth_riverbed = 1,
		y_min = 1,
		y_max = 31000,
		vertical_blend = 16,
		horizontal_blend = 16,
		heat_point = 50,
		humidity_point = 50,
	})

minetest.register_biome({
		name = "floodland",
		node_top = "nc_terrain:dirt",
		depth_top = 1,
		node_filler = "nc_terrain:dirt",
		depth_filler = 2,
		node_riverbed = "nc_terrain:sand",
		depth_riverbed = 4,
		y_min = 0,
		y_max = 2,
		vertical_blend = 2,
		horizontal_blend = 16,
		heat_point = 50,
		humidity_point = 100,
	})

minetest.register_biome({
		name = "thicket",
		node_top = "nc_terrain:dirt_with_grass",
		depth_top = 1,
		node_filler = "nc_terrain:dirt",
		depth_filler = 2,
		node_riverbed = "nc_terrain:sand",
		depth_riverbed = 2,
		y_min = 2,
		y_max = 48,
		vertical_blend = 4,
		horizontal_blend = 16,
		heat_point = 100,
		humidity_point = 100,
	})

minetest.register_biome({
		name = "forest",
		node_top = "nc_terrain:dirt_with_grass",
		depth_top = 1,
		node_filler = "nc_terrain:dirt",
		depth_filler = 4,
		node_riverbed = "nc_terrain:sand",
		depth_riverbed = 2,
		y_min = 2,
		y_max = 250,
		vertical_blend = 16,
		horizontal_blend = 16,
		heat_point = 40,
		humidity_point = 80,
	})

minetest.register_biome({
		name = "old_forest",
		node_top = "nc_terrain:dirt_with_grass",
		depth_top = 1,
		node_filler = "nc_terrain:dirt",
		depth_filler = 8,
		node_riverbed = "nc_terrain:gravel",
		depth_riverbed = 2,
		y_min = 4,
		y_max = 200,
		vertical_blend = 16,
		horizontal_blend = 16,
		heat_point = 20,
		humidity_point = 80,
	})

minetest.register_biome({
		name = "ancient_forest",
		node_top = "nc_terrain:dirt_with_grass",
		depth_top = 1,
		node_filler = "nc_terrain:dirt",
		depth_filler = 12,
		node_riverbed = "nc_terrain:gravel",
		depth_riverbed = 2,
		y_min = 6,
		y_max = 150,
		vertical_blend = 16,
		horizontal_blend = 16,
		heat_point = 0,
		humidity_point = 80,
	})
