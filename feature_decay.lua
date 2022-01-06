-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================== --
minetest.register_abm({
		label = "log decay",
		interval = 1,
		chance = 2,
		nodenames = {"nc_tree:log"},
		neighbors = {"group:soil","group:moist"},
		action = function(pos)
			nodecore.sound_play("nc_api_craft_hiss", {gain = 0.02, pos = pos})
			return minetest.set_node(pos, {name = modname .. ":decayed_log"})
		end
	})
