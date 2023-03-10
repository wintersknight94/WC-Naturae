-- LUALOCALS < ---------------------------------------------------------
local include, minetest, nodecore, pairs, vector
    = include, minetest, nodecore, pairs, vector
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local localpref = "nc_concrete:" .. modname:gsub("^nc_", "") .. "_"
-- ================================================================== --
local coquina = "(nc_optics_glass_frost.png^[colorize:pink:200)^nc_sponge_living.png"
local shellstone = modname.. "_shellstone.png"
local shellmix = coquina.. "^(nc_fire_ash.png^[mask:nc_concrete_mask.png)"
-- ================================================================== --
minetest.register_node(modname .. ":coquina", {
	description = "Coquina",
	tiles = {coquina},
	color = pink,
	groups = {
		crumbly = 2,
		coquina = 1
	},
	crush_damage = 2,
	sounds = nodecore.sounds("nc_terrain_chompy")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":shellstone", {
	description = "Shellstone",
	tiles = {shellstone},
	groups = {
		cracky = 1,
		shellstone = 1
	},
	drop_in_place = modname.. ":coquina",
	crush_damage = 2,
	sounds = nodecore.sounds("nc_terrain_stony")
})
-- ================================================================== --
nodecore.register_concrete_etchable({
	basename = modname .. ":shellstone",
	pliant_opacity = 50,
	pattern_opacity = 100,
	pliant = {
		sounds = nodecore.sounds("nc_terrain_crunchy"),
		drop_in_place = {"nc_concrete:shellmix_wet_source"},
		silktouch = false
	}
})
------------------------------------------------------------------------
nodecore.register_concrete({
	description = "Shellmix",
	tile_powder = shellmix,
	tile_wet = coquina.. "^(nc_fire_ash.png^("
	.. "nc_terrain_gravel.png^[opacity:128)^[mask:nc_concrete_mask.png)",
	sound = "nc_terrain_chompy",
	groups_powder = {crumbly = 1},
	swim_color = {r = 150, g = 90, b = 100},
	craft_from_keys = {"group:coquina"},
	craft_from = {groups = {coquina = true}},
	to_crude = modname.. ":coquina",
	to_washed = modname.. ":coquina",
	to_molded = localpref .. "shellstone_blank_ply"
})
------------------------------------------------------------------------
nodecore.register_stone_bricks("shellstone", "Shellstone",
	shellstone,
	180, 100,
	modname .. ":shellstone",
	{cracky = 1},
	{
		cracky = 2,
		nc_door_scuff_opacity = 45,
		door_operate_sound_volume = 80
	}
)
-- ================================================================== --
nodecore.register_craft({
	label = "break coquina to shells",
	action = "pummel",
	indexkeys = {"group:coquina"},
	nodes = {{match = {groups = {coquina = true}}, replace = "air"}},
	items = {{name = modname .. ":shell", count = 8, scatter = 5}},
	toolgroups = {cracky = 3},
	itemscatter = 5
})
------------------------------------------------------------------------
nodecore.register_craft({
	label = "pack shells",
	action = "pummel",
	toolgroups = {thumpy = 2},
	indexkeys = {modname .. ":shell"},
	nodes = {
		{
			match = {name = modname .. ":shell", count = 8},
			replace = modname.. ":coquina"
		}
	}
})
------------------------------------------------------------------------
