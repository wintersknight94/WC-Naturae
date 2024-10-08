-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local logtop = "(nc_tree_tree_top.png^[colorize:black:75)"
local logside = "(nc_tree_tree_side.png^[colorize:black:75)"
local hollow = "(" ..modname.. "_hollow.png)"
------------------------------------------------------------------------
local fallen = {
	"..f..",
	"..f..",
	"..f..",
	"..f..",
	"..f..",
}
nodecore.deadwood_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		f = {name = "wc_fungi:decayed_log", param2 = 7, prob = 225},
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
		biomes = {"forest", "thicket", "old_forest", "ancient_forest", "rainforest"},
		y_min = -2,
		y_max = 100,
		schematic = nodecore.deadwood_schematic,
		rotation = "random",
		replacements = {},
	})
	
 -- ====================================================================== --

local stump = modname .. ":dead_root"
local visdirt = "wc_fungi:decayed_log"
local rootdef = nodecore.underride({
	description = "Dead Roots",
	drawtype = "plantlike_rooted",
	falling_visual = visdirt,
	special_tiles = {"((" ..logside.. ")^(wc_fungi_mycelium.png^[opacity:100))^[mask:" ..modname.. "_stem_mask.png"},
	drop = visdirt,
	no_self_repack = true,
	groups = {grassable = 0, roots = 1}
}, minetest.registered_items[visdirt] or {})
--rootdef.groups.humus = nil
minetest.register_node(stump, rootdef)
	
------------------------------------------------------------------------
local deadroot = {
	".....",
	".lll.",
	".lrl.",
	".lll.",
	".....",
}
------------------------------------------------------------------------
nodecore.deadroot_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		r = {name = modname.. ":dead_root", prob = 255},
		l = {name = "wc_fungi:decayed_log", param2 = 7, prob = 75},
		
	},
	{
		deadroot
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255}
		}
	}
)
------------------------------------------------------------------------
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"group:soil", "group:gravel", "group:sand"},
	sidelen = 16,
	fill_ratio = 0.001,
	biomes = {"mudflat", "stonewaste", "stoneprairie", "dune", "savanna"},
	y_min = 1,
--	y_max = 120,
	schematic = nodecore.deadroot_schematic,
	flags = "force_placement, place_center_x, place_center_z, all_floors",
--	place_offset_y = -1,
--	rotation = "random",
	replacements = {},
})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "cut useable wood from decayed root",
		action = "pummel",
		toolgroups = {choppy = 1},
		nodes = {
			{
				match = {name = modname .. ":dead_root"},
				replace = "nc_woodwork:plank"
			}
		},
		items = {
		{name = "nc_tree:stick", count = 1, scatter = 1}
		}
	})
