createBlip ( -2442.6064453125, 753.44964599609, 34.136966705322, 36, 2, 255, 0, 0, 255, 0, 200 )
createBlip ( 2194.9331054688, 1991.1153564453, 13.296875, 36, 2, 255, 0, 0, 255, 0, 200 )
Marker24_7 = createMarker ( -2442.6064453125, 753.44964599609, 34.136966705322, "cylinder", 1.2, 200, 0, 0, 200, getRootElement() )
Marker24_7_LV = createMarker( 2194.9331054688, 1991.1153564453, 11.2, "cylinder",1.2, 200, 0, 0, 200, getRootElement() )

function Marker24_7Hit ( player, dim )
	if getElementType ( player ) == "player" and dim then
		if not getPedOccupiedVehicle ( player ) then
			vioSetElementData(player, "24/7", "SF")
			setElementDimension ( player, 1 )
			setElementInterior ( player, 6 )
			setCameraMatrix ( player, -24.504987716675, -50.165203094482, 1004.0047607422, -21.805931091309, -57.300312042236, 1005.2012329102 )
			triggerClientEvent ( player, "create24_7Shop", getRootElement() )
			setPlayerHudComponentVisible ( player, "ammo", true )
			setPlayerHudComponentVisible ( player, "weapon", true )
			setPlayerHudComponentVisible ( player, "armour", true )
			setPlayerHudComponentVisible ( player, "money", true )
		end
	end
end
addEventHandler ( "onMarkerHit", Marker24_7, Marker24_7Hit )

function Marker24_7_LV_Hit ( player, dim )

	if getElementType ( player ) == "player" and dim then
		if not getPedOccupiedVehicle ( player ) then
			vioSetElementData(player, "24/7", "LV")
			setElementDimension ( player, 1 )
			setElementInterior ( player, 6 )
			setCameraMatrix ( player, -24.504987716675, -50.165203094482, 1004.0047607422, -21.805931091309, -57.300312042236, 1005.2012329102 )
			triggerClientEvent ( player, "create24_7Shop", getRootElement() )
			setPlayerHudComponentVisible ( player, "ammo", true )
			setPlayerHudComponentVisible ( player, "weapon", true )
			setPlayerHudComponentVisible ( player, "armour", true )
			setPlayerHudComponentVisible ( player, "money", true )
		end
	end
end
addEventHandler ( "onMarkerHit", Marker24_7_LV, Marker24_7_LV_Hit )

function Cancel24_7_func ( player )
	if player == client then
		if (vioGetElementData(player,"24/7") == "LV") then
			setElementDimension ( player, 0 )
			setElementInterior ( player, 0 )
			setElementPosition ( player, 2194.9331054688, 1990.1153564453, 13.296875 )
			setCameraTarget ( player, player )		
		else
			setElementDimension ( player, 0 )
			setElementInterior ( player, 0 )
			setElementPosition ( player, -2442.4904785156, 749.57501220703, 34.827850341797 )
			setCameraTarget ( player, player )
		end
	end
end
addEvent ( "Cancel24_7", true )
addEventHandler ( "Cancel24_7", getRootElement(), Cancel24_7_func )

