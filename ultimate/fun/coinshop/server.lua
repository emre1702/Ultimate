addEvent ( "giveCoinShopCar", true )
addEvent ( "giveCoinShopCigaretts", true )
addEvent ( "giveCoinShopNickchange", true )
addEvent ( "giveCoinShopMoney", true )

local lastCoinTake = {}


addCommandHandler ( "coin", function ( player )
	local x1, y1, z1 = getElementPosition ( player )
	local house = vioGetElementData ( player, "house" )
	if not lastCoinTake[house] or lastCoinTake[house] + 2*60*60*1000 <= getTickCount() then
		local x2 = vioGetElementData ( player, "housex" )
		local y2 = vioGetElementData ( player, "housey" )
		local z2 = vioGetElementData ( player, "housez" )
		if x2 and y2 and z2 and getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
			vioSetElementData ( player, "coins", vioGetElementData ( player, "coins" ) + 1 )
			infobox ( player, "Coin eingesammelt", 4000, 0, 200, 0 )
			lastCoinTake[house] = getTickCount()
		end
	else
		infobox ( player, "Coin wurde\nschon eingesammelt", 4000, 200, 0, 0 )
	end
end )


addEventHandler ( "giveCoinShopCar", root, function ( vehid, price )
	local coins = vioGetElementData ( client, "coins" )
	if coins >= price then
		local spawnx = tonumber ( spawnx )
		local spawny = tonumber ( spawny )
		local spawnz = tonumber ( spawnz )
		local Tuning = Tuning
		local pname = getPlayerName ( client )
		local slot = 0
		local differenz = 0
		if vioGetElementData ( client, "maxcars" ) > vioGetElementData ( client, "curcars" ) then
			for i=1, vioGetElementData ( client, "maxcars" ) do
				if vioGetElementData ( client, "carslot"..i ) == 0 then
					slot = i
					break
				end
			end
			if slot > 0 then
				setElementDimension ( client, 0 )
				setElementInterior ( client, 0 )
				fadeCamera( client, true)
				setCameraTarget( client, client )
				local vehicle = createVehicle ( vehid, -1932.04, 268.793, 41.1455, 0, 0, 180, pname )
				allPrivateCars[pname][slot] = vehicle
				vioSetElementData ( vehicle, "owner", pname )
				vioSetElementData ( vehicle, "name", vehicle )
				vioSetElementData ( vehicle, "carslotnr_owner", slot )
				vioSetElementData ( vehicle, "locked", true )
				vioSetElementData ( vehicle, "fuelstate", 100 )		
				setVehicleLocked ( vehicle, true )
				vioSetElementData ( client, "carslot"..slot, 1 )
				vioSetElementData ( client, "curcars", vioGetElementData ( client, "curcars" )+1 )
				vioSetElementData ( client, "FahrzeugeGekauft", vioGetElementData ( client, "FahrzeugeGekauft" ) + 1 )
				if not Tuning then
					Tuning = "|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|"
				end
				setVehicleRotation ( vehicle, 0, 0, 180 )
				local Farbe1, Farbe2, Farbe3, Farbe4 = getVehicleColor ( vehicle )
				local Paintjob = getVehiclePaintjob ( vehicle )						
				vioSetElementData ( vehicle, "stuning", "0|0|0|0|0|0|" )
				local color = "|"..Farbe1.."|"..Farbe2.."|"..Farbe3.."|"..Farbe4.."|"
				vioSetElementData ( vehicle, "color", color )
				vioSetElementData ( vehicle, "lcolor", "|255|255|255|" )
				vioSetElementData ( vehicle, "sportmotor", 0 )
				vioSetElementData ( vehicle, "bremse", 0 )
				local antrieb = getVehicleHandling(vehicle)["driveType"]
				vioSetElementData ( vehicle, "antrieb", antrieb )
				setPrivVehCorrectLightColor ( vehicle )				
				specPimpVeh ( vehicle )
				SaveCarData ( client )
				outputChatBox ( "Glückwunsch, du hast das Fahrzeug gekauft! Tippe /vehhelp für mehr Infomationen oder rufe das Hilfemenü auf!", client, 0, 255, 0 )
				checkCarWahnAchiev( client )
				warpPedIntoVehicle ( client, vehicle )		
				if vioGetElementData ( client, "playingtime" ) <= 300 then
					local text = "Du hast soeben ein Fahrzeug erworben!\nHier einige kurze Hinweise:\n\n1. Du kannst dein Fahrzeug mit /park an einem neuen\nOrt abstellen - dort wird es nach einem Server-\nrestart oder wenn du /towveh eintippst, erscheinen.\n\n2. Den Motor schaltest du mit \"X\" ein und aus.\n\n3. Mit /lock kannst du dein Fahrzeug abschliessen.\n\n4. Parke dein Fahrzeug nur an angemessenen Stellen,\nsonst wird es moeglicherweise geloescht.\nNicht angemessene Stellen sind z.b. auf der Strasse oder\nan wichtigen Stellen ( z.b. dem Eingang der Stadthalle ).\n\nFuer mehr: /vehinfos"
					prompt ( client, text, 30 )
				end			
				if not dbExec ( handler, "INSERT INTO ?? (??, ??, ??, ??, ??, ??, ??, ??, ??, ??, ??, ??, ??, ??, ??, ??) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", "vehicles", "UID", "Typ", "Tuning", "Spawnpos_X", "Spawnpos_Y", "Spawnpos_Z", "Spawnrot_X", "Spawnrot_Y", "Spawnrot_Z", "Farbe", "Paintjob", "Benzin", "Slot", "Sportmotor", "Bremse", "Antrieb", playerUID[pname], vehid, Tuning, -1932.04, 268.793, 41.1455, 0, 0, 180, color, Paintjob, '100', slot, '0', '0', antrieb )  then
					outputDebugString ( "[carbuy] Error executing the query" )
					destroyElement ( vehicle )
				end				
				activeCarGhostMode ( client, 10000 )
				triggerClientEvent ( client, "leaveCarhouse", client )
				setElementPosition ( vehicle, -1932.04, 268.793, 41.1455 )
				vioSetElementData ( client, "coins", coins - price )
				triggerClientEvent ( client, "updateCoinsInCoinshop", client )
			end
		else
			infobox ( client, "Kein freier Slot!", 4000, 200, 0, 0 )
		end
	else
		infobox ( client, "Nicht genug Coins!", 4000, 200, 0, 0 )
	end
end )


