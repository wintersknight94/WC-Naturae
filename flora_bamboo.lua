-- LUALOCALS < ---------------------------------------------------------
local math, minetest, next, nodecore, pairs
    = math, minetest, next, nodecore, pairs
local math_floor, math_random
    = math.floor, math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
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
local function bamboo_living(pos)
	local node = minetest.get_node(pos)
	local alive = minetest.get_item_group(node.name, "bamboo_living")
	return alive and alive > 0
end
------------------------------------------------------------------------
local bamboo_nodebox_0 = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625},		-- Shaft
			{-0.125, -0.5, -0.125, 0.125, -0.4375, 0.125}		-- Ridge
		}
	}
local bamboo_nodebox_1 = {
	type = "fixed",
	fixed = {
		{-0.125, -0.4375, -0.125, 0.125, 0.5, 0.125},			-- Shaft
		{-0.1875, -0.5, -0.1875, 0.1875, -0.4375, 0.1875}			-- Ridge
	}
}
local bamboo_nodebox_2 = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},		-- Shaft
			{-0.25, -0.5, -0.25, 0.25, -0.4375, 0.25}			-- Ridge
		}
	}
local bamboo_nodebox_3 = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},				-- Shaft
			{-0.3125, -0.5, -0.3125, 0.3125, -0.4375, 0.3125}	-- Ridge
		}
	}
local bamboo_nodebox_4 = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0.5, 0.3125},		-- Shaft
			{-0.375, -0.5, -0.375, 0.375, -0.4375, 0.375}		-- Ridge
		}
	}
local bamboo_nodebox_5 = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},			-- Shaft
			{-0.4375, -0.5, -0.4375, 0.4375, -0.4375, 0.4375},	-- Ridge
		}
	}
------------------------------------------------------------------------
local function bamboo(desc, deadesc, size, nbox)
local bamboo_side = modname .. "_bamboo.png"
local bamboo_end = modname .. "_bamboo.png^(" ..modname.. "_bamboo_hole_mask.png^[colorize:brown^[opacity:50)"
local bamboo_dead_side = modname .. "_bamboo_dead.png"
local bamboo_dead_end = modname .. "_bamboo_dead.png^(" ..modname.. "_bamboo_hole_mask.png^[opacity:75)"
------------------------------------------------------------------------
minetest.register_node(modname .. ":bamboo_living_" ..size, {
		description = desc.. " Living Bamboo",
		drawtype = "nodebox",
		node_box = nbox,
		tiles = {bamboo_end, bamboo_end, bamboo_side},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		on_place = minetest.rotate_node,
		climbable = true,
		groups = {
			choppy = size,
			flammable = 2,
			fire_fuel = 1,
			bamboo_living = size,
			falling_node = 1
		},
		sounds = nodecore.sounds("nc_tree_sticky"),
	})
minetest.register_node(modname .. ":bamboo_dead_" ..size, {
		description = deadesc.. " Dead Bamboo",
		drawtype = "nodebox",
		node_box = nbox,
		tiles = {bamboo_dead_end, bamboo_dead_end, bamboo_dead_side},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		on_place = minetest.rotate_node,
		climbable = true,
		groups = {
			choppy = size,
			flammable = 2,
			fire_fuel = 1,
			bamboo_dead = size
		},
		sounds = nodecore.sounds("nc_tree_sticky")
	})
------------------------------------------------------------------------
nodecore.register_aism({
		label = "bamboo convert",
		interval = 1,
		chance = 1,
		itemnames = {modname .. ":bamboo_living_" ..size},
		action = function(stack)
			stack:set_name(modname .. ":bamboo_dead_" ..size)
			return stack
		end
	})
	
end
------------------------------------------------------------------------
bamboo("Young",		"Thin",		1,	bamboo_nodebox_0)	--
bamboo("Adolescent",	"Small",		2,	bamboo_nodebox_1)	--
bamboo("Middle-aged",	"Medium",		3,	bamboo_nodebox_2)	--
bamboo("Old",			"Large",		4,	bamboo_nodebox_3)	--
bamboo("Ancient",		"Massive",	5,	bamboo_nodebox_4)	--

------------------------------------------------------------------------
minetest.register_alias_force(modname .. ":bamboo", modname .. ":bamboo_living_2")
minetest.register_alias_force(modname .. ":bamboo_living", modname .. ":bamboo_living_2")
------------------------------------------------------------------------
minetest.register_abm({
		label = "bamboo spreading",
		nodenames = {"group:bamboo_living"},
		neighbors = {"group:water","group:moist"},
		interval = 120,
		chance = 20,
		action = function(pos)
			if pos.y >= 50 then return end
			if #nodecore.find_nodes_around(pos, {"group:soil", "group:gravel", "group:sand"}, 1) < 3
			then return end

			local gro = {
				x = pos.x + math_random(-1, 1),
				y = pos.y + math_random(-1, 1),
				z = pos.z + math_random(-1, 1)
			}
			if not bamboo_air(gro) then return end

			local grodown = {x = gro.x, y = gro.y - 1, z = gro.z}
			if not bamboo_soil(grodown) then return end

			nodecore.set_node(gro, {name = modname .. ":bamboo_living_1"})
		end,
	})

