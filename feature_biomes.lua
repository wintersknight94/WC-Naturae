-- LUALOCALS < ---------------------------------------------------------
local minetest
    = minetest
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
minetest.unregister_biome("unknown")
-- ================================================================== --

-- ================================================================== --
	-- Climate Extremes
	-- Used Voronoi Diagram For Better Biome Pacement
-- ================================================================== --
 -- Cold & Dry
minetest.register_biome({	-- Cold Desert
	name = "stonewaste",
	node_top = "nc_terrain:gravel",
	depth_top = 2,
	node_filler = "nc_terrain:cobble",
	depth_filler = 2,
	node_riverbed = "nc_terrain:gravel",
	depth_riverbed = 3,
	y_min = -20,
	y_max = 150,
	vertical_blend = 16,
	horizontal_blend = 16,
	heat_point = 0,
	humidity_point = 0,
})
 -- Hot & Dry
minetest.register_biome({	-- Hot Desert
	name = "dune",
	node_top = "nc_terrain:sand",
	depth_top = 5,
	node_stone = "nc_concrete:sandstone",
--		depth_filler = 12,
	node_riverbed = "nc_terrain:sand",
	depth_riverbed = 1,
	y_min = -20,
	y_max = 150,
	vertical_blend = 16,
	horizontal_blend = 16,
	heat_point = 100,
	humidity_point = 0,
})
 -- Hot & Humid
minetest.register_biome({	-- Tropical Beaches
	name = "tropic",
	node_top = "nc_terrain:sand",
	depth_top = 1,
--	node_filler = "nc_concrete:sandstone",
--	depth_filler = 3,
	node_riverbed = "nc_terrain:sand",
	depth_riverbed = 3,
	y_min = -24,
	y_max = 148,
	vertical_blend = 8,
	horizontal_blend = 16,
	heat_point = 100,
	humidity_point = 100,
})
 -- Cold & Humid
minetest.register_biome({	-- Northern Old-Growth Forests
	name = "ancient_forest",
	node_top = "nc_terrain:dirt_with_grass",
	depth_top = 1,
	node_filler = "nc_terrain:dirt",
	depth_filler = 12,
	node_riverbed = modname .. ":muck",
	depth_riverbed = 2,
	y_min = 4,
	y_max = 150,
	vertical_blend = 16,
	horizontal_blend = 16,
	heat_point = 0,
	humidity_point = 100,
})

-- ================================================================== --
	-- Placed Primary Via Heat/Humidity
	-- Used Voronoi Diagram For Better Biome Pacement
-- ================================================================== --

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
	node_riverbed = modname .. ":muck",
	depth_riverbed = 2,
	y_min = 4,
	y_max = 200,
	vertical_blend = 16,
	horizontal_blend = 16,
	heat_point = 20,
	humidity_point = 90,
})
minetest.register_biome({
	name = "rainforest",
	node_top = "nc_terrain:dirt_with_grass",
	depth_top = 1,
	node_filler = "nc_terrain:dirt",
	depth_filler = 8,
	node_riverbed = modname .. ":muck",
	depth_riverbed = 2,
	y_min = 1,
--	y_max = 200,
	vertical_blend = 16,
	horizontal_blend = 16,
	heat_point = 70,
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
	heat_point = 30,
	humidity_point = 100,
})
minetest.register_biome({	
	name = "savanna",
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
	heat_point = 100,
	humidity_point = 30,
})
minetest.register_biome({	
	name = "stoneprairie",
	node_top = "nc_terrain:dirt_with_grass",
	depth_top = 1,
	node_filler = "nc_terrain:dirt",
	depth_filler = 2,
	node_riverbed = "nc_terrain:sand",
	depth_riverbed = 4,
	y_min = 1,
	y_max = 31000,
	vertical_blend = 16,
	horizontal_blend = 16,
	heat_point = 100,
	humidity_point = 50,
})

-- ================================================================== --
	-- Highly Restricted by Elevation
-- ================================================================== --

--seabed(vanilla)
--deep(vanilla)

minetest.register_biome({	
	name = "mudflat",
	node_top = modname .. ":muck",
	depth_top = 1,
	node_filler = "nc_terrain:dirt",
	depth_filler = 2,
	node_stone = "nc_concrete:adobe",
	node_riverbed = modname.. ":muck",
	depth_riverbed = 4,
	y_min = -2,
	y_max = 8,
	vertical_blend = 4,
	horizontal_blend = 16,
	heat_point = 0,
	humidity_point = 50
})

minetest.register_biome({	
	name = "floodland",
	node_top = modname .. ":muck",
	depth_top = 1,
	node_filler = modname .. ":muck",
	depth_filler = 2,
	node_riverbed = "nc_terrain:sand",
	depth_riverbed = 4,
	y_min = -2,
	y_max = 2,
	vertical_blend = 2,
	horizontal_blend = 16,
	heat_point = 50,
	humidity_point = 100
})


