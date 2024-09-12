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
		chance = 8,
		nodenames = {frozen},
		neighbors = {"group:flame", "group:igniter", "group:damage_radiant", "group:water"},
--		neighbors_invert = true,
		action = function(pos)
			return minetest.set_node(pos, {name = thawed})
		end
	})
end
------------------------------------------------------------------------
thaw(modname.. ":ice",					"nc_terrain:water_gray_source")
--thaw(modname.. ":dirt_with_ice",		"nc_terrain:dirt")
thaw(modname.. ":dirt_with_ice",		modname.. ":muck")
thaw(modname.. ":grass_with_frost",		modname.. ":muck")

