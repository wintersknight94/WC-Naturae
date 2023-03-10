-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local function register_shroom(suff, desc, light_source,
		ymin, ymax, offset, scale, seed,
		place, biome)
	minetest.register_node(modname .. ":mushroom" .. suff, {
			description = desc,
			drawtype = 'plantlike',
			waving = 1,
			tiles = {modname .. "_mushroom" .. suff .. ".png"},
			sunlight_propagates = true,
			paramtype = 'light',
			paramtype2 = "meshoptions",
			place_param2 = 10,
			light_source = light_source,
			walkable = false,
			groups = {
				snappy = 1,
				fungi = 2,
				flammable = 1,
				attached_node = 1,
--				decay_to_fibers = 1,
				[modname .. "_spread"] = 1
			},
			sounds = nodecore.sounds("nc_terrain_swishy"),
			selection_box = {
				type = "fixed",
				fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16},
			},
			[modname .. "_spread_max_light"] = 8
		})
------------------------------------------------------------------------
	minetest.register_node(modname .. ":mushroom_tall" .. suff, {
		description = desc,
		drawtype = 'plantlike',
		waving = 1,
		tiles = {modname .. "_mushroom_tall" .. suff .. ".png"},
		visual_scale = 1.75,
		sunlight_propagates = true,
		paramtype = 'light',
		paramtype2 = "meshoptions",
		place_param2 = 10,
		light_source = light_source,
		walkable = false,
		groups = {
			snappy = 1,
			fungi = 2,
			flammable = 1,
			attached_node = 1,
			mushroom_tall = 1,
			[modname .. "_spread"] = 1
		},
		sounds = nodecore.sounds("nc_terrain_swishy"),
--		selection_box = {
--			type = "fixed",
--			fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16},
--		},
		[modname .. "_spread_max_light"] = 8,
--		drop = modname.. ":mushroom" ..suff.. " 2",
		on_dig = function(pos)
			local yield = math.random(0,4)
			minetest.set_node(pos, {name = "air"})
			nodecore.item_eject(pos, {name = modname.. ":mushroom" ..suff}, 1, yield)
		end
	})
------------------------------------------------------------------------
	minetest.register_decoration({
			label = modname .. ":mushroom" .. suff,
			deco_type = "simple",
			place_on = place,
			sidelen = 16,
			noise_params = {
				offset = offset,
				scale = scale,
				spread = {x = 100, y = 100, z = 100},
				seed = seed,
				octaves = 3,
				persist = 0.2
			},
			biomes = biome,
			y_max = ymax,
			y_min = ymin,
			decoration = modname .. ":mushroom" .. suff,
			param2 = 10
		})
------------------------------------------------------------------------
	minetest.register_decoration({
			label = modname .. ":mushroom_tall" .. suff,
			deco_type = "simple",
			place_on = place,
			sidelen = 32,
			fill_ratio = 0.0001,
			biomes = biome,
			y_max = ymax,
			y_min = ymin,
			decoration = modname .. ":mushroom_tall" .. suff,
			param2 = 10
		})
end
-- ================================================================== --
---------------suff,	desc,	light_source,   ymin, 	ymax,	offset, 	scale, 	seed,	 place, 			biome-----

register_shroom("", 	"Mushroom",		nil,	 -10, 	200,		-0.01, 	0.1, 	42, 	{"group:soil", "group:mud", "group:fungal", "group:log"}, {"floodland", "thicket", "forest", "old_forest", "ancient_forest", "mudflat", "rainforest"})
	
register_shroom("_glow",	"Glowing Mushroom",	2, 	-400, 	1, 		-0.01, 	0.1, 	94, 	{"group:soil", "group:mud", "group:log", "group:crumbly", "group:cobble"}, {""})
	
register_shroom("_lux",	"Luxaeterna",		4, 	-1000,   -100, 	0.72, 	0.1, 	69, 	{"group:soil", "group:mud", "group:crumbly", "group:cobble"}, {""})
-- ================================================================== --
minetest.register_decoration({
		label = modname .. ":rainforest_glowshroom",
		deco_type = "simple",
		place_on = {"group:soil", "group:fungal", "group:mossy"},
		sidelen = 16,
		fill_ratio = 0.001,
		y_max = 50,
		y_min = -50,
		decoration = modname .. ":mushroom_glow",
		biomes = {"rainforest"},
		param2 = 10,
	})
------------------------------------------------------------------------
minetest.register_decoration({
		label = modname .. ":rainforest_luxshroom",
		deco_type = "simple",
		place_on = {"group:soil", "group:fungal", "group:mossy"},
		sidelen = 16,
		fill_ratio = 0.001,
		y_max = 50,
		y_min = -50,
		decoration = modname .. ":mushroom_lux",
		biomes = {"rainforest"},
		param2 = 10,
	})
------------------------------------------------------------------------
minetest.register_decoration({
		label = modname .. ":rainforest_tallshroom",
		deco_type = "simple",
		place_on = {"group:soil", "group:fungal", "group:mossy"},
		sidelen = 16,
		fill_ratio = 0.0006,
		y_max = 50,
		y_min = -50,
		decoration = modname .. ":mushroom_tall",
		biomes = {"rainforest"},
		param2 = 10,
	})
------------------------------------------------------------------------
minetest.register_decoration({
		label = modname .. ":rainforest_tallshroom_glow",
		deco_type = "simple",
		place_on = {"group:soil", "group:fungal", "group:mossy"},
		sidelen = 16,
		fill_ratio = 0.0004,
		y_max = 50,
		y_min = -50,
		decoration = modname .. ":mushroom_tall_glow",
		biomes = {"rainforest"},
		param2 = 10,
	})
------------------------------------------------------------------------
minetest.register_decoration({
		label = modname .. ":rainforest_tallshroom_lux",
		deco_type = "simple",
		place_on = {"group:soil", "group:fungal", "group:mossy"},
		sidelen = 16,
		fill_ratio = 0.0002,
		y_max = 50,
		y_min = -50,
		decoration = modname .. ":mushroom_tall_lux",
		biomes = {"rainforest"},
		param2 = 10,
	})
-- ================================================================== --

