-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
-- ================================================================== --
local ivy = modname.. "_ivy.png"
local sprout = modname.. "_ivy_sprout.png"
local vine = modname.. "_ivy_vine.png"
------------------------------------------------------------------------
minetest.register_node(modname.. ":ivy", {
	description = "Ivy",
	drawtype = 'plantlike',
	waving = 1,
	tiles = {sprout},
	inventory_image = ivy,
	wield_image = ivy,
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = "meshoptions",
	place_param2 = 4,
	walkable = false,
	groups = {
		snappy = 1,
		ivy = 1,
		flora = 1,
		flammable = 2,
		attached_node = 1,
		stack_as_node = 1,
		peat_grindable_item = 1,
		[modname .. "_spread"] = 1
	},
	sounds = nodecore.sounds("nc_terrain_swishy"),
	buildable_to = true,
})
------------------------------------------------------------------------
minetest.register_node(modname.. ":ivy_vine", {
	description = "Ivy",
	drawtype = 'signlike',
	tiles = {vine},
	inventory_image = ivy,
	wield_image = ivy,
	sunlight_propagates = true,
	paramtype = 'light',
	paramtype2 = 'wallmounted',
	walkable = false,
	groups = {
		snappy = 1,
		ivy = 1,
		flora = 1,
		flammable = 2,
		attached_node = 1,
	},
	climbable = true,
	sounds = nodecore.sounds("nc_terrain_swishy"),
	selection_box = {
		type = "wallmounted",
	},
	buildable_to = true,
	drop = modname.. ":ivy"
})
-- ================================================================== --
minetest.register_decoration({
	label = {modname .. ":ivy"},
	deco_type = "simple",
	place_on = {"group:soil"},
	sidelen = 16,
	fill_ratio = 0.01,
	biomes = {"forest", "old_forest", "ancient_forest", "rainforest"},
	y_max = 256,
	y_min = 1,
	decoration = {modname .. ":ivy"},
	param2 = 4
})
-- ================================================================== --
minetest.register_abm({
	label = "ivy climbing",
	nodenames = {"group:ivy"},
	interval = 60, --60,
	chance = 10, --10,
	action = function(pos)

})

------------------------------------------------------------------------



