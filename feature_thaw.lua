-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local function thaw(frozen, thawed)
minetest.register_abm({
		label = "thawing",
		interval = 20,
		chance = 4,
		nodenames = {"group:frozen"},
		neighbors = {"group:flame", "group:igniter", "group:damage_radiant"},
		neighbors_invert = true,
		action = function(pos)
			return minetest.set_node(pos, {name = thawed})
		end
	})
end
------------------------------------------------------------------------
thaw(modname.. ":ice",			"nc_terrain:water_gray_source")
thaw(modname.. ":dirt_with_ice",	"nc_terrain:dirt")
thaw(modname.. ":grass_with_frost",	"nc_terrain:dirt_with_grass")

