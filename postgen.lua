-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

nodecore.register_abm({
	label = "Pebble Erosion",
	nodenames = {"nc_terrain:gravel"},
	neighbors = {"nc_terrain:water_flowing"},
	neighbors_invert = true,
	interval = 3600,
	chance = 100,
	action = function(pos)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if not nodecore.buildable_to(above) then
			return
		end
		return minetest.set_node(above, {name = modname .. ":pebble"})
	end
})

nodecore.register_abm({
	label = "Pearl Formation",
	nodenames = {"nc_lux:stone"},
	neighbors = {"group:moist", "group:water"},
	interval = 900,
	chance = 100,
	action = function(pos)
		local below = {x = pos.x, y = pos.y - 1, z = pos.z}
		if not nodecore.buildable_to(below) then
			return
		end
		return nodecore.set_loud(below, {name = modname .. ":pearl"})
	end
})

nodecore.register_abm({
	label = "Shell Washing Ashore",
	nodenames = {"nc_terrain:sand"},
	neighbors = {"nc_terrain:water_flowing"},
	neighbors_invert = true,
	interval = 3600,
	chance = 100,
	action = function(pos)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if not nodecore.buildable_to(above) then
			return
		end
		return minetest.set_node(above, {name = modname .. ":shell"})
	end
})


