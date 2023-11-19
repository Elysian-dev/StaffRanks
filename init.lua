local ranks = {
    admin = {color = "#ba0000", privilege = "server", name = "Administrator"},
    moderator = {color = "#1a75ff", privilege = "moderator", name = "Moderator"},
    developer = {color = "#0099cc", privilege = "developer", name = "Developer"},
    builder = {color = "#ffad33", privilege = "builder", name = "Builder"},
    contributor = {color = "#a300cc", privilege = "contributor", name = "Contributor"},
    vip = {color = "#00e600", privilege = "vip", name = "VIP"},
    player = {color = "#ccccff", privilege = nil, name = "Player"}
}

local function onChatMessage(name, message, rank)
    local privs = minetest.get_player_privs(name)
    if privs[rank.privilege] then
        minetest.log("action", "[" .. rank.name .. "]: <" .. name .. "> " .. message)
        minetest.chat_send_all(minetest.colorize(rank.color, "[" .. rank.name .. "] ") .. minetest.colorize("white", "<" .. name .. "> ") .. message)
        return true
    end
end

local function onJoinPlayer(player, rank)
    local name = player:get_player_name()
    local privs = minetest.get_player_privs(name)
    if privs[rank.privilege] then
        player:set_nametag_attributes({
            text = (minetest.colorize(rank.color, "[" .. rank.name .. "] ") .. name),
        })
        for key, _ in pairs(privs) do
            if key ~= rank.privilege then
                privs[key] = nil
            end
        end
        minetest.set_player_privs(name, privs)
    end
end

for rankName, rankData in pairs(ranks) do
    minetest.register_privilege(rankName, {
        description = "This player is a " .. rankData.name,
        give_to_singleplayer = false
    })

    minetest.register_on_chat_message(function(name, message)
        return onChatMessage(name, message, rankData)
    end)

    minetest.register_on_joinplayer(function(player)
        onJoinPlayer(player, rankData)
    end)
end
