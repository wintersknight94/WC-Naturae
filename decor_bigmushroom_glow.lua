-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()

local mycelium1	= "wc_fungi:mycelium_1"
local mycelium2	= "wc_fungi:mycelium_2"
local mushstem	= "wc_fungi:mushroom_stalk_glow"
local mushcap	= "wc_fungi:mushroom_cap_glow"
local mushgills	= "wc_fungi:mushroom_gills_glow"

local root = {
	".......",
	"..rrr..",
	".rrRrr.",
	".rRRRr.",
	".rrRrr.",
	"..rrr..",
	".......",
}
local stem = {
	".......",
	".......",
	".......",
	"...t...",
	".......",
	".......",
	".......",
}
local capbot = {
	".......",
	"..ggg..",
	".ggggg.",
	".ggtgg.",
	".ggggg.",
	"..ggg..",
	".......",
}
local caplow = {
	"..ccc..",
	".cGGGc.",
	"cGGGGGc",
	"cGGtGGc",
	"cGGGGGc",
	".cGGGc.",
	"..ccc..",
}
local captop = {
	".......",
	"..ccc..",
	".ccccc.",
	".ccccc.",
	".ccccc.",
	"..ccc..",
	".......",
}
nodecore.bigmushroom_glow_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		R = {name = mycelium2, prob = 255, force_place = true},
		r = {name = mycelium1, prob = 100, force_place = true},
		t = {name = mushstem, prob = 255, force_place = true},
		c = {name = mushcap, prob = 255},
		G = {name = mushgills, prob = 255},
		g = {name = mushgills, prob = 100},
	},
	{
		root,
		root,
		stem,
		stem,
		stem,
		stem,
		stem,
		stem,
		stem,
		stem,
		capbot,
		caplow,
		captop
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255},
			{ypos = 2, prob = 255},
			{ypos = 3, prob = 255},
			{ypos = 4, prob = 160},
			{ypos = 5, prob = 160},
			{ypos = 6, prob = 160},
			{ypos = 7, prob = 160},
			{ypos = 8, prob = 160},
			{ypos = 9, prob = 160},
			{ypos = 10, prob = 255},
			{ypos = 11, prob = 255},
			{ypos = 12, prob = 255},
			{ypos = 13, prob = 255},
		}
	}
)

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"group:soil", "group:humus"},
		sidelen = 16,
		fill_ratio = 0.00001,
		biomes = {"mudflat", "floodland", "rainforest", "old_forest", "ancient_forest"},
		y_min = -31000,
		y_max = 32,
		schematic = nodecore.bigmushroom_glow_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {},
		place_offset_y = -1
	})
minetest.register_decoration({
		deco_type = "schematic", 
		place_on = {"group:soil", "group:humus", "group:gravel", "group:sand", "group:stone"},
		sidelen = 16,
		fill_ratio = 0.0002,
		y_min = -2000,
		y_max = -512,
		schematic = nodecore.bigmushroom_glow_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {},
		place_offset_y = -1
	})
