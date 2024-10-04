-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore, vector
    = math, minetest, nodecore, vector
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local directions = {
	{x=1, y=0, z=0},
	{x=-1, y=0, z=0},
	{x=0, y=0, z=1},
	{x=0, y=0, z=-1}
}
-- ================================================================== --
-- ================================================================== --
-- Here is where we make small mushrooms grow into tall ones --
------------------------------------------------------------------------
local function shroomgrowth(id, maxlight)
	minetest.register_abm({
		label = "Tallshroom growth",
		nodenames = {modname.. ":mushroom" ..id},
		neighbors = {"group:mycelium"},
		interval = 300,	--300
		chance = 100,		--100
		action = function(pos)
		  local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		  local anode = minetest.get_node(above)
		  local light = nodecore.get_node_light(above)
			if light >= maxlight then return
			end
				if nodecore.air_equivalent(anode) then
					nodecore.set_loud(pos, {name = modname.. ":mushroom_tall" ..id})
					nodecore.witness(pos, "tallshroom growth")
				end
		end
	})
end
-- ================================================================== --
shroomgrowth("",		8)
shroomgrowth("_glow",	6)
shroomgrowth("_lux",	4)
-- ================================================================== --

------------------------------------------------------------------------
minetest.register_abm({
	label = "Shroom Growth",
--	nodenames = {groups = {fungal = true}},
	nodenames = {"group:mycelium"},
	interval = 120, --120
	chance = 20, --20
	action = function(pos)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
--		minetest.chat_send_all("action works")
		if not nodecore.buildable_to(above) then
--			minetest.chat_send_all("blocked above")
			return
		end
		local light = nodecore.get_node_light(above)
		if (not light) or light >= 8 then
--			minetest.chat_send_all("wrong light")
			return
		end
		if light >= 4 then
			return nodecore.set_loud(above, {name = modname .. ":mushroom"})
		end
		if #nodecore.find_nodes_around(pos, "group:lux_emit", 2) > 0 then
			return nodecore.set_loud(above, {name = modname .. ":mushroom_lux"})
		end
		return nodecore.set_loud(above, {name = modname .. ":mushroom_glow"})
	end
})

-- Mushroom Growth Humus
minetest.register_abm({
	label = "Mushroom Growth",
	nodenames = {"nc_tree:humus"},
	neighbors = {"group:moist"},
	interval = 900, --900
	chance = 100, --100
	action = function(pos)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
--		minetest.chat_send_all("action works")
		if not nodecore.buildable_to(above) then
--			minetest.chat_send_all("blocked above")
			return
		end
		local light = nodecore.get_node_light(above)
		if (not light) or light >= 6 then
--			minetest.chat_send_all("wrong light")
			return
		end
		return nodecore.set_loud(above, {name = modname .. ":mushroom"})
	end
})
-- ================================================================== --
nodecore.register_abm({
	label = "Shelf Mushroom Growth",
	nodenames = {"group:detritus"},
	interval = 300, --300
	chance = 20, --20
	action = function(pos, node)
	  local dir = directions[math.random(1,4)]
	  local next_pos = vector.add(pos, dir)
	  local next_node = minetest.get_node(next_pos)	
		if nodecore.air_equivalent(next_node) then
		local light = nodecore.get_node_light(next_pos)
--		if (not light) or light >= 8 then
--			minetest.chat_send_all("wrong light")
--			return
--		end
		if light >= 4 then
			return nodecore.set_loud(next_pos, {name = modname .. ":mushroom_shelf", param2 = minetest.dir_to_wallmounted(vector.multiply(dir, -1))})
		end
		if #nodecore.find_nodes_around(pos, "group:lux_emit", 2) > 0 then
			return nodecore.set_loud(next_pos, {name = modname .. ":mushroom_shelf_lux"})
		end
		return nodecore.set_loud(next_pos, {name = modname .. ":mushroom_shelf_glow"})
		end
	end
})
-- ================================================================== --
local function growth_giantshroom(id, schem)
	minetest.register_abm({
		label = "Giant growth" ..id,
		nodenames = {modname.. ":mushroom_tall" ..id},
		neighbors = {modname.. ":mycelium_4"},
		interval = 600,	--600
		chance = 100,		--100
		action = function(pos, node)
--			minetest.chat_send_all("starting up")
			local above = {x = pos.x, y = pos.y + 3, z = pos.z}
			local below = {x = pos.x, y = pos.y - 1, z = pos.z}
			local anode = minetest.get_node(above)
				if nodecore.is_full_sun(above) then return end
				if nodecore.air_equivalent(anode) then
--				minetest.chat_send_all("good air")
					--minetest.place_schematic(pos, schematic, rotation, replacements, force_placement, flags)
					minetest.place_schematic(below, schem, "random", {}, true, "place_center_x, place_center_z")
--					minetest.chat_send_all("shroom grown")
				else
--				minetest.chat_send_all("failed")
				end		
		end
	})
end
growth_giantshroom("",	nodecore.bigmushroom_schematic)
growth_giantshroom("_glow",	nodecore.bigmushroom_glow_schematic)
growth_giantshroom("_lux",	nodecore.bigmushroom_lux_schematic)
-- ================================================================== --