function itemBuy_func ( player, item, cam, nvslot )

	if player == client then
		if cam == 43 then cam = true else cam = false end
		local money = vioGetElementData ( player, "money" )
		if item == "flowers" then
			if money >= flowers_price then
				vioSetElementData ( player, "money", money - flowers_price )
				giveWeapon ( player, 14, 1, true )
				playSoundFrontEnd ( player, 40 )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nGekauft!", 7500, 0, 125, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 7500, 125, 0, 0 )
			end
		elseif item == "cam" then
			if money >= cam_price then
				if cam then
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast bereits\neine Kamera!", 7500, 125, 0, 0 )
				else
					vioSetElementData ( player, "money", money - cam_price )
					giveWeapon ( player, 43, 36, true )
					playSoundFrontEnd ( player, 40 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nGekauft!", 7500, 0, 125, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 7500, 125, 0, 0 )
			end
		elseif item == "camammo" then
			if money >= camammo_price then
				if cam then
					vioSetElementData ( player, "money", money - camammo_price )
					giveWeapon ( player, 43, 36, true )
					playSoundFrontEnd ( player, 40 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nGekauft!", 7500, 0, 125, 0 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast noch\nkeine Kamera!", 7500, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 7500, 125, 0, 0 )
			end
		elseif item == "nv" then
			if money >= nvgoogles_price then
				vioSetElementData ( player, "money", money - nvgoogles_price )
				giveWeapon ( player, 44, 1, true )
				playSoundFrontEnd ( player, 40 )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nGekauft!", 7500, 0, 125, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 7500, 125, 0, 0 )
			end
		elseif item == "t" then
			if money >= tgoogles_price then
				vioSetElementData ( player, "money", money - tgoogles_price )
				giveWeapon ( player, 45, 1, true )
				playSoundFrontEnd ( player, 40 )
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nGekauft!", 7500, 0, 125, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 7500, 125, 0, 0 )
			end
		elseif item == "dice" then
			if money >= wuerfel_price then
				if vioGetElementData ( player, "dice" ) == 0 then
					vioSetElementData ( player, "money", money - wuerfel_price )
					vioSetElementData ( player, "dice", 1 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "inventar", "Wuerfel", 1, "UID", playerUID[getPlayerName(player)] )
					playSoundFrontEnd ( player, 40 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nGekauft!", 7500, 0, 125, 0 )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast schon\neinen Wuerfel!", 7500, 125, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 7500, 125, 0, 0 )
			end
		elseif item == "los" then
			if money >= rubbellos_price then
				vioSetElementData ( player, "money", money - rubbellos_price )
				playSoundFrontEnd ( player, 40 )
				local rnd = math.random ( 1, 100 )
				if rnd <= 60 then
					outputChatBox ( "Leider nur eine Niete!", player, 0, 125, 0 )
				elseif rnd <= 80 then
					outputChatBox ( "Du hast "..(rubbellos_price*1.5).." $ gewonnen!", player, 125, 0, 0 )
					vioSetElementData ( player, "money", vioGetElementData(player,"money") + (rubbellos_price*1.5) )
				elseif rnd <= 95 then
					outputChatBox ( "Du hast "..(rubbellos_price*2).." $ gewonnen!", player, 125, 0, 0 )
					vioSetElementData ( player, "money", vioGetElementData(player,"money") + rubbellos_price*2 )
				elseif rnd <= 99 then
					outputChatBox ( "Du hast "..(rubbellos_price*5).." $ gewonnen!", player, 125, 0, 0 )
					vioSetElementData ( player, "money", vioGetElementData(player,"money") + rubbellos_price*5 )
				else
					outputChatBox ( "Du hast "..(rubbellos_price*20).." $ gewonnen!", player, 125, 0, 0 )
					vioSetElementData ( player, "money", vioGetElementData(player,"money") + rubbellos_price*20 )
				end
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nGekauft!", 7500, 0, 125, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 7500, 125, 0, 0 )
			end
		elseif item == "beer" then
			if money >= beer_price then
				vioSetElementData ( player, "money", money - beer_price )
				playSoundFrontEnd ( player, 40 )
				putFoodInSlot ( player, 2 )
			else
				outputChatBox ( "Du hast nicht genug Geld! Ein Bier kostet "..beer_price.." $!", player, 125, 0, 0 )
			end
			-- beer_price
		elseif item == "cig" then
			if money >= zigarett_price then
				vioSetElementData ( player, "money", money - zigarett_price )
				vioSetElementData ( player, "zigaretten", vioGetElementData ( player, "zigaretten" ) + 5 )
				playSoundFrontEnd ( player, 40 )
			else
				outputChatBox ( "Du hast nicht genug Geld! Ein Paeckchen Zigaretten kostet "..zigarett_price.." $!", player, 125, 0, 0 )
			end
		elseif item == "sim-50" or item == "sim-100" or item == "sim-250" then
			if vioGetElementData ( player, "handyType" ) == 2 then
				local val = 0
				if item == "sim-50" then
					val = 50
				elseif item == "sim-100" then
					val = 100
				else
					val = 250
				end
				if money >= val then
					vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) + val )
					infobox ( player, "Guthaben aufgeladen!\nTippe /call *100#\num dein Guthaben zu\nueberpruefen!", 5000, 125, 0, 0 )
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - val )
				else
					infobox ( player, "Du hast nicht\ngenug Geld!", 5000, 125, 0, 0 )
				end
			else
				infobox ( player, "Das ist nur\nfuer Prepayed Nutzer!", 5000, 125, 0, 0 )
			end
		end
	end
end
addEvent ( "itemBuy", true )
addEventHandler ( "itemBuy", getRootElement(), itemBuy_func )

function changeTarif ( val )

	--[[
	if guiRadioButtonGetSelected(gRadio["flatrate"]) then
		val = 3
	elseif guiRadioButtonGetSelected(gRadio["prepayed"]) then
		val = 2
	elseif guiRadioButtonGetSelected(gRadio["vertrag"]) then
		val = 1
	end
	
	
	if vioGetElementData ( player, "handyType" ) == 2 then
									vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) - smsprice )
								elseif vioGetElementData ( player, "handyType" ) == 1 then
									vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) + smsprice )
								end
	
	]]
	local player = client
	if val == 1 or val == 2 or val == 3 then
		if val ~= vioGetElementData ( player, "handyType" ) then
			if vioGetElementData ( player, "handyType" ) == 1 then
				if vioGetElementData ( player, "money" ) >= vioGetElementData ( player, "handyCosts" ) then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - vioGetElementData ( player, "handyCosts" ) )
					vioSetElementData ( player, "handyCosts", 0 )
				else
					infobox ( player, "Du hast nicht\ngenug Geld, um\ndie Kosten fuer\ndeinen Vertrag zu\ndecken!", 5000, 125, 0, 0 )
					return false
				end
			elseif vioGetElementData ( player, "handyType" ) == 2 then
				vioSetElementData ( player, "handyCosts", 0 )
			end
			if val == 1 then
				if vioGetElementData ( player, "money" ) >= 10 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 10 )
					vioSetElementData ( player, "handyType", 1 )
					vioSetElementData ( player, "handyCosts", 0 )
					infobox ( player, "Tarif gewechselt!\nTippe /call *100#\nfuer mehr Infos!", 5000, 0, 200, 0 )
				else
					infobox ( player, "Du kannst die\nEinrichtungsgebuehr nicht\nbezahlen!", 5000, 125, 0, 0 )
				end
			elseif val == 2 then
				vioSetElementData ( player, "handyType", 2 )
				vioSetElementData ( player, "handyCosts", 0 )
				infobox ( player, "Tarif gewechselt!\nTippe /call *100#\nfuer mehr Infos!", 5000, 0, 200, 0 )
			elseif val == 3 then
				vioSetElementData ( player, "handyType", 3 )
				vioSetElementData ( player, "handyCosts", 0 )
				infobox ( player, "Tarif gewechselt!\nTippe /call *100#\nfuer mehr Infos!", 5000, 0, 200, 0 )
			end
		else
			infobox ( player, "Diesen Tarif verwendest\ndu bereits!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "changeTarif", true )
addEventHandler ( "changeTarif", getRootElement(), changeTarif )