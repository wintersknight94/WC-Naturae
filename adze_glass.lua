-- LUALOCALS < ---------------------------------------------------------
local ItemStack, minetest, nodecore
    = ItemStack, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local adzedef
adzedef = {
	description = "Glass-Tipped Adze",
	inventory_image = "nc_woodwork_adze.png^(nc_stonework_tip_adze.png^[colorize:aliceblue:100)",
	groups = {
		firestick = 2,
		flammable = 2
	},
	tool_capabilities = nodecore.toolcaps({
			choppy = 2,
			crumbly = 2
		}),
	sounds = nodecore.sounds("nc_tree_sticky"),
	after_use = function(_, who)
		nodecore.toolbreakeffects(who, adzedef)
		return ItemStack("nc_woodwork:adze")
	end
}
minetest.register_tool(modname .. ":adze_glass", adzedef)

nodecore.register_craft({
		label = "assemble glassy adze",
		action = "stackapply",
		wield = {name = modname .. ":shard"},
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
			{name = modname .. ":adze_glass"}
		},
	})

--nodecore.register_craft({
--		label = "assemble glass-tipped adze",
--		action = "stackapply",
--		wield = {name = {modname .. ":shard"}},
--		consumewield = 1,
--		indexkeys = {"nc_woodwork:adze"},
--		nodes = {
--			{
--				match = {
--					name = "nc_woodwork:adze",
--					wear = 0.05
--				}
--			},
--		},
--		items = {
--			{name = modname .. ":adze_glass"}
--		},
--		after = function(pos, data)
--			nodecore.set_loud(pos, {name = data.wield:get_name()})
--		end
--	})

