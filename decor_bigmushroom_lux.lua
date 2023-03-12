-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()

local mycelium = modname.. ":mycelium"
local mushstem = modname.. ":mushroom_stem_lux"
local mushcap = modname.. ":mushroom_cap_lux"
local mushgills = modname.. ":mushroom_gills_lux"

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
	"..GGG..",
	".GGGGG.",
	".GGtGG.",
	".GGGGG.",
	"..GGG..",
	".......",
}
local caplow = {
	"..ccc..",
	".cgggc.",
	"cgggggc",
	"cggtggc",
	"cgggggc",
	".cgggc.",
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
nodecore.bigmushroom_lux_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		R = {name = mycelium, prob = 255, force_place = true},
		r = {name = mycelium, prob = 100, force_place = true},
		t = {name = mushstem, prob = 255, force_place = true},
		c = {name = mushcap, prob = 255},
		g = {name = mushgills, prob = 255},
		G = {name = mushgills, prob = 100},
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
			{ypos = 8, prob = 100},
			{ypos = 9, prob = 100},
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
		biomes = {"rainforest"},
		y_min = -32,
		y_max = 32,
		schematic = nodecore.bigmushroom_lux_schematic,
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
		schematic = nodecore.bigmushroom_lux_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {},
		place_offset_y = -1
	})
