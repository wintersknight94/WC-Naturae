-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local umbrella = modname.. "_umbrella.png"
local fern = "(nc_flora_sedge_color.png^[colorize:darkolivegreen:200)^(nc_terrain_grass_top.png^[mask:nc_lode_mask_molten.png)"
local ferntile = fern.. "^[mask:" ..modname.. "_fern_mask.png"
------------------------------------------------------------------------
minetest.register_node(modname .. ":umbrella", {
		description = "Umbrella Plant",
		drawtype = 'plantlike',
		waving = 1,
		tiles = {umbrella},
		visual_scale = 2.5,
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
			weavable = 1,
			flammable = 2,
			attached_node = 1,
			stack_as_node = 1,
			peat_grindable_item = 1,
			[modname .. "_spread"] = 1
		},
		sounds = nodecore.sounds("nc_terrain_swishy"),
		selection_box = {
			type = "fixed",
			fixed = { {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5}, },
		}
	})
------------------------------------------------------------------------
minetest.register_decoration({
		label = {modname .. ":umbrella"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.01,
		biomes = {"rainforest"},
		y_max = 256,
		y_min = 1,
		decoration = {modname .. ":umbrella"},
		param2 = 10
	})
------------------------------------------------------------------------
minetest.register_decoration({
		label = {modname .. ":umbrella"},
		deco_type = "simple",
		place_on = {"group:soil", "group:sand"},
		sidelen = 16,
		fill_ratio = 0.001,
		biomes = {"tropic"},
		y_max = 256,
		y_min = 1,
		decoration = {modname .. ":umbrella"},
		param2 = 10
	})
