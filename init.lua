
local modname = core.get_current_modname()
local modpath = core.get_modpath(modname)
local S = core.get_translator(modname)

dofile(modpath .. "/api.lua")
dofile(modpath .. "/ranks.lua")

core.register_privilege("ranks_gestion", {
	description = S("This privilege allows you to manage ranks"),
    give_to_singleplayer = true
})

local function check_if_player(player_name)
	local player = core.get_player_by_name(player_name)
	if player then
		return true, player
	elseif not core.player_exists(player_name) then
		return core.chat_send_player(name,
					core.colorize("#FF0F0F", S("[Error] ")) ..
					core.colorize("#FF4040", S("The player @1 doesn't exist.", player_name)))
	elseif not player then
		return core.chat_send_player(name,
					core.colorize("#FF0F0F", S("[Error] ")) ..
					core.colorize("#FF4040", S("The player @1 is not connected.", player_name)))
	else
		return core.chat_send_player(name,
					core.colorize("#FF0F0F", S("[Error] ")) ..
					core.colorize("#FF4040", S("Please specify a player name.")))
	end
end

local function clear_rank_cmd(name, player_name)
	local player = core.get_player_by_name(player_name)
	local meta = player:get_meta()
	local rank = meta:get_string("staffranks:rank_prefix")
	if rank ~= "None" then
		meta:set_string("staffranks:rank", "None")
		meta:set_string("staffranks:rank_prefix", "None")
		meta:set_string("staffranks:rank_color", "None")
		staffranks.clear_nametag(player)
		core.chat_send_player(name,
			core.colorize("#8dff23", "[StaffRanks] ") ..
			core.colorize("#b7ff74", S("@1's rank has been reinisialised.", player_name)))
		staffranks.log("info", S("@1 has cleared the rank of @2", name, player_name))
	else
		core.chat_send_player(name,
			core.colorize("#FF0F0F", S("[Error] ")) ..
			core.colorize("#FF4040", S("The player @1 has no rank.", player_name)))
	end
end

local function add_rank_cmd(name, player_name, rankname)
	if check_if_player(player_name) then
		local player = core.get_player_by_name(player_name)
		if staffranks.rank_exist(rankname) then
			staffranks.add_rank(player_name, rankname)
			staffranks.init_nametag(player)
			core.chat_send_player(name,
			core.colorize("#8dff23", "[StaffRanks] ") ..
			core.colorize("#b7ff74", S("@1's rank has been set to @2.", player_name, rank_prefix)))
			staffranks.log("info", S("@1 has set the rank of @2 to @3", name, player_name, rankname))
		else
			core.chat_send_player(name,
				core.colorize("#FF0F0F", S("[Error] ")) ..
				core.colorize("#FF4040", S("The @1 rank does not exist.", rankname)))
			staffranks.log("error", S("@1 tried to set the rank of @2 to a non-existent rank: @3", name, player_name, rankname))
		end
	end
end

local function view_rank_cmd(name, player_name)
	local player = core.get_player_by_name(player_name)
	if check_if_player(name) then
		local meta = player:get_meta()
		local rank = meta:get_string("staffranks:rank_prefix")
		if rank ~= "None" then
			core.chat_send_player(name,
							core.colorize("#8dff23", "[StaffRanks] ") ..
							core.colorize("#b7ff74", S("The player @1 has the rank @2.", player_name, rank)))
		else
			core.chat_send_player(name,
							core.colorize("#8dff23", "[StaffRanks] ") ..
							core.colorize("#b7ff74", S("The player @1 has no rank.", player_name)))
		end
	end
end

if core.get_modpath("lib_chatcmdbuilder") then
	local cmd = chatcmdbuilder.register("ranks", {
		description = S("Add, clear, view or list all ranks of players."),
		params = "<add | clear | view | list> [<" .. S("player") .. ">]",
		privs = {ranks_gestion=true},
	})

	cmd:sub("add :name:text :rank:text", function(name, player_name, rankname)
		add_rank_cmd(name, player_name, rankname)
	end)

	cmd:sub("clear :name:text", function(name, player_name)
		clear_rank_cmd(name, player_name)
	end)

	cmd:sub("view :name:text", function(name, player_name)
		view_rank_cmd(name, player_name)
	end)

	cmd:sub("list", function(name)
		core.chat_send_player(name, S("List of all ranks: @1", staffranks.rankslist()))
	end)
else
	core.register_chatcommand("add_rank", {
		description = S("Add a rank to player.").. S("@nIf the rank name is 'clear' it resets the player's rank.").. S("@nSee /ranks_list to view all available ranks."),
		params = "<name> <rankname>",
		privs = {ranks_gestion=true},
		func = function(name, param)
			local player_name, rankname = param:split(" ")[1], param:split(" ")[2]
			if rankname == "clear" then
				clear_rank_cmd(name, player_name)
			else
				add_rank_cmd(name, player_name, rankname)
			end
		end,
	})

	core.register_chatcommand("ranks_list", {
		description = S("See the list of all ranks."),
		privs = {ranks_gestion=true},
		func = function(name, param)
			core.chat_send_player(name, S("List of all ranks: @1", staffranks.rankslist()))
		end,
	})

	core.register_chatcommand("view_rank", {
		description = S("View a player's rank."),
		params = "<name>",
		func = function(name, param)
			view_rank_cmd(name, param)
		end,
	})
end

core.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	local rankname = meta:get_string("staffranks:rank")
	if rankname ~= "None" then
		staffranks.init_nametag(player)
	end
end)

core.register_on_chat_message(function(name, message)
	local player = core.get_player_by_name(name)
	local meta = player:get_meta()
	local rankname = meta:get_string("staffranks:rank_prefix")
	local rank_color = meta:get_string("staffranks:rank_color")
	if rankname ~= "None" then
		local format_rank = core.colorize(rank_color, "[" .. rankname .. "]")
		core.chat_send_all(format_rank .." ".. core.format_chat_message(name, message))
		staffranks.log("message", "[" .. rankname .. "] " .. S("@1 sent a message: @2", name, message))
		return true
	else
		staffranks.log("message", S("@1 sent a message: @2", name, message))
	end
end)

core.register_on_newplayer(function(player)
	local meta = player:get_meta()
	meta:set_string("staffranks:rank", "None")
	meta:set_string("staffranks:rank_prefix", "None")
	meta:set_string("staffranks:rank_color", "None")
end)
