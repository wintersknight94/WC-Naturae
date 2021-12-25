-- LUALOCALS < ---------------------------------------------------------
local include, minetest, nodecore
    = include, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

-- ================================================================== --
-- XXX: LEGACY PRE-THATCH SUPPORT
if not minetest.registered_nodes["nc_flora:thatch"] then
	minetest.register_node(modname .. ":thatch", {
			description = "Thatch",
			tiles = {modname .. "_thatch.png"},
			groups = {
				choppy = 2,
				flammable = 2,
				fire_fuel = 5
			},
			sounds = nodecore.sounds("nc_terrain_swishy")
		})

	nodecore.register_craft({
			label = "weave plant fibers into thatch",
			action = "pummel",
			toolgroups = {thumpy = 1},
			duration = 3,
			nodes = {
				{
					match = {name = modname .. ":plant_fibers", count = 8},
					replace = modname .. ":thatch"
				}
			},
		})

	nodecore.register_craft({
			label = "break thatch into fibers",
			action = "pummel",
			priority = -1,
			toolgroups = {choppy = 2},
			nodes = {
				{match = modname .. ":thatch", replace = "air"}
			},
			items = {
				{name = modname .. ":plant_fibers 2", count = 4, scatter = 3}
			}
		})

	return
end
-- ================================================================== --

local floraswap = include("lib_floraswap")
floraswap(modname .. ":thatch", "nc_flora:thatch")
