-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local groot = {
	"........",
	"........",
	"...qq...",
	"..qrrq..",
	"..qrrq..",
	"...qq...",
	"........",
	"........",
}
local gtrunk = {
	"........",
	"........",
	"........",
	"...tt...",
	"...tt...",
	"........",
	"........",
	"........",
}

local gbot = {
	"........",
	"........",
	"..ebbe..",
	"..bttb..",
	"..bttb..",
	"..ebbe..",
	"........",
	"........",
}
local glow = {
	"..llll..",
	".llllll.",
	"llebbell",
	"llbttbll",
	"llbttbll",
	"llebbell",
	".llllll.",
	"..llll..",
}
local ghi = {
	"..llll..",
	".llllll.",
	"llleelll",
	"llebbell",
	"llebbell",
	"llleelll",
	".llllll.",
	"..llll..",
}
local gtop = {
	"........",
	"..llll..",
	".llllll.",
	".llllll.",
	".llllll.",
	".llllll.",
	"..llll..",
	"........",
}

nodecore.grandtree_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		r = {name = "nc_tree:root", prob = 255, force_place = true},
		q = {name = "nc_tree:root", prob = 100, force_place = true},
		t = {name = "nc_tree:tree", prob = 255, force_place = true},
		b = {name = "nc_tree:leaves", param2 = 2, prob = 255},
		e = {name = "nc_tree:leaves", param2 = 1, prob = 255},
		l = {name = "nc_tree:leaves", prob = 240},
	},
	{
		groot, --1
		gtrunk, --2
		gtrunk, --3
		gtrunk, --4
		gtrunk, --5
		gtrunk, --6
		gtrunk, --7
		gtrunk, --8
		gtrunk, --9
		gtrunk, --10
		gtrunk, --11
		gtrunk, --12
		gtrunk, --13
		gbot, --14
		glow, --15
		glow, --16
		ghi, --17
		gtop --18
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
			{ypos = 8, prob = 160},
			{ypos = 9, prob = 160},
			{ypos = 10, prob = 160},
			{ypos = 11, prob = 160},
			{ypos = 12, prob = 160},
			{ypos = 13, prob = 160},
			{ypos = 14, prob = 255},
			{ypos = 15, prob = 255},
			{ypos = 16, prob = 200},
			{ypos = 17, prob = 255},
			{ypos = 18, prob = 255},
		}
	}
)

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.02,
		biomes = {"old_forest", "rainforest"},
		y_min = 1,
		y_max = 200,
		schematic = nodecore.grandtree_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {}
	})
