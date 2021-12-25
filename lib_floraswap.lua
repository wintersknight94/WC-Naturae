-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, string
    = minetest, nodecore, string
local string_gsub
    = string.gsub
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local function floraswap(oldname, newname)
	local newdef = minetest.registered_items[newname] or {}
	local olddef = nodecore.underride({drop = newdef.drop or newname}, newdef)

	minetest.register_node(oldname, olddef)

	local function check(pos)
		return minetest.set_node(pos, {
				name = newname,
				param2 = newdef.place_param2
			})
	end

	local label = modname .. ":floraswap_" .. string_gsub(oldname, "%W", "_")
	minetest.register_lbm({
			name = label,
			run_at_every_load = true,
			nodenames = {oldname},
			action = check
		})
	minetest.register_abm({
			label = label,
			interval = 1,
			chance = 1,
			nodenames = {oldname},
			action = check
		})
	nodecore.register_aism({
			label = label,
			interval = 1,
			chance = 1,
			itemnames = {oldname},
			action = function(stack)
				stack:set_name(newname)
				return stack
			end
		})

	return olddef
end

return floraswap
