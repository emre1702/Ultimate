addEvent ( "invitePlayerToRace", true )

local racedata = {}
local racemarker = {}


addEventHandler ( "invitePlayerToRace", getRootElement(), function ( text, target, betTyp, betAmount, targetID )
	if #text > 1 then
		local x1, y1, z1 = getElementPosition ( client )
		local x2, y2, z2 = getElementPosition ( target )
		local dist = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 )
		if dist <= 5 then
			betAmount = math.floor ( math.abs ( tonumber ( betAmount ) ) )
			if betAmount == 0 then
				betTyp = 0
			end
			outputChatBox ( getPlayerName ( client ).." hat dich zu einem Wettrennen herausgefordert, Ziel: "..text..".", target, 200, 200, 0 )
			if ( betTyp == 1 ) then
				outputChatBox ( "Preisgeld: "..betAmount.." $", target, 200, 200, 0 )
			elseif ( betTyp == 2 ) then
				outputChatBox ( "Wetteinsatz: Die Zulassungspapiere für dein Fahrzeug.", target, 200, 200, 0 )
			end
			outputChatBox ( "Tippe /accept race, um die Herausforderung anzunehmen.", target, 200, 200, 0 )
			outputChatBox ( "Du hast "..getPlayerName ( target ).." zu einem Rennen herausgefordert.", client, 0, 200, 0 )
			
			racedata[client] = { opponent = target, betTyp = betTyp, betAmount = betAmount, targetID = targetID }
			racedata[target] = { opponent = client, betTyp = betTyp, betAmount = betAmount, targetID = targetID }
		else
			infobox ( client, "Du hast bist\nzu weit entfernt!", 5000, 150, 0, 0 )
		end
	end
end )


local function raceTargetMarkerHit ( marker )
	if racedata[source] and racemarker[marker] then
		local player = racedata[source].opponent
		
		outputChatBox ( "Du hast das Rennen verloren!", player, 125, 0, 0 )
		outputChatBox ( "Du hast das Rennen gewonnen!", source, 0, 200, 0 )
		
		local betAmount = racedata[source].betAmount * 2
		triggerClientEvent ( source, "raceWon", source, betAmount )
		if betAmount > 0 then
			vioSetElementData ( source, "money", vioGetElementData ( source, "money" ) + betAmount )
			outputChatBox ( "Du erhälst "..betAmount.." $ Preisgeld!", source, 0, 125, 0 )
		end
		
		removeRaceEvent ( player, source )
	end
end


local function racePlayerQuit ()
	if vioGetElementData ( source, "isInRace" ) then
		local player = source
		local challenger = racedata[source].opponent
		
		outputChatBox ( "Du hast das Rennen gewonnen!", challenger, 0, 200, 0 )
		
		local betAmount = vioGetElementData ( challenger, "betAmount" ) * 2
		triggerClientEvent ( challenger, "raceWon", challenger, betAmount )
		if betAmount > 0 then
			vioSetElementData ( challenger, "money", vioGetElementData ( challenger, "money" ) + betAmount )
			outputChatBox ( "Du erhälst "..betAmount.." $ Preisgeld!", challenger, 0, 125, 0 )
		end
		removeRaceEvent ( player, challenger )
	end
end


local function racePlayerWasted ()
	if vioGetElementData ( source, "isInRace" ) then
		local player = source
		local challenger = vioGetElementData ( player, "challenger" )
		
		outputChatBox ( "Du hast das Rennen verloren!", player, 125, 0, 0 )
		outputChatBox ( "Du hast das Rennen gewonnen!", challenger, 0, 200, 0 )
		
		local betAmount = vioGetElementData ( challenger, "betAmount" ) * 2
		triggerClientEvent ( challenger, "raceWon", challenger, betAmount )
		if betAmount > 0 then
			vioSetElementData ( challenger, "money", vioGetElementData ( challenger, "money" ) + betAmount )
			outputChatBox ( "Du erhälst "..betAmount.." $ Preisgeld!", challenger, 0, 125, 0 )
		end
		removeRaceEvent ( player, challenger )
	end
end


local function racePlayerVehExit ()
	if vioGetElementData ( source, "isInRace" ) then
		local player = source
		local challenger = vioGetElementData ( player, "challenger" )
		
		
		outputChatBox ( "Du hast das Rennen verloren!", player, 125, 0, 0 )
		outputChatBox ( "Du hast das Rennen gewonnen!", challenger, 0, 200, 0 )
		
		local betAmount = vioGetElementData ( challenger, "betAmount" ) * 2
		triggerClientEvent ( challenger, "raceWon", challenger, betAmount )
		if betAmount > 0 then
			vioSetElementData ( challenger, "money", vioGetElementData ( challenger, "money" ) + betAmount )
			outputChatBox ( "Du erhälst "..betAmount.." $ Preisgeld!", challenger, 0, 125, 0 )
		end
		
		removeRaceEvent ( player, challenger )
	end
end


