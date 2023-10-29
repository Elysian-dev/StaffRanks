--- Admin

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.server then 
			minetest.log("action", "[ADMIN]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize("#ba0000","[Administrateur] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.server then
            player:set_nametag_attributes({
                text = (minetest.colorize("#ba0000","[Administrateur] ")..name),
            })
        end
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
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.moderator then
            player:set_nametag_attributes({
                text = (minetest.colorize("#1a75ff","[Modérateur] ")..name),
            })
        end
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
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.developer then
            player:set_nametag_attributes({
                text = (minetest.colorize("#0099cc","[Developper] ")..name),
            })
        end
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
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.builder then
            player:set_nametag_attributes({
                text = (minetest.colorize("#ffad33","[Builder] ")..name),
            })
        end
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
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.contributor then
            player:set_nametag_attributes({
                text = (minetest.colorize("#a300cc","[Contributor] ")..name),
            })
        end
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
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.vip then
            player:set_nametag_attributes({
                text = (minetest.colorize("#00e600","[VIP] ")..name),
            })
        end
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
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.shout then
            player:set_nametag_attributes({
                text = (minetest.colorize("#ccccff","[Player] ")..name),
            })
        end
    end
end)
