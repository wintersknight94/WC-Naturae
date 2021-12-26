-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

minetest.register_node(modname .. ":thornbriar", {
		description = ("Thornbriar"),
		drawtype = "allfaces_optional",
		waving = 1,
		tiles = {modname .. "_thornbriar.png"},
		inventory_image = modname .. "_thornbriar.png",
		wield_image = modname .. "_thornbriar.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		silktouch = false,
		damage_per_second = 1,
		groups = {
			snappy = 1,
			flora = 1,
			flammable = 2,
			attached_node = 1,
			damage_touch = 1,
			[modname .. "_spread"] = 1,
		},
		drop = "nc_tree:stick",
		sounds = nodecore.sounds("nc_terrain_swishy"),
		selection_box = {
			type = "fixed",
			fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16}
		},
	})

minetest.register_decoration({
		label = {modname .. ":thornbriar"},
		deco_type = "simple",
		place_on = {"group:soil","group:mud"},
		sidelen = 16,
		fill_ratio = 0.4,
		biomes = {"thicket"},
		y_max = 200,
		y_min = -40,
		height = 1,
		decoration = {modname .. ":thornbriar"},
	})
	
minetest.register_decoration({
		label = {modname .. ":thornbriar"},
		deco_type = "simple",
		place_on = {"group:sand"},
		sidelen = 4,
		fill_ratio = 0.001,
		biomes = {"dune"},
		y_max = 200,
		y_min = -40,
		height = 1,
		decoration = {modname .. ":thornbriar"},
	})


