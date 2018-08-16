local cuffTimer = {}


function tazer_func ( player )

	if player == client or not client then
		if isOnDuty(player) then
			if vioGetElementData ( player, "tazer" ) == 1 then else vioSetElementData ( player, "tazer", 0 ) end
			if vioGetElementData ( player, "tazer" ) == 0 then
				if not getPedOccupiedVehicle ( player ) then
					local posX, posY, posZ = getElementPosition( player )
					local tazerSphere = createColSphere( posX, posY, posZ, 3 )
					local nearbyPlayers = getElementsWithinColShape( tazerSphere, "player" )
					destroyElement( tazerSphere )
					local curTazerVicitm = nil
					local bestDist = 999
					for index, nearbyPlayer in pairs ( nearbyPlayers ) do
						if nearbyPlayer ~= player and not getPedOccupiedVehicle ( nearbyPlayer ) and ( ( isPedAiming ( nearbyPlayer ) and getPedWeapon ( nearbyPlayer ) < 2 ) or not isPedAiming ( nearbyPlayer ) ) then
							local px, py, pz = getElementPosition ( nearbyPlayer )
							local cDist = getDistanceBetweenPoints3D ( posX, posY, posZ, px, py, pz )
							if cDist <= bestDist then
								curTazerVicitm = nearbyPlayer
								bestDist = cDist
							end
						end
					end
					if isElement ( curTazerVicitm ) then
						setPedAnimation( curTazerVicitm, "crack", "crckdeth2",-1,true,true,false)
						setTimer ( defreeze_tazer, 20000, 1, curTazerVicitm )
						vioSetElementData ( player, "tazer", 1 )
						setTimer ( reuse_tazer, 25000, 1, player )
						local posX, posY, posZ = getElementPosition( player )
						local chatSphere = createColSphere( posX, posY, posZ, 10 )
						local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
						destroyElement ( chatSphere )
						toggleAllControls ( curTazerVicitm, false, true, false )
						local pname = getPlayerName ( player )
						outputLog ( pname.." hat "..getPlayerName(curTazerVicitm).." getazert!", "tazer" )
						for i=1, #nearbyPlayers do
							outputChatBox ( pname.." hat "..getPlayerName(curTazerVicitm).." getazert!", nearbyPlayers[i], 100, 0, 200 )
						end
						vioSetElementData ( curTazerVicitm, "tazered", true )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\nEs ist kein\nSpieler in der\nNähe!", 5000, 125, 0, 0 )
					end
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nTazern ist nur\nalle 25 Sekunden\nmöglich!", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist kein\nPolizist im\nDienst!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "tazer", true )
addEventHandler ( "tazer", getRootElement(), tazer_func )
addCommandHandler ( "tazer", tazer_func )

function defreeze_tazer ( player )
	if isElement ( player ) then
		setPedAnimation ( player )
		vioSetElementData ( player, "tazered", false )
		if vioGetElementData ( player, "nodmzone" ) == 1 then
			toggleControl (player, "fire", false)
			toggleControl (player, "next_weapon", false)
			toggleControl (player, "previous_weapon", false)
			toggleControl (player, "aim_weapon", false)
			toggleControl (player, "vehicle_fire", false)
			toggleControl (player, "vehicle_secondary_fire", false)
		end
		if vioGetElementData ( player, "tied" ) then
			toggleAllControls ( player, true, true, false )
			if isTimer ( cuffTimer[player] ) then
				toggleControl ( player, "sprint", false )
				toggleControl ( player, "walk", false )
				setPedControlState ( player, "walk", true )
			end
		end
	end
end

function reuse_tazer ( player )

	vioSetElementData ( player, "tazer", 0 )
end

function accept_func ( player, cmd, add )

	if add == "test" then
		local cop = vioGetElementData ( player, "tester" )
		if isElement ( cop ) then
			local alc = vioGetElementData ( player, "alcoholFlushPoints" ) / 25
			local drogen = vioGetElementData ( player, "drugFlushPoints" )
			infobox ( player, "\n\n\nDu hast dem\nTest zugestimmt.", 5000, 0, 125, 0 )
			local result = "Ergebnis:\nAlkoholgehalt im Blut: "..alc.." Promil,\nTHC-Gehalt im Blut: "..drogen
			outputChatBox ( result, cop, 200, 200, 0 )
			outputChatBox ( result, player, 200, 200, 0 )
		else
			infobox ( player, "\n\n\nNicht möglich.", 5000, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "accept", accept_func )


function cuff_func ( player, cmd, target )

	if player == client or not client then
		if isOnDuty(player) then
			local target = getPlayerFromName ( target )
			if target then
				local x1, y1, z1 = getElementPosition ( player )
				local x2, y2, z2 = getElementPosition ( target )
				if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
					vioSetElementData ( target, "sprint", 1 )
					if isTimer ( cuffTimer[target] ) then
						killTimer ( cuffTimer[target] )
						outputChatBox ( "Du hast die Handschellen von "..getPlayerName(target).." erneuert!", player, 0, 125, 0 )
					else
						toggleControl ( target, "sprint", false )
						toggleControl ( target, "walk", false )
						setPedControlState ( target, "walk", true )
						outputChatBox ( getPlayerName(player).." hat dich gefesselt! Du kannst nicht mehr rennen!", target, 0, 125, 0 )
						outputChatBox ( "Du hast "..getPlayerName(target).." Handschellen angelegt!", player, 0, 125, 0 )
						takeAllWeapons ( target )
					end
					cuffTimer[target] = setTimer ( reengage_sprint, 30000, 1, target )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist zu weit\nentfernt!", 5000, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nUngueltiger Spieler!", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist kein\nPolizist im\nDienst!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "cuffGUI", true )
addEventHandler ( "cuffGUI", getRootElement(), cuff_func )
addCommandHandler ( "cuff", cuff_func )

function reengage_sprint ( player )

	vioSetElementData ( player, "sprint", 0 )
	toggleControl ( player, "sprint", true )
	toggleControl ( player, "walk", true )
	setPedControlState ( player, "walk", false )
	outputChatBox ( "Du hast deine Fußfesseln gelöst!", player,  0, 125, 0 )
end