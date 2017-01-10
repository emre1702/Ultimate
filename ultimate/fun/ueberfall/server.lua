local ueberfallListe = { [2] = {}, [3] = {}, [7] = {}, [9] = {}, [12] = {}, [13] = {} }
local playerGettingRobbed = {}
local playerGettingRobbedTimer = {}
local playerSchusserlaubnis = {}
local playerHatGeschossen = {}


local function ueberfallSchusserlaubnis ( playera, target )
	local player = findPlayerByName ( playera )
	local x, y, z = getElementPosition ( target )
	local x1, y1, z1 = nil
	local frac = vioGetElementData ( player, "fraktion" )
	playerSchusserlaubnis[target] = getPlayerName ( player )
	if isTimer ( playerGettingRobbedTimer[player] ) then
		killTimer ( playerGettingRobbedTimer[player] )
		playerGettingRobbedTimer[player] = setTimer ( function( player ) 
			playerGettingRobbed[player] = nil
			playerHatGeschossen[player] = nil
			playerSchusserlaubnis[player] = nil
			playerGettingRobbedTimer[player] = nil
		end, 60000, 1, player )
	end
	triggerClientEvent ( player, "infobox_start", getRootElement(), "\nIhr dürft\nschießen!", 5000, 125, 0, 0 )
	triggerClientEvent ( target, "infobox_start", getRootElement(), "\nSie dürfen\nnun schießen!", 5000, 125, 0, 0 )
end


local function ueberfallTod ( ammo, killer )		
	if playerGettingRobbed[source] then
		if playerSchusserlaubnis[source] == nil and playerHatGeschossen[source] == nil then
			local themoney = 0
			outputChatBox ( "Zu früh angegriffen! Dir werden 1000$ abgezogen!", killer, 255, 0, 0 )
			if vioGetElementData ( killer, "money" ) >= 1000 then 
				themoney = 1000
				vioSetElementData ( killer, "money", vioGetElementData ( killer, "money")+500 )
			elseif vioGetElementData ( killer, "bankmoney" ) >= 1000 then 
				themoney = 1000
				vioSetElementData ( killer, "bankmoney", vioGetElementData ( killer, "bankmoney")+500 )
			elseif vioGetElementData ( killer, "money" ) + vioGetElementData ( killer, "bankmoney" ) >= 500 then
				local restgeld = 1000 - vioGetElementData ( killer, "money" )
				themoney = 1000
				vioSetElementData ( killer, "money", 0 )
				vioSetElementData ( killer, "bankmoney", restgeld )
			else 
				themoney = vioGetElementData ( killer, "bankmoney" ) + vioGetElementData ( killer, "money" )
				vioSetElementData ( killer, "money", 0 )
				vioSetElementData ( killer, "bankmoney", 0)
			end
			vioSetElementData ( source, "money", vioGetElementData (source, "money")+themoney)
		end
		playerSchusserlaubnis[source] = nil
		playerGettingRobbed[source] = nil
		playerHatGeschossen[source] = nil
		if isTimer ( playerGettingRobbedTimer[source] ) then
			killTimer ( playerGettingRobbedTimer[source] )
			playerGettingRobbedTimer[source] = nil
		end
	end
end
			
			
local function ueberfallOfflineflucht ()
	if playerSchusserlaubnis[source] then
		outputChatBox ("Der Spieler ist nach der Schusserlaubnis Offline gegangen.", playerGettingRobbed[source], 0, 255, 0 )
		playerSchusserlaubnis[source] = nil
		playerHatGeschossen[source] = nil
	elseif playerGettingRobbed[source] then 
		outputChatBox ("Der Spieler hat Offlineflucht begangen.", playerGettingRobbed[source], 0, 255, 0 )
		playerSchusserlaubnis[source] = nil
		playerHatGeschossen[source] = nil
		if isTimer ( playerGettingRobbedTimer[source] ) then
			killTimer ( playerGettingRobbedTimer[source] )
			playerGettingRobbedTimer[source] = nil
		end
	else
		playerSchusserlaubnis[source] = nil
		playerHatGeschossen[source] = nil
		if isTimer ( playerGettingRobbedTimer[source] ) then
			killTimer ( playerGettingRobbedTimer[source] )
			playerGettingRobbedTimer[source] = nil
		end
		return
	end
	local player = playerGettingRobbed[source]
	local frac = vioGetElementData ( player, "fraktion")
	local targetname = getPlayerName(source)
	ueberfallListe[frac][targetname] = nil
	playerGettingRobbed[source] = nil
	local handpasst = false
	local bankpasst = false
	local beidespasst = false
	local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "Geld", "Bankgeld", "userdata", "UID", playerUID[targetname] ), -1 )
	local handgeld = result[1]["Geld"]
	local bankgeld = result[1]["Bankgeld"]
	local damoney = 0
	if handgeld >= 1000 then
		damoney = 1000
		dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Geld", handgeld-damoney, "UID", playerUID[targetname] )
	elseif bankgeld >= 1000 then
		damoney = 1000
		dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Bankgeld", bankgeld-damoney, "UID", playerUID[targetname] )
	elseif handgeld + bankgeld >= 1000 then
		local bankabzuggeld = 1000 - handgeld
		damoney = 1000
		dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "userdata", "Geld", 0, "Bankgeld", bankgeld - bankabzuggeld, "UID", playerUID[targetname] )
	else
		damoney = handgeld + bankgeld
		dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "userdata", "Geld", 0, "Bankgeld", 0, "UID", playerUID[targetname] )
	end
	outputChatBox ("Dafür kriegst du "..damoney.."$", player, 255, 0, 0)
	vioSetElementData ( player, "money", vioGetElementData ( player, "money") + damoney )
