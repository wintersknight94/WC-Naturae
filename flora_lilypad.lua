-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

minetest.register_node(modname .. ":lilypad", {
		description = "Lilypad",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = {modname .. "_lilypad.png", modname .. "_lilypad_bottom.png"},
		inventory_image = modname .. "_lilypad.png",
		wield_image = modname .. "_lilypad.png",
		use_texture_alpha = "clip",
		liquids_pointable = true,
		walkable = false,
		floodable = true,
--		silktouch = false,
		groups = {snappy = 1, flora = 1, flammable = 3},
		sounds = nodecore.sounds("nc_terrain_swishy"),
		node_placement_prediction = "",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -31/64, -0.5, 0.5, -15/32, 0.5}
		},
		selection_box = {
			type = "fixed",
			fixed = {-7/16, -0.5, -7/16, 7/16, -15/32, 7/16}
		},
--		drop = modname .. ":plant_fibers"
	})
	
minetest.register_decoration({
		label = {modname .. ":lilypad"},
		deco_type = "simple",
		place_on = {"group:soil", "group:crumbly", "group:stone"},
		sidelen = 16,
		noise_params = {
			offset = -0.12,
			scale = 0.3,
			spread = {x = 200, y = 200, z = 200},
			seed = 33,
			octaves = 3,
			persist = 0.7
		},
		y_max = 0,
		y_min = 0,
		decoration = modname .. ":lilypad",
		param2 = 0,
		param2_max = 3,
		place_offset_y = 1,
	})

local function lilycheck(pos)
	local below = {x = pos.x, y = pos.y - 1, z = pos.z}
	local bnode = minetest.get_node_or_nil(below)
	if bnode and minetest.get_item_group(bnode.name, "water") < 1 then
		minetest.remove_node(pos)
		return true
	end
end
minetest.register_lbm({
		name = modname .. ":lilycheck",
		run_at_every_load = true,
		nodenames = {modname .. ":lilypad"},
		action = lilycheck
	})

minetest.register_abm({
		label = "lilypads spreading",
		nodenames = {modname .. ":lilypad"},
		neighbors = {"group:water"},
		interval = 120,
		chance = 20,
		action = function(pos)
			if lilycheck(pos) then return end
			local gro = {x = pos.x + math_random(-1, 1), y = pos.y + math_random(-1, 1), z = pos.z + math_random(-1, 1)}
			local grodown = {x = gro.x, y = gro.y - 1, z = gro.z}
			local num = minetest.find_nodes_in_area(
				{x = pos.x + 1, y = pos.y - 1, z = pos.z + 1},
				{x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
				{"nc_terrain:water_source"})
			local dname = minetest.get_node(grodown).name
			if minetest.get_node(gro).name ~= "air" then return end
			if minetest.get_item_group(dname, "water") <= 0 then return end
			if #num > 3 and pos.y < 5 then
				nodecore.set_node(gro, {name = modname .. ":lilypad"})
			end
		end,
	})
	
minetest.register_node(modname .. ":mudlily", {
		description = "Mudlily",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		tiles = {modname .. "_lilypad.png", modname .. "_lilypad_bottom.png"},
		inventory_image = modname .. "_lilypad.png",
		wield_image = modname .. "_lilypad.png",
		use_texture_alpha = "clip",
		liquids_pointable = true,
		walkable = false,
		floodable = true,
--		silktouch = false,
		groups = {snappy = 1, flora = 1, flammable = 3},
		sounds = nodecore.sounds("nc_terrain_swishy"),
		node_placement_prediction = "",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -31/64, -0.5, 0.5, -15/32, 0.5}
		},
		selection_box = {
			type = "fixed",
			fixed = {-7/16, -0.5, -7/16, 7/16, -15/32, 7/16}
		},
		drop = modname .. ":lilypad"
	})
	
minetest.register_decoration({
		label = {modname .. ":mudlily"},
		deco_type = "simple",
		place_on = {"group:mud"},
		sidelen = 16,
		fill_ratio = 0.01,
		biomes = {"mudflat"},
		decoration = modname .. ":mudlily",
		param2 = 0,
		param2_max = 3
	})

