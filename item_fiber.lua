-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

minetest.register_craftitem(modname .. ":plant_fibers", {
		description = ("Plant Fibers"),
		inventory_image = modname .. "_plant_fibers.png",
		wield_image = modname .. "_plant_fibers.png",
		groups = {snappy = 1, flammable = 1},
		sounds = nodecore.sounds("nc_terrain_swishy"),
	})

nodecore.register_craft({
		label = "grind plants into fibers",
		action = "pummel",
		toolgroups = {crumbly = 2},
		nodes = {
			{
				match = {stacked = true, groups = {flora_dry = true}, count = false}
			}
		},
		after = function(pos)
			local stack = nodecore.stack_get(pos)
			stack:set_name(modname .. ":plant_fibers")
			nodecore.stack_set(pos, stack)
		end
	})

nodecore.register_craft({
		label = "grind plant fibers to peat",
		action = "pummel",
		toolgroups = {crumbly = 2},
		nodes = {
			{
				match = {name = modname .. ":plant_fibers", count = 8},
				replace = "nc_tree:peat"
			}
		}
	})

nodecore.register_aism({
		label = "Plant Stack Decay",
		interval = 20,
		chance = 4,
		itemnames = {"group:decay_to_fibers"},
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
			taken:set_name(modname .. ":plant_fibers")
			if data.inv then taken = data.inv:add_item("main", taken) end
			if not taken:is_empty() then nodecore.item_eject(data.pos, taken) end
			return stack
		end
	})
