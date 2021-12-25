-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

minetest.register_node(modname .. ":decayed_log", {
		description = "Decayed Log",
		drawtype = "normal",
		tiles = {
			modname .. "_decayed_log_top.png",
			modname .. "_decayed_log_top.png",
			modname .. "_decayed_log_side.png"
		},
		groups = {
			choppy = 2,
			flammable = 6,
			fire_fuel = 6,
			falling_repose = 2
		},
		crush_damage = 1,
		sounds = nodecore.sounds("nc_tree_woody"),
		paramtype2 = "facedir",
		on_place = minetest.rotate_node,
		drop = modname .. ":decayed_log"
	})

nodecore.register_craft({
		label = "grind decayed log to peat",
		action = "pummel",
		toolgroups = {crumbly = 2},
		nodes = {
			{
				match = {name = modname .. ":decayed_log"},
				replace = "nc_tree:peat"
			}
		}
	})

local fallen = {
	".....",
	"..f..",
	"..f..",
	"..f..",
	".....",
}
nodecore.deadwood_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		f = {name = modname .. ":decayed_log", param2 = 7, prob = 255},
	},
	{
		fallen,
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255},
		}
	}
)
minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.005,
		biomes = {"forest", "thicket", "old_forest", "ancient_forest"},
		y_min = -2,
		y_max = 1000,
		schematic = nodecore.deadwood_schematic,
		rotation = "random",
		replacements = {},
	})
