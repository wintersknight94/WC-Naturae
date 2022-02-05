-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local twig = "nc_tree_tree_side.png^[mask:" ..modname.. "_stem_mask.png"
------------------------------------------------------------------------
minetest.register_node(modname .. ":deadtwig", {
		description = "Dry Twigs",
		drawtype = 'plantlike',
		tiles = {twig},
		inventory_image = twig,
		wield_image = twig,
		sunlight_propagates = true,
		paramtype = 'light',
		walkable = false,
		groups = {
			snappy = 1,
			flammable = 2,
			attached_node = 1
		},
		sounds = nodecore.sounds("nc_tree_sticky"),
		selection_box = {
			type = "fixed",
			fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16},
		},
		drop = "nc_tree:stick"
	})
------------------------------------------------------------------------
minetest.register_decoration({
		label = {modname .. ":deadtwig"},
		deco_type = "simple",
		place_on = {"group:soil", "group:sand", "group:gravel"},
		sidelen = 16,
		fill_ratio = 0.01,
		biomes = {"dune", "stonewaste", "ancient_forest"},
		y_max = 2000,
		y_min = -100,
		decoration = {modname .. ":deadtwig"},
	})
