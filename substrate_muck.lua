-- LUALOCALS < ---------------------------------------------------------
local include, minetest, nodecore, pairs, vector
    = include, minetest, nodecore, pairs, vector
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local muckwet = modname .. ":muck"
local muckdry = "nc_terrain:dirt"

local muckdirs = {
	{x = 1, y = 0, z = 0},
	{x = -1, y = 0, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z = -1}
}

local function findwater(pos)
	return nodecore.find_nodes_around(pos, "group:water")
end

local function soakup(pos)
	local any
	for _, p in pairs(findwater(pos)) do
		nodecore.node_sound(p, "dig")
		minetest.remove_node(p)
		any = true
	end
	return any
end

-- ================================================================== --

minetest.register_node(modname .. ":muck", {
		description = "Muck",
		tiles = {"nc_terrain_dirt.png^"..modname.."_mossy_dying.png"},
		groups = {
			mud = 1,
			moist = 1,
			coolant = 1,
			crumbly = 1,
			falling_repose = 1,
			slippery = 4,
			soil = 1
		},
		sounds = nodecore.sounds("nc_terrain_chompy")
	})

nodecore.register_craft({
		label = "squeeze muck",
		action = "pummel",
		toolgroups = {thumpy = 1},
		indexkeys = {muckwet},
		nodes = {
			{
				match = muckwet,
				replace = muckdry
			}
		},
		after = function(pos)
			local found
			for _, d in pairs(muckdirs) do
				local p = vector.add(pos, d)
				if nodecore.artificial_water(p, {
						matchpos = pos,
						match = muckwet,
						minttl = 1,
						maxttl = 10
					}) then found = true end
			end
			if found then nodecore.node_sound(pos, "dig") end
		end
	})

nodecore.register_aism({
		label = "muck stack sun dry",
		interval = 1,
		chance = 40,
		itemnames = {modname .. ":muck"},
		action = function(stack, data)
			if data.player and (data.list ~= "main"
				or data.slot ~= data.player:get_wield_index()) then return end
			if data.pos and nodecore.is_full_sun(data.pos)
			and #findwater(data.pos) < 1 then
				nodecore.sound_play("nc_api_craft_hiss", {gain = 0.02, pos = data.pos})
				local taken = stack:take_item(1)
				taken:set_name("nc_terrain:dirt")
				if data.inv then taken = data.inv:add_item("main", taken) end
				if not taken:is_empty() then nodecore.item_eject(data.pos, taken) end
				return stack
			end
		end
	})

minetest.register_abm({
		label = "muck fire dry",
		interval = 1,
		chance = 20,
		nodenames = {modname .. ":muck"},
		neighbors = {"group:igniter"},
		action = function(pos)
			nodecore.sound_play("nc_api_craft_hiss", {gain = 0.02, pos = pos})
			return minetest.set_node(pos, {name = muckdry})
		end
	})
	
minetest.register_ore({
		ore_type = "blob",
		ore  = modname.. ":muck",
		wherein = {"nc_terrain:dirt_with_grass", "nc_terrain:dirt", "nc_terrain:sand", "nc_terrain:gravel"},
		biomes = {"thicket", "floodland"},
		clust_scarcity = 16 * 16 * 16,
		clust_size = 11,
		y_max = 5,
		y_min = -30,
		noise_threshold = 0.0,
		noise_params = {
			offset = 0.5,
			scale = 0.2,
			spread = {x = 5, y = 5, z = 5},
			seed = -316,
			octaves = 1,
			persist = 0.0
		},
	})

