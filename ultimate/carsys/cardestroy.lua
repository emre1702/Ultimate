function privVehExplode ()

	destroyMagnet ( source )
	if vioGetElementData ( source, "ownerfraktion" ) then
		
	else
		local oname = vioGetElementData ( source, "owner" )
		if oname == nil or not oname then
		else
			local owner = getPlayerFromName ( oname )
			local x1, y1, z1 = getElementPosition ( owner )
			local x2, y2, z2 = getElementPosition ( source )
			if vioGetElementData ( owner, "loggedin" ) == 1 and getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) < 7.5 then
				vioSetElementData ( owner, "carslot"..vioGetElementData(source, "carslotnr_owner" ), 0 )
				vioSetElementData ( owner, "curcars", vioGetElementData ( owner, "curcars" )-1 )
				if tonumber(vioGetElementData ( source, "special" )) ~= 2 then outputChatBox ( "Dein Fahrzeug in Slot NR "..vioGetElementData(source, "carslotnr_owner" ).." wurde zerstort!", owner, 125, 0, 0 ) end
				dbExec ( handler, "DELETE FROM ?? WHERE ??=? AND ??=?", "vehicles", "UID", playerUID[oname], "Slot", vioGetElementData(source, "carslotnr_owner" ) )
				outputLog ( "Fahrzeug von "..oname.." ( "..vioGetElementData(source, "carslotnr_owner" ).." ) wurde zerstoert. | Modell: "..getElementModel(source).." |", "explodecar" )
				SaveCarData ( owner )
			end
			if tonumber(vioGetElementData ( source, "special" )) == 2 then
				vioSetElementData ( owner, "yachtImBesitz", false )
				vioSetElementData ( owner, "spawnpos_x", -2458.288085 )
				vioSetElementData ( owner, "spawnpos_y", 774.354492 )
				vioSetElementData ( owner, "spawnpos_z", 35.171875 )
				vioSetElementData ( owner, "spawnrot_x", 52 )
				vioSetElementData ( owner, "spawnint", 0 )
				vioSetElementData ( owner, "spawndim", 0 )
				outputChatBox ( "Deine Yacht in Slot NR "..vioGetElementData ( source, "carslotnr_owner" ).." wurde zerstoert - du spawnst wieder auf der Strasse!", owner, 125, 0, 0 )
				SaveCarData ( owner )
			end
		end
		destroyElement ( source )
	end
	setTimer ( killRests, 3000, 1, source )
end
addEventHandler ( "onVehicleExplode", getRootElement(), privVehExplode )

function killRests ( veh )

	if not isElement ( veh ) then
		return
	end

	setElementPosition ( veh, 999999, 999999, -50 )
end

function armoredRespawn ()

	if isEvilCar ( source ) then
	
		setElementHealth ( source, 2000 )
		
	elseif isFederalCar ( source ) then
		
		if getElementModel ( source ) == 601 then
			setElementHealth ( source, 5000 )
		elseif getElementModel ( source ) == 523 then
			setElementHealth ( source, 1000 )
		elseif getElementModel ( source ) == 599 then
			setElementHealth ( source, 2500 )
		elseif getElementModel ( source ) == 525 then
			setElementHealth ( source, 1000 )
		elseif getElementModel ( source ) == 427 then
			setElementHealth ( source, 5000 )
		elseif getElementModel ( source ) == 609 then
			setElementHealth ( source, 5000 )
		elseif getElementModel ( source ) == 490 then
			setElementHealth ( source, 2500 )
		elseif getElementModel ( source ) == 470 or getElementModel ( source ) == 548 or getElementModel ( source ) == 425 or getElementModel ( source ) == 520 or getElementModel ( source ) == 563 then
			setElementHealth ( source, 3000 )
		elseif getElementModel ( source ) == 433 then
			setElementHealth ( source, 5000 )
		else
			setElementHealth ( source, 2000 )
		end
		
	elseif getElementModel ( source ) == 432 then
	
		setElementHealth ( source, 8000 )
		
	end
	
end
addEventHandler ( "onVehicleRespawn", getRootElement(), armoredRespawn )