for n = 1, 5 do
	minetest.register_abm({
		label = "bamboo growing",
		nodenames = {modname .. ":bamboo_living_" ..n},
		interval = 60, --60,
		chance = 10, --10,
		action = function(pos)
			local up = {x = pos.x, y = pos.y + 1, z = pos.z}
			if not bamboo_air(up) then return end
			for i = 1, 13 do
				local down = {x = pos.x, y = pos.y - i; z = pos.z}
				local dname = minetest.get_node(down).name
--				if dname ~= modname .. ":bamboo_living_" ..n then
				if minetest.get_item_group(dname, "bamboo_living") <=0 then
					return bamboo_soil(down) and minetest.set_node(up,
						{name = modname .. ":bamboo_living_1"})
				end
			end
		end,
	})
------------------------------------------------------------------------
nodecore.register_craft({
		label = "split bamboo into staves",
		action = "pummel",
		toolgroups = {choppy = 1},
		nodes = {{match = modname .. ":bamboo_dead_" ..n, replace = "air"}},
		items = {
			{name = "nc_woodwork:staff", count = n, scatter = n},
			{name = "nc_woodwork:plank", count = n-3, scatter = n}
		},
		itemscatter = n
	})
end
------------------------------------------------------------------------
for n = 1, 3 do
	minetest.register_abm({
		label = "bamboo aging " ..n,
		nodenames = {modname .. ":bamboo_living_" ..n},
		interval = 3600, 	--900,
		chance = 1, 	--10,
		action = function(pos)
			local up = {x = pos.x, y = pos.y + 1, z = pos.z}
			local down = {x = pos.x, y = pos.y - 1; z = pos.z}
			local dname = minetest.get_node(down).name
--			if not bamboo_living(up) then return end
				if minetest.get_item_group(dname, "bamboo_living") >=0 then
					minetest.set_node(pos,{name = modname .. ":bamboo_living_" ..n+1})
			end
		end,
	})
------------------------------------------------------------------------
minetest.register_decoration({
		label = modname .. ":bamboo_living_" ..n,
		deco_type = "simple",
		place_on = {"group:soil", "nc_terrain:sand", "group:mud"},
		sidelen = 16,
		fill_ratio = 0.01,
		y_max = 200,
		y_min = 1,
		decoration = modname .. ":bamboo_living_" ..n,
		height = n,
		height_max = n+10,
		biomes = {"thicket", "floodland", "rainforest"}
	})
end
------------------------------------------------------------------------
minetest.register_decoration({
		label = modname .. ":bamboo_living_4",
		deco_type = "simple",
		place_on = {"group:soil", "group:mud"},
		sidelen = 16,
		fill_ratio = 0.0001,
		y_max = 200,
		y_min = 1,
		decoration = modname .. ":bamboo_living_4",
		height = 4,
		height_max = 14,
		biomes = {"thicket", "floodland", "rainforest"}
	})
------------------------------------------------------------------------
for m = 1, 2 do
minetest.register_decoration({
		label = modname .. ":bamboo_living_" ..m,
		deco_type = "simple",
		place_on = {"group:mud"},
		sidelen = 16,
		fill_ratio = 0.001,
		y_max = 200,
		y_min = 1,
		decoration = modname .. ":bamboo_living_" ..m,
		height = m*2,
		height_max = m*6,
		biomes = {"mudflat", "rainforest"}
	})
end
------------------------------------------------------------------------
-- LIGHTING FIX (no longer necessary)

--local lightjobs = {}
--minetest.register_lbm({
--		name = modname .. ":bamboo_lighting",
--		nodenames = {"group:bamboo_living"},
--		action = function(pos)
--			pos = {
--				x = math_floor(pos.x / 16) * 16,
--				y = math_floor(pos.y / 16) * 16,
--				z = math_floor(pos.z / 16) * 16,
--			}
--			lightjobs[minetest.hash_node_position(pos)] = pos
--		end
--	})
--nodecore.register_globalstep(modname .. ":bamboo_lighting", function()
--		if not next(lightjobs) then return end
--		for _, pos in pairs(lightjobs) do
--			local vm = minetest.get_voxel_manip(pos, {
--					x = pos.x + 15,
--					y = pos.y + 15,
--					z = pos.z + 15
--				})
--			vm:write_to_map(true)
--			vm:update_map()
--		end
--		lightjobs = {}
--	end)
