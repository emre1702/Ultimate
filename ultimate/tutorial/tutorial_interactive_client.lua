-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function setPlayerInTutorial_func ()

	tutorial = true
	setElementClicked ( true )
	player = lp
	setElementPosition ( player, -1836.3757324219, 59.434074401855, 1054.8388671875 )
	setElementInterior ( player, 14 )
	setElementDimension ( player, 0 )
	secruity = createPed ( 71, -1876.4310302734, 48.805534362793, 1054.8388671875 )
	airportPed1 = createPed ( 14, -1882.2819824219, 68.042358398438, 1054.8388671875 )
	airportPed2 = createPed ( 55, -1882.1889648438, 65.037223815918, 1054.8388671875 )
	airportPed3 = createPed ( 35, -1878.8829345703, 60.107585906982, 1054.8388671875 )
	
	airportPed4 = createPed ( 26, -1881.2846679688, 56.253040313721, 1054.84 )
	airportPed5 = createPed ( 41, -1882.8354492188, 54.725475311279, 1054.84 )
	chatPeds ( airportPed4, airportPed5 )
	
	airportSecruityPed = createPed ( 71, -1875.6363525391, 52.43042755127, 1054.8409423828 )
	setPedRotation ( airportSecruityPed, 90 )
	secruityWalk ( airportSecruityPed )
	
	setElementInterior ( secruity, 14 )
	setElementInterior ( airportPed1, 14 )
	setElementInterior ( airportPed2, 14 )
	setElementInterior ( airportPed3, 14 )
	setElementInterior ( airportPed4, 14 )
	setElementInterior ( airportPed5, 14 )
	setElementInterior ( airportSecruityPed, 14 )
	setPedRotation ( secruity, 0 )
	setPedRotation ( airportPed1, 270 )
	setPedRotation ( airportPed2, 270 )
	setPedRotation ( airportPed3, 0 )
	
	case = createObject ( 1210, -1867.8599853516, 60.985023498535, 1054.890625, 0, 0, 345 )
	setElementInterior ( case, 14 )
	showBeginningGui ()
	
	showCursor ( true )
end
--addEvent ( "setPlayerInTutorial", true )
--addEventHandler ( "setPlayerInTutorial", getRootElement(), setPlayerInTutorial_func )

function showTutCursor ()

	if isCursorShowing() and not activeGui then
		showCursor ( false )
	elseif not isCursorShowing() then
		showCursor ( true )
	end
end

function showBeginningGui ()

	for i = 1, 35 do outputChatBox ( "" ) end
	gWindow["tutorialWindow"] = guiCreateWindow ( screenwidth/2-223/2, screenheight/2-276/2, 223, 276, "Tutorial", false )
	guiSetAlpha(gWindow["tutorialWindow"],1)
	guiWindowSetMovable(gWindow["tutorialWindow"],false)
	guiWindowSetSizable(gWindow["tutorialWindow"],false)
	gImage["at400Image"] = guiCreateStaticImage(0.0942,0.0978,0.843,0.3007,"images/at400.jpg",true,gWindow["tutorialWindow"])
	guiSetAlpha(gImage["at400Image"],1)
	gLabel["tutorialText1"] = guiCreateLabel(0.0359,0.4638,0.9372,0.3043,"Herzlich wilkommen in San Andreas!\nDein Flugzeug ist soeben\nam San Fierro International\nAirport gelandet - am besten\nfragst du beim Personal nach\ndeinem Koffer!",true,gWindow["tutorialWindow"])
	guiSetAlpha(gLabel["tutorialText1"],1)
	guiLabelSetColor(gLabel["tutorialText1"],200,200,000)
	guiLabelSetVerticalAlign(gLabel["tutorialText1"],"top")
	guiLabelSetHorizontalAlign(gLabel["tutorialText1"],"left",false)
	guiSetFont(gLabel["tutorialText1"],"default-bold-small")
	gButton["goAhead"] = guiCreateButton(0.2377,0.7935,0.5157,0.1522,"Fortsetzen",true,gWindow["tutorialWindow"])
	guiSetAlpha(gButton["goAhead"],1)
	addEventHandler("onClientGUIClick", gButton["goAhead"],
		function ()
			guiSetVisible ( gWindow["tutorialWindow"], false )
			showCursor ( false )
			activeGui = false
			tutMarker1 = createMarker ( -1876.4082, 50.1959, 1055.488, "arrow", 1, getColorFromString ( "#E3FF0099" ) )
			setArrowMoving ( tutMarker1 )
			setElementInterior ( tutMarker1, 14 )
			addEventHandler ( "onClientMarkerHit", tutMarker1, showTutIntel1 )
			for i = 1, 35 do outputChatBox ( "" ) end
			outputChatBox ( "Begib dich zum Personal und frage nach deinem Koffer!", 200, 200, 0 )
		end
	)
	activeGui = true
