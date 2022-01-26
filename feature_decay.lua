-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================== --
minetest.register_abm({
		label = "log decay",
		interval = 100,
		chance = 20,
		nodenames = {"nc_tree:log"},
		neighbors = {"group:water","group:fungal"},
		action = function(pos)
			return minetest.set_node(pos, {name = modname .. ":decayed_log"})
		end
	})
