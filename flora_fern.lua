-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

minetest.register_node(modname .. ":fern", {
		description = "Fern",
		drawtype = 'plantlike',
		waving = 1,
		tiles = {modname .. "_fern.png"},
		inventory_image = modname .. "_fern.png",
		wield_image = modname .. "_fern.png",
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		groups = {
			snappy = 1,
			flora = 1,
			flammable = 2,
			attached_node = 1,
--			decay_to_fibers = 1,
			[modname .. "_spread"] = 1
		},
		sounds = nodecore.sounds("nc_terrain_swishy"),
		selection_box = {
			type = "fixed",
			fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16},
		}
	})

minetest.register_decoration({
		label = {modname .. ":fern"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.1,
		biomes = {"forest", "old_forest", "ancient_forest"},
		y_max = 2000,
		y_min = -20,
		decoration = {modname .. ":fern"},
	})