addEventHandler ( "giveCoinShopCigaretts", root, function ( )
	local coins = vioGetElementData ( client, "coins" )
	if coins >= 10 then
		vioSetElementData ( client, "zigaretten", vioGetElementData ( client, "zigaretten" ) + 100 )
		vioSetElementData ( client, "coins", coins - 10 )
		outputChatBox ( "100 Zigaretten gekauft", client, 0, 200, 0 )
		triggerClientEvent ( client, "updateCoinsInCoinshop", client )
	else
		infobox ( client, "Nicht genug Coins!", 4000, 200, 0, 0 )
	end
end )


addEventHandler ( "giveCoinShopNickchange", root, function ( )
	local coins = vioGetElementData ( client, "coins" )
	if coins >= 300 then
		offlinemsg ( getPlayerName ( client ) .. " hat einen Nickchange gekauft!", getPlayerName ( client ), "Bonus" )
		offlinemsg ( getPlayerName ( client ) .. " hat einen Nickchange gekauft!", getPlayerName ( client ), "[Utm]Pluz." )
		outputChatBox ( "Melde dich bei der Projektleitung für den Nickchange.", client, 0, 200, 0 )
		vioSetElementData ( client, "coins", coins - 300 )
		triggerClientEvent ( client, "updateCoinsInCoinshop", client )
	else
		infobox ( client, "Nicht genug Coins!", 4000, 200, 0, 0 )
	end
end )


addEventHandler ( "giveCoinShopMoney", root, function ( )
	local coins = vioGetElementData ( client, "coins" )
	if coins >= 200 then
		infobox ( client, "Du hast\n20.000$ gekauft", 4000, 0, 200, 0 )
		vioSetElementData ( client, "money", vioGetElementData ( client, "money" ) + 20000 )
		vioSetElementData ( client, "coins", coins - 200 )
		triggerClientEvent ( client, "updateCoinsInCoinshop", client )
	else
		infobox ( client, "Nicht genug Coins!", 4000, 200, 0, 0 )
	end
end )