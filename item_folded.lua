-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local weave0	= "nc_flora_flower_color_dry.png^[colorize:black:64"
local weave1	= "nc_flora_flower_color.png^[mask:" ..modname .. "_weave1.png"
local weave2	= "nc_flora_flower_color_dry.png^[mask:" ..modname .. "_weave2.png"
local woven		= "(" ..weave0.. ")^(" ..weave1.. ")^(" ..weave2.. ")"
local tattered	= "(" ..weave0.. "^[colorize:black:64)^(" ..weave1.. "^[colorize:sienna:64)^(" ..weave2.. "^[colorize:black:64)"
------------------------------------------------------------------------
minetest.register_node(modname .. ":leaves_folded", {
	description = "Woven Leaves",
	tiles = {woven},
	groups = {
		choppy = 1,
		flammable = 2,
		fire_fuel = 4,
		peat_grindable_node = 1,
		leaves_woven = 1
	},
	sounds = nodecore.sounds("nc_terrain_swishy"),
	drop_in_place = modname .. ":leaves_folded_dry"
})
minetest.register_node(modname .. ":leaves_folded_dry", {
	description = "Tattered Woven Leaves",
	tiles = {tattered},
	groups = {
		snappy = 1,
		flammable = 1,
		fire_fuel = 4,
		falling_repose = 2,
		stack_as_node = 1,
		peat_grindable_node = 1
	},
	sounds = nodecore.sounds("nc_terrain_swishy"),
})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "Weave Broad Leaves",
		action = "pummel",
		toolgroups = {thumpy = 1},
		nodes = {
			{
				match = {groups = {weavable = true}, count = 8},
				replace = modname .. ":leaves_folded"
			}
		},
	})
