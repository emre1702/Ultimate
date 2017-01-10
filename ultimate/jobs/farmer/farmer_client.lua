local farmingJobTargetMarker, farmingAreaMarker
local playerToGroundLevel = 1.3085

function showNextFarmerJobMarker ( x, y, z, typ )

	local size = 1
	if typ == 2 then
		size = 10
	elseif typ == 3 then
		size = 10
	end
	local marker = createMarker ( x, y, z, "checkpoint", size, 200, 0, 0, 125, nil )
	farmingJobTargetMarker = marker
	local blip = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999 )
	setElementParent ( blip, marker )
	if typ == 1 then
		addEventHandler ( "onClientMarkerHit", marker, farmerJobMarker1Hit )
	elseif typ == 2 then
		addEventHandler ( "onClientMarkerHit", marker, farmerJobMarker2Hit )
	elseif typ == 3 then
		addEventHandler ( "onClientMarkerHit", marker, farmerJobMarker3Hit )
	end
end
addEvent ( "showNextFarmerJobMarker", true )
addEventHandler ( "showNextFarmerJobMarker", getRootElement(), showNextFarmerJobMarker )

function farmerJobMarker1Hit ( player )

	if player == lp and not getPedOccupiedVehicle ( player ) then
		setElementFrozen ( lp, true )
		local x, y, z = getElementPosition ( lp )
		local z = z - playerToGroundLevel * 2
		setTimer (
			function ( x, y, z )
				local crop = createObject ( 3409, x, y, z )
				moveObject ( crop, 5000, x, y, z + playerToGroundLevel )
				setTimer ( destroyElement, 60000, 1, crop )
			end,
		1500, 1, x, y, z )
		
		triggerServerEvent ( "farmerJobMarkerHit", lp, 1 )
		destroyElement ( source )
	end
end

function farmerJobMarker2Hit ( player )

	if getPedOccupiedVehicle ( lp ) and player == lp then
		triggerServerEvent ( "farmerJobMarkerHit", lp, 2 )
		destroyElement ( source )
	end
end
function farmerJobMarker3Hit ( player )

	if getPedOccupiedVehicle ( lp ) and player == lp then
		triggerServerEvent ( "farmerJobMarkerHit", lp, 3 )
		destroyElement ( source )
	end
end

function startFarmingJob ()

	farmingAreaMarker = createMarker ( -1186.4422607422, -1048.7531738281, 129.21875, "checkpoint", 450, 200, 0, 0, 125, nil )
	addEventHandler ( "onClientPlayerWasted", lp, clientFarmerWasted )
	addEventHandler ( "onClientMarkerLeave", farmingAreaMarker,
		function ( player )
			if player == lp then
				cancel_farming ( "", "farming" )
			end
		end
	)
end
addEvent ( "startFarmingJob", true )
addEventHandler ( "startFarmingJob", getRootElement(), startFarmingJob )

function cancel_farming ( cmd, arg )

	if arg == "farming" or arg == "job" then
		if isElement ( farmingAreaMarker ) then
			destroyElement ( farmingAreaMarker )
		end
		if isElement ( farmingJobTargetMarker ) then
			destroyElement ( farmingJobTargetMarker )
		end
		triggerServerEvent ( "cancelFarmingJob", lp )
		
		infobox ( "Du hast die Arbeit\nabgebrochen.", 5000, 125, 0, 0 )
		removeEventHandler ( "onClientPlayerWasted", lp, clientFarmerWasted )
	end
end
addEvent ( "cancelFarming", true )
addEventHandler ( "cancelFarming", getRootElement(), cancel_farming )
addCommandHandler ( "cancel", cancel_farming )

function clientFarmerWasted ()
	cancel_farming ( "", "farming" )
	removeEventHandler ( "onClientPlayerWasted", lp, clientFarmerWasted )
end
