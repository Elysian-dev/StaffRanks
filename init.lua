local modname = core.get_current_modname()
local modpath = core.get_modpath(modname)
local S = core.get_translator(modname)

dofile(modpath .. "/api.lua")
dofile(modpath .. "/ranks.lua")

core.register_privilege("ranks_gestion", {
    description = S("This privilege allows you to manage ranks"),
    give_to_singleplayer = true
})

core.register_chatcommand("add_rank", {
	description = S("Add a rank to player@nIf the rank name is 'clear', it resets the player's rank.@n@n  See /ranks_list to view all available ranks."),
	params = "<name> <rankname>",
	privs = {ranks_gestion = true},
	func = function(name, param)
		local pname, rankname = param:split(" ")[1], param:split(" ")[2]
		local player = core.get_player_by_name(pname)
		if player then
			local meta = player:get_meta()
			local rank = meta:get_string("staffranks:rank_prefix")
			if rankname == "clear" then
				if rank ~= "None" then
					meta:set_string("staffranks:rank", "None")
					meta:set_string("staffranks:rank_prefix", "None")
					meta:set_string("staffranks:rank_color", "None")
					staffranks.clear_nametag(player)
					core.chat_send_player(name,
					    core.colorize("#8dff23", "[StaffRanks]") .." "..
					    core.colorize("#b7ff74", S("@1's rank has been reinisialised.", pname)))
				else
					core.chat_send_player(name,
					    core.colorize("#FF0F0F", S("[Error]")) .." "..
					    core.colorize("#FF4040", S("The player @1 has no rank.", pname)))
				end
			else
				if staffranks.rank_exist(rankname) then
					staffranks.add_rank(pname, rankname)
					staffranks.set_nametag(player, rankname)
					core.chat_send_player(name,
					    core.colorize("#8dff23", "[StaffRanks]") .." "..
					    core.colorize("#b7ff74", S("@1's rank has been set to  @2.", pname, rankname)))
				else
					core.chat_send_player(name,
					    core.colorize("#FF0F0F", S("[Error]")) .." "..
					    core.colorize("#FF4040", S("The @1 rank does not exist.", pname)))
				end
			end
		elseif not core.player_exists(pname) then
			core.chat_send_player(name,
			    core.colorize("#FF0F0F", S("[Error]")) .." "..
			    core.colorize("#FF4040", "The player @1 doesn't exist.", pname))
		elseif not player then
			core.chat_send_player(name,
			    core.colorize("#FF0F0F", S("[Error]")) .." "..
			    core.colorize("#FF4040", S("The player @1 is offline.", pname)))
		end
	end,
})

core.register_chatcommand("ranks_list", {
	description = S("See the list of all ranks."),
	privs = {ranks_gestion = true},
	func = function(name, param)
		core.chat_send_player(name, S("List of all ranks: @1", staffranks.rankslist()))
	end,
})

core.register_chatcommand("view_rank", {
	description = S("View a player's rank."),
	params = "<name>",
	func = function(name, param)
		local player = core.get_player_by_name(param)
		if player then
			local meta = player:get_meta()
			local rank = meta:get_string("staffranks:rank_prefix")
			if rank ~= "None" then
				core.chat_send_player(name,
				    core.colorize("#8dff23", "[StaffRanks]") .." "..
				    core.colorize("#b7ff74", S("The player @1 has the rank @2.", param, rank)))
			else
				core.chat_send_player(name,
				    core.colorize("#8dff23", "[StaffRanks]") .." "..
                    core.colorize("#b7ff74", S("The player @1  has no rank.", param)))
			end
		elseif not core.player_exists(param) then
			core.chat_send_player(name,
			    core.colorize("#FF0F0F", S("[Error]")) .." "..
			    core.colorize("#FF4040", "The player @1 doesn't exist.", param))
		elseif not player then
			core.chat_send_player(name,
			    core.colorize("#FF0F0F", S("[Error]")) .." "..
			    core.colorize("#FF4040", S("The player @1 is offline.", param)))
		end
	end,
})

core.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	local rankname = meta:get_string("staffranks:rank")
	if rankname ~= "None" then
		staffranks.set_nametag(player)
	end
end)

core.register_on_chat_message(function(name, message)
	local player = core.get_player_by_name(name)
	local meta = player:get_meta()
	local rankname = meta:get_string("staffranks:rank_prefix")
	local rank_color = meta:get_string("staffranks:rank_color")
	if rankname ~= "None" then
        local format_rank = core.colorize(rank_color, S("[@1] ", rankname))
		core.chat_send_all(format_rank .." ".. core.format_chat_message(name, message))
		return true
	end
end)

core.register_on_newplayer(function(player)
	local meta = player:get_meta()
	meta:set_string("staffranks:rank", "None")
	meta:set_string("staffranks:rank_prefix", "None")
	meta:set_string("staffranks:rank_color", "None")
end)
