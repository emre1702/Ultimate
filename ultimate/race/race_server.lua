function invitePlayerToRace ( text, target, betTyp, betAmount, targetID )

	if #text > 1 then
		local player = client
		local x1, y1, z1 = getElementPosition ( player )
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
			
			vioSetElementData ( target, "challengerQ", client )
			vioSetElementData ( target, "betTypQ", betTyp )
			vioSetElementData ( target, "betAmountQ", betAmount )
			vioSetElementData ( target, "targetIDQ", targetID )
			
			vioSetElementData ( client, "challengerQ", target )
			vioSetElementData ( client, "betTypQ", betTyp )
			vioSetElementData ( client, "betAmountQ", betAmount )
			vioSetElementData ( client, "targetIDQ", targetID )
		else
			infobox ( player, "Du hast bist\nzu weit entfernt!", 5000, 150, 0, 0 )
		end
	end
end
addEvent ( "invitePlayerToRace", true )
addEventHandler ( "invitePlayerToRace", getRootElement(), invitePlayerToRace )

function acceptRace ( player )

	local challenger = vioGetElementData ( player, "challengerQ" )
	local bet = vioGetElementData ( player, "betAmountQ" )
	local betTyp = vioGetElementData ( player, "betTypQ" )
	local targetID = vioGetElementData ( player, "targetIDQ" )
	if isElement ( challenger ) and isElement ( player ) then
		vioSetElementData ( player, "betAmount", bet )
		vioSetElementData ( challenger, "betAmount", bet )
		vioSetElementData ( player, "betTyp", betTyp )
		vioSetElementData ( challenger, "betTyp", betTyp )
		vioSetElementData ( player, "challenger", challenger )
		vioSetElementData ( challenger, "challenger", player )
		vioSetElementData ( player, "targetID", targetID )
		vioSetElementData ( challenger, "targetID", targetID )
	end
	if isElement ( challenger ) and vioGetElementData ( challenger, "challenger" ) == player and vioGetElementData ( player, "betAmount" ) == vioGetElementData ( challenger, "betAmount" ) and vioGetElementData ( player, "betTyp" ) == vioGetElementData ( challenger, "betTyp" ) then
		local x1, y1, z1 = getElementPosition ( player )
		local x2, y2, z2 = getElementPosition ( challenger )
		
		local dist = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 )
		if dist <= 5 then
			if getPedOccupiedVehicleSeat ( player ) == 0 then
				if getPedOccupiedVehicleSeat ( challenger ) == 0 then
					if vioGetElementData ( player, "betTyp" ) == 0 or ( vioGetElementData ( player, "betTyp" ) == 1 and vioGetElementData ( player, "money" ) >= bet and vioGetElementData ( challenger, "money" ) >= bet ) then
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
						
						local i = vioGetElementData ( player, "targetID" )
						
						local x, y, z = possibleRaceTargets["x"][i], possibleRaceTargets["y"][i], possibleRaceTargets["z"][i]
						local marker = createMarker ( x, y, z, "checkpoint", 10, 200, 0, 0, 125, nil )
						local blip = createBlip ( x, y, z, 53, 2, 0, 0, 0, 255, 0, 99999, nil )
						
						addEventHandler ( "onPlayerMarkerHit", player, raceTargetMarkerHit )
						addEventHandler ( "onPlayerMarkerHit", challenger, raceTargetMarkerHit )
						
						vioSetElementData ( player, "raceMarker", marker )
						vioSetElementData ( challenger, "raceMarker", marker )
						vioSetElementData ( player, "raceBlip", blip )
						vioSetElementData ( challenger, "raceBlip", blip )
						
						setElementVisibleTo ( marker, player, true )
						setElementVisibleTo ( blip, player, true )
						setElementVisibleTo ( marker, challenger, true )
						setElementVisibleTo ( blip, challenger, true )
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
		infobox ( player, "Du hast keine\nHerausforderung!", 5000, 150, 0, 0 )
	end
	vioSetElementData ( player, "challenger", false )
end

