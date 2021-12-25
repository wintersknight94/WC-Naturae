-- LUALOCALS < ---------------------------------------------------------
local math, minetest, next, nodecore, pairs
    = math, minetest, next, nodecore, pairs
local math_floor, math_random
    = math.floor, math.random
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

------------------------------------------------------------------------
-- NODE DEFINITIONS

local bamboo_nodebox = {
	type = "fixed",
	fixed = {
		{-0.125, -0.4375, -0.125, 0.125, 0.5, 0.125}, -- Shaft
		{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875} -- Bottom
	}
}

minetest.register_node(modname .. ":bamboo_pole", {
		description = "Bamboo",
		drawtype = "nodebox",
		node_box = bamboo_nodebox,
		tiles = {modname .. "_bamboo.png^[colorize:peru:100"},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		on_place = minetest.rotate_node,
		climbable = true,
		groups = {
			choppy = 1,
			flammable = 2,
			fire_fuel = 1,
			bamboo = 1
		},
		sounds = nodecore.sounds("nc_tree_sticky")
	})

minetest.register_node(modname .. ":bamboo_living", {
		description = "Living Bamboo",
		drawtype = "nodebox",
		node_box = bamboo_nodebox,
		tiles = {modname .. "_bamboo.png"},
		paramtype = "light",
		sunlight_propagates = true,
		climbable = true,
		groups = {
			choppy = 2,
			flammable = 6,
			fire_fuel = 1,
			falling_node = 1,
			scaling_time = 80
		},
		crush_damage = 1,
		sounds = nodecore.sounds("nc_tree_sticky"),
		drop = modname .. ":bamboo_pole"
	})

minetest.register_alias_force(modname .. ":bamboo", modname .. ":bamboo_living")

nodecore.register_aism({
		label = "bamboo convert",
		interval = 1,
		chance = 1,
		itemnames = {modname .. ":bamboo_living"},
		action = function(stack)
			stack:set_name(modname .. ":bamboo_pole")
			return stack
		end
	})

------------------------------------------------------------------------
-- MAPGEN

minetest.register_decoration({
		label = modname .. ":bamboo_living",
		deco_type = "simple",
		place_on = {"group:soil", "nc_terrain:sand"},
		sidelen = 16,
		fill_ratio = 0.1,
		y_max = 200,
		y_min = 1,
		decoration = modname .. ":bamboo_living",
		height = 1,
		height_max = 12,
		biomes = {"thicket", "floodland"}
	})

nodecore.register_craft({
		label = "split bamboo into staves",
		action = "pummel",
		toolgroups = {choppy = 1},
		nodes = {{match = modname .. ":bamboo_pole", replace = "air"}},
		items = {{name = "nc_woodwork:staff", count = 2, scatter = 2}},
		itemscatter = 2
	})

------------------------------------------------------------------------
-- GROW/SPREAD

local function bamboo_air(pos)
	local node = minetest.get_node(pos)
	local def = minetest.registered_nodes[node.name]
	return def and def.air_equivalent
end
local function bamboo_soil(pos)
	local node = minetest.get_node(pos)
	local soil = minetest.get_item_group(node.name, "soil")
	return soil and soil > 0
end

minetest.register_abm({
		label = "bamboo spreading",
		nodenames = {modname .. ":bamboo_living"},
		neighbors = {"group:water"},
		interval = 120,
		chance = 20,
		action = function(pos)
			if pos.y >= 50 then return end
			if #nodecore.find_nodes_around(pos, {"group:soil", "group:sand"}, 1) < 3
			then return end

			local gro = {
				x = pos.x + math_random(-1, 1),
				y = pos.y + math_random(-1, 1),
				z = pos.z + math_random(-1, 1)
			}
			if not bamboo_air(gro) then return end

			local grodown = {x = gro.x, y = gro.y - 1, z = gro.z}
			if not bamboo_soil(grodown) then return end

			nodecore.set_node(gro, {name = modname .. ":bamboo_living"})
		end,
	})

minetest.register_abm({
		label = "bamboo growing",
		nodenames = {modname .. ":bamboo_living"},
		interval = 60,
		chance = 10,
		action = function(pos)
			local up = {x = pos.x, y = pos.y + 1, z = pos.z}
			if not bamboo_air(up) then return end
			for i = 1, 13 do
				local down = {x = pos.x, y = pos.y - i; z = pos.z}
				local dname = minetest.get_node(down).name
				if dname ~= modname .. ":bamboo_living" then
					return bamboo_soil(down) and minetest.set_node(up,
						{name = modname .. ":bamboo_living"})
				end
			end
		end,
	})

------------------------------------------------------------------------
-- LIGHTING FIX

local lightjobs = {}
minetest.register_lbm({
		name = modname .. ":bamboo_lighting",
		nodenames = {modname .. ":bamboo_living"},
		action = function(pos)
			pos = {
				x = math_floor(pos.x / 16) * 16,
				y = math_floor(pos.y / 16) * 16,
				z = math_floor(pos.z / 16) * 16,
			}
			lightjobs[minetest.hash_node_position(pos)] = pos
		end
	})
nodecore.register_globalstep(modname .. ":bamboo_lighting", function()
		if not next(lightjobs) then return end
		for _, pos in pairs(lightjobs) do
			local vm = minetest.get_voxel_manip(pos, {
					x = pos.x + 15,
					y = pos.y + 15,
					z = pos.z + 15
				})
			vm:write_to_map(true)
			vm:update_map()
		end
		lightjobs = {}
	end)
