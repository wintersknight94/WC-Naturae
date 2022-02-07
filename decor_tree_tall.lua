-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local root = {
	".....",
	".....",
	"..r..",
	".....",
	".....",
}
local trunk = {
	".....",
	".....",
	"..t..",
	".....",
	".....",
}
local bot = {
	".....",
	".ebe.",
	".btb.",
	".ebe.",
	".....",
}
local low = {
	".lll.",
	"lebel",
	"lbtbl",
	"lebel",
	".lll.",
}
local hi = {
	".lll.",
	"llell",
	"lebel",
	"llell",
	".lll.",
}
local top = {
	".....",
	".lll.",
	".lll.",
	".lll.",
	".....",
}
nodecore.talltree_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		r = {name = "nc_tree:root", prob = 255, force_place = true},
		t = {name = "nc_tree:tree", prob = 255, force_place = true},
		b = {name = "nc_tree:leaves", param2 = 2, prob = 255},
		e = {name = "nc_tree:leaves", param2 = 1, prob = 255},
		l = {name = "nc_tree:leaves", prob = 240},
	},
	{
		root,
		trunk,
		trunk,
		trunk,
		trunk,
		trunk,
		trunk,
		trunk,
		trunk,
		bot,
		low,
		low,
		hi,
		top
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255},
			{ypos = 2, prob = 160},
			{ypos = 3, prob = 160},
			{ypos = 4, prob = 160},
			{ypos = 5, prob = 160},
			{ypos = 6, prob = 160},
			{ypos = 7, prob = 160},
			{ypos = 8, prob = 100},
			{ypos = 9, prob = 100},
			{ypos = 10, prob = 255},
			{ypos = 11, prob = 160},
			{ypos = 12, prob = 160},
			{ypos = 13, prob = 255},
		}
	}
)

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.02,
		biomes = {"forest", "thicket", "old_forest", "rainforest"},
		y_min = 1,
		y_max = 1000,
		schematic = nodecore.talltree_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {}
	})
	
minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"group:sand"},
		sidelen = 16,
		fill_ratio = 0.0025,
		biomes = {"tropic"},
		y_min = 1,
		y_max = 1000,
		schematic = nodecore.talltree_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {}
	})