function acceptRace ( player )

	local challenger = racedata[player].opponent
	local bet = racedata[player].betAmount
	local betTyp = racedata[player].betType
	local targetID = racedata[player].targetID
	if isElement ( challenger ) and isElement ( player ) then
		if not vioGetElementData ( player, "isInRace" ) then
			if not vioGetElementData ( challenger, "isInRace" ) then
				racedata[challenger] = { opponent = player, betTyp = betTyp, betAmount = bet, targetID = targetID }
				racedata[player] = { opponent = challenger, betTyp = betTyp, betAmount = bet, targetID = targetID }

				local x1, y1, z1 = getElementPosition ( player )
				local x2, y2, z2 = getElementPosition ( challenger )
				
				local dist = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 )
				if dist <= 5 then
					if getPedOccupiedVehicleSeat ( player ) == 0 then
						if getPedOccupiedVehicleSeat ( challenger ) == 0 then
							if betTyp == 0 or ( betTyp == 1 and vioGetElementData ( player, "money" ) >= bet and vioGetElementData ( challenger, "money" ) >= bet ) then
								vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - bet )
								vioSetElementData ( challenger, "money", vioGetElementData ( challenger, "money" ) - bet )
								
								local veh1 = getPedOccupiedVehicle ( challenger )
								local veh2 = getPedOccupiedVehicle ( player )
								
								setElementFrozen ( veh1, true )
								setElementFrozen ( veh2, true )
								setVehicleDamageProof ( veh1, true )
								setVehicleDamageProof ( veh2, true )
								toggleControl ( player, "enter_exit", false )
								toggleControl ( challenger, "enter_exit", false )
								
								addEventHandler ( "onPlayerWasted", player, racePlayerWasted )
								addEventHandler ( "onPlayerWasted", challenger, racePlayerWasted )
								addEventHandler ( "onPlayerQuit", player, racePlayerQuit )
								addEventHandler ( "onPlayerQuit", challenger, racePlayerQuit )
								addEventHandler ( "onPlayerVehicleExit", player, racePlayerVehExit )
								addEventHandler ( "onPlayerVehicleExit", challenger, racePlayerVehExit )
								
								vioSetElementData ( player, "isInRace", true )
								vioSetElementData ( challenger, "isInRace", true )
								
								triggerClientEvent ( player, "showRaceCountdown", player )
								triggerClientEvent ( challenger, "showRaceCountdown", challenger )
								setTimer (
									function ( veh1, veh2, player, challenger )
										setElementFrozen ( veh1, false )
										setElementFrozen ( veh2, false )
										
										setVehicleDamageProof ( veh1, false )
										setVehicleDamageProof ( veh2, false )
										
										if isElement ( player ) then
											toggleControl ( player, "enter_exit", true )
										end
										if isElement ( challenger ) then
											toggleControl ( challenger, "enter_exit", true )
										end
									end,
								3000 + 3000, 1, veh1, veh2, player, challenger )
								
								
								local x, y, z = possibleRaceTargets["x"][targetID], possibleRaceTargets["y"][targetID], possibleRaceTargets["z"][targetID]
								local marker = createMarker ( x, y, z, "checkpoint", 10, 200, 0, 0, 125, nil )
								local blip = createBlip ( x, y, z, 53, 2, 0, 0, 0, 255, 0, 99999, nil )
								
								addEventHandler ( "onPlayerMarkerHit", player, raceTargetMarkerHit )
								addEventHandler ( "onPlayerMarkerHit", challenger, raceTargetMarkerHit )
								
								racemarker[marker] = blip

								racedata[player].marker = marker 
								racedata[challenger].marker = marker
								
								setElementVisibleTo ( marker, player, true )
								setElementVisibleTo ( blip, player, true )
								setElementVisibleTo ( marker, challenger, true )
								setElementVisibleTo ( blip, challenger, true )

								for thePlayer, hisTable in pairs ( racedata ) do 
									if hisTable.opponent == player and challenger ~= thePlayer or hisTable.opponent == challenger and player ~= thePlayer then
										racedata[thePlayer] = nil 
										infobox ( thePlayer, "Einladung zum Rennen ist verflogen, der Gegner ist in einem Rennen!", 5000, 150, 0, 0 )
									end
								end
								return true
							else
								infobox ( player, "Du oder dein\nPartner haben nicht\ngenug Geld dabei!", 5000, 150, 0, 0 )
							end
						else
							infobox ( player, "Das Ziel ist\nnicht in einem\nFahrzeug!", 5000, 150, 0, 0 )
						end
					else
						infobox ( player, "Du bist nicht\nin einem Fahrzeug!", 5000, 150, 0, 0 )
					end
				else
					infobox ( player, "Du hast bist\nzu weit entfernt!", 5000, 150, 0, 0 )
				end
			else
				infobox ( client, "Der Spieler ist schon in einem Rennen!", 5000, 150, 0, 0 )
			end
		else
			infobox ( client, "Du bist schon in einem Rennen!", 5000, 150, 0, 0 )
		end	
	else
		infobox ( player, "Du hast keine\nHerausforderung!", 5000, 150, 0, 0 )
	end
end


function removeRaceEvent ( player, challenger )

	removeEventHandler ( "onPlayerWasted", player, racePlayerWasted )
	removeEventHandler ( "onPlayerWasted", challenger, racePlayerWasted )
	removeEventHandler ( "onPlayerQuit", player, racePlayerQuit )
	removeEventHandler ( "onPlayerQuit", challenger, racePlayerQuit )
	removeEventHandler ( "onPlayerVehicleExit", player, racePlayerVehExit )
	removeEventHandler ( "onPlayerVehicleExit", challenger, racePlayerVehExit )
	removeEventHandler ( "onPlayerMarkerHit", player, raceTargetMarkerHit )
	removeEventHandler ( "onPlayerMarkerHit", challenger, raceTargetMarkerHit )
	
	destroyElement ( racemarker[racedata[player].marker] )
	destroyElement ( racedata[player].marker )

	racedata[player] = nil 
	racedata[challenger] = nil

	vioSetElementData ( player, "isInRace", false )
	vioSetElementData ( challenger, "isInRace", false )
end