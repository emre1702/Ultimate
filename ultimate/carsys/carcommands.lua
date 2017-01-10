vehBlipColor = {}
	vehBlipColor["r"] = {}
	vehBlipColor["g"] = {}
	vehBlipColor["b"] = {}
		color = 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 0
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 0
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 0
		vehBlipColor["g"][color] = 255
		vehBlipColor["b"][color] = 255
		color = color + 1
		vehBlipColor["r"][color] = 125
		vehBlipColor["g"][color] = 125
		vehBlipColor["b"][color] = 125
		color = color + 1
		vehBlipColor["r"][color] = 255
		vehBlipColor["g"][color] = 150
		vehBlipColor["b"][color] = 0
		color = color + 1
		color = nil

		
function respawnPrivVeh ( carslot, pname )
	local carslot = tonumber ( carslot )
	local vehicle = allPrivateCars[pname][carslot] or false
	if isElement ( vehicle ) then
		if vioGetElementData ( vehicle, "special" ) == 2 then 
			detachElements ( objectYacht[pname][carslot], vehicle )
			destroyElement ( objectYacht[pname][carslot] )
			special = 2
		end
		destroyMagnet ( vehicle )
		dbExec ( handler, "UPDATE vehicles SET ??=? WHERE ??=? AND ??=?", "Benzin", vioGetElementData(vehicle,"fuelstate"), "UID", playerUID[pname], "Slot", carslot )
		destroyElement ( vehicle )
	end
	local dsatz = dbPoll ( dbQuery ( handler, "SELECT * from vehicles WHERE UID = ? AND Slot = ?", playerUID[pname], carslot ), -1 )
	if dsatz and dsatz[1] then	
		dsatz = dsatz[1]
		local Besitzer = playerUIDName[tonumber(dsatz["UID"])]
		local Typ = tonumber ( dsatz["Typ"] )
		local Tuning = dsatz["Tuning"]
		local Spawnpos_X = tonumber ( dsatz["Spawnpos_X"] )
		local Spawnpos_Y = tonumber ( dsatz["Spawnpos_Y"] )
		local Spawnpos_Z = tonumber ( dsatz["Spawnpos_Z"] )
		local Spawnrot_X = tonumber ( dsatz["Spawnrot_X"] )
		local Spawnrot_Y = tonumber ( dsatz["Spawnrot_Y"] )
		local Spawnrot_Z = tonumber ( dsatz["Spawnrot_Z"] )
		local Farbe = dsatz["Farbe"]
		local LFarbe = dsatz["Lights"]
		local Paintjob = tonumber ( dsatz["Paintjob"] )
		local Benzin = tonumber ( dsatz["Benzin"] )
		local Distanz = tonumber ( dsatz["Distance"] )
		local STuning = dsatz["STuning"]
		local Spezcolor = dsatz["spezcolor"]
		local Sportmotor = tonumber (dsatz["Sportmotor"])
		local Bremse = tonumber (dsatz["Bremse"] )
		local Antrieb = dsatz["Antrieb"]
		local PlateText = dsatz["plate"]
		vehicle = createVehicle ( Typ, Spawnpos_X, Spawnpos_Y, Spawnpos_Z, 0, 0, 0, Besitzer )
		allPrivateCars[pname][carslot] = vehicle
		vioSetElementData ( vehicle, "owner", Besitzer )
		vioSetElementData ( vehicle, "name", vehicle )
		vioSetElementData ( vehicle, "carslotnr_owner", carslot )
		vioSetElementData ( vehicle, "locked", true )
		vioSetElementData ( vehicle, "color", Farbe )
		vioSetElementData ( vehicle, "lcolor", LFarbe )
		vioSetElementData ( vehicle, "spawnpos_x", Spawnpos_X )
		vioSetElementData ( vehicle, "spawnpos_y", Spawnpos_Y )
		vioSetElementData ( vehicle, "spawnpos_z", Spawnpos_Z )
		vioSetElementData ( vehicle, "spawnrot_x", Spawnrot_X )
		vioSetElementData ( vehicle, "spawnrot_y", Spawnrot_Y )
		vioSetElementData ( vehicle, "spawnrot_z", Spawnrot_Z )
		vioSetElementData ( vehicle, "distance", Distanz )
		vioSetElementData ( vehicle, "stuning", STuning )
		vioSetElementData ( vehicle, "spezcolor", Spezcolor )
		setVehiclePlateText( vehicle, PlateText )
		vioSetElementData ( vehicle, "rcVehicle", tonumber ( dsatz["rc"] ) )
		vioSetElementData ( vehicle, "sportmotor", Sportmotor )
		vioSetElementData ( vehicle, "bremse", Bremse )
		vioSetElementData ( vehicle, "antrieb", Antrieb )
		setVehicleLocked ( vehicle, true )
		vioSetElementData ( vehicle, "fuelstate", Benzin )
		setPrivVehCorrectColor ( vehicle )
		setPrivVehCorrectLightColor ( vehicle )
		setVehiclePaintjob ( vehicle, Paintjob )
		if special == 2 then
			objectYacht[pname][carslot] = createObject ( 1337, 0, 0, 0 )
			attachElements ( objectYacht[pname][carslot], vehicle, 0, 2, 1.55 )
			setElementDimension (objectYacht[pname][carslot], 1 )
		end
		giveSportmotorUpgrade ( vehicle )
		setVehicleRotation ( vehicle, Spawnrot_X, Spawnrot_Y, Spawnrot_Z )
		pimpVeh ( vehicle, Tuning )
		setVehicleAsMagnetHelicopter ( vehicle )
		return true
	end
	return false
