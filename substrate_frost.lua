-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local water = "nc_terrain_water.png^[verticalframe:32:8"
local glass = "nc_optics_glass_glare.png"
local dirt = "nc_terrain_dirt.png"
local grass = "nc_terrain_grass_top.png^[colorize:white:75"
------------------------------------------------------------------------
local ice = "((" ..water.. ")^(" ..glass.. "))^[colorize:aqua:100"
local grasside = "(" ..grass.. ")^[mask:nc_terrain_grass_sidemask.png"
local grassdirt = "(" ..dirt.. ")^(" ..grasside.. ")"
-- ================================================================== --
minetest.register_node(modname .. ":ice", {
	description = "Ice",
	tiles = {ice},
	groups = {
		ice = 1,
		frozen = 1,
		coolant = 1,
		cracky = 3,
		slippery = 20
	},
	mapgen = {"ice"},
	sounds = nodecore.sounds("nc_optics_glassy")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":dirt_with_ice", {
	description = "Permafrost",
	tiles = {dirt.. "^(" ..glass.. ")"},
	groups = {
		soil = 1,
		frozen = 1,
		coolant = 1,
		crumbly = 3,
		slippery = 1
	},
	drop_in_place = "nc_terrain:dirt",
	sounds = nodecore.sounds("nc_terrain_chompy")
})
------------------------------------------------------------------------
minetest.register_node(modname .. ":grass_with_frost", {
	description = "Frosted Grass",
	mapgen = {"dirt_with_snow"},
	tiles = {
		grass,
		dirt,
		grassdirt
	},
	groups = {
		soil = 1,
		grass = 1,
		frozen = 1,
		crumbly = 3,
		slippery = 1
	},
	drop_in_place = "nc_terrain:dirt",
	sounds = nodecore.sounds("nc_terrain_chompy")
})
-- ================================================================== --
-- ================================================================== --
local grass_under_nodes = {}
do
	local breathable = {
		airlike = true,
		allfaces = true,
		allfaces_optional = true,
		torchlike = true,
		signlike = true,
		plantlike = true,
		firelike = true,
		raillike = true,
		nodebox = true,
		mesh = true,
		plantlike_rooted = true
	}
	minetest.after(0, function()
			for name, def in pairs(minetest.registered_nodes) do
				if def.drawtype and breathable[def.drawtype]
				and (not (def.groups and def.groups.moist))
				and (def.damage_per_second or 0) <= 0 then
					grass_under_nodes[name] = true
				end
			end
		end)
end

-- nil = stay, false = die, true = grow
local function can_grass_grow_under(above)
	local nodename = minetest.get_node(above).name
	if nodename == "ignore" then return end
	if (not grass_under_nodes[nodename]) then return false end
	local ln = nodecore.get_node_light(above)
	if not ln then return end
	return ln >= 10
end
nodecore.can_grass_grow_under = can_grass_grow_under
------------------------------------------------------------------------
minetest.register_abm({
		label = "frostgrass spread",
		nodenames = {"group:grassable"},
		neighbors = {modname.. ":grass_with_frost"},
		neighbors_invert = true,
		interval = 300,
		chance = 64,
		action = function(pos)
			local above = {x = pos.x, y = pos.y + 1, z = pos.z}
			if not can_grass_grow_under(above) then return end
			return minetest.set_node(pos, {name = "nc_terrain:dirt_with_grass"})
		end
	})
-- ================================================================== --
minetest.register_abm({
		label = "frostgrass decay",
		nodenames = {modname.. ":grass_with_frost"},
		interval = 12,
		chance = 64,
		action = function(pos)
			local above = {x = pos.x, y = pos.y + 1, z = pos.z}
			if can_grass_grow_under(above) ~= false then return end
			return minetest.set_node(pos, {name = modname .. ":dirt_with_ice"})
		end
	})