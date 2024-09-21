-- LUALOCALS < ---------------------------------------------------------
local include, minetest, nodecore
    = include, minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------

include("substrate_mycelium")
include("substrate_muck")

if minetest.settings:get_bool(modname .. ".frost", true) then
	include("substrate_frost")
end

include("item_fiber")
include("item_thatch")
include("item_coquina")
include("item_mushroom_giant")

include("feature_biomes")
include("feature_blobs")
include("feature_decay")
include("feature_dungeon")
include("feature_spread")
include("feature_mushgrowth")
if minetest.settings:get_bool(modname .. ".frost", true) then
	include("feature_thaw")
end

include("decor_pebbles")
include("decor_shells")
include("decor_pearls")
include("decor_boulder")
include("decor_decaylog")
include("decor_tree_antique")
include("decor_tree_grand")
include("decor_tree_tall")
include("decor_tree_tropic")
include("decor_deadshrub")
include("decor_bigmushroom")
include("decor_bigmushroom_glow")
include("decor_bigmushroom_lux")

include("gourd_pumpkin")
--include("gourd_squash")

include("flora_bamboo")
include("flora_fern")
include("flora_flower")
include("flora_grass")
include("flora_lilypad")
include("flora_mossy")
include("flora_mushroom")
include("flora_reed")
include("flora_shrub")
include("flora_starflower")
include("flora_thornbriar")
include("flora_umbrella")
if minetest.settings:get_bool(modname .. ".ivy", true) then
	include("flora_ivy")
end
--include("flora_sporebloom")

if minetest.settings:get_bool(modname .. ".stoneadze", true) then
	include("craft_adjust")
end

include("tools_glass")
include("tools_shell")

if minetest.settings:get_bool(modname .. ".stonewash", true) then
	include("postgen")
end

include("conversion")
