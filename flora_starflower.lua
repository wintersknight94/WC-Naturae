-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local starflower = "(nc_flora_flower_color.png^[mask:" ..modname.. "_starstem_mask.png)^" ..modname.. "_starflower.png"
local deadflower = "(nc_flora_flower_color_dry.png^[mask:" ..modname.. "_starstem_mask.png)^(" ..modname.. "_starflower.png^[colorize:GREY:240)"
------------------------------------------------------------------------
minetest.register_node(modname .. ":starflower", {
		description = "Pinnacle Flower",
		drawtype = 'plantlike',
		waving = 1,
		tiles = {starflower},
		wield_image = starflower,
		inventory_image = starflower,
		sunlight_propagates = true,
		paramtype = 'light',
		paramtype2 = "meshoptions",
		place_param2 = 10,
		light_source = 5,
		glow = 1,
		walkable = false,
		groups = {
			snappy = 1,
			flora = 1,
			flammable = 1,
			attached_node = 1,
			[modname .. "_spread"] = 1,
			peat_grindable_item = 1,
		},
		sounds = nodecore.sounds("nc_terrain_swishy"),
		selection_box = {
			type = "fixed",
			fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16},
		},
	})
minetest.register_node(modname .. ":starflower_dead", {
		description = "Wilted Pinnacle Flower",
		drawtype = 'plantlike',
		waving = 1,
		tiles = {deadflower},
		wield_image = deadflower,
		inventory_image = deadflower,
		sunlight_propagates = true,
		paramtype = 'light',
		paramtype2 = "meshoptions",
		place_param2 = 10,
		walkable = false,
		floodable = true,
		groups = {
			snappy = 1,
			flora_dry = 1,
			flammable = 1,
			attached_node = 1,
			peat_grindable_item = 1,
		},
		sounds = nodecore.sounds("nc_terrain_swishy"),
		selection_box = {
			type = "fixed",
			fixed = {-6/16, -0.5, -6/16, 6/16, 4/16, 6/16},
		},
		drop_in_place = "air"
	})
------------------------------------------------------------------------
nodecore.register_aism({
	label = "starflower stack dry",
	interval = 1,
	chance = 20,
	arealoaded = 2,
	itemnames = {modname.. ":starflower"},
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
		taken:set_name(modname .. ":starflower_dead")
		if data.inv then taken = data.inv:add_item("main", taken) end
		if not taken:is_empty() then nodecore.item_eject(data.pos, taken) end
		return stack
	end
})	
------------------------------------------------------------------------
minetest.register_decoration({
		label = {modname .. ":starflower"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.001,
--		noise_params = {
--			offset = -0.001 + 0.005 * 0.0005,
--			scale = 0.001,
--			spread = {x = 100, y = 100, z = 100},
--			seed = 1572,
--			octaves = 3,
--			persist = 0.7
--		},
		y_max = 31000,
		y_min = 100,
		decoration = {modname .. ":starflower"},
		param2 = 10
	})
minetest.register_decoration({
		label = {modname .. ":starflower"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.025,
--		noise_params = {
--			offset = -0.001 + 0.005 * 0.005,
--			scale = 0.001,
--			spread = {x = 100, y = 100, z = 100},
--			seed = 1420,
--			octaves = 3,
--			persist = 0.7
--		},
		y_max = 31000,
		y_min = 200,
		decoration = {modname .. ":starflower"},
		param2 = 10
	})
minetest.register_decoration({
		label = {modname .. ":starflower"},
		deco_type = "simple",
		place_on = {"group:soil"},
		sidelen = 16,
		fill_ratio = 0.001,
		y_max = 31000,
		y_min = 50,
		decoration = {modname .. ":starflower"},
		biomes = {"rainforest"},
		param2 = 10
	})
