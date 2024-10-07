-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, math, math_random
    = minetest, nodecore, math, math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local rootname = modname .. ":shrub_root"
local visdirt = "nc_tree:humus"
local dirt = "nc_terrain:dirt_loose"
local rootdef = nodecore.underride({
	description = "Shrub Roots",
	drawtype = "plantlike_rooted",
	tiles = {"nc_tree_humus.png"},
	falling_visual = visdirt,
	special_tiles = {"nc_tree_tree_side.png^[mask:" ..modname.. "_stem_mask.png"},
	drop = dirt,
	no_self_repack = true,
	groups = {grassable = 0, soil = 1, roots = 1, choppy = 2, crumbly = 2}
}, minetest.registered_items[dirt] or {})
rootdef.groups.humus = nil
minetest.register_node(rootname, rootdef)
------------------------------------------------------------------------
minetest.register_node(modname .. ":shrub", {
	description = ("Shrub"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {modname .. "_shrub.png"},
	paramtype = "light",
	air_pass = true,
	sunlight_propagates = true,
	walkable = true,
	silktouch = false,
	groups = {
		snappy = 1,
		flora = 1,
		flammable = 3,
		attached_node = 1,
		green = 1,
		leafy = 1,
		shrub = 1,
--		[modname .. "_spread"] = 1
	},
	alternate_loose = {
		tiles = {modname .. "_shrub.png^nc_api_loose.png"},
		walkable = false,
		groups = {
			snappy = 1,
			leafy = 1,
			flammable = 1,
			attached_node = 0,
			falling_repose = 1,
			green = 1,
			stack_as_node = 1,
			shrub = 1,
--			decay_to_fibers = 1,
--			[modname .. "_spread"] = 0,
			peat_grindable_item = 1
		}
	},
	no_repack = true,
	sounds = nodecore.sounds("nc_terrain_swishy")
})
------------------------------------------------------------------------
local stemroot = {
	".....",
	".....",
	"..r..",
	".....",
	".....",
}
local shrubbery = {
	".....",
	".....",
	"..s..",
	".....",
	".....",
}
------------------------------------------------------------------------
nodecore.shrub_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		r = {name = modname.. ":shrub_root", prob = 255},
		s = {name = modname.. ":shrub", prob = 200},
		
	},
	{
		stemroot,
		shrubbery	
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255},
			{ypos = 2, prob = 255}
		}
	}
)
------------------------------------------------------------------------
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"group:soil"},
	sidelen = 16,
	fill_ratio = 0.01,
	biomes = {"unknown", "grassland", "thicket", "forest", "ancient_forest"},
	y_min = -2,
	y_max = 120,
	schematic = nodecore.shrub_schematic,
	flags = "force_placement, place_center_x, place_center_z, all_floors",
--	place_offset_y = -1,
--	rotation = "random",
	replacements = {},
})
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"group:soil"},
	sidelen = 16,
	fill_ratio = 0.001,
	biomes = {"rainforest", "stoneprairie", "stonewaste"},
	y_min = -2,
	y_max = 120,
	schematic = nodecore.shrub_schematic,
	flags = "force_placement, place_center_x, place_center_z, all_floors",
--	place_offset_y = -1,
--	rotation = "random",
	replacements = {},
})
------------------------------------------------------------------------
minetest.register_abm({
	label = "Shrub Rerooting",
	nodenames = {"group:shrub"},
	neighbors = {"group:soil"},
	interval = 60,
	chance = 20,
	action = function(pos)
		local up = {x = pos.x, y = pos.y + 1, z = pos.z}
		local down = {x = pos.x, y = pos.y - 1; z = pos.z}
		local dname = minetest.get_node(down).name
			if minetest.get_item_group(dname, "soil") >=0 then
				minetest.set_node(pos,{name = modname .. ":shrub"})
				minetest.set_node(down,{name = modname .. ":shrub_root"})
		end
	end,
})
------------------------------------------------------------------------
minetest.register_abm({
	label = "Shrubroot Regrowing",
	nodenames = {modname .. ":shrub_root"},
	neighbors = {"group:soil", "group:moist", "group:water"},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local below = {x = pos.x, y = pos.y - 1; z = pos.z}
		local anode = minetest.get_node(above)
		local bnode = minetest.get_node(below)
			if not nodecore.air_equivalent(anode) then
				return
			end
--			if bnode.name == "group:lux_cobble" then
			if minetest.get_item_group(bnode.name, "lux_cobble") == 1 then
				minetest.set_node(pos,{name = modname .. ":atomatillo_root"})
				minetest.set_node(above,{name = modname .. ":atomatillo_bush_0"})
			else	
				minetest.set_node(above,{name = modname .. ":shrub"})
			end
	end
})
------------------------------------------------------------------------
minetest.register_abm({
	label = "Shrub Dying",
	nodenames = {modname.. ":shrub_loose"},
	interval = 20,
	chance = 10,
	action = function(pos)
		if #nodecore.find_nodes_around(pos, {"group:moist", "group:water"}, 1) < 1
			then	nodecore.set_node(pos, {name = "nc_tree:leaves_loose"})
		end
	end,
	})
--nodecore.register_aism({
--	label = "shrub item dying",
--	interval = 20,
--	chance = 10,
--	itemnames = {modname .. ":shrub", modname.. ":shrub_loose"},
--	action = function(stack)
--		stack:set_name("nc_tree:leaves_loose")
--		return stack
--	end
--})
nodecore.register_aism({
	label = "shrub stack die",
	interval = 1,
	chance = 25,
	arealoaded = 2,
	itemnames = {modname .. ":shrub_loose"},
	action = function(stack, data)
		if data.toteslot then return end
		if data.player and data.list then
			local inv = data.player:get_inventory()
			for i = 1, inv:get_size(data.list) do
				local item = inv:get_stack(data.list, i):get_name()
				if minetest.get_item_group(item, "moist") > 0 then return end
			end
		end
		if #nodecore.find_nodes_around(data.pos, "group:moist", 2) > 0 then return end
		nodecore.sound_play("nc_terrain_swishy", {pos = data.pos})
		local taken = stack:take_item(1)
		taken:set_name("nc_tree:leaves_loose")
		if data.inv then taken = data.inv:add_item("main", taken) end
		if not taken:is_empty() then nodecore.item_eject(data.pos, taken) end
		return stack
	end
})
------------------------------------------------------------------------
local x = math.random(3)
nodecore.register_craft({
	label = "break shrub stem into sticks",
	action = "pummel",
	duration = 2,
	toolgroups = {crumbly = 1},
	nodes = {
		{match = modname.. ":shrub_root", replace = "nc_terrain:dirt_loose"}
	},
	items = {
		{name = "nc_tree:stick", count = x, scatter = x}
	},
	itemscatter = x
})

------------------------------------------------------------------------