function raceTargetMarkerHit ( marker )

	if vioGetElementData ( source, "isInRace" ) and marker == vioGetElementData ( source, "raceMarker" ) then
		local challenger = source
		local player = vioGetElementData ( challenger, "challenger" )
		removeRaceEvent ( player, challenger )
		
		outputChatBox ( "Du hast das Rennen verloren!", player, 125, 0, 0 )
		outputChatBox ( "Du hast das Rennen gewonnen!", challenger, 0, 200, 0 )
		
		local betAmount = vioGetElementData ( challenger, "betAmount" ) * 2
		triggerClientEvent ( challenger, "raceWon", challenger, betAmount )
		if betAmount > 0 then
			vioSetElementData ( challenger, "money", vioGetElementData ( challenger, "money" ) + betAmount )
			outputChatBox ( "Du erhälst "..betAmount.." $ Preisgeld!", challenger, 0, 125, 0 )
		end
		
		vioSetElementData ( player, "isInRace", false )
		vioSetElementData ( challenger, "isInRace", false )
	end
end

function racePlayerQuit ()

	if vioGetElementData ( source, "isInRace" ) then
		local player = source
		local challenger = vioGetElementData ( player, "challenger" )
		removeRaceEvent ( player, challenger )
		
		outputChatBox ( "Du hast das Rennen gewonnen!", challenger, 0, 200, 0 )
		
		local betAmount = vioGetElementData ( challenger, "betAmount" ) * 2
		triggerClientEvent ( challenger, "raceWon", challenger, betAmount )
		if betAmount > 0 then
			vioSetElementData ( challenger, "money", vioGetElementData ( challenger, "money" ) + betAmount )
			outputChatBox ( "Du erhälst "..betAmount.." $ Preisgeld!", challenger, 0, 125, 0 )
		end
		
		vioSetElementData ( player, "isInRace", false )
		vioSetElementData ( challenger, "isInRace", false )
	end
end

function racePlayerWasted ()

	if vioGetElementData ( source, "isInRace" ) then
		local player = source
		local challenger = vioGetElementData ( player, "challenger" )
		removeRaceEvent ( player, challenger )
		
		outputChatBox ( "Du hast das Rennen verloren!", player, 125, 0, 0 )
		outputChatBox ( "Du hast das Rennen gewonnen!", challenger, 0, 200, 0 )
		
		local betAmount = vioGetElementData ( challenger, "betAmount" ) * 2
		triggerClientEvent ( challenger, "raceWon", challenger, betAmount )
		if betAmount > 0 then
			vioSetElementData ( challenger, "money", vioGetElementData ( challenger, "money" ) + betAmount )
			outputChatBox ( "Du erhälst "..betAmount.." $ Preisgeld!", challenger, 0, 125, 0 )
		end
		
		vioSetElementData ( player, "isInRace", false )
		vioSetElementData ( challenger, "isInRace", false )
	end
end

function racePlayerVehExit ()

	if vioGetElementData ( source, "isInRace" ) then
		local player = source
		local challenger = vioGetElementData ( player, "challenger" )
		removeRaceEvent ( player, challenger )
		
		outputChatBox ( "Du hast das Rennen verloren!", player, 125, 0, 0 )
		outputChatBox ( "Du hast das Rennen gewonnen!", challenger, 0, 200, 0 )
		
		local betAmount = vioGetElementData ( challenger, "betAmount" ) * 2
		triggerClientEvent ( challenger, "raceWon", challenger, betAmount )
		if betAmount > 0 then
			vioSetElementData ( challenger, "money", vioGetElementData ( challenger, "money" ) + betAmount )
			outputChatBox ( "Du erhälst "..betAmount.." $ Preisgeld!", challenger, 0, 125, 0 )
		end
		
		vioSetElementData ( player, "isInRace", false )
		vioSetElementData ( challenger, "isInRace", false )
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
	
	destroyElement ( vioGetElementData ( player, "raceMarker" ) )
	destroyElement ( vioGetElementData ( player, "raceBlip" ) )
end