-- Copy this example and paste it into init.lua by making all the changes.

-- Rank Name (Replace "Rank Name" with the name of rank you have chosen.)

minetest.register_privilege("<Privilege Name>", { -- Replace "<Privilege Name>" with the name of the privilege you have chosen.
  description = "<Privilege Description>", -- Replace "<Privilege Description>" with the privilege description you have chosen. Example: "This player is ...."
  give_to_singleplayer = false
})

minetest.register_on_chat_message(function(name, message)
	local privs = minetest.get_player_privs(name)
		if privs.<Privilege> then -- Replace "<Privilege>" with the privilege you created above.
			minetest.log("action", "<Rank Name in logs>: <" .. name .. "> " .. message) -- Replace "<Rank Name in logs>" with the name of the rank you have chosen.
		minetest.chat_send_all(minetest.colorize(color_,"<Rank Name> ").. minetest.colorize("white","<".. name .."> ") .. message) -- Replace "<Rank Name>" with the name of the rank you have chosen. After "color_" adds the role name or the name you put in color.lua

    return true
	end
end)

-- Read Readme.md for more information