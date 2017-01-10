local playerListLabels = {}
local playerListFactionMembersLabel = {}
local playersOnline = {}
local playersOnlineData = {}

local curPlayerListPosition = 1
local playerCount = 0
local playerListWidth = 650
local playerListHeight = 360
local maxPlayersInCurList = 17
local maxPlayers = 250

local playersToScrollPerButton = 10

function recieveServerSlotCount ( max )

	maxPlayers = max
end
addEvent ( "recieveServerSlotCount", true )
addEventHandler ( "recieveServerSlotCount", getRootElement(), recieveServerSlotCount )
triggerServerEvent ( "getServerSlotCount", lp )

local radioUpState, radioDownState, weaponUpState, weaponDownState = true

function fillPlayerListOnStart ()

	local players = getElementsByType ( "player" )
	for key, index in pairs ( players ) do
		playerCount = playerCount + 1
		playersOnlineData[index] = playerCount
		playersOnline[playerCount] = index
	end
end
fillPlayerListOnStart ()
function clientPlayerListDisconnect ()

	local i = playersOnlineData[source]
	playersOnline[i] = nil
	playerCount = playerCount - 1
end
addEventHandler ( "onClientPlayerQuit", getRootElement(), clientPlayerListDisconnect )
function clientPlayerListConnect ()

	local i
	for k = 1, maxPlayers do
		if not playersOnline[k] then
			i = k
			break
		end
	end
	playerCount = playerCount + 1
	playersOnlineData[source] = i
	playersOnline[i] = source
end
addEventHandler ( "onClientPlayerJoin", getRootElement(), clientPlayerListConnect )

