-- LUALOCALS < ---------------------------------------------------------
local  minetest, nodecore, math
	= minetest, nodecore, math
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local skin = "nc_igneous_pumice.png^[colorize:darkorange:50"
local hollow = "nc_fire_coal_4.png^[mask:" ..modname.. "_mask_pumpkin.png"
local hollowface = "(" ..skin.. ")^(" ..hollow.. ")"
------------------------------------------------------------------------
minetest.register_node(modname .. ":pumseed", {
		description = "Pumseed",
		drawtype = "plantlike",
		paramtype = "light",
		visual_scale = 0.5,
		wield_scale = {x = 0.75, y = 0.75, z = 1.5},
		collision_box = nodecore.fixedbox(-3/16, -0.5, -3/16, 3/16, 0, 3/16),
		selection_box = nodecore.fixedbox(-3/16, -0.5, -3/16, 3/16, 0, 3/16),
		inventory_image = "[combine:24x24:4,4=" .. modname
		.. "_pumseed.png\\^[resize\\:16x16",
		tiles = {modname .. "_pumseed.png"},
		groups = {
			snappy = 1,
			flammable = 3,
			attached_node = 1,
		},
		node_placement_prediction = "nc_items:stack",
		place_as_item = true,
		sounds = nodecore.sounds("nc_tree_corny")
	})
----------Pumpkin----------
minetest.register_node(modname.. ":pumpkin", {
	description = "Pumpkin",
		tiles = {skin},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.5, 0.5, 0.1875, 0.5}, -- Middle
			{-0.375, -0.5, -0.375, 0.375, 0.25, 0.375}, -- Core
			{-0.25, 0.25, -0.25, 0.25, 0.3125, 0.25}, -- Top
			{-0.0625, 0.25, -0.0625, 0.0625, 0.5, 0.0625}, -- Stem
			{-0.125, 0.3125, -0.125, 0.125, 0.375, 0.125}, -- StemBase
		}
	},
	collision_box = nodecore.fixedbox(),
	selection_box = nodecore.fixedbox(),
	sunlight_propagates = true,
	groups = {
		stack_as_node = 1,
		snappy = 1,
		gourd = 1,
--		[modname .. "_spread"] = 1,
		peat_grindable_node = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
----------Carved----------
minetest.register_node(modname.. ":pumpkin_carved", {
	description = "Carved Pumpkin",
		tiles = {
			skin,
			skin,
			hollowface
		},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.4375, -0.5, 0.5, 0.1875, 0.5}, -- Middle
			{-0.375, -0.5, -0.375, 0.375, 0.25, 0.375}, -- Core
			{-0.25, 0.25, -0.25, 0.25, 0.3125, 0.25}, -- Top
			{-0.0625, 0.25, -0.0625, 0.0625, 0.5, 0.0625}, -- Stem
			{-0.125, 0.3125, -0.125, 0.125, 0.375, 0.125}, -- StemBase
		}
	},
	collision_box = nodecore.fixedbox(),
	selection_box = nodecore.fixedbox(),
	sunlight_propagates = true,
	groups = {
		stack_as_node = 1,
		snappy = 1,
		gourd = 1,
		peat_grindable_node = 1
	},
	stack_max = 1,
	sounds = nodecore.sounds("nc_tree_woody"),
})
----------Decoration----------
minetest.register_decoration({
		label = {modname .. ":pumpkin"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.00025,
		biomes = {"grassland", "stoneprairie", "stonewaste", "rainforest"},
		y_max = 80,
		y_min = 2,
		decoration = {modname .. ":pumpkin"}
	})
----------Craft----------
nodecore.register_craft({
	label = "carve pumpkin",
	action = "pummel",
	duration = 4,
	toolgroups = {thumpy = 2},
	normal = {y = 1},
	indexkeys = {"group:chisel"},
	nodes = {
		{
		match = {
--			lode_temper_cool = true,
			groups = {chisel = true}
			},
		dig = true
		},
		{
			y = -1,
			match = modname.. ":pumpkin",
			replace = modname .. ":pumpkin_carved"
		}
	},
	items = {
			{name = modname..":pumseed", count = 1, scatter = 3},
		},
})
----------Joke----------
nodecore.register_craft({
		label = "smash pumpkin",
		action = "pummel",
		duration = 0.01,
		toolgroups = {thumpy = 3},
		nodes = {
			{
				match = {groups = {gourd = true}},
				replace = "air"
			}
		},
		items = {
			{name = modname..":pumseed", count = 3, scatter = 3},
			{name = "nc_tree:stick", count = 1, scatter = 3}
		},
		itemscatter = 3
	})
------------------------------------------------------------------------
local epname = modname .. ":pumseed_planted"
------------------------------------------------------------------------
local function soilboost(pos, name)
	local def = minetest.registered_items[name]
	local soil = def.groups.soil or 0
	if soil > 2 then
		nodecore.soaking_abm_push(pos, "pumseed", (soil - 2) * 500)
		nodecore.soaking_particles(pos, (soil - 2) * 10,
			0.5, .45, modname .. ":pumpkin")
	end
end
nodecore.register_item_entity_step(function(self)
		if self.itemstring ~= modname .. ":pumseed" then
			return
		end

		local pos = self.object:get_pos()
		if not pos then return end

		local curnode = minetest.get_node(pos)
		if minetest.get_item_group(curnode.name, "dirt_loose") < 1 then
			return
		end

		nodecore.set_loud(pos, {name = epname})
		self.itemstring = ""
		self.object:remove()

		soilboost(pos, curnode.name)
	end)
nodecore.register_craft({
		label = "pumseed planting",
		action = "stackapply",
		wield = {groups = {dirt_loose = true}},
		consumewield = 1,
		indexkeys = {modname .. ":pumseed"},
		nodes = {{match = modname .. ":pumseed", replace = epname}},
		after = function(pos, data)
			soilboost(pos, data.wield:get_name())
		end
	})
local ldname = "nc_terrain:dirt_loose"
local epdef = nodecore.underride({
		description = "Pumsprout",
		drawtype = "plantlike_rooted",
		falling_visual = "nc_terrain:dirt_loose",
		special_tiles = {modname .. "_pumseed_planted.png"},
		drop = ldname,
		no_self_repack = true,
		groups = {grassable = 0}
	}, minetest.registered_items[ldname] or {})
epdef.groups.soil = nil
minetest.register_node(epname, epdef)

------------------------------------------------------------------------
-- ================================================================== --
local function growparticles(pos, rate, width)
	nodecore.soaking_particles(pos, rate, 10, width, "nc_tree:leaves_bud")
end

local sproutcost = 2000
nodecore.register_soaking_abm({
		label = "pumpkin sprout",
		fieldname = "pumseed",
		nodenames = {modname .. ":pumseed_planted"},
		interval = 10,
		arealoaded = 1,
		soakrate = nodecore.tree_growth_rate,
		soakcheck = function(data, pos)
			if data.total >= sproutcost then
				nodecore.node_sound(pos, "dig")
				nodecore.set_loud(pos, {name = "nc_terrain:dirt"})
				local apos = {x = pos.x, y = pos.y + 1, z = pos.z}
				local anode = minetest.get_node(apos)
				if anode.name == "air" then
					nodecore.set_loud(apos,
						{name = modname .. ":pumpkin", param2 = 1})
					nodecore.witness(apos, "pumpkin growth")
				end
			end
			return growparticles(pos, data.rate, 0.2)
		end
	})