end

function setArrowMoving ( arrow, x, y, z )

	if isElement ( arrow ) then
		if not x then
			x, y, z = getElementPosition ( arrow )
		end
		for i = 1, 10 do
			setTimer ( setElementPosition, 500 + 50 * i, 1, arrow, x, y, z + i * 0.01 )
			setTimer ( setElementPosition, 1050 + 50 * i, 1, arrow, x, y, z + 0.1 - i * 0.01 )
		end
		
		setTimer ( setArrowMoving, 1050, 1, arrow, x, y, z )
	end
end

function showTutIntel1 ()

	destroyElement ( tutMarker1 )
	local x, y, z = getElementPosition ( lp )
	setElementAlpha ( lp, 0 )
	setCameraMatrix ( x, y, 1055.5, -1876.4310302734, 48.805534362793, 1055.5, 0, 0 )
	showClickGuiInfo ()
end

function showClickGuiInfo ()

	setPedAnimation ( secruity, "ped", "IDLE_chat", -1, true, true, true )
	showCursor ( true )
	activeGui = true
	gWindow["tutorialWindow1"] = guiCreateWindow(screenwidth/2-246/2, screenheight/2-217/2,246,217,"Tutorial",false)
	guiSetAlpha(gWindow["tutorialWindow1"],1)
	gLabel["tutorialText2"] = guiCreateLabel(0.0366,0.4332,0.9309,0.3364,"Du kannst mit bestimmten Objekten\ninteragieren, in dem du sie anklickst.\nDazu druecke die ALT-GR-Taste ( Neben\nder Leertaste ), und ein Mauszeiger\nerscheint.",true,gWindow["tutorialWindow1"])
	guiSetAlpha(gLabel["tutorialText2"],1)
	guiLabelSetColor(gLabel["tutorialText2"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["tutorialText2"],"top")
	guiLabelSetHorizontalAlign(gLabel["tutorialText2"],"left",false)
	guiSetFont(gLabel["tutorialText2"],"default-bold-small")
	gLabel["tutorialText3"] = guiCreateLabel(0.0447,0.129,0.8984,0.2857,"Clicksystem",true,gWindow["tutorialWindow1"])
	guiSetAlpha(gLabel["tutorialText3"],1)
	guiLabelSetColor(gLabel["tutorialText3"],125,000,000)
	guiLabelSetVerticalAlign(gLabel["tutorialText3"],"top")
	guiLabelSetHorizontalAlign(gLabel["tutorialText3"],"left",false)
	guiSetFont(gLabel["tutorialText3"],"sa-header")
	gButton["tutBtn2"] = guiCreateButton(0.3211,0.7696,0.3374,0.1659,"Fortsetzen",true,gWindow["tutorialWindow1"])
	guiSetAlpha(gButton["tutBtn2"],1)
	addEventHandler("onClientGUIClick", gButton["tutBtn2"],
		function ()
			guiSetVisible ( gWindow["tutorialWindow1"], false )
			showCursor ( false )
			activeGui = false
			tutMarker2 = createMarker ( -1867.8538, 60.9195, 1056.2336, "arrow", 1, getColorFromString ( "#E3FF0099" ) )
			setArrowMoving ( tutMarker2 )
			setElementInterior ( tutMarker2, 14 )
			setElementAlpha ( lp, 255 )
			setPedAnimation ( secruity )
			setCameraTarget ( lp )
			bindKey ( "ralt", "down", showTutCursor )
			bindKey ( "m", "down", showTutCursor )
			for i = 1, 35 do outputChatBox ( "" ) end
			outputChatBox ( "Begib dich zu deinem Koffer, druecke ALT-GR oder M und klicke ihn an!", 200, 200, 0 )
			addEventHandler ( "onClientClick", getRootElement(), tutorialClickCase )
		end
	)
end

function tutorialClickCase ( btn, state, x, y, wx, wy, wz, element )

	if element == case then
		removeEventHandler ( "onClientClick", getRootElement(), tutorialClickCase )
		showInventarGuiInfo ()
	end
end

function showInventarGuiInfo ()

	showCursor ( true )
	activeGui = true
	
	destroyElement ( case )
	
	gWindow["tutInfo3"] = guiCreateWindow(screenwidth/2-254/2, screenheight/2-231/2,254,231,"Tutorial",false)
	guiSetAlpha(gWindow["tutInfo3"],1)
	gLabel["tutorialText4"] = guiCreateLabel(0.2362,0.1212,0.7126,0.2814,"Inventar",true,gWindow["tutInfo3"])
	guiSetAlpha(gLabel["tutorialText4"],1)
	guiLabelSetColor(gLabel["tutorialText4"],000,150,000)
	guiLabelSetVerticalAlign(gLabel["tutorialText4"],"top")
	guiLabelSetHorizontalAlign(gLabel["tutorialText4"],"left",false)
	guiSetFont(gLabel["tutorialText4"],"sa-header")
	gLabel["tutorialText5"] = guiCreateLabel(0.0433,0.329,0.9173,0.3723,"Alle Gegenstaende, die du hier erhaelst,\nwerden in deinem Inventar gelagert.\nDruecke die i-Taste, um es aufzurufen.\n\nItems sind z.b.: Nahrung, Drogen oder\nauch Benzinkanister.",true,gWindow["tutInfo3"])
	guiSetAlpha(gLabel["tutorialText5"],1)
	guiLabelSetColor(gLabel["tutorialText5"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["tutorialText5"],"top")
	guiLabelSetHorizontalAlign(gLabel["tutorialText5"],"left",false)
	guiSetFont(gLabel["tutorialText5"],"default-bold-small")
	gButton["tutBtn3"] = guiCreateButton(0.2598,0.7316,0.4449,0.1905,"Fortsetzen",true,gWindow["tutInfo3"])
	guiSetAlpha(gButton["tutBtn3"],1)
	destroyElement ( tutMarker2 )
	addEventHandler("onClientGUIClick", gButton["tutBtn3"],
		function ()
			guiSetVisible ( gWindow["tutInfo3"], false )
			showCursor ( false )
			activeGui = false
			unbindKey ( "ralt", "down", showTutCursor )
			unbindKey ( "m", "down", showTutCursor )
			removeEventHandler ( "onClientClick", getRootElement(), tutorialClickCase )
			for i = 1, 35 do outputChatBox ( "" ) end
			outputChatBox ( "Verlasse nun den Flughafen.", 200, 200, 0 )
			
			tutMarker3 = createMarker ( -1855.8928222656, 42.833137512207, 1055.1896972656, "checkpoint", 2, getColorFromString ( "#FF000099" ) )
			setElementInterior ( tutMarker3, 14 )
			addEventHandler ( "onClientMarkerHit", tutMarker3, showLastIntel )
		end
	)
end

function showLastIntel ()

	showCursor ( true )
	gWindow["Tutorial4"] = guiCreateWindow(screenwidth/2-300/2,screenheight/2-400/2,300,400,"Tutorial",false)
	guiSetAlpha(gWindow["Tutorial4"],1)
	gLabel["tutorialText6"] = guiCreateLabel(19,19,200,200,"Hunger &\n   Anzeigen",false,gWindow["Tutorial4"])
	guiSetAlpha(gLabel["tutorialText6"],1)
	guiLabelSetColor(gLabel["tutorialText6"],000,150,000)
	guiLabelSetVerticalAlign(gLabel["tutorialText6"],"top")
	guiLabelSetHorizontalAlign(gLabel["tutorialText6"],"left",false)
	guiSetFont(gLabel["tutorialText6"],"sa-header")
	gLabel["tutorialText7"] = guiCreateLabel(0.0593,0.4367,0.8941,0.3354,"Deine Anzeigen ( HP, Waffen oder\nauch Hunger ) kannst du mit der\nB-Taste einblenden.\nWenn du nichts isst, und dein\nHunger zu gross wird, faengst du an,\nan Energie zu verlieren.\nDeinen Hunger kannst du mit Snacks\noder im Restaurant stillen.",true,gWindow["Tutorial4"])
	guiSetAlpha(gLabel["tutorialText7"],1)
	guiLabelSetColor(gLabel["tutorialText7"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["tutorialText7"],"top")
	guiLabelSetHorizontalAlign(gLabel["tutorialText7"],"left",false)
	guiSetFont(gLabel["tutorialText7"],"default-bold-small")
	gButton["tutBtn4"] = guiCreateButton(0.2034,0.807,0.572,0.1519,"Fortfahren",true,gWindow["Tutorial4"])
	guiSetAlpha(gButton["tutBtn4"],1)
	addEventHandler("onClientGUIClick", gButton["tutBtn4"],
		function ()
			guiSetVisible ( gWindow["Tutorial4"], false )
			destroyElement ( tutMarker3 )
			showCursor ( false )
			for i = 1, 35 do outputChatBox ( "" ) end
			triggerServerEvent ( "gameBeginGuiShow", lp, lp )
			tutorial = nil
			setElementInterior ( lp, 0 )
		end
	)
end