function showPlayerList ()

	if gImage["playerList"] then
		guiSetVisible ( gImage["playerList"], true )
	else
		local label, img
		
		--gImage["playerList"] = guiCreateStaticImage(screenwidth/2-playerListWidth/2,screenheight/2-playerListHeight/2,playerListWidth,playerListHeight,"images/colors/c_black.jpg",false)
		gImage["playerList"] = guiCreateStaticImage(screenwidth/2-playerListWidth/2,screenheight/2-playerListHeight/2,playerListWidth,playerListHeight,"images/scoreboard.png",false)
		guiSetAlpha(gImage["playerList"],0.9)
		
		label = guiCreateLabel(40,39,51,23,"Name",false,gImage["playerList"])
		guiSetAlpha(label,1)
		guiLabelSetColor(label,255,255,255)
		guiLabelSetVerticalAlign(label,"top")
		guiLabelSetHorizontalAlign(label,"left",false)
		guiSetFont(label,"default-bold-small")
		--img = guiCreateStaticImage(8,23,453,5,"images/colors/c_green.jpg",false,gImage["playerList"])
		--guiSetAlpha(img,0.7)
		label = guiCreateLabel(166,39,88,23,"Sozialer Status",false,gImage["playerList"])
		guiSetAlpha(label,1)
		guiLabelSetColor(label,255,255,255)
		guiLabelSetVerticalAlign(label,"top")
		guiLabelSetHorizontalAlign(label,"left",false)
		guiSetFont(label,"default-bold-small")
		label = guiCreateLabel(290,39,52,20,"Spielzeit",false,gImage["playerList"])
		guiSetAlpha(label,1)
		guiLabelSetColor(label,255,255,255)
		guiLabelSetVerticalAlign(label,"top")
		guiLabelSetHorizontalAlign(label,"left",false)
		guiSetFont(label,"default-bold-small")
		--img = guiCreateStaticImage(151,28,3,268,"images/colors/c_green.jpg",false,gImage["playerList"])
		--guiSetAlpha(img,0.7)
		--img = guiCreateStaticImage(265,28,3,268,"images/colors/c_green.jpg",false,gImage["playerList"])
		--guiSetAlpha(img,0.7)
		label = guiCreateLabel(360,39,62,16,"Telefonnr.",false,gImage["playerList"])
		guiSetAlpha(label,1)
		guiLabelSetColor(label,255,255,255)
		guiLabelSetVerticalAlign(label,"top")
		guiLabelSetHorizontalAlign(label,"left",false)
		guiSetFont(label,"default-bold-small")
		--img = guiCreateStaticImage(333,28,3,268,"images/colors/c_green.jpg",false,gImage["playerList"])
		--guiSetAlpha(img,0.7)
		--img = guiCreateStaticImage(413,28,3,268,"images/colors/c_green.jpg",false,gImage["playerList"])
		--guiSetAlpha(img,0.7)
		
		label = guiCreateLabel(443,39,65,15,"Fraktion",false,gImage["playerList"])
		guiSetAlpha(label,1)
		guiLabelSetColor(label,255,255,255)
		guiLabelSetVerticalAlign(label,"top")
		guiLabelSetHorizontalAlign(label,"left",false)
		guiSetFont(label,"default-bold-small")
		
		label = guiCreateLabel(546,39,57,15,"Ping",false,gImage["playerList"])
		guiSetAlpha(label,1)
		guiLabelSetColor(label,255,255,255)
		guiLabelSetVerticalAlign(label,"top")
		guiLabelSetHorizontalAlign(label,"left",false)
		guiSetFont(label,"default-bold-small")
		
		--gImage["playerListBarBG"] = guiCreateStaticImage(472,0,12,playerListHeight,"images/colors/c_white.jpg",false,gImage["playerList"])
		--guiSetAlpha(gImage["playerListBarBG"],0.7)
		--gImage["playerListBarPull"] = guiCreateStaticImage(0,17,12,33,"images/colors/c_black.jpg",false,gImage["playerListBarBG"])
		--guiSetAlpha(gImage["playerListBarPull"],1)
		
		gLabel["playerListPlayers"] = guiCreateLabel(45,330,100,18,"0/"..maxPlayers.." Spieler",false,gImage["playerList"])
		guiSetAlpha(gLabel["playerListPlayers"],1)
		guiLabelSetColor(gLabel["playerListPlayers"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["playerListPlayers"],"top")
		guiLabelSetHorizontalAlign(gLabel["playerListPlayers"],"left",false)
		guiSetFont(gLabel["playerListPlayers"],"default-bold-small")
		
		for i, index in pairs ( factionColors ) do
			if i > 0 then
				local r, g, b = factionColors[i][1], factionColors[i][2], factionColors[i][3]
				playerListFactionMembersLabel[i] = guiCreateLabel(175+175+(i)*20,330,20,18,"",false,gImage["playerList"])
				guiSetAlpha(playerListFactionMembersLabel[i],1)
				guiLabelSetColor(playerListFactionMembersLabel[i],r,g,b)
				guiLabelSetVerticalAlign(playerListFactionMembersLabel[i],"top")
				guiLabelSetHorizontalAlign(playerListFactionMembersLabel[i],"left",false)
				guiSetFont(playerListFactionMembersLabel[i],"default-bold-small")
			end
		end
		
		for i = 1, maxPlayersInCurList do
			playerListLabels[i] = {}
			playerListLabels[i][1] = guiCreateLabel(40,55 - 16 + 16 * i,141,16,"",false,gImage["playerList"])
			playerListLabels[i][2] = guiCreateLabel(166,55 - 16 + 16 * i,141,16,"",false,gImage["playerList"])
			playerListLabels[i][3] = guiCreateLabel(290,55 - 16 + 16 * i,141,16,"",false,gImage["playerList"])
			playerListLabels[i][4] = guiCreateLabel(360,55 - 16 + 16 * i,141,16,"",false,gImage["playerList"])
			playerListLabels[i][5] = guiCreateLabel(443,55 - 16 + 16 * i,141,16,"",false,gImage["playerList"])
			playerListLabels[i][6] = guiCreateLabel(546,55 - 16 + 16 * i,141,16,"",false,gImage["playerList"])
			
			for k = 1, 6 do
				guiSetAlpha(playerListLabels[i][k],1)
				guiLabelSetColor(playerListLabels[i][k],255,255,255)
				guiLabelSetVerticalAlign(playerListLabels[i][k],"top")
				guiLabelSetHorizontalAlign(playerListLabels[i][k],"left",false)
				guiSetFont(playerListLabels[i][k],"default-bold-small")
			end
			guiLabelSetColor ( playerListLabels[i][2], 200, 200, 0 )
		end
	end
	updatePlayerList ()
end

function updateFactionPlayerCount ()

	factionCounter = {}
	local players = getElementsByType ( "player" )
	for key, index in pairs ( players ) do
		local i = getElementData ( index, "fraktion" )
		if i then
			if not factionCounter[i] then
				factionCounter[i] = {}
			end
			factionCounter[i][index] = true
		end
	end
	for i, index in pairs ( factionColors ) do
		if playerListFactionMembersLabel[i] then
			local length = tableLength ( factionCounter[i] )
			if length > 0 then
				guiSetText ( playerListFactionMembersLabel[i], length )
			else
				guiSetText ( playerListFactionMembersLabel[i], "" )
			end	
		end
	end
end

function tableLength ( table )

	local i = 0
	if table then
		for _, _ in pairs ( table ) do
			i = i + 1
		end
	end
	return i
end

function updatePlayerList ()

	if guiGetVisible ( gImage["playerList"] ) then
		updateFactionPlayerCount ()
		guiSetText ( gLabel["playerListPlayers"], playerCount.."/"..maxPlayers.." Spieler" )
		reFillPlayerList ()
		playerListUpdateTimer = setTimer ( updatePlayerList, 1000, 1 )
	end
end

function reAdjustPlayerListScollBar ()

	--[[pxPerPlayer = playerListHeight / ( playerCount )
	barSize = maxPlayersInCurList / playerCount * playerListHeight
	if barSize > playerListHeight then
	]]
	pxPerPlayer = 310 / ( playerCount )
	barSize = maxPlayersInCurList / playerCount * 310
	if barSize > 310 then
		barSize = 1
		barYPos = 0
	else
		barYPos = ( curPlayerListPosition - 1 ) * ( pxPerPlayer )
	end
	--guiSetSize ( gImage["playerListBarPull"], 17, barSize, false )
	--guiSetPosition ( gImage["playerListBarPull"], 0, barYPos, false )
end

function reFillPlayerList ()

	for key, index in pairs ( playerListLabels ) do
		for i = 1, 6 do
			guiSetText ( playerListLabels[key][i], "" )
		end
	end
	local i = 0
	local k = 0
	local name, rang, playingtime, ping, r, g, b
	for z = -2, factioncount do
		for key, index in pairs ( playersOnline ) do
			if ( z == -2 and not getElementData ( index, "loggedin" ) ) or ( z == -1 and getElementData ( index, "loggedin" ) == 0 ) or getElementData ( index, "fraktion" ) == z then
				i = i + 1
				if k > maxPlayersInCurList then
					break
				end
				if i >= curPlayerListPosition then
					k = k + 1
					name = getPlayerName ( index )
					rang = getElementData ( index, "socialState" )
					fraktion = getElementData ( index, "fraktion" )
					
					ping = tonumber ( getPlayerPing ( index ) )
					if not rang then
						rang = "Verbinden..."
						nr = ""
						playingtime = ""
						r, g, b = 175, 175, 175
					else
						nr = getElementData ( index, "telenr" )
						local faction = getElementData ( index, "fraktion" )
						r, g, b = factionColors[faction][1], factionColors[faction][2], factionColors[faction][3]
						playingtime = getElementData ( index, "playingtime" )
						playingtime = math.floor ( playingtime / 60 )..":"..( playingtime - math.floor ( playingtime / 60 ) * 60 )
					end
					
					if not fraktion then
						fraktion = "-"
					else
						fraktion = fraktionsNamen[fraktion] or "Zivilist"
					end
					
					if playerListLabels[k] and playerListLabels[k][1] and isElement(playerListLabels[k][1]) and name then
						guiSetText ( playerListLabels[k][1], name )
						
						guiSetText ( playerListLabels[k][2], rang )
						guiSetText ( playerListLabels[k][3], playingtime )
						guiSetText ( playerListLabels[k][4], nr )
						guiSetText ( playerListLabels[k][5], fraktion )
						guiSetText ( playerListLabels[k][6], ping )
						
						pr, pg, pb = getPingColor ( ping )
						local admlvl = getElementData ( index, "adminlvl" )
						if admlvl and admlvl >= 1 then
							guiLabelSetColor ( playerListLabels[k][2], 0, 200, 0 )
						else
							guiLabelSetColor ( playerListLabels[k][2], 200, 200, 0 )
						end
						guiLabelSetColor ( playerListLabels[k][1], r, g, b )
						guiLabelSetColor ( playerListLabels[k][5], r, g, b )
						guiLabelSetColor ( playerListLabels[k][6], pr, pg, pb )
					end
				end
			end
		end
	end
end

function getPingColor ( ping )

	if ping <= 50 then
		return 0, 200, 0
	elseif ping <= 150 then
		return 200, 200, 0
	else
		return 200, 0, 0
	end
end

function playerListScrollDown ()

	if curPlayerListPosition < playerCount - maxPlayersInCurList + playersToScrollPerButton then
		curPlayerListPosition = curPlayerListPosition + playersToScrollPerButton
	else
		curPlayerListPosition = playerCount
	end
	reFillPlayerList ()
end
function playerListScrollUp ()

	if curPlayerListPosition > playersToScrollPerButton then
		curPlayerListPosition = curPlayerListPosition - playersToScrollPerButton
	else
		curPlayerListPosition = 1
	end
	reFillPlayerList ()
end

function playerListKeyPressed ( key, state )
	
	if state == "down" then
		
		radioUpState = isControlEnabled ( "radio_next" )
		radioDownState = isControlEnabled ( "radio_previous" )
		weaponUpState = isControlEnabled ( "next_weapon" )
		weaponDownState = isControlEnabled ( "previous_weapon" )
		toggleControl ( "radio_next", false )
		toggleControl ( "radio_previous", false )
		toggleControl ( "next_weapon", false )
		toggleControl ( "previous_weapon", false )
		toggleControl ( "radio_user_track_skip", false )
		unbindKey ( "radio_next", "down", customRadioChannelSwitchUp )
		unbindKey ( "radio_previous", "down", customRadioChannelSwitchDown )
		
		if isTimer ( playerListUpdateTimer ) then
			killTimer ( playerListUpdateTimer )
		end
		scollBarAdjustTimer = setTimer ( reAdjustPlayerListScollBar, 50, 0 )
		bindKey ( "mouse_wheel_up", "down", playerListScrollUp )
		bindKey ( "mouse_wheel_down", "down", playerListScrollDown )
		showPlayerList ()
	else
		if isControlEnabled ( "next_weapon" ) then
			toggleControl ( "radio_next", true )
			toggleControl ( "radio_previous", true )
			toggleControl ( "next_weapon", true )
			toggleControl ( "previous_weapon", true )
		else
			if radioUpState ~= nil then
				toggleControl ( "radio_next", radioUpState )
			else
				toggleControl ( "radio_next", true )
			end
			if radioDownState ~= nil then
				toggleControl ( "radio_previous", radioDownState )
			else
				toggleControl ( "radio_previous", true )
			end
			if weaponUpState ~= nil then
				toggleControl ( "next_weapon", weaponUpState )
			else
				toggleControl ( "next_weapon", true )
			end
			if weaponDownState ~= nil then
				toggleControl ( "previous_weapon", weaponDownState )
			else
				toggleControl ( "previous_weapon", true )
			end
		end
		toggleControl ( "radio_user_track_skip", true )
		bindKey ( "radio_next", "down", customRadioChannelSwitchUp )
		bindKey ( "radio_previous", "down", customRadioChannelSwitchDown )
			
		if isTimer ( scollBarAdjustTimer ) then
			killTimer ( scollBarAdjustTimer )
		end
		unbindKey ( "mouse_wheel_up", "down", playerListScrollUp )
		unbindKey ( "mouse_wheel_down", "down", playerListScrollDown )
		if gImage["playerList"] then
			guiSetVisible ( gImage["playerList"], false )
		end
	end
end
bindKey ( "tab", "both", playerListKeyPressed )