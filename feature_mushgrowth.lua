-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
------------------------------------------------------------------------
local function shroomgrowth(id, maxlight)
	minetest.register_abm({
		label = "mushroom growth",
		nodenames = {modname.. ":mushroom" ..id},
		neighbors = {"group:humus"},
		interval = 300,
		chance = 50,
		action = function(pos)
		  local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		  local anode = minetest.get_node(above)
		  local light = nodecore.get_node_light(above)
			if light >= maxlight then return
			end
				if anode.name == "air" then
					nodecore.set_loud(pos, {name = modname.. ":mushroom_tall" ..id})
					nodecore.witness(pos, "mushroom growth")
				end
		end
	})
end
-- ================================================================== --
shroomgrowth("",		8)
shroomgrowth("_glow",	6)
shroomgrowth("_lux",	4)
