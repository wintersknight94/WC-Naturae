-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

minetest.register_node(modname .. ":shrub", {
		description = ("Shrub"),
		drawtype = "allfaces_optional",
		waving = 1,
		tiles = {modname .. "_shrub.png"},
		paramtype = "light",
		air_pass = true,
		sunlight_propagates = true,
		walkable = true,
		silktouch = false,
		groups = {
			snappy = 1,
			flora = 1,
			flammable = 3,
			green = 1,
			leafy = 1,
			shrub = 1,
			[modname .. "_spread"] = 1
		},
		alternate_loose = {
			tiles = {modname .. "_shrub.png^nc_api_loose.png"},
			walkable = false,
			groups = {
				snappy = 1,
				leafy = 1,
				flammable = 1,
				falling_repose = 1,
				green = 1,
				stack_as_node = 1,
				shrub = 1,
				decay_to_fibers = 1,
				[modname .. "_spread"] = 0
			}
		},
		no_repack = true,
		sounds = nodecore.sounds("nc_terrain_swishy")

	})

minetest.register_decoration({
		label = {modname .. ":shrub"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.01,
		biomes = {"unknown", "grassland", "forest", "thicket"},
		y_max = 200,
		y_min = -20,
		decoration = {modname .. ":shrub"},
	})

minetest.register_abm({
		label = "Shrub Rerooting",
		nodenames = {modname .. ":shrub_loose"},
		neighbors = {"group:soil"},
		interval = 2,
		chance = 10,
		action = function(pos)
			nodecore.set_loud(pos, {name = modname .. ":shrub"})
		end
	})

nodecore.register_craft({
		label = "break shrub into sticks",
		action = "pummel",
		duration = 3,
		toolgroups = {thumpy = 1},
		nodes = {
			{match = modname .. ":shrub_loose", replace = "air"}
		},
		items = {
			{name = "nc_tree:stick", count = 4, scatter = 3}
		},
		itemscatter = 3
	})

nodecore.register_craft({
		label = "compress peat from shrubs",
		action = "pummel",
		toolgroups = {crumbly = 2},
		indexkeys = {modname .. ":shrub_loose"},
		nodes = {
			{
				match = {name = modname .. ":shrub_loose", count = 8},
				replace = "nc_tree:peat"
			}
		}
	})

