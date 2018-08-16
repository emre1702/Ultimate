----------------------------------------------------
----------------------------------------------------
------ Copyright (c) 2013 by [vio]Lars-Marcel ------
----------------------------------------------------
----------------------------------------------------

createBlip ( -1786.779, 1215.474, 24.5, 27, 2, 255, 0, 0, 255, 0, 300, getRootElement() )
setGarageOpen(24, true)
local marker = createMarker( -1786.779, 1215.474, 24.5, "cylinder", 2, 255, 0, 0, 255 )
local pickup = createPickup( -1782.215, 1205.233, 25, 3, 1239, 1, 99 )

function showSpezialLack_func(player)
	if getElementType (player) == "player" then
		if isPedInVehicle (player) then
			local veh = getPedOccupiedVehicle(player)
			if veh then
				if vioGetElementData ( veh, "owner" ) == getPlayerName ( player ) then
					setElementClicked ( player, true )
					setElementFrozen(veh, true)
					toggleControl ( player, "enter_exit", false )
					triggerClientEvent (player, "showMichelles", player)
					
					local dim = math.random(5000,9000)
						
					setElementDimension(veh, dim)
					setElementDimension(player, dim)
				else
					outputChatBox ( "Du kannst nur deine Privatfahrzeuge tunen!", player, 125, 0, 0 )
				end
			end
		end
	end
end
addEventHandler("onMarkerHit", marker, showSpezialLack_func)


function seeSpezialLack_func(red1, green1, blue1, red2, green2, blue2)
	local player = source
	
	local red1 = red1 * 2.55
	local green1 = green1 * 2.55
	local blue1 = blue1 * 2.55
	local red2 = red2 * 2.55
	local green2 = green2 * 2.55
	local blue2 = blue2 * 2.55
	
	local veh = getPedOccupiedVehicle(player)
	
	if veh then
		setVehicleColor(veh, red1, green1, blue1, red2, green2, blue2)
	else
		return false
	end
end
addEvent( "seeSpezialLack", true )
addEventHandler( "seeSpezialLack", getRootElement(), seeSpezialLack_func )

function buySpezialLack_func(red1, green1, blue1, red2, green2, blue2)
	local player = source
	
	local red1 = red1 * 2.55
	local green1 = green1 * 2.55
	local blue1 = blue1 * 2.55
	local red2 = red2 * 2.55
	local green2 = green2 * 2.55
	local blue2 = blue2 * 2.55
	
	local veh = getPedOccupiedVehicle(player)
	
	toggleControl ( player, "enter_exit", true )
	setElementClicked ( player, true )
	setElementDimension(veh, 0)
	setElementDimension(player, 0)
	activeCarGhostMode ( player, 10000 )
	
	if veh then
		setElementFrozen(veh, false)
		
		if vioGetElementData(veh, "spezcolor") == "" then
			if vioGetElementData(player, "money") >= 2500 then
				vioSetElementData(player, "money", vioGetElementData(player, "money") - 2500)
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				return false
			end
			--MichellesKasse = MichellesKasse + 2500
		else
			if vioGetElementData(player, "money") >= 1250 then
				vioSetElementData(player, "money", vioGetElementData(player, "money") - 1250)
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				return false
			end
			--MichellesKasse = MichellesKasse + 1250
		end
		
		setVehicleColor(veh, red1, green1, blue1, red2, green2, blue2)
		local spezcolor = "|"..red1.."|"..green1.."|"..blue1.."|"..red2.."|"..green2.."|"..blue2.."|"
		vioSetElementData(veh, "spezcolor", spezcolor)
		dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=? AND ??=?", "vehicles", "spezcolor", spezcolor, "UID", playerUID[getPlayerName(player)], "Slot", vioGetElementData(veh, "carslotnr_owner") )
	else
		return false
	end
end
addEvent( "buySpezialLack", true )
addEventHandler( "buySpezialLack", getRootElement(), buySpezialLack_func )

function closeSpezialLack_func(red1, green1, blue1, red2, green2, blue2)
	local player = source
	
	local veh = getPedOccupiedVehicle(player)
	
	toggleControl ( player, "enter_exit", true )
	setElementClicked ( player, false )
	setElementDimension(veh, 0)
	setElementDimension(player, 0)
	activeCarGhostMode ( player, 10000 )
	
	if veh then
		setElementFrozen(veh, false)
		
		setPrivVehCorrectColor(veh)
		
	else
		return false
	end
end
addEvent( "closeSpezialLack", true )
addEventHandler( "closeSpezialLack", getRootElement(), closeSpezialLack_func )

function deleteSpezialLack_func(player)
	local veh = getPedOccupiedVehicle(player)
	
	if veh then
		local x, y, z = getElementPosition ( player )
		if getDistanceBetweenPoints3D ( -1782.215, 1205.233, 25, x, y, z ) <= 5 then
			if vioGetElementData ( veh, "owner" ) == getPlayerName ( player ) then
				local colors = vioGetElementData ( veh, "color" )
				local c1 = tonumber ( gettok ( colors, 1, string.byte( '|' ) ))
				local c2 = tonumber ( gettok ( colors, 2, string.byte( '|' ) ))
				local c3 = tonumber ( gettok ( colors, 3, string.byte( '|' ) ))
				local c4 = tonumber ( gettok ( colors, 4, string.byte( '|' ) ))
				setVehicleColor ( veh, c1, c2, c3, c4 )
				setTimer ( setVehicleColor, 100, 1, veh, c1, c2, c3, c4 )
				
				removeElementData(veh, "spezcolor")
				
				dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=? AND ??=?", "vehicles", "spezcolor", "", "UID", playerUID[getPlayerName(player)], "Slot", vioGetElementData(veh, "carslotnr_owner") )
				
				outputChatBox("Speziallack erfolgreich entfernt!", player, 0, 255, 0)
			else
				outputChatBox ( "Du kannst nur deine Privatfahrzeuge tunen!", player, 125, 0, 0 )
			end
		else
			outputChatBox("Du bist nicht im Icon.", player, 255, 0, 0)
		end
	end
end
addCommandHandler("dellack", deleteSpezialLack_func)

function deleteSpezialLack_info(player)
	outputChatBox("Um den Speziallack zu entfernen Tippe /dellack", player, 255, 155, 0)
end
addEventHandler("onPickupHit", pickup, deleteSpezialLack_info)



function closeMichelles_func()
	local player = source
	
	setElementClicked ( player, false )
	toggleControl ( player, "enter_exit", true )
	local veh = getPedOccupiedVehicle(player)
	setElementFrozen(veh, false)
	setElementDimension(veh, 0)
	setElementDimension(player, 0)
	activeCarGhostMode ( player, 10000 )
end
addEvent( "closeMichelles", true )
addEventHandler( "closeMichelles", getRootElement(), closeMichelles_func )