end


function towveh_func ( player, command, towcar )
	if towcar == nil then
		triggerClientEvent ( player, "infobox_start", player, "Gebrauch:\n/towveh\n[Fahrzeugnummer]", 5000, 125, 0, 0 )
	else
		if vioGetElementData ( player, "carslot"..towcar ) and tonumber(vioGetElementData ( player, "carslot"..towcar )) >= 1 then
			local pname = getPlayerName ( player )
			if vioGetElementData ( player, "money" ) >= 35 then
				if respawnPrivVeh ( towcar, pname ) then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 35 )
					triggerClientEvent ( player, "infobox_start", player, "\nDu hast dein\nFahrzeug respawnt!", 5000, 0, 255, 0 )
				else
					triggerClientEvent ( player, "infobox_start", player, "\nDas Fahrzeug ist\nnicht leer!", 5000, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", player, "\nDu hast nicht\ngenug Geld!", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", player, "\nDu hast kein\nFahrzeug mit\ndieser Nummer!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "respawnPrivVehClick", true )
addEventHandler ( "respawnPrivVehClick", getRootElement(), towveh_func )
addCommandHandler ( "towveh", towveh_func )


function towvehall_func ( player )
	local curcars = vioGetElementData ( player, "curcars" )
	local maxcars = vioGetElementData ( player, "maxcars" )
	local pname = getPlayerName ( player )
	if vioGetElementData ( player, "money" ) >= curcars*20 then
		for i = 1, maxcars do
			local carslotname = "carslot"..i
			if vioGetElementData ( player, carslotname ) ~= 0 then
				respawnPrivVeh ( i, pname )
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - curcars*20 )
				triggerClientEvent ( player, "infobox_start", player, "\n\nDu hast alle deine\nFahrzeug respawnt!", 5000, 0, 255, 0 )
			end
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 5000, 125, 0, 0 )
	end
end
addCommandHandler ( "towvehall", towvehall_func )


