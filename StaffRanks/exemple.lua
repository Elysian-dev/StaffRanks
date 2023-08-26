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
		minetest.chat_send_all(minetest.colorize("#Color","<Rank Name> ").. minetest.colorize("white","<".. name .."> ") .. message) -- Replace "<Rank Name>" with the name of the rank you have chosen. Replace "#Color" with the color you want for your rank. Color in "#...."!

    return true
	end
end)