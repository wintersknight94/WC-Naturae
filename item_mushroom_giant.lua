-- LUALOCALS < ---------------------------------------------------------
local include, minetest, nodecore
    = include, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local function register_shroomtree(suff, desc, light_source, capcolor, stemcolor, gillcolor)
	minetest.register_node(modname .. ":mushroom_cap" ..suff, {
		description = desc,
		tiles = {modname .. "_mushroom_cap.png^[colorize:" ..capcolor},
		groups = {
			snappy = 1,
			flammable = 2,
			fire_fuel = 4,
			mushblock = 1
		},
		sounds = nodecore.sounds("nc_terrain_swishy"),
		light_source = light_source
	})
------------------------------------------------------------------------
	minetest.register_node(modname .. ":mushroom_stem" ..suff, {
		description = desc,
		tiles = {
			modname .. "_mushroom_stem_top.png^[colorize:" ..stemcolor,
			modname .. "_mushroom_stem.png^[colorize:" ..stemcolor
		},
		groups = {
			snappy = 1,
			flammable = 2,
			fire_fuel = 4,
			mushblock = 1
		},
		sounds = nodecore.sounds("nc_terrain_swishy"),
		light_source = light_source
	})
------------------------------------------------------------------------
	minetest.register_node(modname .. ":mushroom_gills" ..suff, {
		description = desc,
		tiles = {modname .. "_mushroom_gills.png^[colorize:" ..gillcolor},
		drawtype = "plantlike",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		groups = {
			snappy = 1,
			flammable = 2,
			fire_fuel = 4,
			attached_node = 1,
			mushgills = 1
		},
		waving = 1,
		sounds = nodecore.sounds("nc_terrain_swishy"),
		light_source = light_source
	})
end
------------------------------------------------------------------------
-- ================================================================== --
register_shroomtree("", 	"Mushroom",		nil,		"#cb410b:180", "#e3dac9:100", "WHITE:100")
	
register_shroomtree("_glow",	"Glowing Mushroom",	2,	"#0892d0:120", "WHITE:140", "WHITE:100")
	
register_shroomtree("_lux",	"Luxaeterna",		4,	"#664c28:180", "#009e60:140", "#b2ec5d:100")
-- ================================================================== --
------------------------------------------------------------------------
nodecore.register_craft({
		label = "grind giant mushrooms to compost",
		action = "pummel",
		toolgroups = {crumbly = 2},
		indexkeys = {"group:mushblock"},
		nodes = {
			{
				match = {groups = {mushblock = true}},
				replace = {name = modname .. ":compost"}
			}
		}
	})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "grind mushroom gills to compost",
		action = "pummel",
		toolgroups = {crumbly = 2},
		indexkeys = {"group:mushgills"},
		nodes = {
			{
				match = {groups = {mushgills = true}, count = 8},
				replace = {name = modname .. ":compost"}
			}
		}
	})
------------------------------------------------------------------------
