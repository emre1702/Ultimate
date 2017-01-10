guiObjectModels = { [2942]=true, [2190]=true, [2754]=true }
secondClickTypes = { ["ped"] = true, ["player"] = true, ["vehicle"] = true }
clickSpecialPeds = { [rathausped]=true, [vincenzo]=true, [aztecasBouncer]=true }

function player_click ( button, state, clickedElement, x, y, z )

	if state == "down" and not getElementClicked ( source ) then

		if vioGetElementData ( source, "shaderedit" ) == true then
			return nil
		end
		
		if vioGetElementData ( source, "adminEnterVehicle" ) then
			
			if isElement ( clickedElement ) then
				if getElementType( clickedElement ) == "vehicle" then
				
					if getVehicleOccupant ( clickedElement ) then
						removePedFromVehicle ( getVehicleOccupant ( clickedElement ) )
					end
					
					warpPedIntoVehicle ( source, clickedElement )
					vioSetElementData ( source, "adminEnterVehicle", false )
				
					return nil
				
				end
			end
			
		end
	
		-- Keypads
		if fourDragonGateSwitches[clickedElement] then
			moveTriadCasinoGate_func ( source )
			return nil
		elseif MafiaCasinoKeypads and MafiaCasinoKeypads[clickedElement] then
			moveCasinoDoor ( source )
			return true
		end

		local x1, y1, z1 = getElementPosition ( source )
		local veh = getPedOccupiedVehicle ( source )

		if veh then
			if vioGetElementData ( veh, "katjuscha" ) then
				fireKatjuscha ( vioGetElementData ( veh, "katjuschaID" ), x, y, z )
				showCursor ( source, false )
				return nil
			end
		end
		
		-- Wanzen --
		
		if vioGetElementData ( source, "wanzen" ) then
		
			if clickedElement then
			
				if getElementType( clickedElement ) == "vehicle" then
				
					createWanze ( source, clickedElement, x, y, z )
					return true
				
				else
				
					outputChatBox ( "Wanzen koennen nur an Autos oder in der Umgebung platziert werden!", source, 0, 125, 0 )
				
				end
				
			else
			
				createWanze ( source, clickedElement, x, y, z )
				return true

			end
		
		end
		
		-----------------

		-- Spezial --
		if not clickedElement then
			if vioGetElementData ( source, "objectToPlace" ) or vioGetElementData ( source, "airstrike" ) then
				if vioGetElementData ( source, "airstrike" ) then
					vioSetElementData ( source, "airstrike", false )
					createAirstrike ( source, x, y, z )
					showCursor ( source, false )
					setElementClicked ( source, false )
				end
				return true
			end
		end
		---------------
		
		if clickedElement then
		
			if getElementData( clickedElement, "bank_ped" ) == true then
			
				triggerClientEvent ( source, "showCashPoint", getRootElement() ) ---dfsfsdfsdf
				setElementClicked ( source, true )
			
			end
		
		end

		-- Special Elements - Objekte --
		if clickedElement and not secondClickTypes[getElementType(clickedElement)] then
			local x2, y2, z2 = getElementPosition ( clickedElement )
			if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 10 then
				local model = getElementModel ( clickedElement )
				local count = getElementData ( clickedElement, "count" )
				if guiObjectModels[model] then
					if model == 2942 then
						triggerClientEvent ( source, "showCashPoint", getRootElement() )
						setElementClicked ( source, true )
					elseif model == 2190 then
						if isOnDuty ( source ) or isArmy ( source ) then
							triggerClientEvent ( source, "showPDComputer", getRootElement() )
							setElementClicked ( source, true )
						end
					elseif model == 2754 then
						triggerClientEvent ( source, "showChipBuy", source )
					end
				elseif vioGetElementData ( clickedElement, "placeableObject" ) then
					if vioGetElementData ( source, "adminlvl" ) >= 1 then
						if not vioGetElementData ( source, "objectDelete" ) then
							outputChatBox ( "Du kannst dieses Objekt loeschen; Klicke es dazu erneut an!", source, 0, 125, 0 )
							vioSetElementData ( source, "objectDelete", true )
							setTimer ( vioSetElementData, 60000, 1, source, "objectDelete", nil )
						else
							destroyElement ( clickedElement )
						end
					end
				elseif vioGetElementData ( clickedElement, "placeableObjectMySQL" ) then
					if vioGetElementData ( source, "adminlvl" ) >= 1 then
						if not vioGetElementData ( source, "objectDelete" ) then
							outputChatBox ( "Du kannst dieses Objekt löschen; Klicke es dazu erneut an!", source, 0, 125, 0 )
							vioSetElementData ( source, "objectDelete", true )
							setTimer ( vioSetElementData, 60000, 1, source, "objectDelete", nil )
						else
							local id = vioGetElementData ( clickedElement, "id" )
							dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "object", "id", id )
							destroyElement ( clickedElement )
						end
					end
				elseif vioGetElementData ( clickedElement, "weed" ) then
					local x1, y1, z1 = getElementPosition ( source )
					local x2, y2, z2 = getElementPosition ( clickedElement )
					if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 3 then
						local id = vioGetElementData ( clickedElement, "id" )
						if weedPlants[id] then
						
							local drugs = math.floor ( ( getMinTime () - vioGetElementData ( clickedElement, "time" ) ) / 20 )
							
							if drugs > 50 then
								drugs = 50
							elseif drugs < 20 then	
								if not isOnDuty ( source ) then
									outputChatBox ( "Die Drogen sind noch nicht bereit geerntet zu werden!", source, 255, 0, 0 )
									return
								end
							end
							destroyElement ( weedPlants[id] )
							weedPlants[id] = nil
							outputLog ( getPlayerName(source).." hat ID "..id.." geerntet und "..drugs.." bekommen!", "drogen" )
							dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "weed", "id", id )
							
							outputChatBox ( "Du hast "..drugs.." Gramm Drogen geerntet!", source, 0, 125, 0 )
							vioSetElementData ( source, "drugs", vioGetElementData ( source, "drugs" ) + drugs )
						else
							destroyElement ( clickedElement )
						end
					end
				elseif gunBoxes[clickedElement] then
					triggerClientEvent ( source,"gunCrateMenue", getRootElement() )
					setElementFrozen ( source, true )
					setElementClicked ( source, true )
				elseif depots[clickedElement] then
					if isInDepotFaction ( source ) then
						setElementClicked ( source, true )
						local owner = vioGetElementData ( source, "fraktion" )
						if owner == 11 then
							owner = 10
						end
						triggerClientEvent ( source, "showFDepot", getRootElement(), factionDepotData["money"][owner], factionDepotData["mats"][owner], factionDepotData["drugs"][owner] )
					else
						outputChatBox ( "Du bist in einer ungueltigen Fraktion!", source, 125, 0, 0 )
					end
				end
				return true
			end
		end
		
		-- Special Elements - Player --
		if clickedElement then
			if secondClickTypes[getElementType(clickedElement)] then
				if getElementModel ( clickedElement ) == 283 and not getElementType ( clickedElement ) == "player" then
					if not vioGetElementData ( source, "ticketOffered" ) then
						vioSetElementData ( source, "ticketOffered", true )
						outputChatBox ( "Hier kannst du ein Strafzettel loesen, um ein Wanted zu loeschen.", source, 200, 200, 0 )
						outputChatBox ( "Kosten: 2.000 $", source, 200, 200, 0 )
						setTimer ( vioSetElementData, 30000, 1, source, "ticketOffered", false )
					else
						if vioGetElementData ( source, "wanteds" ) == 1 then
							if vioGetElementData ( source, "money" ) >= 2000 then
								vioSetElementData ( source, "ticketOffered", false )
								outputChatBox ( "Strafzettel bezahlt!", source, 0, 125, 0 )
								setPlayerWantedLevel ( source, 0 )
								vioSetElementData ( source, "wanteds", 0 )
								takePlayerSaveMoney ( source, 2000 )
							else
								outputChatBox ( "Ein Strafzettel kostet 2.000 $", source, 125, 0, 0 )
							end
						else
							outputChatBox ( "Nur moeglich, wenn du ein Wanted hast!", source, 125, 0, 0 )
						end
					end
				elseif clickedElement == source then
					triggerClientEvent ( source, "ShowSelfClickMenue", getRootElement() )
					showCursor ( source, true )
					setElementClicked ( source, true )
				elseif clickSpecialPeds[clickedElement] then
					if clickedElement == rathausped then
						triggerClientEvent ( source, "ShowRathausMenue", getRootElement() )
						showCursor ( source, true )
						setElementClicked ( source, true )
					elseif clickedElement == vincenzo then
						triggerClientEvent ( source, "showVincenzosGunshop", getRootElement() )
						showCursor ( source, true )
						setElementClicked ( source, true )
					elseif clickedElement == aztecasBouncer then
						if isAztecas ( source ) then
							triggerClientEvent ( source, "showAztecasGunshop", source )
							showCursor ( source, true )
							setElementClicked ( source, true )
						end
					end
				elseif getElementType ( clickedElement ) == "vehicle" then
					local veh = clickedElement
					if vioGetElementData ( source, "wanzen" ) then
						createWanze ( source, clickedElement, false, false, false )
					elseif getVehicleTrunkState ( veh ) then
						local data = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=? AND ??=?", "Kofferraum", "vehicles", "UID", playerUID[vioGetElementData ( veh, "owner" )], "Slot", vioGetElementData ( veh, "carslotnr_owner" ) ), -1 )[1]["Kofferraum"]
						local drugs = tonumber ( gettok ( data, 1, string.byte ( '|' ) ) )
						local mats = tonumber ( gettok ( data, 2, string.byte ( '|' ) ) )
						local gun = tonumber ( gettok ( data, 3, string.byte ( '|' ) ) )
						local ammo = tonumber ( gettok ( data, 4, string.byte ( '|' ) ) )
						triggerClientEvent ( source, "showTrunkGui", getRootElement(), drugs, mats, gun, ammo )
						vioSetElementData ( source, "clickedVehicle", clickedElement )
						showCursor ( source, true )
						setElementClicked ( source, true )
					elseif not gangAreaUnderPreparation or not playerData[getPlayerName(source)] then
						triggerClientEvent ( source, "_createCarmenue", getRootElement(), clickedElement )
						vioSetElementData ( source, "clickedVehicle", clickedElement )
						showCursor ( source, true )
						setElementClicked ( source, true )
						-- -2098.6645
						-- -163.8
					end
				elseif vioGetElementData ( clickedElement, "clickPed" ) then
					local typ = vioGetElementData ( clickedElement, "typ" )
					local item, price
					if typ == "bum" then
						item = "100 $?!"
						price = "Burger"
					elseif typ == "gunbuyer" then
						if vioGetElementData ( clickedElement, "item" ) == 4 then
							price = "Messer"
						elseif vioGetElementData ( clickedElement, "item" ) == 22 then
							price = "9mm Pistole"
						else
							price = "AK-47"
						end
						item = tostring ( vioGetElementData ( clickedElement, "price" ) ).." $"
					else
						price = tostring ( vioGetElementData ( clickedElement, "price" ) ).." $"
					end
					if typ == "wdealer" then
						item = aiGunNames[vioGetElementData ( clickedElement, "item" )]
					elseif typ == "dealer" then
						item = tostring ( vioGetElementData ( clickedElement, "item" ) ).." g, \nDrogen"
					elseif typ == "sdealer" then
						item = tostring ( vioGetElementData ( clickedElement, "item" ) ).." Stk.,\nHanfsamen"
					elseif typ == "car" then
						local i = vioGetElementData ( clickedElement, "id" )
						local car = curAiCarSpots[i]["car"]
						item = vioGetElementData ( car, "name" )
						price = vioGetElementData ( car, "price" )
					end
					vioSetElementData ( source, "curclicked", clickedElement )
					setElementClicked ( source, true )
					triggerClientEvent ( source, "showPedInteraction", getRootElement(), typ, item, price )
				elseif getElementType ( clickedElement ) == "player" then
					if vioGetElementData ( clickedElement, "tazered" ) and isOnStateDuty ( source ) then
						grab_func ( source, "grab", getPlayerName ( clickedElement ) )
					else
						local pname = getPlayerName ( clickedElement )
						vioSetElementData ( source, "curclicked", pname )
						setElementClicked ( source, true )
						triggerClientEvent ( source,"ShowInteraktionsguiGui", getRootElement() )
					end
				end
			end
		end
	end
end
addEventHandler ( "onPlayerClick", getRootElement (), player_click )

function removeRemoteExplosive ( clickedElement )

	destroyElement ( clickedElement )
	setElementFrozen ( source, false )
end

function cancel_gui_server_func ( player )

	if player then source = player end
	if vioGetElementData(source,"nodmzone") == 1 then toggleControl ( source, "fire", false ) end
	if vioGetElementData(source,"sprint") == 1 then toggleControl ( source, "sprint", false ) end
	showCursor ( source, false )
	setElementClicked ( source, false )
end
addEvent ("cancel_gui_server", true )
addEventHandler ( "cancel_gui_server", getRootElement (), cancel_gui_server_func )

function self_func ( player )

	if not getElementClicked ( player ) then
		triggerClientEvent ( player, "ShowSelfClickMenue", player )
		showCursor ( player, true )
		setElementClicked ( player, true )
	end
end
addCommandHandler ( "self", self_func )