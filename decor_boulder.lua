-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local lowboulder = {
	".....",
	"csss.",
	".sss.",
	".sss.",
	"..c..",
}
local rareslice = {
	".....",
	".sss.",
	".sos.",
	".sss.",
	".....",
}
local midboulder = {
	".....",
	"..s..",
	".ssc.",
	"..s..",
	".....",
}
local topboulder = {
	".....",
	"..c..",
	".ss..",
	".....",
	".....",
}
local mossboulder = {
	".....",
	".....",
	"..m..",
	".....",
	".....",
}
nodecore.boulder_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		s = {name = "nc_terrain:stone", prob = 255},
		c = {name = "nc_terrain:cobble", prob = 160},
		m = {name = modname .. ":mossy_stone", prob = 255},
		o = {name = "nc_lode:ore", prob = 255},
	},
	{
		lowboulder,
		rareslice,
		midboulder,
		topboulder,
		mossboulder
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255},
			{ypos = 2, prob = 100},
			{ypos = 3, prob = 225},
			{ypos = 4, prob = 100},
			{ypos = 5, prob = 200},
		}
	}
)

minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"group:soil", "group:sand", "group:gravel"},
		sidelen = 16,
		fill_ratio = 0.001,
		biomes = {"grassland", "stonewaste", "stoneprairie", "old_forest", "ancient_forest"},
		y_min = 1,
		y_max = 100,
		schematic = nodecore.boulder_schematic,
		flags = "place_center_x, place_center_z",
		rotation = "random",
		replacements = {},
	})
