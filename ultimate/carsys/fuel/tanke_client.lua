TankeSFDowntown = createMarker ( -1681.7896728516, 407.72265625, 5.6796879768372, "cylinder", 5, getColorFromString ( "#FF000099" ) )
TankeSFJuniperHill = createMarker ( -2415.208984375, 976.42901611328, 43.807689666748, "cylinder", 5, getColorFromString ( "#FF000099" ) )
TankeBoat = createMarker ( -1108.8315429688, -136.8196105957, 0, "cylinder", 5, getColorFromString ( "#FF000099" ) )
AirportTanke = createMarker ( -1122.7724609375, -202.25073242188, 10.893966674805, "cylinder", 50, getColorFromString ( "#FF000099" ) )
Tanke = {
	[1] = createMarker(-2244.2653808594, -2561.2934570313, 30.921875, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[2] = createMarker(658.52795410156, -565.03424072266, 15.3359375, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[3] = createMarker(1003.8759155273, -940.43975830078, 41.1796875, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[4] = createMarker(-92.113708496094, -1171.3128662109 ,1.3799414634705, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[5] = createMarker(1597.9239501953 ,2199.1923828125 ,9.8203125, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[6] = createMarker(2144.8181152344 ,2748.4426269531 ,9.8203125, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[7] = createMarker(2113.7553710938 ,920.28552246094 ,9.8203125, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[8] = createMarker(-736.88232421875 ,2741.0732421875 ,46.224239349365, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[9] = createMarker(-1326.2266845703 ,2688.9340820313 ,49.0625, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[10] = createMarker(1936.3382568359 ,-1772.1337890625 ,12.3828125, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[11] = createMarker(62.793960571289 ,1217.6678466797 ,17.835973739624, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[12] = createMarker(-1612.5341796875 ,-2723.4165039063 ,47.5390625, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[13] = createMarker(2638.4443359375 ,1106.2412109375 ,9.8203125, "cylinder", 5, getColorFromString ( "#FF000099" )),
	[14] = createMarker(2203.1423339844 ,2473.5385742188 ,9.8203125, "cylinder", 5, getColorFromString ( "#FF000099" ))
}



helicopters = { [548]=true, [425]=true, [417]=true, [487]=true, [488]=true, [497]=true, [563]=true, [447]=true, [469]=true }
planea = { [512]=true, [593]=true, [476]=true, [460]=true, [513]=true }
planeb = { [592]=true, [577]=true, [511]=true, [520]=true, [553]=true, [519]=true }

function showTankenGui ( player, dim )
	
	if player == getLocalPlayer() and dim then
		local veh = getPedOccupiedVehicle ( getLocalPlayer() )
		if veh then
			if getVehicleType ( veh ) ~= "Plane" and getVehicleType ( veh ) ~= "Helicopter" then
				setElementVelocity ( veh, 0, 0, 0 )
				showCursor ( true )
				setElementClicked ( true )
				toggleAllControls ( false )
				if gWindow["tankstelle"] then
					guiSetVisible ( gWindow["tankstelle"], true )
				else
					local screenwidth, screenheight = guiGetScreenSize ()
					
					gWindow["tankstelle"] = guiCreateWindow(screenwidth/2-378/2,screenheight/2-174/2,378,174,"Tankstelle",false)
					guiSetAlpha(gWindow["tankstelle"],1)
					guiWindowSetMovable(gWindow["tankstelle"],false)
					guiWindowSetSizable(gWindow["tankstelle"],false)
					gEdit["literFill"] = guiCreateEdit(0.3545,0.477,0.164,0.1609,"",true,gWindow["tankstelle"])
					guiSetAlpha(gEdit["literFill"],1)
					gLabel["literText"] = guiCreateLabel(0.5317,0.523,0.1005,0.1092,"Liter",true,gWindow["tankstelle"])
					guiSetAlpha(gLabel["literText"],1)
					guiLabelSetColor(gLabel["literText"],125,000,000)
					guiLabelSetVerticalAlign(gLabel["literText"],"top")
					guiLabelSetHorizontalAlign(gLabel["literText"],"left",false)
					guiSetFont(gLabel["literText"],"default-bold-small")
					gLabel["snackPrice"] = guiCreateLabel(0.7804,0.5115,0.0582,0.1092,"X $",true,gWindow["tankstelle"])
					guiSetAlpha(gLabel["snackPrice"],1)
					guiLabelSetColor(gLabel["snackPrice"],000,125,000)
					guiLabelSetVerticalAlign(gLabel["snackPrice"],"top")
					guiLabelSetHorizontalAlign(gLabel["snackPrice"],"left",false)
					guiSetFont(gLabel["snackPrice"],"default-bold-small")
					gLabel["pricePerLiter"] = guiCreateLabel(0.0767,0.5172,0.2011,0.1092,"X.XX $ / Liter",true,gWindow["tankstelle"])
					guiSetAlpha(gLabel["pricePerLiter"],1)
					guiLabelSetColor(gLabel["pricePerLiter"],000,125,000)
					guiLabelSetVerticalAlign(gLabel["pricePerLiter"],"top")
					guiLabelSetHorizontalAlign(gLabel["pricePerLiter"],"left",false)
					guiSetFont(gLabel["pricePerLiter"],"default-bold-small")
					gLabel["kannisterPrice"] = guiCreateLabel(0.3545,0.7069,0.1429,0.1897,"X Liter,\nX $",true,gWindow["tankstelle"])
					guiSetAlpha(gLabel["kannisterPrice"],1)
					guiLabelSetColor(gLabel["kannisterPrice"],200,050,020)
					guiLabelSetVerticalAlign(gLabel["kannisterPrice"],"top")
					guiLabelSetHorizontalAlign(gLabel["kannisterPrice"],"left",false)
					guiSetFont(gLabel["kannisterPrice"],"default-bold-small")
					
					gButton["buyKannister"] = guiCreateButton(0.0344,0.6724,0.291,0.2644,"Benzinkanister\nkaufen",true,gWindow["tankstelle"])
					guiSetAlpha(gButton["buyKannister"],1)
					gButton["volltanken"] = guiCreateButton(0.0344,0.1724,0.291,0.2644,"Volltanken",true,gWindow["tankstelle"])
					guiSetAlpha(gButton["volltanken"],1)
					gButton["ltanken"] = guiCreateButton(0.3519,0.1667,0.291,0.2644,"Liter tanken",true,gWindow["tankstelle"])
					guiSetAlpha(gButton["ltanken"],1)
					gButton["snack"] = guiCreateButton(0.6693,0.1667,0.291,0.2644,"Snack kaufen",true,gWindow["tankstelle"])
					guiSetAlpha(gButton["snack"],1)
					gButton["closeTanke"] = guiCreateButton(0.6825,0.6782,0.291,0.2644,"Fenster schliessen",true,gWindow["tankstelle"])
					guiSetAlpha(gButton["closeTanke"],1)
					
					addEventHandler("onClientGUIClick", gButton["closeTanke"],
						function()
							guiSetVisible ( gWindow["tankstelle"], false )
							showCursor(false)
							setElementClicked ( false )
							triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
							toggleAllControls ( true )
						end
					)
					addEventHandler("onClientGUIClick", gButton["volltanken"],
						function()
							guiSetVisible ( gWindow["tankstelle"], false )
							showCursor(false)
							setElementClicked ( false )
							toggleAllControls ( true )
							triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
							triggerServerEvent ( "fillComplete", getLocalPlayer(), getLocalPlayer() )
						end
					)
					addEventHandler("onClientGUIClick", gButton["ltanken"],
						function()
							guiSetVisible ( gWindow["tankstelle"], false )
							showCursor(false)
							setElementClicked ( false )
							toggleAllControls ( true )
							triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
							if guiGetText ( gEdit["literFill"] ) ~= "" then
								triggerServerEvent ( "fillPart", getLocalPlayer(), getLocalPlayer(), guiGetText ( gEdit["literFill"] ) )
							end
						end
					)
					addEventHandler("onClientGUIClick", gButton["snack"],
						function()
							triggerServerEvent ( "buySnack", getLocalPlayer(), getLocalPlayer() )
						end
					)
					addEventHandler("onClientGUIClick", gButton["buyKannister"],
						function()
							triggerServerEvent ( "buyKannister", getLocalPlayer(), getLocalPlayer() )
						end
					)
				end
				guiSetText ( gLabel["snackPrice"], snackPrice.." $" )
				guiSetText ( gLabel["pricePerLiter"], literPrice.." $ / Liter" )
				guiSetText ( gLabel["kannisterPrice"], "15 Liter,\n"..math.floor(literPrice*15)+kannisterPrice.." $" )
			end
		end
	end
end
addEventHandler ( "onClientMarkerHit", TankeSFJuniperHill, showTankenGui )
addEventHandler ( "onClientMarkerHit", TankeSFDowntown, showTankenGui )
addEventHandler ( "onClientMarkerHit", TankeBoat, showTankenGui )
for i=1, #Tanke do
	addEventHandler ( "onClientMarkerHit", Tanke[i], showTankenGui )
end

function showAirportTanke ( player, dim )

	if player == getLocalPlayer() and dim then
		if (getElementDimension ( player ) == 14) then return false end
		local veh = getPedOccupiedVehicle ( getLocalPlayer() )
		if veh then
			if ( getVehicleType ( veh ) == "Plane" or getVehicleType ( veh ) == "Helicopter" ) then
				setElementVelocity ( getPedOccupiedVehicle ( getLocalPlayer() ), 0, 0, 0 )
				showCursor ( true )
				setElementClicked ( true )
				toggleAllControls ( false )
				if gWindow["tankstelle"] then
					guiSetVisible ( gWindow["tankstelle"], true )
				else
					local screenwidth, screenheight = guiGetScreenSize ()
					
					gWindow["tankstelle"] = guiCreateWindow(screenwidth/2-378/2,screenheight/2-174/2,378,174,"Tankstelle",false)
					guiSetAlpha(gWindow["tankstelle"],1)
					guiWindowSetMovable(gWindow["tankstelle"],false)
					guiWindowSetSizable(gWindow["tankstelle"],false)
					gEdit["literFill"] = guiCreateEdit(0.3545,0.477,0.164,0.1609,"",true,gWindow["tankstelle"])
					guiSetAlpha(gEdit["literFill"],1)
					gLabel["literText"] = guiCreateLabel(0.5317,0.523,0.1005,0.1092,"Liter",true,gWindow["tankstelle"])
					guiSetAlpha(gLabel["literText"],1)
					guiLabelSetColor(gLabel["literText"],125,000,000)
					guiLabelSetVerticalAlign(gLabel["literText"],"top")
					guiLabelSetHorizontalAlign(gLabel["literText"],"left",false)
					guiSetFont(gLabel["literText"],"default-bold-small")
					gLabel["snackPrice"] = guiCreateLabel(0.7804,0.5115,0.0582,0.1092,"X $",true,gWindow["tankstelle"])
					guiSetAlpha(gLabel["snackPrice"],1)
					guiLabelSetColor(gLabel["snackPrice"],000,125,000)
					guiLabelSetVerticalAlign(gLabel["snackPrice"],"top")
					guiLabelSetHorizontalAlign(gLabel["snackPrice"],"left",false)
					guiSetFont(gLabel["snackPrice"],"default-bold-small")
					gLabel["pricePerLiter"] = guiCreateLabel(0.0767,0.5172,0.2011,0.1092,"X.XX $ / Liter",true,gWindow["tankstelle"])
					guiSetAlpha(gLabel["pricePerLiter"],1)
					guiLabelSetColor(gLabel["pricePerLiter"],000,125,000)
					guiLabelSetVerticalAlign(gLabel["pricePerLiter"],"top")
					guiLabelSetHorizontalAlign(gLabel["pricePerLiter"],"left",false)
					guiSetFont(gLabel["pricePerLiter"],"default-bold-small")
					gLabel["kannisterPrice"] = guiCreateLabel(0.3545,0.7069,0.1429,0.1897,"X Liter,\nX $",true,gWindow["tankstelle"])
					guiSetAlpha(gLabel["kannisterPrice"],1)
					guiLabelSetColor(gLabel["kannisterPrice"],200,050,020)
					guiLabelSetVerticalAlign(gLabel["kannisterPrice"],"top")
					guiLabelSetHorizontalAlign(gLabel["kannisterPrice"],"left",false)
					guiSetFont(gLabel["kannisterPrice"],"default-bold-small")
					
					gButton["buyKannister"] = guiCreateButton(0.0344,0.6724,0.291,0.2644,"Benzinkanister\nkaufen",true,gWindow["tankstelle"])
					guiSetAlpha(gButton["buyKannister"],1)
					gButton["volltanken"] = guiCreateButton(0.0344,0.1724,0.291,0.2644,"Volltanken",true,gWindow["tankstelle"])
					guiSetAlpha(gButton["volltanken"],1)
					gButton["ltanken"] = guiCreateButton(0.3519,0.1667,0.291,0.2644,"Liter tanken",true,gWindow["tankstelle"])
					guiSetAlpha(gButton["ltanken"],1)
					gButton["snack"] = guiCreateButton(0.6693,0.1667,0.291,0.2644,"Snack kaufen",true,gWindow["tankstelle"])
					guiSetAlpha(gButton["snack"],1)
					gButton["closeTanke"] = guiCreateButton(0.6825,0.6782,0.291,0.2644,"Fenster schliessen",true,gWindow["tankstelle"])
					guiSetAlpha(gButton["closeTanke"],1)
					
					addEventHandler("onClientGUIClick", gButton["closeTanke"],
						function()
							guiSetVisible ( gWindow["tankstelle"], false )
							showCursor(false)
							setElementClicked ( false )
							triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
							toggleAllControls ( true )
						end
					)
					addEventHandler("onClientGUIClick", gButton["volltanken"],
						function()
							guiSetVisible ( gWindow["tankstelle"], false )
							showCursor(false)
							setElementClicked ( false )
							triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
							triggerServerEvent ( "fillComplete", getLocalPlayer(), getLocalPlayer(), true )
						end
					)
					addEventHandler("onClientGUIClick", gButton["ltanken"],
						function()
							guiSetVisible ( gWindow["tankstelle"], false )
							showCursor(false)
							setElementClicked ( false )
							triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
							triggerServerEvent ( "fillPart", getLocalPlayer(), getLocalPlayer(), guiGetText ( gEdit["literFill"] ), true )
							toggleAllControls ( true )
						end
					)
					addEventHandler("onClientGUIClick", gButton["snack"],
						function()
							triggerServerEvent ( "buySnack", getLocalPlayer(), getLocalPlayer() )
						end
					)
					addEventHandler("onClientGUIClick", gButton["buyKannister"],
						function()
							triggerServerEvent ( "buyKannister", getLocalPlayer(), getLocalPlayer() )
						end
					)
				end
				guiSetText ( gLabel["snackPrice"], snackPrice.." $" )
				guiSetText ( gLabel["pricePerLiter"], (literPrice*3).." $ / Liter" )
				guiSetText ( gLabel["kannisterPrice"], "15 Liter,\n"..math.floor(literPrice*15)+kannisterPrice.." $" )
			end
		end
	end
end
addEventHandler ( "onClientMarkerHit", AirportTanke, showAirportTanke )