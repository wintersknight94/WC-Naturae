-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore, pairs, tonumber, type, vector
    = math, minetest, nodecore, pairs, tonumber, type, vector
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

------------------------------------------------------------------------
-- NODE DEFINITIONS

local diggroups = {
	cracky = true,
	crumbly = true,
	choppy = true,
	snappy = true,
	thumpy = true,
	scratchy = true
}

local mossy_groups = {}
nodecore.mossy_groups = mossy_groups

local function tileswith(olddef, suff)
	local tiles = {}
	for k, v in pairs(olddef.tiles) do
		if type(v) == "string" then
			v = v .. "^" .. modname .. "_" .. suff .. ".png"
		end
		tiles[k] = v
	end
	return tiles
end
local function groupswith(olddef, added)
	local groups = {snappy = 1, [added] = 1}
	for k, v in pairs(olddef.groups) do
		if not diggroups[k] then groups[k] = v end
	end
	return groups
end
local function blend(color, r, g, b)
	if (not color) or (color.a == 0) then return color end
	return {
		r = (color.r + r) / 2,
		g = (color.g + g) / 2,
		b = (color.b + b) / 2,
	}
end
local function register_mossy(subname, fromname)
	local olddef = minetest.registered_nodes[fromname]
	if not olddef then return end
	local livename = modname .. ":mossy_" .. subname
	minetest.register_node(livename, {
			description = "Mossy " .. olddef.description,
			tiles = tileswith(olddef, "mossy"),
			drop_in_place = fromname,
			groups = groupswith(olddef, "mossy"),
			sounds = nodecore.sounds("nc_terrain_crunchy"),
			paramtype = olddef.paramtype,
			paramtype2 = olddef.paramtype2,
			mapcolor = blend(olddef.mapcolor, 62, 101, 27),
		})
	local dyingname = modname .. ":mossy_" .. subname .. "_dying"
	minetest.register_node(dyingname, {
			description = "Blighted Mossy " .. olddef.description,
			tiles = tileswith(olddef, "mossy_dying"),
			drop_in_place = fromname,
			groups = groupswith(olddef, "mossy_dying"),
			sounds = nodecore.sounds("nc_terrain_crunchy"),
			paramtype = olddef.paramtype,
			paramtype2 = olddef.paramtype2,
			mapcolor = blend(olddef.mapcolor, 54, 41, 28),
		})
	local mossgroup = {
		original = fromname,
		mossy = livename,
		dying = dyingname
	}
	for _, v in pairs(mossgroup) do
		nodecore.mossy_groups[v] = mossgroup
	end
end
nodecore.register_mossy = register_mossy

register_mossy("cobble", "nc_terrain:cobble")
register_mossy("stone", "nc_terrain:stone")
-- XXX: LEGACY PRE-THATCH SUPPORT
register_mossy("thatch", minetest.registered_nodes["nc_flora:thatch"]
	and "nc_flora:thatch" or modname .. ":thatch")
register_mossy("trunk", "nc_tree:tree")
register_mossy("stump", "nc_tree:root")
register_mossy("dirt", "nc_terrain:dirt")
register_mossy("bricks", "nc_stonework:bricks_stone")
register_mossy("bricks_bonded", "nc_stonework:bricks_stone_bonded")
register_mossy("adobe", "nc_concrete:adobe")
register_mossy("adobe_bricks", "nc_stonework:bricks_adobe")
register_mossy("adobe_bricks_bonded", "nc_stonework:bricks_adobe_bonded")
register_mossy("sandstone", "nc_concrete:sandstone")
register_mossy("sandstone_bricks", "nc_stonework:bricks_sandstone")
register_mossy("sandstone_bricks_bonded", "nc_stonework:bricks_sandstone_bonded")
for i = 1, 7 do
	register_mossy("hstone" .. i, "nc_terrain:hard_stone_" .. i)
end
register_mossy("lodestone", "nc_lode:stone")
register_mossy("gravel", "nc_terrain:gravel")
register_mossy("decaylog", modname .. ":decayed_log")

------------------------------------------------------------------------
-- SPREADING ABM

local breathable_drawtypes = {
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
	plantlike_rooted = true,
	flowingliquid = true
}

local breathable_nodes = {}
minetest.after(0, function()
		for k, v in pairs(minetest.registered_nodes) do
			if breathable_drawtypes[v.drawtype] then
				breathable_nodes[k] = true
			end
		end
	end)

