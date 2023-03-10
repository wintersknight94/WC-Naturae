-- LUALOCALS < ---------------------------------------------------------
local ItemStack, minetest, nodecore
    = ItemStack, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
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
	sounds = nodecore.sounds("nc_optics_glassy"),
	after_use = function(_, who)
		nodecore.toolbreakeffects(who, adzedef)
		return ItemStack("nc_woodwork:adze")
	end
}
minetest.register_tool(modname .. ":adze_glass", adzedef)
------------------------------------------------------------------------
nodecore.register_craft({
		label = "assemble glass adze",
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
-- ================================================================== --
-- ================================================================== --
local function tooltip(name, group)
	local tool = modname .. ":tool_" .. name:lower() .. "_glass"
	local wood = "nc_woodwork:tool_" .. name:lower()
	minetest.register_tool(tool, {
			description = "Glass-Tipped " .. name,
			inventory_image = "nc_woodwork_tool_" .. name:lower() .. ".png^(nc_stonework_tip_" .. name:lower() .. ".png^[colorize:aliceblue:100)",
			tool_wears_to = wood,
			groups = {
				flammable = 2
			},
			tool_capabilities = nodecore.toolcaps({
					uses = 0.25,
					[group] = 3
				}),
			on_ignite = modname .. ":shard",
			sounds = nodecore.sounds("nc_optics_glassy")
		})
	local woodmatch = {name = wood, wear = 0.05}
	nodecore.register_craft({
			label = "assemble " .. tool,
			action = "stackapply",
			wield = {name = modname .. ":shard"},
			consumewield = 1,
			indexkeys = {wood},
			nodes = {{match = woodmatch, replace = "air"}},
			items = {tool}
		})
end

tooltip("Mallet", "thumpy")
tooltip("Spade", "crumbly")
tooltip("Hatchet", "choppy")
tooltip("Pick", "cracky")



