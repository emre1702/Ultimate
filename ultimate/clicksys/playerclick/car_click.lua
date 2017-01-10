function SubmitFahrzeugAbbrechenBtn(button)
	if button == "left" then
		guiSetInputEnabled ( true )
		guiSetVisible ( gWindows["vehinteraktion"], false )
		if gWindow["vehCarDelete"] then
			guiSetVisible ( gWindow["vehCarDelete"], false )
		end
		showCursor(false)
		triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
	end
end

function _createCarmenue_func ( veh )

	guiSetInputEnabled ( false )
	if gWindows["vehinteraktion"] then
		guiSetVisible ( gWindows["vehinteraktion"], true )
		if gWindow["vehCarDelete"] then
			guiSetVisible ( gWindow["vehCarDelete"], true )
		end
	else
		if getElementData ( lp, "adminlvl" ) >= 3 then
			gWindow["vehCarDelete"] = guiCreateWindow(0,screenheight/2-132/2,151,137,"Admin",false)
			guiSetAlpha(gWindow["vehCarDelete"],1)
			gButton["vehCarDel"] = guiCreateButton(0.0596,0.1898,0.3974,0.2555,"Loeschen",true,gWindow["vehCarDelete"])
			guiSetAlpha(gButton["vehCarDel"],1)
			gButton["vehCarResp"] = guiCreateButton(0.4901,0.1898,0.457,0.2555,"Respawnen",true,gWindow["vehCarDelete"])
			guiSetAlpha(gButton["vehCarResp"],1)
			gLabel["vehCarInfo1"] = guiCreateLabel(0.0596,0.4891,0.3113,0.1387,"Grund:",true,gWindow["vehCarDelete"])
			guiSetAlpha(gLabel["vehCarInfo1"],1)
			guiLabelSetColor(gLabel["vehCarInfo1"],255,255,255)
			guiLabelSetVerticalAlign(gLabel["vehCarInfo1"],"top")
			guiLabelSetHorizontalAlign(gLabel["vehCarInfo1"],"left",false)
			guiSetFont(gLabel["vehCarInfo1"],"default-bold-small")
			gMemo["vehCarReason"] = guiCreateMemo(0.0596,0.6058,0.8808,0.3358,"",true,gWindow["vehCarDelete"])
			guiSetAlpha(gMemo["vehCarReason"],1)
			
			addEventHandler("onClientGUIClick", gButton["vehCarResp"], 
				function()
					local veh = vioClientGetElementData ( "clickedVehicle" )
					local towcar = getElementData ( veh, "carslotnr_owner" )
					local pname = getElementData ( veh, "owner" )
					triggerServerEvent ( "respawnVeh", lp, towcar, pname, veh )
					SubmitFahrzeugAbbrechenBtn("left")
				end
			)
			addEventHandler("onClientGUIClick", gButton["vehCarDel"], 
				function()
					local veh = vioClientGetElementData ( "clickedVehicle" )
					local towcar = getElementData ( veh, "carslotnr_owner" )
					local pname = getElementData ( veh, "owner" )
					if not pname then
						triggerServerEvent ( "moveVehicleAway", lp, veh )
					else
						triggerServerEvent ( "deleteVeh", lp, towcar, pname, veh, guiGetText ( gMemo["vehCarReason"] ) )
					end
					SubmitFahrzeugAbbrechenBtn("left")
				end,
			false)
		end
		gWindows["vehinteraktion"] = guiCreateWindow(screenwidth/2-224/2,screenheight/2-132/2,224,132,"Fahrzeuginteraktion",false)
		guiSetAlpha(gWindows["vehinteraktion"],1)
		
		gButtons["vehabschliessen"] = guiCreateButton(0.0402,0.1818,0.442,0.3485,"Abschliessen",true,gWindows["vehinteraktion"])
		guiSetAlpha(gButtons["vehabschliessen"],1)
		gButtons["vehrespawn"] = guiCreateButton(0.52,0.1818,0.442,0.3485,"Respawnen",true,gWindows["vehinteraktion"])
		guiSetAlpha(gButtons["vehrespawn"],1)
		gButtons["vehinfo"] = guiCreateButton(0.0402,0.59,0.442,0.3485,"Infos",true,gWindows["vehinteraktion"])
		guiSetAlpha(gButtons["vehinfo"],1)
		gButtons["vehcancel"] = guiCreateButton(0.52,0.59,0.442,0.3485,"Abbrechen",true,gWindows["vehinteraktion"])
		guiSetAlpha(gButtons["vehcancel"],1)

		addEventHandler("onClientGUIClick", gButtons["vehcancel"], SubmitFahrzeugAbbrechenBtn, false)
		
		addEventHandler("onClientGUIClick", gButtons["vehrespawn"], 
			function ()
				local veh = vioClientGetElementData ( "clickedVehicle" )
				if veh then
					if getElementData ( veh, "owner" ) == getPlayerName ( lp ) then
						triggerServerEvent ( "respawnPrivVehClick", lp, lp, "lock", tonumber ( getElementData ( veh, "carslotnr_owner" ) ) )
					else
						outputChatBox ( "Das Fahrzeug gehoert dir nicht!", 125, 0, 0 )
					end
				end
			end
		)
		addEventHandler("onClientGUIClick", gButtons["vehabschliessen"], 
			function ()
				local veh = vioClientGetElementData ( "clickedVehicle" )
				if veh then
					if getElementData ( veh, "owner" ) == getPlayerName ( lp ) then
						triggerServerEvent ( "lockPrivVehClick", lp, lp, "lock", tonumber ( getElementData ( veh, "carslotnr_owner" ) ) )
					else
						outputChatBox ( "Das Fahrzeug gehoert dir nicht!", 125, 0, 0 )
					end
				end
			end
		)
		addEventHandler("onClientGUIClick", gButtons["vehinfo"], 
			function ()
				local veh = vioClientGetElementData ( "clickedVehicle" )
				if veh then
					local owner = getElementData ( veh, "owner" )
					if not owner or owner == "console" then
						owner = "Niemand"
					end
					local stunings = sTuningsToString ( veh )
					outputChatBox ( "Fahrzeug Modell: "..getVehicleName (veh)..", Besitzer: "..owner, 200, 200, 255 )
					outputChatBox ( "Tunings: "..stunings, 200, 200, 255 )
				end
			end
		)

		if gWindows["vehinteraktion"] then
			guiWindowSetSizable(gWindows["vehinteraktion"],false)
			guiWindowSetMovable(gWindows["vehinteraktion"],false)
		end
		
		if gWindows["adminvehinteraktion"] then
			guiWindowSetSizable(gWindows["adminvehinteraktion"],false)
			guiWindowSetMovable(gWindows["adminvehinteraktion"],false)
		end
	end
