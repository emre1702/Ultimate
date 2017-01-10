noengine = { [509]=true, [481]=true, [510]=true, [462]=true }

function toggleVehicleLights ( player, key, state )
	if ( getPedOccupiedVehicleSeat ( player ) == 0 ) then
		local veh = getPedOccupiedVehicle ( player )
		if getElementModel ( veh ) ~= 438 then
			if ( getVehicleOverrideLights ( veh ) ~= 2 ) then
				setVehicleOverrideLights ( veh, 2 )
				vioSetElementData ( veh, "light", true)
			else
				setVehicleOverrideLights ( veh, 1 )
				vioSetElementData ( veh, "light", false)
			end
		end
	end
end

function toggleVehicleTrunkBind ( player, key, state )

	local veh = getPedOccupiedVehicle ( player )
	if getPedOccupiedVehicleSeat ( player ) == 0 and vioGetElementData ( veh, "engine" ) then
		if vioGetElementData ( veh, "owner" ) then
			if vioGetElementData ( veh, "stuning1" ) then
				if vioGetElementData ( veh, "engine" ) then
					toggleVehicleTrunk ( veh )
					unbindKey ( player, "sub_mission", "down", toggleVehicleTrunkBind, "Kofferraum auf/zu" )
					setTimer ( rebindTrunk, 750, 1, player )
				else
					outputChatBox ( "Der Motor muss laufen!", player, 125, 0, 0 )
				end
			else
				outputChatBox ( "Dieses Fahrzeug hat keinen Kofferraum!", player, 125, 0, 0 )
			end
		end
	end
end

function rebindTrunk ( player )

	bindKey ( player, "sub_mission", "down", toggleVehicleTrunkBind, "Kofferraum auf/zu" )
end

