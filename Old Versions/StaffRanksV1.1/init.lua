--- Admin

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.server then 
			minetest.log("action", "[ADMIN]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize("#ba0000","[Admin] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)

-- Moderator

minetest.register_privilege("moderator", {
  description = "This player is Moderator",
  give_to_singleplayer = false
})

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.moderator then
			minetest.log("action", "[MODERATOR]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize("#1a75ff","[Moderator] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)

-- Developper

minetest.register_privilege("developer", {
  description = "This player is Developer",
  give_to_singleplayer = false
})

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.developper then
			minetest.log("action", "[DEVELOPER]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize("#0099cc","[Developer] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)


-- Builder

minetest.register_privilege("builder", {
  description = "This player is Builder",
  give_to_singleplayer = false
})

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.builder then
			minetest.log("action", "[BUIDER]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize("#ffad33","[Builder] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)

-- Contributor

minetest.register_privilege("contributor", {
  description = "This player is Contributor",
  give_to_singleplayer = false
})

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.contributor then
			minetest.log("action", "[CONTRIBUTOR]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize("#a300cc","[Contributor] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)

-- VIP

minetest.register_privilege("vip", {
  description = "This player is VIP",
  give_to_singleplayer = false
})

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.vip then
			minetest.log("action", "[VIP]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize("#00e600","[VIP] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)

-- Player

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.shout then
			minetest.log("action", "[PLAYER]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize("#ccccff","[Player] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)