end
	
	
local function startUeberfallZwei ( player, target )
	local x, y, z = getElementPosition ( player )
	local x1, y1, z1 = nil
	local frac = vioGetElementData ( player, "fraktion" )
	triggerClientEvent ( target, "infobox_start", getRootElement(), "\nDu wirst\nüberfallen!", 5000, 125, 0, 0 )
	local players = getElementsByType ("player")
	for i=1, #players do
		local playeritem = players[i]
		if playeritem ~= player and playeritem ~= target then
			x1, y1, z1 = getElementPosition ( playeritem )
			if getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 30 then
				outputChatBox ( getPlayerName(target).." wird ausgeraubt!", playeritem, 255, 0, 0 )
			end
		elseif playeritem == player then
			outputChatBox ( "Du überfällst "..getPlayerName(target)..".", playeritem, 255, 0, 0 )
		elseif playeritem == target then
			outputChatBox ( "Du wirst von der "..fraktionNames[frac].." überfallen (max. 500$)!", playeritem, 255, 0, 0 )
			outputChatBox ( "Benutze innerhalb 15 Sekunden /payrob oder sie dürfen dich töten!", playeritem, 255, 0, 0 )
		end
	end
	playerGettingRobbed[target] = player
	ueberfallListe[frac][getPlayerName(target)] = true
	addEventHandler ( "onPlayerQuit", target, ueberfallOfflineflucht )
	addEventHandler ( "onPlayerWasted", target, ueberfallTod )
	playerGettingRobbedTimer[target] = setTimer ( ueberfallSchusserlaubnis, 15*1000, 1, getPlayerName(player), target )
end
	

local function startUeberfallEins ( player, cmd, target )
	if isEvil ( player ) then
		if not vioGetElementData ( player, "jailtime" ) or vioGetElementData ( player, "jailtime" ) == 0 then
			if target then
				if findPlayerByName ( target )  then
					local targetpl = findPlayerByName ( target )
					local frac = vioGetElementData ( player, "fraktion" )
					if vioGetElementData ( targetpl, "fraktion" ) == 0 then
						if vioGetElementData ( targetpl, "playingtime") >= 180 then
							if not ueberfallListe[frac][getPlayerName(targetpl)] or ueberfallListe[frac][getPlayerName(targetpl)] == nil then
								if not playerGettingRobbed[targetpl] then
									local x, y, z = getElementPosition ( player )
									local x1, y1, z1 = getElementPosition ( targetpl )
									if getDistanceBetweenPoints3D ( x, y, z, x1, y1, z1 ) <= 15 then
										startUeberfallZwei ( player, targetpl )
									else
										triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist\nnicht nah genug\nam Spieler!", 5000, 125, 0, 0 )
									end
								else
									triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler\nwird gerade\nüberfallen!", 5000, 125, 0, 0 )
								end
							else
								triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler\nwurde heute\nschon ausgeraubt!", 5000, 125, 0, 0 )
							end
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Das Ziel\nist noch ein\nAnfänger!", 5000, 125, 0, 0 )
						end
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Nur Zivilisten\ndürfen überfallen\werden!", 5000, 125, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler\nist offline\noder ungültig!", 5000, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\Gebrauch:\n/rob NAME", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Du darfst\ndiesen Befehl im\nKnast nicht\nnutzen!!", 5000, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Nur für\nböse Fraktionisten!", 5000, 125, 0, 0 )
	end
end
addCommandHandler ("rob", startUeberfallEins)


local function payTheRob ( player )
	if playerGettingRobbed[player] then
		local raeuber = playerGettingRobbed[player]
		outputChatBox ( "Du hast bezahlt.", player, 0, 255, 0 )
		outputChatBox ( "Das Geld wurde bezahlt.", raeuber, 0, 255, 0 )
		local themoney = 500
		if vioGetElementData(player, "money") < 500 then
			themoney = vioGetElementData(player, "money")
		end
		vioSetElementData ( player, "money", vioGetElementData (player, "money") - themoney )
		vioSetElementData ( raeuber, "money", vioGetElementData (raeuber, "money") + themoney )
		playerSchusserlaubnis[player] = nil
		playerHatGeschossen[player] = nil
		if isTimer ( playerGettingRobbedTimer[player] ) then
			killTimer ( playerGettingRobbedTimer[player] )
			playerGettingRobbedTimer[player] = nil
		end
		playerGettingRobbed[player] = nil
	end
end
addCommandHandler ("payrob", payTheRob)

