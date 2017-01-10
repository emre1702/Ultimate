mincontract = 5000 
							   
hitmanjobicon = createPickup ( -1830.404, 572.713, 35.164, 3, 1239, 1000, 0 )
setElementAlpha ( hitmanjobicon, 0 )

hitmanblip = createBlip ( -1830.404, 572.713, 35.164, 43, 1, 255, 0, 0, 255, 0, 99999 )
setElementVisibleTo ( hitmanblip, getRootElement(), false )

function hitmanjobiconHit ( player )
	if vioGetElementData ( player, "job" ) == "hitman" then
		outputChatBox ( "Tippe /contracts, um die Auftraege zu sehen, /contract [Name] [Summe], um ein Kopfgeld auszusetzen.", player, 200, 125, 125 )
		--outputChatBox ( "/arm um dich für 300$ auszurüsten.", player, 200, 125, 125 )
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Tippe /job, um\nals Hitman zu\narbeiten -\nAllerdings illegal!", 5000, 200, 200, 0 )
	end
	--outputChatBox ( "Vorruebergehend deaktiviert, bitte wende dich an einen Administrator!", player, 125, 0, 0 )
end
--addEventHandler ( "onPickupHit", hitmanjobicon, hitmanjobiconHit )

function arm_func ( player )

	if vioGetElementData ( player, "job" ) == "hitman" then
		local x1, y1, z1 = getElementPosition ( player )
		local x2, y2, z2 = getElementPosition ( hitmanjobicon )
		if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 10 then
			if vioGetElementData ( player, "money" ) >= 300 then
				takePlayerSaveMoney ( player, 300 )
				giveWeapon ( player, 24, 56, true )
				giveWeapon ( player, 25, 25, true )
				giveWeapon ( player, 34, 10, true )
			else
				outputChatBox ( "Du hast nicht genug Geld - ein Paket kostet 100$!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Du bist an einer ungueltigen Stelle!", player, 125, 0, 0 )
		end
	end
end
--addCommandHandler ( "arm", arm_func )

function contract_func ( player, cmd, name, geld )
	if not name then return end
	
	local target = getPlayerFromName ( name )
	if target and vioGetElementData ( target, "loggedin" ) then
		local geld = tonumber ( geld )
		if geld then
			local pmoney = tonumber ( vioGetElementData ( player, "money" ) )
			if pmoney >= geld then
				if geld >= mincontract then
					vioSetElementData ( player, "money", pmoney - geld )
					playSoundFrontEnd ( player, 40 )
					vioSetElementData ( target, "contract", tonumber ( vioGetElementData ( target, "contract" ) ) + geld )
					outputChatBox ( "Du hast "..geld.." $ Kopfgeld auf "..name.." ausgesetzt - ein Hitman wird sich bald um ihn kuemmern...", player, 0, 125, 0 )
				else
					outputChatBox ( "Bitte setze mindestens "..mincontract.." $ als Belohnung aus!", player, 125, 0, 0 )
				end
			else
				outputChatBox ( "Du hast nicht genug Geld, um einen Mord in Auftrag zu geben.", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Ungueltige Summe!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Der Spieler existiert nicht / ist offline!", player, 125, 0, 0 )
	end
end
--addCommandHandler ( "contract", contract_func )

function contracts_func ( player )

	--if isHitman ( player ) then
	if vioGetElementData ( player, "job" ) == "hitman" then
		outputChatBox ( "Auftraege ( Die ersten 5 werden angezeigt ):", player, 200, 200, 20 )
		local players = getElementsByType("player")
		for i=1, #players do
			local playeritem = players[i]
			if vioGetElementData ( playeritem, "loggedin" ) == 1 then
				local contract = tonumber ( vioGetElementData ( playeritem, "contract" ) )
				local i = 0
				if contract then
					if contract >= mincontract then
						local i = i + 1
						outputChatBox ( getPlayerName ( playeritem )..", Belohnung: "..contract, player, 200, 200, 20 )
						if i == 5 then
							break
						end
					end
				end
			end
		end
	else
		outputChatBox ( "Du bist kein Hitman!", player, 125, 0, 0 )
	end
end
--addCommandHandler ( "contracts", contracts_func )