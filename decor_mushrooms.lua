-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local fungi = "wc_fungi"
-- ================================================================== --
local function register_shroom(suff, ymin, ymax, offset, scale, seed, place, biome)
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
			decoration = fungi .. ":mushroom" .. suff,
			flags = "all_floors",
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
			decoration = fungi .. ":mushroom_tall" .. suff,
			flags = "all_floors",
			param2 = 10
		})
end
-- ================================================================== --
---------------suff,		ymin, 	ymax,	offset, 	scale, 	seed,	 place, 	biome-----

register_shroom("", 		-10, 	200,	-0.01, 	0.1, 	420, 	{"group:soil", "group:mud", "group:fungal", "group:log"}, {"floodland", "thicket", "forest", "old_forest", "ancient_forest", "mudflat", "rainforest"})
	
register_shroom("_glow",	-400, 	1, 		-0.01, 	0.1, 	941, 	{"group:soil", "group:mud", "group:log", "group:crumbly", "group:cobble"}, {""})
	
register_shroom("_lux",		-1000,   -100, 	0.72, 	0.1, 	692, 	{"group:soil", "group:mud", "group:crumbly", "group:cobble"}, {""})

if minetest.settings:get_bool(modname .. ".extrashrooms", true) then
	register_shroom("_honey",	-64,   64, 	-0.12, 	0.1, 	213, 	{"group:soil", "group:log"}, {"floodland", "thicket", "forest", "old_forest", "ancient_forest", "mudflat"})
end
-- ================================================================== --
minetest.register_decoration({
		label = modname .. ":rainforest_glowshroom",
		deco_type = "simple",
		place_on = {"group:soil", "group:fungal", "group:mossy"},
		sidelen = 16,
		fill_ratio = 0.001,
		y_max = 50,
		y_min = -50,
		decoration = fungi .. ":mushroom_glow",
		biomes = {"rainforest"},
		param2 = 10,
		flags = "all_floors",
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
		decoration = fungi .. ":mushroom_lux",
		biomes = {"rainforest"},
		param2 = 10,
		flags = "all_floors",
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
		decoration = fungi .. ":mushroom_tall",
		biomes = {"rainforest"},
		param2 = 10,
		flags = "all_floors",
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
		decoration = fungi .. ":mushroom_tall_glow",
		biomes = {"rainforest"},
		param2 = 10,
		flags = "all_floors",
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
		decoration = fungi .. ":mushroom_tall_lux",
		biomes = {"rainforest"},
		param2 = 10,
		flags = "all_floors",
	})
-- ================================================================== --
if minetest.settings:get_bool(modname .. ".extrashrooms", true) then
	local function extrashroom(id)
		minetest.register_decoration({
			label = modname .. ":rainforest_ex_" ..id,
			deco_type = "simple",
			place_on = {"group:soil", "group:fungal", "group:mossy"},
			sidelen = 16,
			fill_ratio = 0.001,
			y_max = 48,
			y_min = -32,
			decoration = fungi .. ":mushroom_" ..id,
			biomes = {"rainforest"},
			param2 = 10,
			flags = "all_floors",
		})
		minetest.register_decoration({
			label = modname .. ":rainforest_tall_ex_" ..id,
			deco_type = "simple",
			place_on = {"group:soil", "group:fungal", "group:mossy"},
			sidelen = 16,
			fill_ratio = 0.0001,
			y_max = 24,
			y_min = -32,
			decoration = fungi .. ":mushroom_tall_" ..id,
			biomes = {"rainforest"},
			param2 = 10,
			flags = "all_floors",
		})
	end
	extrashroom("gloom")
	extrashroom("liar")
	extrashroom("satan")
	extrashroom("azure")
	extrashroom("star")
	extrashroom("wart")
	extrashroom("stone")
	extrashroom("honey")
end
-- ================================================================== --
