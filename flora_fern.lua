-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local fern = "(nc_flora_flower_color.png^[colorize:darkolivegreen:200)^(nc_terrain_grass_top.png^[mask:nc_lode_mask_molten.png)"
local ferntile = fern.. "^[mask:" ..modname.. "_fern_mask.png"
------------------------------------------------------------------------
minetest.register_node(modname .. ":fern", {
		description = "Fern",
		drawtype = 'plantlike',
		waving = 1,
		tiles = {ferntile},
		inventory_image = ferntile,
		wield_image = ferntile,
		sunlight_propagates = true,
		paramtype = 'light',
		paramtype2 = "meshoptions",
		place_param2 = 10,
		walkable = false,
		groups = {
			snappy = 1,
			flora = 1,
			flammable = 2,
			attached_node = 1,
			peat_grindable_item = 1,
			[modname .. "_spread"] = 1
		},
		sounds = nodecore.sounds("nc_terrain_swishy"),
		selection_box = {
			type = "fixed",
			fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16},
		}
	})
------------------------------------------------------------------------
minetest.register_decoration({
		label = {modname .. ":fern"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.1,
		biomes = {"forest", "old_forest", "ancient_forest", "rainforest"},
		y_max = 2000,
		y_min = -20,
		decoration = {modname .. ":fern"},
		param2 = 10
	})
