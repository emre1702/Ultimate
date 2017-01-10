houses = {}
 houses["id"] = {}
 houses["pickup"] = {}

function createHouse ( player, cmd, preis, int )
	if preis and tonumber(preis) and int and tonumber(int) then
		local Preis = tonumber ( math.abs ( preis ) )
		local CurrentInterior = tonumber ( int )
		if vioGetElementData ( player, "adminlvl" ) >= 4 then
			if Preis >= 15000 then
				if CurrentInterior ~= nil then					
					local SymbolX, SymbolY, SymbolZ = getElementPosition ( player )
					local Besitzer = "none"
					local Preis = tonumber ( preis )
					local CurrentInterior = tonumber ( int )
					local inserted, _, ID = dbPoll ( dbQuery ( handler, "INSERT INTO houses ( SymbolX, SymbolY, SymbolZ, UID, Preis, CurrentInterior, Kasse, Miete ) VALUES (?,?,?,?,?,?,?,?)", SymbolX, SymbolY, SymbolZ, 0, Preis, CurrentInterior, '0', '0' ), -1 )
					if not inserted then
						outputDebugString("[createHouse] Error executing the query")
						return false
					else
						outputDebugString ("Haus ID "..ID.." wurde angelegt!")
						outputChatBox ( "Haus angelegt!", player, 200, 200, 0 )
						createHouseNew ( ID, SymbolX, SymbolY, SymbolZ, Besitzer, Preis, CurrentInterior, 0, 0 )
						return true
					end
				else
					outputChatBox ( "Gebrauch: /newhouse [Preis] [Interior ( iraum [1-30] )]", player, 155, 0, 0 )
				end
			else
				outputChatBox ( "Mindestpreis muss 15.000$ sein!", player, 155, 0, 0 )
			end
		else
			infobox ( player, "Du bist\nnicht befugt!", player, 4000, 155, 0, 0 )
		end
	else
		outputChatBox ( "Gebrauch: /newhouse [Preis] [Interior ( iraum [1-30] )]", player, 155, 0, 0 )
	end
end
addCommandHandler ( "newhouse", createHouse )


function createHouseNew ( id, x, y, z, owner, cost, int, kasse, rent )

	local img
	if owner == "none" then img = 1273 else img = 1272 end
	
	local pickup = createPickup ( x, y, z, 3, img, 200, 0 )
	addEventHandler ( "onPickupHit", pickup, housePickup )
	
	houses["id"][pickup] = id
	houses["pickup"][id] = pickup
	if owner ~= "0" then
		houses["pickup"][owner] = pickup
	end
	
	vioSetElementData ( pickup, "owner", owner )
	vioSetElementData ( pickup, "locked", true )
	vioSetElementData ( pickup, "preis", cost )
	vioSetElementData ( pickup, "curint", int )
	vioSetElementData ( pickup, "id", id )
	vioSetElementData ( pickup, "miete", rent )
	vioSetElementData ( pickup, "kasse", kasse )
end


function setHouseBought ( pickup, owner )
	if isElement ( pickup ) then
		local x, y, z = getElementPosition ( pickup )
		local newpickup = createPickup ( x, y, z, 3, 1272, 200, 0 )
		
		local id = houses["id"][pickup]
		houses["id"][newpickup] = id
		houses["id"][pickup] = nil
		
		houses["pickup"][id] = newpickup
		houses["pickup"][owner] = newpickup
		
		vioSetElementData ( newpickup, "owner", owner )
		vioSetElementData ( newpickup, "locked", true )
		vioSetElementData ( newpickup, "preis", vioGetElementData ( pickup, "preis" ) )
		vioSetElementData ( newpickup, "curint", vioGetElementData ( pickup, "curint" ) )
		vioSetElementData ( newpickup, "id", id )
		vioSetElementData ( newpickup, "miete", vioGetElementData ( pickup, "miete" )  )
		vioSetElementData ( newpickup, "kasse", vioGetElementData ( pickup, "kasse" )  )
		
		destroyElement ( pickup )
		addEventHandler ( "onPickupHit", newpickup, housePickup )
	end
end


function setHouseSold ( pickup, owner )
	if isElement ( pickup ) then
		local x, y, z = getElementPosition ( pickup )
		local newpickup = createPickup ( x, y, z, 3, 1273, 200, 0 )
		
		local id = houses["id"][pickup]
		houses["id"][newpickup] = id
		houses["id"][pickup] = nil
		
		houses["pickup"][id] = newpickup
		houses["pickup"][owner] = nil
		
		vioSetElementData ( newpickup, "owner", "none" )
		vioSetElementData ( newpickup, "locked", true )
		vioSetElementData ( newpickup, "preis", vioGetElementData ( pickup, "preis" ) )
		vioSetElementData ( newpickup, "curint", vioGetElementData ( pickup, "curint" ) )
		vioSetElementData ( newpickup, "id", id )
		vioSetElementData ( newpickup, "miete", vioGetElementData ( pickup, "miete" )  )
		vioSetElementData ( newpickup, "kasse", vioGetElementData ( pickup, "kasse" )  )
		
		destroyElement ( pickup )
		addEventHandler ( "onPickupHit", newpickup, housePickup )
	end
end


function houseCreation()
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM houses" ), -1 )
	if result and result[1] then
		local amount = #result
		for i=1, amount do
			local id = tonumber(result[i]["ID"])
			local x = tonumber(result[i]["SymbolX"])
			local y = tonumber(result[i]["SymbolY"])
			local z = tonumber(result[i]["SymbolZ"])
			local owner = playerUIDName[tonumber(result[i]["UID"])] or "none"
			local cost = tonumber(result[i]["Preis"])
			local int = tonumber(result[i]["CurrentInterior"])
			local kasse = tonumber(result[i]["Kasse"])
			local rent = tonumber(result[i]["Miete"])
			createHouseNew ( id, x, y, z, owner, cost, int, kasse, rent )				
			loadGangData ( id )				
		end
		outputServerLog("Es wurden "..amount.." Haeuser gefunden")
	else
		outputDebugString("[houseCreation] Error executing the query.")
	end
end
addEventHandler ( "onResourceStart", resourceRoot, houseCreation )