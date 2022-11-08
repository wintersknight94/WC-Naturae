-- LUALOCALS < ---------------------------------------------------------
local  minetest, nodecore, math
	= minetest, nodecore, math
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local skin = "nc_igneous_pumice.png^[colorize:darkorange:50"
local hollow = "nc_fire_coal_4.png^[mask:" ..modname.. "_mask_pumpkin.png"
local hollowface = "(" ..skin.. ")^(" ..hollow.. ")"
------------------------------------------------------------------------
----------Pumpkin----------
minetest.register_node(modname.. ":pumpkin", {
	description = "Pumpkin",
		tiles = {skin},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.5, 0.5, 0.1875, 0.5}, -- Middle
			{-0.375, -0.5, -0.375, 0.375, 0.25, 0.375}, -- Core
			{-0.25, 0.25, -0.25, 0.25, 0.3125, 0.25}, -- Top
			{-0.0625, 0.25, -0.0625, 0.0625, 0.5, 0.0625}, -- Stem
			{-0.125, 0.3125, -0.125, 0.125, 0.375, 0.125}, -- StemBase
		}
	},
	sunlight_propagates = true,
	groups = {
		stack_as_node = 1,
		snappy = 1,
		gourd = 1,
		[modname .. "_spread"] = 1,
		peat_grindable_node = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
----------Carved----------
minetest.register_node(modname.. ":pumpkin_carved", {
	description = "Carved Pumpkin",
		tiles = {
			skin,
			skin,
			hollowface
		},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.5, 0.5, 0.1875, 0.5}, -- Middle
			{-0.375, -0.5, -0.375, 0.375, 0.25, 0.375}, -- Core
			{-0.25, 0.25, -0.25, 0.25, 0.3125, 0.25}, -- Top
			{-0.0625, 0.25, -0.0625, 0.0625, 0.5, 0.0625}, -- Stem
			{-0.125, 0.3125, -0.125, 0.125, 0.375, 0.125}, -- StemBase
		}
	},
	sunlight_propagates = true,
	groups = {
		stack_as_node = 1,
		snappy = 1,
		gourd = 1,
		peat_grindable_node = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
----------Decoration----------
minetest.register_decoration({
		label = {modname .. ":pumpkin"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.00025,
		biomes = {"grassland", "savanna", "rainforest"},
		y_max = 80,
		y_min = 2,
		decoration = {modname .. ":pumpkin"}
	})
----------Craft----------
nodecore.register_craft({
	label = "carve pumpkin",
	action = "pummel",
	duration = 4,
	toolgroups = {thumpy = 2},
	normal = {y = 1},
	indexkeys = {"group:chisel"},
	nodes = {
		{
		match = {
--			lode_temper_cool = true,
			groups = {chisel = true}
			},
		dig = true
		},
		{
			y = -1,
			match = modname.. ":pumpkin",
			replace = modname .. ":pumpkin_carved"
		}
	}
})
----------Joke----------
nodecore.register_craft({
		label = "smash pumpkin",
		action = "pummel",
		duration = 0.01,
		toolgroups = {thumpy = 3},
		nodes = {
			{
				match = {groups = {gourd = true}},
				replace = "air"
			}
		},
		items = {
			{name = "nc_tree:stick", count = 2, scatter = 3},
--			{name = "nc_tree:eggcorn", count = 1, scatter = 3},
			{name = "nc_flora:rush_dry", count = 1, scatter = 3},
			{name = "nc_flora:sedge_1", count = 1, scatter = 3},
--			{name = "nc_stonework:chip", count = 1, scatter = 3}
		},
		itemscatter = 3
	})