local function loaded(pos)
	return minetest.get_node_or_nil({x = pos.x - 1, y = pos.y - 1, z = pos.z - 1})
	and minetest.get_node_or_nil({x = pos.x + 1, y = pos.y - 1, z = pos.z - 1})
	and minetest.get_node_or_nil({x = pos.x - 1, y = pos.y + 1, z = pos.z - 1})
	and minetest.get_node_or_nil({x = pos.x + 1, y = pos.y + 1, z = pos.z - 1})
	and minetest.get_node_or_nil({x = pos.x - 1, y = pos.y - 1, z = pos.z + 1})
	and minetest.get_node_or_nil({x = pos.x + 1, y = pos.y - 1, z = pos.z + 1})
	and minetest.get_node_or_nil({x = pos.x - 1, y = pos.y + 1, z = pos.z + 1})
	and minetest.get_node_or_nil({x = pos.x + 1, y = pos.y + 1, z = pos.z + 1})
end

local alldirs = nodecore.dirs()
local function canbreathe(pos)
	for i = 1, #alldirs do
		local p = vector.add(pos, alldirs[i])
		local n = minetest.get_node(p)
		if breathable_nodes[n.name] then
			local l = nodecore.get_node_light(p);
			if l and l > 0 then
				return true
			end
		end
	end
end

local function setnodename(pos, oldnode, newname)
	return minetest.set_node(pos, {
			name = newname,
			param = oldnode.param,
			param2 = oldnode.param2,
		})
end

minetest.register_abm({
		label = "moss spreading",
		nodenames = {"group:mossy"},
		interval = 90,
		chance = 10,
		action = function(pos, node)
			if not loaded(pos) then return end
			if not canbreathe(pos) or #nodecore.find_nodes_around(pos, "group:mossy", 1) > 7 then
				local grp = mossy_groups[node.name]
				return grp and grp.original
				and setnodename(pos, node, grp.original)
			end
			local topos = {
				x = pos.x + math_random(-1, 1),
				y = pos.y + math_random(-1, 1),
				z = pos.z + math_random(-1, 1),
			}
			local tonode = minetest.get_node(topos)
			if minetest.get_item_group(tonode.name, "lux_emit") > 0 then
				local grp = mossy_groups[node.name]
				return grp and grp.dying
				and setnodename(pos, node, grp.dying)
			else
				local grp = mossy_groups[tonode.name]
				return grp and grp.mossy and tonode.name ~= grp.dying
				and canbreathe(topos)
				and setnodename(topos, tonode, grp.mossy)
			end
		end
	})

minetest.register_abm({
		label = "moss blight",
		nodenames = {"group:mossy_dying"},
		interval = 20,
		chance = 10,
		action = function(pos, node)
			if not loaded(pos) then return end
			if not canbreathe(pos) then
				local grp = mossy_groups[node.name]
				return grp and grp.original
				and setnodename(pos, node, grp.original)
			end
			local found = nodecore.find_nodes_around(pos, "group:mossy", 1)
			if #found < 1 then
				local grp = mossy_groups[node.name]
				return grp and grp.original
				and setnodename(pos, node, grp.original)
			end
			local picked = found[math_random(1, #found)]
			local tonode = minetest.get_node(picked)
			local grp = mossy_groups[tonode.name]
			return grp and grp.dying and canbreathe(picked)
			and setnodename(picked, tonode, grp.dying)
		end
	})

minetest.register_chatcommand("moss_blight", {
		description = "Blight all nearby moss",
		privs = {server = true},
		params = "[radius]",
		func = function(pname, param)
			local player = minetest.get_player_by_name(pname)
			if not player then return end
			local pos = player:get_pos()
			param = tonumber(param) or 5
			if param < 0 then param = 0 end
			if param > 79 then param = 79 end
			for _, p in pairs(nodecore.find_nodes_around(pos, "group:mossy", param)) do
				local node = minetest.get_node(p)
				local grp = mossy_groups[node.name]
				if grp and grp.dying then
					setnodename(p, node, grp.dying)
				end
			end
		end
	})
minetest.register_chatcommand("moss_remove", {
		description = "Remove all nearby moss",
		privs = {server = true},
		params = "[radius]",
		func = function(pname, param)
			local player = minetest.get_player_by_name(pname)
			if not player then return end
			local pos = player:get_pos()
			param = tonumber(param) or 5
			if param < 0 then param = 0 end
			if param > 79 then param = 79 end
			for _, p in pairs(nodecore.find_nodes_around(pos, {
						"group:mossy", "group:mossy_dying"
					}, param)) do
				local node = minetest.get_node(p)
				local grp = mossy_groups[node.name]
				if grp and grp.original then
					setnodename(p, node, grp.original)
				end
			end
		end
	})
