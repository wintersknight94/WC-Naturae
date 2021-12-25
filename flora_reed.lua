-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

-- Nature reeds generate on terrain that wouldn't sustain rushes, but we
-- don't want tons of rushes instantly dying on mapgen. Register reeds as
-- "dormant" rushes in these situations and keep them alive until either
-- disturbed, or given moisture to awaken them.

------------------------------------------------------------------------
-- NODE DEFINITION

local rushname = "nc_flora:rush"
local reedname = modname .. ":reeds"
local rushdef = minetest.registered_items[rushname] or {}
local reeddef = nodecore.underride({
		description = "Dormant Rush",
		drop = rushname,
		tiles = {"nc_flora_rush_side.png^(nc_flora_rush_side_dry.png"
			.. "^[mask:" .. modname .. "_checkermask.png)"}
	}, rushdef)
minetest.register_node(reedname, reeddef)

------------------------------------------------------------------------
-- MAPGEN

minetest.register_decoration({
		label = {modname .. ":reeds"},
		deco_type = "simple",
		place_on = {"group:soil", "group:mud", "nc_terrain:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x = 100, y = 100, z = 100},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		y_max = 1,
		y_min = 1,
		decoration = {modname .. ":reeds"},
		spawn_by = "nc_terrain:water_source",
		num_spawn_by = 1,
		param2 = 4
	})
minetest.register_decoration({
		label = {modname .. ":reeds"},
		deco_type = "simple",
		place_on = {"group:mud", "nc_terrain:dirt_with_grass", "nc_terrain:dirt", "nc_terrain:sand"},
		sidelen = 16,
		fill_ratio = 0.1,
		y_max = 2,
		y_min = -4,
		decoration = {modname .. ":reeds"},
		biomes = {"floodlands"},
		param2 = 4
	})

------------------------------------------------------------------------
-- CONVERSION

local function reedcheck(loud)
	return function(pos, node)
		if node.param2 == 0 then
			local below = {x = pos.x, y = pos.y - 1, z = pos.z}
			local bnode = minetest.get_node_or_nil(below)
			local bdef = bnode and minetest.registered_nodes[bnode.name]
			if not (bdef and bdef.walkable) then
				return minetest.remove_node(pos)
			end
		end
		if #nodecore.find_nodes_around(pos, "group:moist", 2) > 0 then
			return (loud and nodecore.set_loud or nodecore.set_node)(pos, {
					name = rushname,
					param2 = rushdef.place_param2
				})
		elseif node.param2 ~= reeddef.place_param2 then
			return nodecore.set_node(pos, {
					name = reedname,
					param2 = reeddef.place_param2
				})
		end
	end
end
minetest.register_lbm({
		name = modname .. ":reedcheck",
		run_at_every_load = true,
		nodenames = {reedname},
		action = reedcheck(false)
	})
minetest.register_abm({
		label = modname .. ":reedcheck",
		interval = 1,
		chance = 50,
		nodenames = {reedname},
		action = reedcheck(true)
	})