function toggleVehicleEngine ( player, key, state )
	local veh = getPedOccupiedVehicle ( player )
	if veh and getElementModel ( veh ) ~= 438 then
		if ( getPedOccupiedVehicleSeat ( player ) == 0 ) then
			
			-- Falls das Fahrzeug neu gespawnt ist und noch keinen Benzinwert hat
			if not vioGetElementData ( veh, "fuelstate" ) then
				vioSetElementData ( veh, "fuelstate", 100 )
				vioSetElementData ( veh, "engine", false )
				setVehicleOverrideLights ( veh, 1 )
				vioSetElementData ( veh, "light", false)
				setVehicleEngineState ( veh, false )
			end
			
			-- Falls der Motor läuft -> immer abschalten
			if getVehicleEngineState ( veh ) then
				setVehicleEngineState ( veh, false )
				vioSetElementData ( veh, "engine", false )
				--[[local x, y, z = getElementPosition ( veh )
				local sphere = createColSphere ( x, y, z, 3 )
				local vehicles = getElementsWithinColShape ( sphere, "vehicle" )
				destroyElement ( sphere )
				for key, index in pairs ( vehicles ) do
					if getElementModel ( index ) == 443 then
						attachElementsInVeryCorrectWay ( veh, index )
						vioSetElementData ( veh, "attachedToPacker", index )
						break
					end
				end]]
			-- Falls der Motor NICHT läuft, dem Spieler das Fahrzeug jedoch gehört
			elseif vioGetElementData ( veh, "owner" ) == getPlayerName ( player ) then
				-- Falls das Fahrzeug noch genug Benzin hat
				if tonumber ( vioGetElementData ( veh, "fuelstate" ) ) >= 1 then
					setVehicleEngineState ( veh, true )
					vioSetElementData ( veh, "engine", true )
					if not vioGetElementData ( veh, "timerrunning" ) then
						setVehicleNewFuelState ( veh )
						vioSetElementData ( veh, "timerrunning", true )
						--[[if vioGetElementData ( veh, "attachedToPacker" ) then
							detachElements ( veh, vioGetElementData ( veh, "attachedToPacker" ) )
						end]]
					end
				else
					outputChatBox ( "Das Fahrzeug hat nicht mehr genug Benzin - du kannst an einer Tankstelle einen Reservekannister erwerben!", player, 125, 0, 0 )
				end
			-- Kein Besitzer bzw. Fraktionswagen / gespawnte Fahrzeuge
			elseif not vioGetElementData ( veh, "owner" ) then
				if vioGetElementData ( veh, "fuelstate" ) >= 1 then
					setVehicleEngineState ( veh, true )
					vioSetElementData ( veh, "engine", true )
					if not vioGetElementData ( veh, "timerrunning" ) then
						setVehicleNewFuelState ( veh )
						vioSetElementData ( veh, "timerrunning", true )
					end
					--[[if vioGetElementData ( veh, "attachedToPacker" ) then
						detachElements ( veh, vioGetElementData ( veh, "attachedToPacker" ) )
					end]]
				end
			elseif vioGetElementData ( veh, "ownerfraktion" ) then
				local car_acess
				if tonumber(vioGetElementData( veh, "ownerfraktion" )) == tonumber(vioGetElementData ( player, "fraktion" )) then
					car_acess = true
				elseif tonumber(vioGetElementData( veh, "ownerfraktion" )) == 1 then
					if isCop ( player ) or ( isOnDuty ( player ) and vioGetElementData ( player, "rang" ) >= 4 ) then
						car_acess = true				
					end
				elseif tonumber(vioGetElementData( veh, "ownerfraktion" )) == 6 then
					if isFBI ( player ) or ( isOnDuty ( player ) and vioGetElementData ( player, "rang" ) >= 4 ) then
						car_acess = true				
					end
				elseif tonumber(vioGetElementData( veh, "ownerfraktion" )) == 8 then
					if isArmy ( player ) or ( isOnDuty ( player ) and vioGetElementData ( player, "rang" ) >= 4 ) then
						car_acess = true				
					end
				end
			
				if vioGetElementData ( veh, "fuelstate" ) >= 1 and car_acess == true then
					setVehicleEngineState ( veh, true )
					vioSetElementData ( veh, "engine", true )
					if not vioGetElementData ( veh, "timerrunning" ) then
						setVehicleNewFuelState ( veh )
						vioSetElementData ( veh, "timerrunning", true )
					end
				end
			end
			--[[if not vioGetElementData ( veh, "owner" ) then
				if getVehicleEngineState ( veh ) then
					setVehicleEngineState ( veh, false )
					vioSetElementData ( veh, "engine", false )
				else
					setVehicleEngineState ( veh, true )
					vioSetElementData ( veh, "engine", true )
				end
			elseif vioGetElementData ( veh, "owner" ) and vioGetElementData ( veh, "owner" ) ~= getPlayerName ( player ) then
				if getVehicleEngineState ( veh ) then
					setVehicleEngineState ( veh, false )
					vioSetElementData ( veh, "engine", false)
				end
			else
				if getVehicleEngineState ( veh ) and ( ( noengine[getElementModel ( veh )] and vioGetElementData ( veh, "owner" ) ) or not noengine[getElementModel ( veh )] ) then
					setVehicleEngineState ( veh, false )
					vioSetElementData ( veh, "engine", false)
				elseif not getVehicleEngineState ( veh ) and tonumber ( vioGetElementData ( veh, "fuelstate" ) ) > 0 then
					setVehicleEngineState ( veh, true )
					vioSetElementData ( veh, "engine", true )
					if not vioGetElementData ( veh, "timerrunning" ) then
						setVehicleNewFuelState ( veh )
						vioSetElementData ( veh, "timerrunning", true )
					end
				end
			end]]
		end
	end
end

function enginecheck ( veh, seat )

	if seat == 0 then
		if ( not noengine[getElementModel ( veh )] or ( noengine[getElementModel ( veh )] and vioGetElementData ( veh, "owner" ) ) ) and getElementModel ( veh ) ~= 438 then
			if not vioGetElementData ( veh, "engine" ) then
				vioSetElementData ( veh, "engine", false )
				setVehicleEngineState ( veh, false )
			end
			if not vioGetElementData ( veh, "light" ) then
				vioSetElementData ( veh, "light", false )
				setVehicleOverrideLights ( veh, 1 )
			end
			if getElementType ( source ) == "player" then
				if not isKeyBound ( source, "l", "down", toggleVehicleLights ) then
					bindKey ( source, "l", "down", toggleVehicleLights, "Licht an/aus" )
					bindKey ( source, "x", "down", toggleVehicleEngine, "Motor an/aus" )
					bindKey ( source, "sub_mission", "down", toggleVehicleTrunkBind, "Kofferraum auf/zu" )
				end
			end
		end
	end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), enginecheck )

function vehexit ()

	unbindKey ( source, "l", "down", toggleVehicleLights, "Licht an/aus" )
	unbindKey ( source, "x", "down", toggleVehicleEngine, "Motor an/aus" )
	unbindKey ( source, "sub_mission", "down", toggleVehicleTrunkBind, "Kofferraum auf/zu" )
end
addEventHandler ("onPlayerVehicleExit", getRootElement(), vehexit )