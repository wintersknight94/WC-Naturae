-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()

minetest.register_node(modname .. ":vine_thorny", {
		description = "Thorny Vines",
		drawtype = "plantlike",
		paramtype = "light",
--		visual_scale = 0.5,
--		wield_scale = {x = 0.75, y = 0.75, z = 1.5},
--		collision_box = nodecore.fixedbox(-3/16, -0.5, -3/16, 3/16, 0, 3/16),
--		selection_box = nodecore.fixedbox(-3/16, -0.5, -3/16, 3/16, 0, 3/16),
		inventory_image = "[combine:24x24:4,4=" .. modname
		.. "_plant_fibers.png\\^[resize\\:16x16",
		tiles = {modname .. "_plant_fibers.png"},
		groups = {
			snappy = 1,
			flammable = 3,
			attached_node = 1,
			peat_grindable_item = 1
		},
		node_placement_prediction = "nc_items:stack",
		place_as_item = true,
		sounds = nodecore.sounds("nc_terrain_swishy")
	})

minetest.register_node(modname .. ":thornbriar", {
		description = ("Thornbriar"),
		drawtype = "allfaces_optional",
		waving = 1,
		tiles = {modname .. "_thornbriar.png"},
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		silktouch = false,
		damage_per_second = 1,
		move_resistance = 2,
		groups = {
			snappy = 1,
			flora = 1,
			flammable = 2,
			attached_node = 1,
	--		damage_touch = 1,
			thorny = 1,
			[modname .. "_spread"] = 1,
			stack_as_node = 1
		},
--		drop = modname .. ":vine_thorny",
		sounds = nodecore.sounds("nc_terrain_swishy"),
		selection_box = {
			type = "fixed",
			fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16}
		},
		alternate_loose = {
			description = ("Brambles"),
			tiles = {modname .. "_thornbriar.png"},
			color = "lightslategray",
			walkable = false,
			groups = {
				snappy = 1,
				leafy = 1,
				flammable = 1,
				falling_repose = 1,
				stack_as_node = 1,
				thorny = 1,
				[modname .. "_spread"] = 0,
			}
		},
		no_repack = true,
	})

local i = math.random(5)

nodecore.register_craft({
		label = "break brambles into sticks",
		action = "pummel",
		duration = 3,
		toolgroups = {snappy = 1, choppy = 1},
		nodes = {
			{match = modname .. ":thornbriar_loose", replace = "air"}
		},
		items = {
			{name = "nc_tree:stick", count = i, scatter = i}
		},
		itemscatter = i
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


