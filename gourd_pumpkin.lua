-- LUALOCALS < ---------------------------------------------------------
local  minetest, nodecore
	= minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local skin = "nc_lode_annealed.png^[colorize:darkorange:50"
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
		snappy = 1
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
		snappy = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
