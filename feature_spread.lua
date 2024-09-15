-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local function fertile(pos, node_if_air)
	local below = {x = pos.x, y = pos.y - 1, z = pos.z}
	local bnode = minetest.get_node(below)
	if minetest.get_item_group(bnode.name, "soil") < 1 then return end
	if #nodecore.find_nodes_around(pos, "group:moist", 2) < 1 then return end
	if not node_if_air then return true end
	local sdef = minetest.registered_nodes[node_if_air.name] or {}
	local maxlight = sdef[modname .. "_spread_max_light"]
	if maxlight then
		local ll = nodecore.get_node_light(pos) or 15
		if ll > maxlight then return end
	end
	local node = minetest.get_node(pos)
	local def = (node.name ~= "ignore") and minetest.registered_nodes[node.name] or {}
	return def.air_equivalent
end

minetest.register_abm({
		label = "nature standard spreading",
		nodenames = {"group:" .. modname .. "_spread"},
		interval = 120,
		chance = 20,
		action = function(pos, node)
			if not fertile(pos) then return end
			local gro = {
				x = pos.x + math_random(-1, 1),
				y = pos.y + math_random(-1, 1),
				z = pos.z + math_random(-1, 1)
			}
			if not fertile(gro, node) then return end
			if #nodecore.find_nodes_around(pos, node.name, 4) >= 20 then return end
			return nodecore.set_loud(gro, node)
		end
	})
