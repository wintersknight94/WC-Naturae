-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()


--minetest.override_item("nc_stonework:chip",{
--	on_place = function(itemstack, placer, pointed_thing)
--	local pos = nodecore.buildable_to(pointed_thing.under)
--		and pointed_thing.under or pointed_thing.above
--	nodecore.set_loud(pos, {name = modname .. ":pebble"})
--	itemstack:take_item(1)
--	return itemstack
--end
--})

minetest.register_node(modname .. ":pebble", {
		description = "Pebble",
		drawtype = "nodebox",
		tiles = {"nc_terrain_gravel.png"},
		paramtype = "light",
		node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.1875, 0.125, -0.4375, 0.1875}, -- NodeBox1
			{-0.1875, -0.5, -0.125, 0.1875, -0.4375, 0.125}, -- NodeBox2
		}
		},
		sunlight_propagates = true,
		walkable = true,
		floodable = true,
		groups = {
			snappy = 1,
			pebble = 1,
			stack_as_node = 1,
			falling_node = 1
		},
		sounds = nodecore.sounds("nc_terrain_stony"),
		selection_box = nodecore.fixedbox({-3/8, -1/2, -3/8, 3/8, 1/4, 3/8}),
		drop = "nc_stonework:chip"
	}
)

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"nc_terrain:dirt_with_grass","nc_terrain:stone","nc_terrain:gravel","nc_terrain:cobble"},
    sidelen = 16,
    fill_ratio = 0.01,
    y_max = 100,
    y_min = -31000,
    flags = "all_floors",
    decoration = modname ..":pebble",
    rotation = "random",
})

nodecore.register_craft({
		label = "reset chip to pebble",
		action = "pummel",
		indexkeys = {"nc_stonework:chip"},
		nodes = {
			{
				match = {name = "nc_terrain:chip", count = 1},
				replace = modname.. ":pebble"
			}
		},
		toolgroups = {thumpy = 1}
	})
