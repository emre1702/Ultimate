function spawnchange_func ( player, cmd, place, sType )
	
	local pname = getPlayerName ( player )
	if place == "house" then
		if vioGetElementData ( player, "housekey" ) ~= 0 then
			local dim = math.abs ( tonumber ( vioGetElementData ( player, "housekey" ) ) )
			local hint = vioGetElementData ( houses["pickup"][dim], "curint" )
			local int, intx, inty, intz = getInteriorData ( hint )
			
			if hint == 0 then
				int = 0
				dim = 0
				intx, inty, intz = getElementPosition ( houses["pickup"][dim] )
			end
			
			vioSetElementData ( player, "spawndim", dim )
			vioSetElementData ( player, "spawnint", int )
			vioSetElementData ( player, "spawnpos_x", intx )
			vioSetElementData ( player, "spawnpos_y", inty )
			vioSetElementData ( player, "spawnpos_z", intz )
			
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
			OwnFootCheck ( player )
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist Obdachlos!", 5000, 0, 125, 0 )
		end
	elseif place == "faction" then
		local faction = vioGetElementData ( player, "fraktion" )
		if faction > 0 then
			if vioGetElementData ( player, "rang" ) >= 5 or faction == 9 then
				OwnFootCheck ( player )
				if faction == 1 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", 228.71 )
						vioSetElementData ( player, "spawnpos_y", 126.83 )
						vioSetElementData ( player, "spawnpos_z", 1009.85 )
						vioSetElementData ( player, "spawnrot_x", 180 )
						vioSetElementData ( player, "spawnint", 10 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 210.94281005859, 150.44526672363, 1002.672668457, -90, 3, 0 )
					end
				elseif faction == 2 then
					if sType == "sf" then
						setPlayerNewSpawnpoint ( player, -691.36187, 939.672,13.6328, 270, 0, 0 )
					else
						setPlayerNewSpawnpoint ( player, 2170.59, 1601.95, 999.61895751953, 0, 1, 0 )
					end
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 3 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -2160.2456054688 )
						vioSetElementData ( player, "spawnpos_y", 642.27325439453 )
						vioSetElementData ( player, "spawnpos_z", 1057.2429199219 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 1 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 1927.07, 1017.93, 994.11, 90, 10, 0 )
					end
				elseif faction == 4 then
					vioSetElementData ( player, "spawnpos_x", -1998.9085693359 )
					vioSetElementData ( player, "spawnpos_y", -1563.2896728516 )
					vioSetElementData ( player, "spawnpos_z", 85.435836791992 )
					vioSetElementData ( player, "spawnrot_x", 0 )
					vioSetElementData ( player, "spawnint", 0 )
					vioSetElementData ( player, "spawndim", 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 5 then
					setPlayerNewSpawnpoint ( player, -2520.77, -623.44, 132.77, 0, 0, 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 6 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -2453.8784179688 )
						vioSetElementData ( player, "spawnpos_y", 503.82363891602 )
						vioSetElementData ( player, "spawnpos_z", 29.728803634644 )
						vioSetElementData ( player, "spawnrot_x", 0 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 221.1217956543, 150.03002929688, 1002.672668457, -90, 3, 0 )
					end
				elseif faction == 7 then
					if sType == "strip" then
						setPlayerNewSpawnpoint ( player, 1200.94, 11.89, 1000.57, 0, 2, 0 )
					else
						setPlayerNewSpawnpoint ( player, -1321.766, 2475.6, 87.96, 2, 0, 0 )
					end
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 8 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -1346.1706542969 )
						vioSetElementData ( player, "spawnpos_y", 492.36785888672 )
						vioSetElementData ( player, "spawnpos_z", 10.851915359497 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					elseif sType == "lv" then
						vioSetElementData ( player, "spawnpos_x", 247.46310424805 )
						vioSetElementData ( player, "spawnpos_y", 1859.85546875 )
						vioSetElementData ( player, "spawnpos_z", 13.733238220215 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					end
				elseif faction == 9 then
					if sType == "sf" then
						setPlayerNewSpawnpoint ( player, -2186.9316, -2322.244, 30.625, 0, 0, 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					elseif sType == "lv" then
						setPlayerNewSpawnpoint ( player, 1126.712890625, -12.259765625, 1002.0859375, 0, 12, 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					end
				elseif faction == 10 then
					setPlayerNewSpawnpoint ( player, 441.684, 263.2427, 996.81188, 180, 3, 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 11 then
					setPlayerNewSpawnpoint ( player, -2383.105, -184.557, 35.2888, 0, 0, 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 12 then
					vioSetElementData ( player, "spawnpos_x", -2200.4140625 )
					vioSetElementData ( player, "spawnpos_y", 76.34375 )
					vioSetElementData ( player, "spawnpos_z", 35.3203125 )
					vioSetElementData ( player, "spawnrot_x", 0 )
					vioSetElementData ( player, "spawnint", 0 )
					vioSetElementData ( player, "spawndim", 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				elseif faction == 13 then
					vioSetElementData ( player, "spawnpos_x", -2446.2680664063 )
					vioSetElementData ( player, "spawnpos_y", -86.6 )
					vioSetElementData ( player, "spawnpos_z", 34.215 )
					vioSetElementData ( player, "spawnrot_x", 180 )
					vioSetElementData ( player, "spawnint", 0 )
					vioSetElementData ( player, "spawndim", 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				end
			else
				if faction == 1 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", 246.3 )
						vioSetElementData ( player, "spawnpos_y", 125.05 )
						vioSetElementData ( player, "spawnpos_z", 1003 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 10 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 216.72428894043, 168.78742980957, 1002.672668457, 90, 3, 0 )
					end
				elseif faction == 2 then
					if sType == "sf" then
						setPlayerNewSpawnpoint ( player, -660.3037, 1025.721, 12.8076, 160, 0, 0 )
					else
						setPlayerNewSpawnpoint ( player, 2170.59, 1601.95, 999.61895751953, 0, 1, 0 )
					end
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 3 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -2160.2456054688 )
						vioSetElementData ( player, "spawnpos_y", 642.27325439453 )
						vioSetElementData ( player, "spawnpos_z", 1057.2429199219 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 1 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 1927.07, 1017.93, 994.11, 90, 10, 0 )
					end
				elseif faction == 4 then
					vioSetElementData ( player, "spawnpos_x", -1998.9085693359 )
					vioSetElementData ( player, "spawnpos_y", -1563.2896728516 )
					vioSetElementData ( player, "spawnpos_z", 85.435836791992 )
					vioSetElementData ( player, "spawnrot_x", 0 )
					vioSetElementData ( player, "spawnint", 0 )
					vioSetElementData ( player, "spawndim", 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 5 then
					setPlayerNewSpawnpoint ( player, -2520.77, -623.44, 132.77, 0, 0, 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 6 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -2453.8784179688 )
						vioSetElementData ( player, "spawnpos_y", 503.82363891602 )
						vioSetElementData ( player, "spawnpos_z", 29.728803634644 )
						vioSetElementData ( player, "spawnrot_x", 0 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					else
						setPlayerNewSpawnpoint ( player, 216.72428894043, 168.78742980957, 1002.672668457, 90, 3, 0 )
					end
				elseif faction == 7 then
					if sType == "strip" then
						setPlayerNewSpawnpoint ( player, 1200.94, 11.89, 1000.57, 0, 2, 0 )
					else
						setPlayerNewSpawnpoint ( player, -1303.456, 2537.7158, 88.531, 90, 0, 0 )
					end
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 8 then
					if sType == "sf" then
						vioSetElementData ( player, "spawnpos_x", -1346.1706542969 )
						vioSetElementData ( player, "spawnpos_y", 492.36785888672 )
						vioSetElementData ( player, "spawnpos_z", 10.851915359497 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					elseif sType == "lv" then
						vioSetElementData ( player, "spawnpos_x", 247.46310424805 )
						vioSetElementData ( player, "spawnpos_y", 1859.85546875 )
						vioSetElementData ( player, "spawnpos_z", 13.733238220215 )
						vioSetElementData ( player, "spawnrot_x", 90 )
						vioSetElementData ( player, "spawnint", 0 )
						vioSetElementData ( player, "spawndim", 0 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
					end
				elseif faction == 10 then
					setPlayerNewSpawnpoint ( player, 441.684, 263.2427, 996.81188, 180, 3, 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 11 then
					setPlayerNewSpawnpoint ( player, -2395.73462 -122.067, 35.2888, 270, 0, 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 12 then
					vioSetElementData ( player, "spawnpos_x", -2202.4140625 )
					vioSetElementData ( player, "spawnpos_y", 76.34375 )
					vioSetElementData ( player, "spawnpos_z", 35.3203125 )
					vioSetElementData ( player, "spawnrot_x", 0 )
					vioSetElementData ( player, "spawnint", 0 )
					vioSetElementData ( player, "spawndim", 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
				elseif faction == 13 then
					vioSetElementData ( player, "spawnpos_x", -2446.2680664063 )
					vioSetElementData ( player, "spawnpos_y", -86.6 )
					vioSetElementData ( player, "spawnpos_z", 34.215 )
					vioSetElementData ( player, "spawnrot_x", 180 )
					vioSetElementData ( player, "spawnint", 0 )
					vioSetElementData ( player, "spawndim", 0 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeaendert!", 5000, 0, 125, 0 )
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist in\nkeiner Fraktion!", 5000, 125, 0, 0 )
		end
	elseif place == "noobspawn" then
		local thex = -1969.730
		local they = 116.0128
		local thexminus = math.random (0,5)
		local theyminus = math.random (0,6)
		local thexkommata = math.random (9)
		local theykommata = math.random (9)
		vioSetElementData ( player, "spawnpos_x", thex+thexminus+(thexkommata/10) )
		vioSetElementData ( player, "spawnpos_y", they )
		vioSetElementData ( player, "spawnpos_z", 28 )
		vioSetElementData ( player, "spawnrot_x", 0 )
		vioSetElementData ( player, "spawnint", 0 )
		vioSetElementData ( player, "spawndim", 0 )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
	elseif place == "hotel" then
		if vioGetElementData ( player, "money" ) >= 100 then
			takePlayerSaveMoney ( player, 100 )
			if sType == "sf" then
				vioSetElementData ( player, "spawnpos_x", 2230.5236816406 )
				vioSetElementData ( player, "spawnpos_y", -1107.6160888672 )
				vioSetElementData ( player, "spawnpos_z", 1050.5319824219 )
				vioSetElementData ( player, "spawnrot_x", 0 )
				vioSetElementData ( player, "spawnint", 5 )
				vioSetElementData ( player, "spawndim", 0 )
			else
				vioSetElementData ( player, "spawnpos_x", 2230.5236816407 )
				vioSetElementData ( player, "spawnpos_y", -1107.6160888672 )
				vioSetElementData ( player, "spawnpos_z", 1050.5319824219 )
				vioSetElementData ( player, "spawnrot_x", 0 )
				vioSetElementData ( player, "spawnint", 5 )
				vioSetElementData ( player, "spawndim", 0 )
			end
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nDu musst mind.\n100 $ besitzen!", 5000, 0, 125, 0 )
		end
	elseif place == "hier" then
		if vioGetElementData ( player, "adminlvl" ) >= 1 then
			local x, y, z = getElementPosition ( player )
			vioSetElementData ( player, "spawnpos_x", x )
			vioSetElementData ( player, "spawnpos_y", y )
			vioSetElementData ( player, "spawnpos_z", z )
			vioSetElementData ( player, "spawnrot_x", getPedRotation ( player ) )
			vioSetElementData ( player, "spawnint", getElementInterior ( player ) )
			vioSetElementData ( player, "spawndim", getElementDimension ( player ) )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
		end
	elseif place == "bar" then
		if vioGetElementData ( player, "club" ) == "biker" then
			vioSetElementData ( player, "spawnpos_x", -2244.6462402344 )
			vioSetElementData ( player, "spawnpos_y", -88.103973388672 )
			vioSetElementData ( player, "spawnpos_z", 34.96 )
			vioSetElementData ( player, "spawnrot_x", 180 )
			vioSetElementData ( player, "spawnint", 0 )
			vioSetElementData ( player, "spawndim", 0 )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
		else
			outputChatBox ( "Du bist kein Biker!", player, 125, 0, 0 )
		end
	elseif place == "boat" then
		OwnFootCheck ( player )
		local pname = getPlayerName ( player )
		local model = false
		local veh
		for i = 1, vioGetElementData ( player, "maxcars" ) do
			veh = allPrivateCars[pname][i]
			if isElement ( veh ) then
				veh = getElementModel ( veh )
				if veh == 454 or veh == 484 then
					if veh == 484 then
						model = "marquis"
					elseif veh == 454 then
						model = "tropic"
					end
					nexti = i
					break
				end
			end
		end
		if not model then
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast keine\nYacht!", 5000, 125, 0, 0 )
		else
			vioSetElementData ( player, "spawnpos_x", model )
			vioSetElementData ( player, "spawnpos_y", getPrivVehString ( pname, nexti ) )
			vioSetElementData ( player, "spawnpos_z", 0 )
			vioSetElementData ( player, "spawnrot_x", 0 )
			vioSetElementData ( player, "spawnint", 0 )
			vioSetElementData ( player, "spawndim", 0 )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
		end
	elseif place == "wohnmobil" then
		local wohnmobil = false
		
		for i = 1, vioGetElementData ( player, "maxcars" ) do
			veh = allPrivateCars[pname][i]
			if isElement ( veh ) then
				if camper [ getElementModel ( veh ) ] then
					wohnmobil = true
				end
			end
		end
		
		if wohnmobil then
			vioSetElementData ( player, "spawnpos_x", "wohnmobil" )
			vioSetElementData ( player, "spawnpos_y", 0 )
			vioSetElementData ( player, "spawnpos_z", 0 )
			vioSetElementData ( player, "spawnrot_x", 0 )
			vioSetElementData ( player, "spawnint", 0 )
			vioSetElementData ( player, "spawndim", 0 )
			
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nSpawnpunkt\ngeändert!", 5000, 0, 125, 0 )
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\n\nDu hast kein\nWohnmobil!", 5000, 0, 125, 0 )
		end
	else
		outputChatBox ( "Ungueltige Eingabe! Bitte entweder \"house\", \"faction\", \"boat\", \"wohnmobil\" oder \"street\" eingeben!", player, 125, 0, 0 )
	end
	dbExec ( handler, "UPDATE ?? SET ??=?, ??=?, ??=?, ??=?, ??=?, ??=? WHERE ??=?", "userdata", "Spawnpos_X", vioGetElementData ( player, "spawnpos_x" ), "Spawnpos_Y", vioGetElementData ( player, "spawnpos_y" ), "Spawnpos_Z", vioGetElementData ( player, "spawnpos_z" ), "Spawnrot_X", vioGetElementData ( player, "spawnrot_x" ), "SpawnInterior", vioGetElementData ( player, "spawnint" ), "SpawnDimension", vioGetElementData ( player, "spawndim" ), "UID", playerUID[pname] )
end
addCommandHandler ( "spawnchange", 
	function ( player )
		outputChatBox ( "Bitte nutze das Optionsmenue!", player, 125, 0, 0 )
	end
)

function changeSpawnPosition_func ( arg1, arg2 )

	spawnchange_func ( client, "", arg1, arg2 )
end
addEvent ( "changeSpawnPosition", true )
addEventHandler ( "changeSpawnPosition", getRootElement(), changeSpawnPosition_func )

function setPlayerNewSpawnpoint ( player, x, y, z, rot, int, dim )

	vioSetElementData ( player, "spawnpos_x", x )
	vioSetElementData ( player, "spawnpos_y", y )
	vioSetElementData ( player, "spawnpos_z", z )
	vioSetElementData ( player, "spawnrot_x", rot )
	vioSetElementData ( player, "spawnint", int )
	vioSetElementData ( player, "spawndim", dim )
end