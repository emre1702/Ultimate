--[[function setVehicleAsGangVehicle ( player, carSlot )

	local pname = getPlayerName ( player )
	local id = getPlayerGang ( pname )
	if id then
		local veh = _G["privVeh"..pname..carSlot]
		if isElement ( veh ) then
			if MySQLCarHousesCars[getElementModel(veh)] then
				local typ = getElementModel ( typ )
				local tuning = vioGetElementData ( veh, "" )
				local sx = vioGetElementData ( veh, "spawnpos_x" )
				local sy = vioGetElementData ( veh, "spawnpos_y" )
				local sz = vioGetElementData ( veh, "spawnpos_z" )
				local srx = vioGetElementData ( veh, "spawnrot_x" )
				local sry = vioGetElementData ( veh, "spawnrot_y" )
				local srz = vioGetElementData ( veh, "spawnrot_z" )
				local c1, c2, c3, c4 = getVehicleColor ( veh )
				local colors = "|"..c1.."|"..c2.."|"..c3.."|"..c4.."|"
				local paintjob = getVehiclePaintjob ( veh )
				local light = vioGetElementData ( veh, "lcolor" )
				
				dbExec ( handler, "DELETE * FROM gang_vehicles WHERE GangID = '"..id.."'" )
				
				local querya, queryb
				
				querya = "GangID"
				querya = querya.."Typ,"
				querya = querya.."Tuning,"
				querya = querya.."Spawnpos_X,"
				querya = querya.."Spawnpos_Y,"
				querya = querya.."Spawnpos_Z,"
				querya = querya.."Spawnrot_X,"
				querya = querya.."Spawnrot_Y,"
				querya = querya.."Spawnrot_Z,"
				querya = querya.."Farbe,"
				querya = querya.."Paintjob,"
				querya = querya.."Lights"
				
				queryb = "'"..id.."',"
				queryb = queryb.."'"..typ.."',"
				queryb = queryb.."'"..tuning.."',"
				queryb = queryb.."'"..sx.."',"
				queryb = queryb.."'"..sy.."',"
				queryb = queryb.."'"..sz.."',"
				queryb = queryb.."'"..srx.."',"
				queryb = queryb.."'"..sry.."',"
				queryb = queryb.."'"..srz.."',"
				queryb = queryb.."'"..color.."',"
				queryb = queryb.."'"..paintjob.."',"
				queryb = queryb.."'"..light.."'"
				
				local result = dbExec(handler, "INSERT INTO gang_vehicles ( "..querya.." ) VALUES (?)", queryb)
				if ( not result ) then
					outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
					destroyElement ( _G["privVeh"..xy] )
				end
			else
				outputChatBox ( "Du kannst nur Fahrzeuge von Autohaendlern benutzen!", palyer, 125, 0, 0 )
			end
		else
			outputChatBox ( "Ungueltiger Fahrzeugslot!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du bist in keiner Gang!", player, 125, 0, 0 )
	end
end]]