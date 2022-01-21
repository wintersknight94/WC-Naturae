-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()

minetest.register_alias("nc_pebbles:stalactite", "nc_pebbles:pearl")

minetest.register_craftitem(modname .. ":shard", {
		description = "Glass Shard",
		inventory_image = "nc_stonework_stone.png^[colorize:aliceblue:100",
		wield_image = "[combine:16x16:0,2=nc_stonework_stone.png^[colorize:aliceblue:100",
		wield_scale = {x = 1.25, y = 1.25, z = 1.75},
		sounds = nodecore.sounds("nc_optics_glassy"),
		groups = {shard = 1, pebble = 1}
	})

minetest.register_node(modname .. ":pearl", {
		description = "Cave Pearl",
		drawtype = "nodebox",
--		tiles = {"nc_terrain_stone.png^[colorize:aliceblue:25"},
		tiles = {"nc_optics_glass_frost.png^[colorize:aliceblue:100"},
		paramtype = "light",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.25, 0.4375, -0.1875, 0.25, 0.5, 0.1875},
			{-0.1875, 0.4375, -0.25, 0.1875, 0.5, 0.25},
			{-0.1875, 0.375, -0.1875, 0.1875, 0.5, 0.1875},
		}
	},
		sunlight_propagates = true,
		light_source = 1,
		walkable = false,
		groups = {
			snappy = 1,
			pebble = 1,
			rock = 1,
			stack_as_node = 1
		},
		sounds = nodecore.sounds("nc_optics_glassy"),
		drop = modname .. ":shard"
	})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"nc_terrain:stone"},
	place_offset_y = 0,
	sidelen = 16,
	fill_ratio = 0.001,
	y_max = 5,
	y_min = -31000,
	flags = "all_ceilings",
	decoration = modname ..":pearl",
	rotation = "random",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"nc_terrain:stone"},
	place_offset_y = 0,
	sidelen = 16,
	fill_ratio = 0.005,
	y_max = -100,
	y_min = -31000,
	flags = "all_ceilings",
	decoration = modname ..":pearl",
	rotation = "random",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"nc_terrain:stone"},
	place_offset_y = 0,
	sidelen = 16,
	fill_ratio = 0.01,
	y_max = -250,
	y_min = -31000,
	flags = "all_ceilings",
	decoration = modname ..":pearl",
	rotation = "random",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"nc_terrain:stone"},
	place_offset_y = 0,
	sidelen = 16,
	fill_ratio = 0.025,
	y_max = -500,
	y_min = -31000,
	flags = "all_ceilings",
	decoration = modname ..":pearl",
	rotation = "random",
})

nodecore.register_craft({
		label = "melt shards togethers",
		action = "pummel",
		toolgroups = {thumpy = 1},
		touchgroups = {
			coolant = 0,
			flame = 1
		},
		indexkeys = {modname .. ":shard"},
		nodes = {
			{
				match = {name = modname .. ":shard", count = 8},
				replace = "air"
			}
		},
		items = {
			"nc_optics:glass_crude"
		}
	})

