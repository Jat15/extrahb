local function extrahb(player, nb_slots)
	nb_slots = tonumber(nb_slots)
	
	if nb_slots == nil then
		minetest.chat_send_player(player:get_player_name(), "It takes a number between 1 and 23")
		return
	end
	
	if nb_slots < 1 then
		nb_slots = 1
	elseif nb_slots > 32 then
		nb_slots = 32
	end

	player:hud_set_hotbar_itemcount(nb_slots)
	player:hud_set_hotbar_image("extrahb_gui_hotbar.png")
	player:hud_set_hotbar_selected_image("extrahb_gui_hotbar_selected.png")
	
	player:set_attribute("extrahb", nb_slots)
end

minetest.register_on_joinplayer(function(player)
	local nb_slots = minetest.settings:get("extrahb_initial_number_slots") or 8

	if not player:get_attribute("extrahb") then
		player:set_attribute("extrahb", nb_slots)
	else
		nb_slots = player:get_attribute("extrahb")
	end
	
	extrahb(player,nb_slots)
end)

minetest.register_chatcommand("extrahb", {
	description = "Configure number between 1 and 23",
	params = "<slot number>",
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if player then
			extrahb(player,param)
		end
	end
})