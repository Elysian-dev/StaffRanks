dofile(minetest.get_modpath("staffranks").."/color.lua")

--- Admin

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.server then 
			minetest.log("action", "[ADMIN]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize(color_admin,"[Administrateur] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.server then
            player:set_nametag_attributes({
                text = (minetest.colorize(color_admin,"[Administrateur] ")..name),
            })
        end
    end
end)

minetest.register_on_joinplayer(function(player)
local name = player:get_player_name()
local privs = minetest.get_player_privs(name)
	if privs.server then
		privs.developer = nil
		privs.builder = nil
		privs.contributor = nil
		privs.vip = nil
		privs.player = nil
		privs.moderator = nil
		minetest.set_player_privs(name, privs)
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
		minetest.chat_send_all(minetest.colorize(color_moderator,"[Moderator] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.moderator then
            player:set_nametag_attributes({
                text = (minetest.colorize(color_moderator,"[Modérateur] ")..name),
            })
        end
    end
end)

minetest.register_on_joinplayer(function(player)
local name = player:get_player_name()
local privs = minetest.get_player_privs(name)
	if privs.moderator then
		privs.developer = nil
		privs.builder = nil
		privs.contributor = nil
		privs.vip = nil
		privs.player = nil
		minetest.set_player_privs(name, privs)
	end
end)

-- Developper

minetest.register_privilege("developer", {
  description = "This player is Developer",
  give_to_singleplayer = false
})

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local privs = minetest.get_player_privs(name)
		if privs.developer then
		privs.moderator = nil
		privs.vip = nil
		privs.builder = nil
		privs.contributor = nil
		privs.player = nil
		minetest.set_player_privs(name, privs)
	end
end)

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.developper then
			minetest.log("action", "[DEVELOPER]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize(color_developer,"[Developer] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.developer then
            player:set_nametag_attributes({
                text = (minetest.colorize(color_developer,"[Developper] ")..name),
            })
        end
    end
end)

-- Builder

minetest.register_privilege("builder", {
  description = "This player is Builder",
  give_to_singleplayer = false
})

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local privs = minetest.get_player_privs(name)
		if privs.builder then
		privs.moderator = nil
		privs.developer = nil
		privs.vip = nil
		privs.contributor = nil
		privs.player = nil
		minetest.set_player_privs(name, privs)
	end
end)

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.builder then
			minetest.log("action", "[BUIDER]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize(color_builder,"[Builder] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.builder then
            player:set_nametag_attributes({
                text = (minetest.colorize(color_builder,"[Builder] ")..name),
            })
        end
    end
end)

-- Contributor

minetest.register_privilege("contributor", {
  description = "This player is Contributor",
  give_to_singleplayer = false
})

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local privs = minetest.get_player_privs(name)
		if privs.contributor then
		privs.moderator = nil
		privs.developer = nil
		privs.builder = nil
		privs.vip = nil
		privs.player = nil
		minetest.set_player_privs(name, privs)
	end
end)

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.contributor then
			minetest.log("action", "[CONTRIBUTOR]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize(color_contributor,"[Contributor] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.contributor then
            player:set_nametag_attributes({
                text = (minetest.colorize(color_contributor,"[Contributor] ")..name),
            })
        end
    end
end)

-- VIP

minetest.register_privilege("vip", {
  description = "This player is VIP",
  give_to_singleplayer = false
})

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local privs = minetest.get_player_privs(name)
		if privs.vip then
		privs.moderator = nil
		privs.developer = nil
		privs.builder = nil
		privs.contributor = nil
		privs.player = nil
		minetest.set_player_privs(name, privs)
	end
end)

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.vip then
			minetest.log("action", "[VIP]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize(color_vip,"[VIP] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.vip then
            player:set_nametag_attributes({
                text = (minetest.colorize(color_vip,"[VIP] ")..name),
            })
        end
    end
end)

-- Player

minetest.register_privilege("player", {
  description = "This player is just a player",
  give_to_singleplayer = false
})

minetest.register_on_joinplayer(function(player)
    local name = player:get_player_name()
    local privs = minetest.get_player_privs(name)
	local allranks = privs.server or privs.moderator or privs.developer or privs.builder or privs.contributor or privs.vip
		if not allranks then 
				privs.player = true
				minetest.set_player_privs(name, privs)
		else
			privs.player = nil
			minetest.set_player_privs(name,privs)
		end
end)

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.player then
			minetest.log("action", "[PLAYER]: <" .. name .. "> " .. message)
		minetest.chat_send_all(minetest.colorize(color_player,"[Player] ").. minetest.colorize("white","<".. name .."> ") .. message)

    return true
	end
end)
	minetest.register_on_joinplayer(function(player)
    if player then
        local name = player:get_player_name()
        local privs = minetest.get_player_privs(name)
        if privs.player then
            player:set_nametag_attributes({
                text = (minetest.colorize(color_player,"[Player] ")..name),
            })
        end
    end
end)