function sellcarto_func ( player, cmd, target, price, pSlot )
	local target = target and getPlayerFromName ( target ) or false
	if target and pSlot and tonumber ( pSlot ) then
		local pSlot = tonumber ( pSlot )
		local tSlot = getFreeCarSlot ( target )
		local pname = getPlayerName ( player )
		local result = dbPoll ( dbQuery ( handler, "SELECT AuktionsID FROM vehicles WHERE ??=? AND ??=?", "UID", playerUID[pname], "Slot", pslot ), -1 )
		if not result or not result[1] or tonumber ( result[1]["AuktionsID"] ) == 0 then
			if tSlot and vioGetElementData ( target, "carslot"..tSlot ) == 0 and vioGetElementData ( player, "carslot"..pSlot ) > 0 then
				local veh = allPrivateCars[pname][pSlot] or false
				if tonumber ( price ) then
					price = math.abs ( math.floor ( tonumber ( price ) ) )
					if isElement ( veh ) then
						if vioGetElementData ( target, "curcars" ) < vioGetElementData ( target, "maxcars" ) then
							local model = getElementModel ( veh )
							local stunings = sTuningsToString ( veh )
							outputChatBox ( getPlayerName ( player ).." bietet dir folgendes Fahrzeug für "..price.." $ an: "..getVehicleName ( veh ), target, 0, 125, 0 )
							outputChatBox ( "Tunings: "..stunings, target, 0, 125, 0 )
							outputChatBox ( "Tippe /buy car, um das Fahrzeug zu kaufen.", target, 0, 125, 0 )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." dein Fahrzeug aus Slot Nr. "..pSlot.." angeboten.", player, 200, 200, 0 )
							
							vioSetElementData ( target, "carToBuyFrom", player )
							vioSetElementData ( target, "carToBuySlot", tonumber ( pSlot ) )
							vioSetElementData ( target, "carToBuyPrice", price )
							vioSetElementData ( target, "carToBuyModel", getElementModel ( veh ) )
							outputLog ( getPlayerName ( player ).." hat ein Auto an Spieler angeboten ( "..getVehicleName ( veh ) .. " - " .. getPlayerName ( target ).." )", "vehicle" )
						else
							outputChatBox ( "Der Spieler hat keinen freien Fahrzeugslot mehr!", player, 125, 0, 0 )
						end
					else
						outputChatBox ( "Ungültiges Fahrzeug oder nicht respawnt! Gebrauch: /sellcarto [Name] [Preis] [Eigener Slot]", player, 125, 0, 0 )
					end
				else
					outputChatBox ( "Ungültiger Preis! Gebrauch: /sellcarto [Name] [Preis] [Eigener Slot]", player, 125, 0, 0 )
				end
			else
				outputChatBox ( "Ungültiger Fahrzeugslot! Gebrauch: /sellcarto [Name] [Preis] [Eigener Slot]", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Dieses Fahrzeuge wird momentan versteigert!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Gebrauch: /sellcarto [Name] [Preis] [Eigener Slot]", player, 125, 0, 0 )
	end
end
addCommandHandler ( "sellcarto", sellcarto_func )


function respawnVeh_func ( towcar, pname, veh )
	if towcar then
		respawnPrivVeh ( towcar, pname )
	else
		if not getVehicleOccupant ( veh ) then
			respawnVehicle ( veh )
			setElementDimension ( veh, 0 )
			setElementInterior ( veh, 0 )
		end
	end
end
addEvent ( "respawnVeh", true )
addEventHandler ( "respawnVeh", getRootElement(), respawnVeh_func )


function deleteVeh_func ( towcar, pname, veh, reason )
	local admin = getPlayerName ( source )
	if vioGetElementData ( source, "adminlvl" ) >= 3 then
		local towcar = tonumber ( towcar )
		local player = getPlayerFromName ( pname )
		if player then
			outputChatBox ( "Dein Fahrzeug in Slot Nr. "..towcar.." wurde von "..admin.." gelöscht ("..reason..")!", player, 125, 0, 0 )
			vioSetElementData ( player, "carslot"..towcar, 0 )
			allPrivateCars[pname][towcar] = nil
		else
			offlinemsg ( "Dein Fahrzeug in Slot Nr. "..towcar.." wurde von "..admin.." gelöscht("..reason..")!", "Server", pname )
		end
		outputLog ( "Fahrzeug von "..pname.." ( "..towcar.." ) wurde von "..admin.." gelöscht. | Modell: "..getElementModel(veh).." |", "autodelete" )
		destroyElement ( veh )
		dbExec ( handler, "DELETE FROM ?? WHERE ??=? AND ??=?", "vehicles", "UID", playerUID[pname], "Slot", towcar )
	end
end
addEvent ( "deleteVeh", true )
addEventHandler ( "deleteVeh", getRootElement(), deleteVeh_func )


function park_func ( player, command )
	if getPedOccupiedVehicleSeat ( player ) == 0 then
		local veh = getPedOccupiedVehicle ( player )
		if isElement ( veh ) and vioGetElementData ( veh, "owner" ) == getPlayerName ( player ) or vioGetElementData ( player, "adminlvl" ) >= 5 then
			if isTrailerInParkingZone ( veh ) then
				local x, y, z = getElementPosition ( veh )
				local rx, ry, rz = getVehicleRotation ( veh )
				local c1, c2, c3, c4 = getVehicleColor ( veh )
				vioSetElementData ( veh, "spawnposx", x )
				vioSetElementData ( veh, "spawnposy", y )
				vioSetElementData ( veh, "spawnposz", z )
				vioSetElementData ( veh, "spawnrotx", rx )
				vioSetElementData ( veh, "spawnroty", ry )
				vioSetElementData ( veh, "spawnrotz", rz )
				vioSetElementData ( veh, "color1", c1 )
				vioSetElementData ( veh, "color2", c2 )
				vioSetElementData ( veh, "color3", c3 )
				vioSetElementData ( veh, "color4", c4 )
				outputChatBox ( "Fahrzeug geparkt!", player, 0, 255, 0 )
			
				local Spawnpos_X, Spawnpos_Y, Spawnpos_Z = getElementPosition ( veh )
				local Spawnrot_X, Spawnrot_Y, Spawnrot_Z = getVehicleRotation ( veh )
				local Farbe1, Farbe2, Farbe3, Farbe4 =  getVehicleColor ( veh )
				local color = "|"..Farbe1.."|"..Farbe2.."|"..Farbe3.."|"..Farbe4.."|"
				local Paintjob = getVehiclePaintjob ( veh ) or 3
				local Benzin = vioGetElementData ( veh, "fuelstate" )
				local pname = vioGetElementData ( veh, "owner" )
				local Distance = vioGetElementData ( veh, "distance" )
				local slot = vioGetElementData ( veh, "carslotnr_owner" )
				
				dbExec ( handler, "UPDATE vehicles SET Spawnpos_X=?, Spawnpos_Y=?, Spawnpos_Z=?, Spawnrot_X=?, Spawnrot_Y=?, Spawnrot_Z=?, Farbe=?, Paintjob=?, Benzin=?, Distance=? WHERE UID=? AND Slot=?", Spawnpos_X, Spawnpos_Y, Spawnpos_Z, Spawnrot_X, Spawnrot_Y, Spawnrot_Z, color, Paintjob, Benzin, Distance, playerUID[pname], slot ) 
			else
				outputChatBox ( "Dieses Fahrzeug kannst du nicht in der Stadt parken!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Dieses Fahrzeug gehört dir nicht!", player, 255, 0, 0 )
		end
	else
		outputChatBox ( "Du musst in einem Fahrzeug sitzen!", player, 255, 0, 0 )
	end
end
addCommandHandler ( "park", park_func )


function lock_func ( player, command, locknr )
	if locknr == nil then
		outputChatBox ( "Gebrauch: /lock [Fahrzeugnummer]", player, 255, 0, 0 )
	else
		if vioGetElementData ( player, "carslot"..locknr ) and tonumber(vioGetElementData ( player, "carslot"..locknr )) >= 1 then
			local pname = getPlayerName ( player )
			local veh = allPrivateCars[pname][tonumber(locknr)] or false
			if isElement ( veh ) then
				if vioGetElementData ( veh, "locked" ) then
					vioSetElementData ( veh, "locked", false )
					setVehicleLocked ( veh, false )
					outputChatBox ( "Fahrzeug Aufgeschlossen!", player, 0, 0, 255 )
				elseif not vioGetElementData ( veh, "locked" ) then
					vioSetElementData ( veh, "locked", true )
					setVehicleLocked ( veh, true )
					outputChatBox ( "Fahrzeug Abgeschlossen!", player, 0, 0, 255 )
				end
			else
				outputChatBox ( "Bitte respawne dein Fahrzeug zuerst!", player, 255, 0, 0 )
			end
		else
			outputChatBox ( "Du hast kein Fahrzeug mit diesem Namen!", player, 255, 0, 0 )
		end
	end
end
addEvent ( "lockPrivVehClick", true )
addEventHandler ( "lockPrivVehClick", getRootElement(), lock_func )
addCommandHandler ( "lock", lock_func )


function vehinfos_func ( player )
	local curcars = vioGetElementData ( player, "curcars" )
	local maxcars = vioGetElementData ( player, "maxcars" )
	if curcars and maxcars then
		outputChatBox ( "Momentan im Besitz: "..curcars.." Fahrzeuge von maximal "..maxcars, player, 0, 0, 255  )
		local pname = getPlayerName ( player )
		color = 0
		for i = 1, maxcars do
			carslotname = "carslot"..i
			if vioGetElementData ( player, carslotname ) ~= 0 then
				local veh = allPrivateCars[pname][i] or false
				if isElement ( veh ) then
					local x, y, z = getElementPosition( veh )
					if vioGetElementData ( veh, "gps" ) then
						color = color + 1
						local blip = createBlip ( x, y, z, 0, 2, vehBlipColor["r"][color], vehBlipColor["g"][color], vehBlipColor["b"][color], 255, 0, 99999.0, player )
						setTimer ( destroyElement, 10000, 1, blip )
						outputChatBox ( "Slot NR "..i..": "..getVehicleName ( veh )..", steht momentan in "..getZoneName( x,y,z )..", "..getZoneName( x,y,z, true ), player, vehBlipColor["r"][color], vehBlipColor["g"][color], vehBlipColor["b"][color] )
					else
						outputChatBox ( "Slot NR "..i..": "..getVehicleName ( veh )..", steht momentan in "..getZoneName( x,y,z )..", "..getZoneName( x,y,z, true ), player, 0, 0, 200 )
					end
				else
					local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=? AND ??=?", "AuktionsID", "vehicles", "UID", playerUID[pname], "Slot", i ), -1 )
					if result and result[1] and result[1]["AuktionsID"] == "1" then
						outputChatBox ( "Dein Fahrzeug in Slot NR "..i.." muss zuerst mit /towveh "..i.." respawned werden!", player, 125, 0, 0 )
					elseif result and result[1] then
						outputChatBox ( "Dein Fahrzeug in Slot NR "..i.." steht momentan zum Verkauf!", player, 125, 0, 0 )
					end
				end
			end
		end
	end
end
addCommandHandler ( "vehinfos", vehinfos_func )


function vehhelp_func ( player )
	outputChatBox ( "--- Fahrzeughilfe ---", player, 0, 0, 255 )
	outputChatBox ( "/towveh [Nummer] zum Respawnen am Parkort", player, 255, 0, 255 )
	outputChatBox ( "/towvehall zum Respawnen aller Fahrzeuge", player, 255, 0, 255 )
	outputChatBox ( "/lock [Nummer] zum Oeffnen/Schliessen", player, 255, 0, 255 )
	outputChatBox ( "/park zum Parken", player, 255, 0, 255 )
	outputChatBox ( "/vehinfos zum Anzeigen aller Aktueller Fahrzeuge", player, 255, 0, 255 )
	outputChatBox ( "/sellcar [Nummer] zum verkaufen des Autos ( 75% der Kosten werden erstattet )", player, 255, 0, 255 )
	outputChatBox ( "/sellcarto [Name] [Preis] [Slot zum verkaufen des Autos an einen Spieler", player, 255, 0, 255 )
	outputChatBox ( "/buy car zum Annehmen eines Angebotes", player, 255, 0, 255 )
	outputChatBox ( "/givecar [Spieler] [Eigener Slot] [Neuer Slot], um das Auto weiterzugeben", player, 255, 0, 255 )
	outputChatBox ( "/break um die Handbremse zu betätigen", player, 255, 0, 255 )
end
addCommandHandler ( "vehhelp", vehhelp_func )


function sellcar_func ( player, cmd, slot )
	if slot then
		local slot = tonumber(slot)
		if vioGetElementData ( player, "carslot"..slot ) > 0 then
			local pname = getPlayerName(player)
			local veh = allPrivateCars[pname][slot] or false
			if isElement ( veh ) then
				local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=? AND ??=?", "AuktionsID", "vehicles", "UID", playerUID[pname], "Slot", slot ), -1 )
				if result and result[1] and tonumber ( result[1]["AuktionsID"] ) == 0 then
					destroyMagnet ( veh )
					local model = getElementModel ( veh )
					local price = carprices[model]
					if not price then
						price = 0
					end
					vioSetElementData ( player, "carslot"..slot, 0 )
					allPrivateCars[pname][slot] = nil
					local spawnx = vioGetElementData ( player, "spawnpos_x" )
					if spawnx == "marquis" or spawnx == "tropic" then
						vioSetElementData ( player, "spawnpos_x", -2458.288085 )
						vioSetElementData ( player, "spawnpos_y", 774.354492 )
						vioSetElementData ( player, "spawnpos_z", 35.171875 )
						vioSetElementData ( player, "spawnrot_x", 52 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
					end
					dbExec ( handler, "DELETE FROM ?? WHERE ??=? AND ??=?", "vehicles", "UID", playerUID[pname], "Slot", slot )
					vioSetElementData(player,"curcars",tonumber(vioGetElementData ( player, "curcars" ))-1)
					vioSetElementData ( player, "FahrzeugeVerkauft", vioGetElementData ( player, "FahrzeugeVerkauft" ) + 1 )
					SaveCarData ( player )
					infobox ( player, "Fahrzeug verkauft\nfür "..price/100*75 .."$", 4000, 0, 200, 0 )
					outputLog ( getPlayerName ( player ).." hat ein Auto an Server verkauft ( "..getVehicleName ( veh ).." )", "vehicle" )
					destroyElement ( veh )
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" )+price/100*75 )
				else
					outputChatBox ( "Dieses Fahrzeug kannst du nicht verkaufen, da es zum Verkauf steht.", player, 125, 0, 0 )
				end
			else
				outputChatBox ( "Bitte respawne dein Fahrzeug vorher!", player, 125, 0, 0 )
			end
		else
			infobox ( player, "\nUngültiger Slot!", 4000, 125, 0, 0 )
		end
	else
		infobox ( player, "Gebrauch:\n/sellcar [Slot]!", 4000, 200, 0, 0 )
	end
end
addCommandHandler ( "sellcar", sellcar_func )


function accept_sellcarto ( accepter, _, cmd )
	if cmd == "car" then
		local target = accepter
		local pSlot = vioGetElementData ( accepter, "carToBuySlot" )
		player = vioGetElementData ( accepter, "carToBuyFrom" )
		price = vioGetElementData ( accepter, "carToBuyPrice" )
		model = vioGetElementData ( accepter, "carToBuyModel" )
		if isElement ( player ) then
			local money = vioGetElementData ( target, "bankmoney" )
			local tSlot = tonumber ( getFreeCarSlot ( target ) )
			if price <= money then
				if tonumber ( pSlot ) and tSlot then
					pSlot = tonumber ( pSlot )
					local pname = getPlayerName ( player )
					local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=? AND ??=?", "AuktionsID", "ID", "vehicles", "UID", playerUID[pname], "Slot", pSlot ), -1 )
					if result and result[1] and tonumber ( result[1]["AuktionsID"] ) == 0 then
						if vioGetElementData ( player, "carslot"..pSlot ) > 0 then
							local veh = allPrivateCars[pname][pSlot] or false
							if isElement ( veh ) then
								if model == getElementModel ( veh ) then
									if vioGetElementData ( target, "curcars" ) < vioGetElementData ( target, "maxcars" ) then
										
										local id = result[1]["ID"]
										
										outputChatBox ( "Du hast dein Fahrzeug in Slot Nr. "..pSlot.." an "..getPlayerName ( target ).." gegeben!", player, 0, 125, 0 )
										outputChatBox ( "Du hast ein Fahrzeug in Slot Nr. "..tSlot.." von "..getPlayerName ( player ).." erhalten!", target, 0, 125, 0 )
										
										dbExec ( handler, "UPDATE ?? SET ??=?, ??=?, ??=? WHERE ??=?", "vehicles", "UID", playerUID[getPlayerName(target)], "Slot", tSlot, "Lights", "|255|255|255|", "ID", id )

										vioSetElementData ( target, "carslot"..tSlot, vioGetElementData ( player, "carslot"..pSlot ) )
										vioSetElementData ( player, "carslot"..pSlot, 0 )
										vioSetElementData ( target, "curcars", vioGetElementData ( target, "curcars" ) + 1 )
										vioSetElementData ( player, "curcars", vioGetElementData ( player, "curcars" ) - 1 )
										vioSetElementData ( veh, "lcolor", "|255|255|255|" )
										
										setPrivVehCorrectLightColor ( veh )
										
										vioSetElementData ( veh, "owner", getPlayerName ( target ) )
										vioSetElementData ( veh, "name", "privVeh"..getPlayerName(target)..tSlot )
										vioSetElementData ( veh, "carslotnr_owner", tSlot )
										
										allPrivateCars[getPlayerName(target)][tSlot] = veh
										allPrivateCars[pname][pSlot] = nil
										
										SaveCarData ( player )
										SaveCarData ( target )
										vioSetElementData ( player, "FahrzeugeVerkauft", vioGetElementData ( player, "FahrzeugeVerkauft" ) + 1 )
										vioSetElementData ( target, "FahrzeugeGekauft", vioGetElementData ( target, "FahrzeugeGekauft" ) + 1 )
											
										vioSetElementData ( target, "bankmoney", money - price )
										vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) + price )
											
										casinoMoneySave ( target )
										casinoMoneySave ( player )
										outputLog ( getPlayerName ( accepter ).." hat ein Auto von "..getPlayerName ( player ) .. " gekauft ( "..price.." - "..getVehicleName ( veh ).." )", "vehicle" )
									else
										infobox ( accepter, "Du hast keinen\nfreien Fahrzeugslot mehr!", 5000, 125, 0, 0 )
									end
								else
									infobox ( accepter, "Ein Fehler\nist aufgetreten.\nBitte lass dir\ndas Angebot erneut\nschicken!", 5000, 125, 0, 0 )
								end
							else
								infobox ( accepter, "Ein Fehler\nist aufgetreten.\nBitte lass dir\ndas Angebot erneut\nschicken!", 5000, 125, 0, 0 )
							end
						else
							infobox ( accepter, "Der Verkaufer hat\ndas Fahrzeug nicht\nmehr!", 5000, 125, 0, 0 )
						end
					end
				else
					infobox ( accepter, "Ein Fehler\nist aufgetreten.\nBitte lass dir\ndas Angebot erneut\nschicken!", 5000, 125, 0, 0 )
				end
			else
				infobox ( accepter, "Du hast nicht\ngenug Geld auf\nder Bank!", 5000, 125, 0, 0 )
			end
		else
			infobox ( accepter, "Der Anbieter des\nFahrzeugs ist offline!", 5000, 125, 0, 0 )
		end
	end
