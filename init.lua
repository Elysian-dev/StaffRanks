dofile(minetest.get_modpath("staffranks") .. "/api.lua")
dofile(minetest.get_modpath("staffranks") .. "/ranks.lua")

minetest.register_privilege("ranks_gestion", {
	description = "This privilege allows you to manage ranks",
    give_to_singleplayer = true
})

minetest.register_chatcommand("add_rank", {
	description = "Add a rank to player. If the rank name is 'clear', it resets the player's rank. See /ranks_list to view all available ranks.",
	params = "<name> <rankname>",
	privs = {ranks_gestion=true},
	func = function(name, param)
		local player_name, rankname = param:split(" ")[1], param:split(" ")[2]
		local player = minetest.get_player_by_name(player_name)
		if player then
			local meta = player:get_meta()
			local rank = meta:get_string("staffranks:rank")
			if rankname == "clear" then
				if rank ~= "None" then
					meta:set_string("staffranks:rank", "None")
					meta:set_string("staffranks:rank_color", "None")
					staffranks.clear_nametag(player)
					minetest.chat_send_player(name,
						minetest.colorize("#8dff23", "[StaffRanks] ") ..
						minetest.colorize("#b7ff74", player_name .. "'s rank has been reinisialised."))
				else
					minetest.chat_send_player(name,
						minetest.colorize("#FF0F0F", "[Error] ") ..
						minetest.colorize("#FF4040", "The player " .. player_name .. " has no rank."))
				end
			else
				if staffranks.rank_exist(rankname) then
					staffranks.add_rank(player_name, rankname)
					staffranks.set_nametag(player, rankname)
					minetest.chat_send_player(name,
						minetest.colorize("#8dff23", "[StaffRanks] ") ..
						minetest.colorize("#b7ff74", player_name .. "'s rank has been set to " .. rankname .. "."))
				else
					minetest.chat_send_player(name,
						minetest.colorize("#FF0F0F", "[Error] ") ..
						minetest.colorize("#FF4040", "The " .. rankname .. " rank does not exist."))
				end
			end
		elseif not minetest.player_exists(player_name) then
			minetest.chat_send_player(name,
						minetest.colorize("#FF0F0F", "[Error] ") ..
						minetest.colorize("#FF4040", "The player " .. player_name .. " doesn't exist."))
		elseif not player then
			minetest.chat_send_player(name,
						minetest.colorize("#FF0F0F", "[Error] ") ..
						minetest.colorize("#FF4040", "The player " .. player_name .. " is not connected."))
		end
	end,
})

minetest.register_chatcommand("ranks_list", {
	description = "See the list of all ranks.",
	privs = {ranks_gestion=true},
	func = function(name, param)
		minetest.chat_send_player(name, "List of all ranks: " .. staffranks.rankslist())
	end,
})

minetest.register_chatcommand("view_rank", {
	description = "View a player's rank.",
	params = "<name>",
	func = function(name, param)
		local player = minetest.get_player_by_name(param)
		if player then
			local meta = player:get_meta()
			local rank = meta:get_string("staffranks:rank")
			if rank ~= "None" then
				minetest.chat_send_player(name,
								minetest.colorize("#8dff23", "[StaffRanks] ") ..
								minetest.colorize("#b7ff74", "The player " .. param .. " has the rank " .. rank .. "."))
			else
				minetest.chat_send_player(name,
								minetest.colorize("#8dff23", "[StaffRanks] ") ..
								minetest.colorize("#b7ff74", "The player " .. param .. " has no rank."))
			end
		elseif not minetest.player_exists(param) then
			minetest.chat_send_player(name,
						minetest.colorize("#FF0F0F", "[Error] ") ..
						minetest.colorize("#FF4040", "The player " .. param .. " doesn't exist."))
		elseif not player then
			minetest.chat_send_player(name,
						minetest.colorize("#FF0F0F", "[Error] ") ..
						minetest.colorize("#FF4040", "The player " .. param .. " is not connected."))
		end
	end,
})

minetest.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	local rankname = meta:get_string("staffranks:rank")
	if rankname ~= "None" then
		staffranks.set_nametag(player)
		return true
	end
end)

minetest.register_on_chat_message(function(name, message)
	local player = minetest.get_player_by_name(name)
	local meta = player:get_meta()
	local rankname = meta:get_string("staffranks:rank")
	local rank_color = meta:get_string("staffranks:rank_color")
	if rankname ~= "None" then
			minetest.chat_send_all(minetest.colorize(rank_color, "[" .. rankname .. "] ") .. name .. " > " .. message)
			return true
	end
end)

minetest.register_on_newplayer(function(player)
	local meta = player:get_meta()
	meta:set_string("staffranks:rank", "None")
	meta:set_string("staffranks:rank_color", "None")
end)