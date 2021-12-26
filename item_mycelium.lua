-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

-- ================================================================== --

-- Node Definitions
minetest.register_node(modname .. ":mycelium", {
		description = "Mycelium",
		tiles = {"nc_terrain_dirt.png^"..modname.."_mycelium.png"},
		groups = {
			crumbly = 1,
			soil = 4,
			fungal = 1,
			humus = 1,
			grassable = 1
		},
		alternate_loose = {
			tiles = {"(nc_terrain_dirt.png^"..modname.."_mycelium.png)^nc_api_loose.png"},
			walkable = false,
			groups = {
				crumbly = 1,
				soil = 5,
				fungal = 1,
				dirt_loose = 2,
				falling_repose = 2,
				grassable = 1
			}
		},
		sounds = nodecore.sounds("nc_terrain_chompy")
	})
	
minetest.register_node(modname .. ":compost", {
		description = "Fungal Compost",
		tiles = {"nc_terrain_dirt.png^nc_tree_peat.png^("..modname.."_mycelium.png^[opacity:100)"},
		groups = {
			crumbly = 1,
			soil = 3,
			moist = 1,
			fungal = 1,
			falling_repose = 1
		},
		sounds = nodecore.sounds("nc_terrain_chompy")
	})

-- ================================================================== --

-- Compost Grinding
nodecore.register_craft({
		label = "grind mushrooms to compost",
		action = "pummel",
		toolgroups = {crumbly = 2},
		indexkeys = {modname .. ":mushroom"},
		nodes = {
			{
				match = {name = modname .. ":mushroom", count = 8},
				replace = {name = modname .. ":compost"}
			}
		}
	})

nodecore.register_craft({
		label = "grind glowshrooms to compost",
		action = "pummel",
		toolgroups = {crumbly = 2},
		indexkeys = {modname .. ":mushroom_glow"},
		nodes = {
			{
				match = {name = modname .. ":mushroom_glow", count = 8},
				replace = {name = modname .. ":compost"}
			}
		}
	})

nodecore.register_craft({
		label = "grind luxaeterna to compost",
		action = "pummel",
		toolgroups = {crumbly = 2},
		indexkeys = {modname .. ":mushroom_lux"},
		nodes = {
			{
				match = {name = modname .. ":mushroom_lux", count = 8},
				replace = {name = modname .. ":compost"}
			}
		}
	})

-- ================================================================== --

-- Mycelium Growth
local compostcost = 2500

nodecore.register_soaking_abm({
		label = "fungal compost",
		fieldname = "compost",
		nodenames = {modname .. ":compost"},
		interval = 10,
		soakrate = nodecore.tree_soil_rate,
		soakcheck = function(data, pos)
			if data.total < compostcost then return end
			minetest.get_meta(pos):from_table({})
			if math_random(1, 100) == 1 and nodecore.is_full_sun(
				{x = pos.x, y = pos.y + 1, z = pos.z}) then
				nodecore.set_loud(pos, {name = modname .. ":mossy_dirt"})
				return
			end
			nodecore.set_loud(pos, {name = modname .. ":mycelium"})
			nodecore.witness(pos, "fungal compost")
			local found = nodecore.find_nodes_around(pos, {modname .. ":compost"})
			if #found < 1 then return false end
			nodecore.soaking_abm_push(nodecore.pickrand(found),
				"compost", data.total - compostcost)
			return false
		end
	})

-- ================================================================== --

-- Mushroom Growth
minetest.register_abm({
		label = "Mushroom Growth",
		nodenames = {modname .. ":mycelium"},
--		neighbors = {"group:moist"},
		interval = 5, --50
		chance = 2, --10
		action = function(pos)
			if nodecore.buildable_to({x = pos.x, y = pos.y + 1, z = pos.z}) then
				nodecore.set_loud({x = pos.x, y = pos.y + 1, z = pos.z}, {name = modname .. ":mushroom"})
				return
			end
		end
	})

-- Glowshroom Growth
minetest.register_abm({
		label = "Glowshroom Growth",
		nodenames = {modname .. ":mycelium"},
--		neighbors = {"group:moist"},
		interval = 5, --50
		chance = 2, --10
		action = function(pos)
			if nodecore.buildable_to({x = pos.x, y = pos.y + 1, z = pos.z})
			and nodecore.get_node_light(pos) < 8 then
				nodecore.set_loud({x = pos.x, y = pos.y + 1, z = pos.z}, {name = modname .. ":mushroom_glow"})
				return
			end
		end
	})
