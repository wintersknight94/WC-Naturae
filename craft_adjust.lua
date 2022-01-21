-- LUALOCALS < ---------------------------------------------------------
local ItemStack, minetest, nodecore
    = ItemStack, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

minetest.override_item("nc_stonework:adze",
	{description = "Stone-Tipped Adze"}
)

nodecore.register_craft({
	label = "assemble gravelled adze",
	action = "stackapply",
	wield = {name = "nc_stonework:chip"},
	consumewield = 1,
	indexkeys = {"nc_woodwork:adze"},
	nodes = {
		{
			match = {
				name = "nc_woodwork:adze",
				wear = 0.05
			},
			replace = "air"
		},
	},
	items = {
		{name = "nc_stonework:adze"}
	},
})


