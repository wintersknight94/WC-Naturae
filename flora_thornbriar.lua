-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
local rootname = modname .. ":briar_root"
local visdirt = "nc_tree:humus"
local dirt = "nc_terrain:dirt_loose"
local rootdef = nodecore.underride({
	description = "Thorny Roots",
	drawtype = "plantlike_rooted",
	tiles = {"nc_tree_humus.png"},
	falling_visual = visdirt,
	special_tiles = {"nc_tree_tree_side.png^[mask:" ..modname.. "_stem_mask.png"},
	drop = dirt,
	no_self_repack = true,
	groups = {grassable = 0, soil = 1, roots = 1, damage_touch = 1, stack_as_node = 1}
}, minetest.registered_items[dirt] or {})
rootdef.groups.humus = nil
minetest.register_node(rootname, rootdef)
------------------------------------------------------------------------
minetest.register_node(modname .. ":vine_thorny", {
		description = "Thorny Vines",
		drawtype = "plantlike",
		paramtype = "light",
--		visual_scale = 0.5,
--		wield_scale = {x = 0.75, y = 0.75, z = 1.5},
--		collision_box = nodecore.fixedbox(-3/16, -0.5, -3/16, 3/16, 0, 3/16),
--		selection_box = nodecore.fixedbox(-3/16, -0.5, -3/16, 3/16, 0, 3/16),
		inventory_image = "[combine:24x24:4,4=" .. modname
		.. "_plant_fibers.png\\^[resize\\:16x16",
		tiles = {modname .. "_plant_fibers.png"},
		groups = {
			snappy = 1,
			flammable = 3,
			attached_node = 1,
			peat_grindable_item = 1
		},
		node_placement_prediction = "nc_items:stack",
--		place_as_item = true,
		sounds = nodecore.sounds("nc_terrain_swishy")
	})

minetest.register_node(modname .. ":thornbriar", {
		description = ("Thornbriar"),
		drawtype = "allfaces_optional",
		waving = 1,
		tiles = {modname .. "_thornbriar.png"},
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		silktouch = false,
		damage_per_second = 1,
		move_resistance = 2,
		groups = {
			snappy = 1,
			flora = 1,
			flammable = 2,
			attached_node = 1,
			damage_touch = 1,
			thorny = 1,
			[modname .. "_spread"] = 1,
			stack_as_node = 1
		},
--		drop = modname .. ":vine_thorny",
		sounds = nodecore.sounds("nc_terrain_swishy"),
		selection_box = {
			type = "fixed",
			fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16}
		},
		alternate_loose = {
			description = ("Brambles"),
			tiles = {modname .. "_thornbriar.png"},
			color = "olive",
			walkable = false,
			groups = {
				snappy = 1,
				leafy = 1,
				flammable = 1,
				falling_repose = 1,
				stack_as_node = 1,
				damage_touch = 0,
				thorny = 1,
				peat_grindable_item = 1,
				[modname .. "_spread"] = 0,
			}
		},
		no_repack = true,
	})
------------------------------------------------------------------------
minetest.register_abm({
	label = "Thornroot Regrowing",
	nodenames = {modname .. ":briar_root"},
	neighbors = {"group:soil", "group:moist", "group:water"},
	interval = 120,
	chance = 20,
	action = function(pos)
		local up = {x = pos.x, y = pos.y + 1, z = pos.z}
		local down = {x = pos.x, y = pos.y - 1; z = pos.z}
		local upname = minetest.get_node(up).name
			if upname == "air" then
				minetest.set_node(up,{name = modname .. ":thornbriar"})
		end
	end,
})
------------------------------------------------------------------------
minetest.register_abm({
	label = "Thornbriar Rerooting",
	nodenames = {modname .. ":thornbriar"},
	neighbors = {"group:soil"},
	interval = 120,
	chance = 20,
	action = function(pos)
		local down = {x = pos.x, y = pos.y - 1; z = pos.z}
		local dname = minetest.get_node(down).name
			if minetest.get_item_group(dname, "root") > 0 then
				return end
			if minetest.get_item_group(dname, "soil") > 0 then
				minetest.set_node(down,{name = modname .. ":briar_root"})
		end
	end,
})
------------------------------------------------------------------------
------------------------------------------------------------------------
local thornroot = {
	".....",
	".....",
	"..r..",
	".....",
	".....",
}
local thornbriar = {
	".....",
	".....",
	"..s..",
	".....",
	".....",
}
------------------------------------------------------------------------
nodecore.thornbriar_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		r = {name = modname.. ":briar_root", prob = 255},
		s = {name = modname.. ":thornbriar", prob = 250}	
	},
	{
		thornroot,
		thornbriar	
	},
	{
		yslice_prob = {
			{ypos = 1, prob = 255},
			{ypos = 2, prob = 255}
		}
	}
)
------------------------------------------------------------------------
------------------------------------------------------------------------
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"group:soil", "group:mud"},
	sidelen = 16,
	fill_ratio = 0.5,
	biomes = {"thicket"},
	y_min = -40,
	y_max = 200,
	schematic = nodecore.thornbriar_schematic,
	flags = "force_placement, place_center_x, place_center_z, all_floors",
--	place_offset_y = -1,
--	rotation = "random",
	replacements = {},
})
------------------------------------------------------------------------
local i = math.random(5)
------------------------------------------------------------------------
nodecore.register_craft({
		label = "break brambles into sticks",
		action = "pummel",
		duration = 3,
		toolgroups = {snappy = 1, choppy = 1},
		nodes = {
			{match = modname .. ":thornbriar_loose", replace = "air"}
		},
		items = {
			{name = "nc_tree:stick", count = i, scatter = i}
		},
		itemscatter = i
	})
------------------------------------------------------------------------
local x = math.random(3)
------------------------------------------------------------------------
nodecore.register_craft({
	label = "break thorny stem into sticks",
	action = "pummel",
	duration = 2,
	toolgroups = {crumbly = 1},
	nodes = {
		{match = modname.. ":briar_root", replace = "nc_terrain:dirt_loose"}
	},
	items = {
		{name = "nc_tree:stick", count = x, scatter = x}
	},
	itemscatter = x
})
