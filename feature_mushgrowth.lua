-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local function growparticles(pos, rate, width)
	nodecore.soaking_particles(pos, rate, 10, width, "nc_tree:leaves_bud")
end
------------------------------------------------------------------------
local mycost = 20
------------------------------------------------------------------------
local function shroomgrowth(id)
------------------------------------------------------------------------
nodecore.register_soaking_abm({
		label = "mushgroom growth",
		fieldname = "shroomgrow",
		nodenames = {modname.. ":mushroom" ..id},
		neighbors = {"group:moist"},
		interval = 10,
		arealoaded = 1,
		soakrate = nodecore.tree_growth_rate,
		soakcheck = function(data, pos)
		   local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		   local below = {x = pos.x, y = pos.y - 1, z = pos.z}
		   local gnode = minetest.get_node(below)
		   local light = nodecore.get_node_light(above)
			minetest.chat_send_all("action works")
			if gnode.name ~= modname.. ":mycelium" then
				minetest.chat_send_all("wrong soil")
				return
			end
				if light >= 6 then
					minetest.chat_send_all("wrong light")
					return
				end
					if data.total ~= mycost then
						minetest.chat_send_all("have more patience")
						return
					end
						if data.total >= mycost and gnode.name == modname.. ":mycelium" then
							nodecore.set_loud(pos, {name = modname.. ":mushroom_tall" ..id})
							nodecore.witness(pos, "mushroom growth")
						end
						return growparticles(pos, data.rate, 0.2)
		end
	})
end
shroomgrowth("")
shroomgrowth("_glow")
shroomgrowth("_lux")