end
addCommandHandler ( "buy", accept_sellcarto )


function handbremsen ( player )

	local vehicle = getPedOccupiedVehicle ( player )
	
	if vehicle then
	
		local sitz = getPedOccupiedVehicleSeat ( player )
		
		if sitz == 0 then
		
			local vx, vy, vz = getElementVelocity ( getPedOccupiedVehicle ( player ) )
			local speed = math.sqrt ( vx ^ 2 + vy ^ 2 + vz ^ 2 )
			
			if speed < 5 * 0.00464 then
			else
				return
			end
		
			if vioGetElementData ( vehicle, "owner" ) == getPlayerName ( player )  then
			
				if isElementFrozen ( vehicle ) then
			
					setElementFrozen ( vehicle, false )
					outputChatBox ( "Handbremse gelöst!", player, 0, 125, 0 )
				
				else
				
					setElementFrozen ( vehicle, true )
					outputChatBox ( "Handbremse angezogen!", player, 0, 125, 0 )
				
				end
			
			end
		
		end
	
	end
	
end

addCommandHandler ( "break", handbremsen )



addCommandHandler ( "setcarmodel", function ( player, _, target, slot, newmodel ) 
	if vioGetElementData ( player, "adminlvl" ) >= 6 then
		if target then
			if allPrivateCars[target] then
				if slot and tonumber ( slot ) then
					local slot = tonumber ( slot )
					if allPrivateCars[target][slot] then
						if newmodel and tonumber ( newmodel ) then
							local newmodel = tonumber ( newmodel )
							local veh = allPrivateCars[target][slot]
							local r, g, b = nil, nil, nil
							local paintjob = nil
							if isElement ( veh ) then
								r, g, b = getVehicleColor ( veh )
								paintjob = getVehiclePaintjob ( veh )
								if not setElementModel ( veh, newmodel ) then
									outputChatBox ( "Die neue ID ist ungültig", player, 200, 0, 0 )	
									return 
								end
							else
								local testveh = createVehicle ( 602, 0, 0, 0 )
								if not setElementModel ( testveh, newmodel ) then
									outputChatBox ( "Die neue ID ist ungültig", player, 200, 0, 0 )	
									destroyElement ( testveh )
									return 
								end
								destroyElement ( testveh )
							end
							dbExec ( handler, "UPDATE vehicles SET Typ = ? WHERE UID = ? AND SLOT = ?", newmodel, playerUID[target], slot )
							if isElement ( veh ) then
								setVehicleColor ( veh, r, g, b )
								setVehiclePaintjob ( veh, paintjob )
							end
							outputChatBox ( "Fahrzeug-Model verändert", player, 0, 200, 0 )
						else
							outputChatBox ( "Gebrauch: /setcar [Name] [Slot] [NeueID]", player, 200, 0, 0 )	
						end
					else
						outputChatBox ( "Der Spieler hat keine Fahrzeuge in diesem Slot", player, 200, 0, 0 )
					end
				else
					outputChatBox ( "Gebrauch: /setcar [Name] [Slot] [NeueID]", player, 200, 0, 0 )	
				end
			else
				outputChatBox ( "Der Spieler existiert nicht oder hat keine Fahrzeuge", player, 200, 0, 0 )
			end
		else
			outputChatBox ( "Gebrauch: /setcar [Name] [Slot] [NeueID]", player, 200, 0, 0 )	
		end
	else
		outputChatBox ( "Du bist nicht befugt", player, 200, 0, 0 )
	end
end )