end
addEvent ( "_createCarmenue", true )
addEventHandler ( "_createCarmenue", getRootElement(), _createCarmenue_func )


function sTuningsToString ( veh )
	if veh and getElementType (veh) == "vehicle" then
		local carstring = ""
		if getElementData ( veh, "stuning1" ) and getElementData ( veh, "stuning1" ) >= 1 then
			carstring = "Kofferraum"
		end
		if getElementData ( veh, "stuning2" ) and getElementData ( veh, "stuning2" ) >= 1 then
			if carstring == "" then
				carstring = "Panzerung"
			else
				carstring = carstring..", Panzerung"
			end
		end
		if getElementData ( veh, "stuning3" ) and getElementData ( veh, "stuning3" ) >= 1 then
			if carstring == "" then
				carstring = "Benzinersparnis"
			else
				carstring = carstring..", Benzinersparnis"
			end
		end
		if getElementData ( veh, "stuning4" ) and getElementData ( veh, "stuning4" ) >= 1 then
			if carstring == "" then
				carstring = "GPS"
			else
				carstring = carstring..", GPS"
			end
		end
		if getElementData ( veh, "stuning5" ) and getElementData ( veh, "stuning5" ) >= 1 then
			if carstring == "" then
				carstring = "Doppelreifen"
			else
				carstring = carstring..", Doppelreifen"
			end
		end
		if getElementData ( veh, "stuning6" ) and getElementData ( veh, "stuning6" ) >= 1 then
			if carstring == "" then
				carstring = "Nebelwerfer"
			else
				carstring = carstring..", Nebelwerfer"
			end
		end
		if getVehicleType ( veh ) ~= "Plane" and getVehicleType ( veh ) ~= "Helicopter" then
			local sportmotor = getElementData ( veh,"sportmotor" )
			if sportmotor and sportmotor > 0 then
				if carstring == "" then
					carstring = "Sportmotor "..sportmotor
				else
					carstring = carstring..", Sportmotor "..sportmotor
				end
			end
			local bremse = getElementData ( veh,"bremse" )
			if bremse and bremse > 0 then
				if carstring == "" then
					carstring = "Bremse "..bremse
				else
					carstring = carstring..", Bremse "..bremse
				end
			end
			local radtyp = getVehicleHandling ( veh )["driveType"]
			if radtyp == "rwd" then
				radtyp = "Heckantrieb"
			elseif radtyp == "awd" then
				radtyp = "Allradantrieb"
			else
				radtyp = "Frontantrieb"
			end
			if carstring == "" then
				carstring = radtyp
			else
				carstring = carstring..", "..radtyp
			end
		end
		if carstring == "" then
			return "Keine"
		else
			return carstring
		end
	end
end