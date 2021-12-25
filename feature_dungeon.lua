-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, pairs
    = minetest, nodecore, pairs
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local oldbricks = nodecore.dungeon_bricks

-- ================================================================== --
-- XXX: LEGACY PRE-STANDARDIZATION MAPGEN SUPPORT
if not oldbricks then
	local mapperlin
	minetest.after(0, function() mapperlin = minetest.get_perlin(8658, 1, 0, 1) end)

	local materials = {
		shallow = {
			bulk = {
				plain = "nc_concrete:adobe",
				mossy = modname .. ":mossy_adobe"
			},
			brick = {
				plain = "nc_stonework:bricks_adobe",
				mossy = modname .. ":mossy_adobe_bricks"
			},
			bonded = {
				plain = "nc_stonework:bricks_adobe_bonded",
				mossy = modname .. ":mossy_adobe_bricks_bonded"
			}
		},
		deep = {
			bulk = {
				plain = "nc_terrain:cobble",
				mossy = modname .. ":mossy_cobble"
			},
			brick = {
				plain = "nc_stonework:bricks_stone",
				mossy = modname .. ":mossy_bricks"
			},
			bonded = {
				plain = "nc_stonework:bricks_stone_bonded",
				mossy = modname .. ":mossy_bricks_bonded"
			}
		}
	}

	nodecore.register_dungeongen({
			label = "nature dungeons",
			func = function(pos)
				if pos.y < -10 then return end
				local rng = nodecore.seeded_rng(mapperlin:get_3d(pos))
				local option = pos.y < 0 and rng(-10, 0) > pos.y
				and materials.deep or materials.shallow
				if rng(1, 4) ~= 1 then
					option = option.bulk
				else
					local below = {x = pos.x, y = pos.y - 1, z = pos.z}
					local bnode = minetest.get_node(below)
					local bdef = minetest.registered_nodes[bnode.name] or {}
					option = rng(1, 10) <= (bdef.walkable and 9 or 2)
					and option.brick or option.bonded
				end
				minetest.set_node(pos, {name = rng(1, 100) == 1
						and option.mossy or option.plain})
			end
		})
	return
end
-- ================================================================== --

local proftrans = {}
function nodecore.dungeon_bricks(pos, rng, ...)
	local profile = oldbricks(pos, rng, ...)
	if rng(1, 100) ~= 1 then return profile end
	local cached = proftrans[profile]
	if cached then return cached end

	local mossy = nodecore.mossy_groups
	if not mossy then return profile end
	cached = {}
	proftrans[profile] = cached
	for k, v in pairs(profile) do
		local mg = mossy[v]
		cached[k] = mg and mg.mossy or v
	end
	return cached
end
