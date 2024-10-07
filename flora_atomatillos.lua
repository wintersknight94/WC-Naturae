-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, math
    = minetest, nodecore, math
local math_random
    = math.random
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
minetest.register_node(modname.. ":atomatillo", {
	description = "Atomatillo",
--	tiles = {"nc_terrain_grass_top.png^[colorize:lime:64"},
	inventory_image = modname.. "_pepper.png",
	wield_image = modname.. "_pepper.png",
--	drawtype = "nodebox",
	paramtype = "light",
--	node_box = {
--		type = "fixed",
--		fixed = {
--			{-0.0625, -0.5, -0.0625, 0.0625, 0, 0.0625}, -- Stem
--			{-0.125, -0.4375, -0.125, 0.125, -0.125, 0.125}, -- Fruit
--		}
--	},
	groups = {
		snappy = 1,
		fruit = 1,
		pepper = 1,
	},
	node_placement_prediction = "nc_items:stack",
	place_as_item = true,
	light_source = 1, glow = 1,
	sounds = nodecore.sounds("nc_tree_corny"),
})
------------------------------------------------------------------------
local rootname = modname .. ":atomatillo_root"
local visdirt = "nc_tree:humus"
local dirt = "nc_terrain:dirt_loose"
local rootdef = nodecore.underride({
	description = "Blastbramble",
	drawtype = "plantlike_rooted",
	tiles = {"nc_tree_humus.png"},
	falling_visual = visdirt,
--	falling_visual = {"nc_tree_humus.png"},
	special_tiles = {"nc_tree_tree_side.png^[mask:" ..modname.. "_stem_mask.png"},
	drop = dirt,
	groups = {grassable = 0, soil = 1, roots = 1, choppy = 2, crumbly = 2}
}, minetest.registered_items[dirt] or {})
rootdef.groups.humus = nil
minetest.register_node(rootname, rootdef)
------------------------------------------------------------------------
local peppers = "(nc_flora_sedge_color.png^[colorize:lime:128)^[mask:nc_flora_flower_5_top.png"
local shrubbery = modname.. "_shrub.png^" ..modname.. "_thornbriar.png"
for i = 0,3 do
	minetest.register_node(modname .. ":atomatillo_bush_" ..i, {
		description = ("Blastbramble"),
		drawtype = "allfaces_optional",
		waving = 1,
		tiles = {shrubbery},
		paramtype = "light",
		air_pass = true,
		sunlight_propagates = true,
		walkable = false,
		silktouch = false,
		groups = {
			snappy = 1,
			flora = 1,
			flammable = 3,
			attached_node = 1,
			green = 1,
			leafy = 1,
			bush = 1,
			damage_touch = 1,
		},
		damage_per_second = 1,
		move_resistance = 2,
		light_source = i,
		drop_in_place = modname.. ":thornbriar_loose",
		sounds = nodecore.sounds("nc_terrain_swishy")
	})
-- ================================================================== --
	minetest.register_abm({
		label = "Atomatillo Growth",
		nodenames = {modname .. ":atomatillo_bush_" ..i},
		neighbors = {"group:water", "group:moist"},
		interval = 300,
		chance = 12,
		action = function(pos)
			local above = {x = pos.x, y = pos.y + 1, z = pos.z}
			local grow = i+1
--			if not nodecore.buildable_to(above) then
--				return
--			end
			if i == 3 then 
				return 
			end
			if #nodecore.find_nodes_around(pos, "group:lux_emit", 3) > 0 then
				return nodecore.set_loud(pos, {name = modname .. ":atomatillo_bush_" ..grow})
			end
		end
	})
end
-- ================================================================== --
-- ================================================================== --
minetest.register_abm({
	label = "Blastbramble Regrowing",
	nodenames = {modname .. ":atomatillo_root"},
	neighbors = {"group:soil", "group:moist", "group:water"},
	interval = 120, --120
	chance = 20,
	action = function(pos)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local anode = minetest.get_node(above)
			if nodecore.air_equivalent(anode) then
				minetest.set_node(above,{name = modname .. ":atomatillo_bush_0"})
			end
	end,
})
------------------------------------------------------------------------
-- ================================================================== --
-- ================================================================== --
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
nodecore.bush_schematic = nodecore.ezschematic(
	{
		["."] = {name = "air", prob = 0},
		r = {name = modname.. ":atomatillo_root", prob = 255},
		s = {name = modname.. ":atomatillo_bush_0", prob = 200},
		
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
-- ================================================================== --
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"group:soil"},
	sidelen = 16,
	fill_ratio = 0.0001,
	biomes = {"unknown", "grassland", "thicket", "rainforest", "stoneprairie", "stonewaste"},
	y_min = -32,
	y_max = 128,
	schematic = nodecore.bush_schematic,
	flags = "force_placement, place_center_x, place_center_z, all_floors",
--	place_offset_y = -1,
--	rotation = "random",
	replacements = {},
})
-- ================================================================== --
-- ================================================================== --
-- ================================================================== --
minetest.override_item(modname.. ":atomatillo_bush_3",{
	overlay_tiles = {
		"(" ..peppers.. ")^[opacity:240",
	},
	groups = {
			snappy = 1,
			flora = 1,
			flammable = 3,
			attached_node = 1,
			green = 1,
			leafy = 1,
			bush = 1,
			lux_emit = 1
		},
	on_dig = function(pos)
			local y = math.random(6)
			minetest.set_node(pos, {name = modname.. ":thornbriar_loose"})
			nodecore.item_eject(pos, {name = modname.. ":atomatillo"}, y, y)
		end
})
-- ================================================================== --
-- ================================================================== --
-- ================================================================== --
-- ================================================================== --
local epname = modname .. ":atomatillo_root"
local function soilboost(pos, name)
	local def = minetest.registered_items[name]
	local soil = def.groups.soil or 0
	if soil > 2 then
		nodecore.soaking_abm_push(pos, "atomatillo", (soil - 2) * 500)
		nodecore.soaking_particles(pos, (soil - 2) * 10,
			0.5, .45, modname .. ":atomatillo")
	end
end
nodecore.register_item_entity_step(function(self)
		if self.itemstring ~= modname .. ":atomatillo" then
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
		label = "atomatillo planting",
		action = "stackapply",
		wield = {groups = {dirt_loose = true}},
		consumewield = 1,
		indexkeys = {modname .. ":atomatillo"},
		nodes = {{match = modname .. ":atomatillo", replace = modname.. ":atomatillo_root"}},
		after = function(pos, data)
			soilboost(pos, data.wield:get_name())
		end
	})
-- ================================================================== --
-- ================================================================== --
nodecore.register_aism({
		label = "atomatillo ignition",
		interval = 10,
		chance = 2,
		arealoaded = 2,
		itemnames = {modname .. ":atomatillo"},
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
			nodecore.sound_play("nc_api_toolbreak", {pos = data.pos})
			nodecore.firestick_spark_ignite(data.pos,true)
			local taken = stack:take_item(1)
			taken:set_name("nc_fire:fire")
--			if data.inv then taken = data.inv:add_item("main", taken) end
			if not taken:is_empty() then nodecore.item_eject(data.pos, taken) end
			return stack
		end
	})
	
