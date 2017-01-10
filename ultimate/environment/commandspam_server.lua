local antiSpam = {}
local notAntiSpam = {
	["Next"] = true, ["Previous"] = true, ["admin"] = true, ["grabheli"] = true, ["High Sensivity Mode"] = true, ["High Sensivity Mode up"] = true, ["mv"] = true, ["Toggle"] = true, ["smoke"] = true, 
	["dropheli"] = true, ["fskin"] = true
}

addEventHandler ( "onPlayerCommand", root, function ( cmd )
	if not notAntiSpam[cmd] then
		if antiSpam[source] and antiSpam[source] + 300 >= getTickCount() then
			cancelEvent()
			outputChatBox ( "Nicht spammen!", source, 200, 0, 0 )
		else
			antiSpam[source] = getTickCount()
		end
	end
end )
