addEvent ( "starttutorial", true )

local skin
local tutsound
local dimension
local objects = {}
local peds = {}
local vehicles = {}
local choicegui = {}
local screenX, screenY = guiGetScreenSize()
local progress = 0
local safetyquestion = nil
local registersound = nil


function startTutorial ( skinid )
	fadeCamera ( false )
	setTimer ( tutintro, 2000, 1 )
	skin = skinid
	dimension = getElementDimension ( localPlayer )
end
addEventHandler ( "starttutorial", root, startTutorial )


function tutintro ( )
	slowDrawText ( "Auf der Flucht    \nund der Suche    \nnach einer zweiten Chance." )
	setTimer ( scene1, 6000, 1 )
	objects[1] = createObject ( 1455, -3351, 150, 0 )
	setElementAlpha ( objects[1], 0 )
	setElementCollisionsEnabled ( objects[1], false )
	objects[2] = createObject ( 1455, -3351, 180, 5 )
	setElementAlpha ( objects[2], 0 )
	setElementCollisionsEnabled ( objects[2], false )
	vehicles[1] = createVehicle ( 473, -3380, 150, 0, 0, 0, 270 )
	vehicles[2] = createVehicle ( 605, -2813.56, 153.144, 6.9, 0, 0, 181 )
	peds[1] = createPed ( 58, -3400, 150, 0, 270 )
	warpPedIntoVehicle ( peds[1], vehicles[1] )
	peds[2] = createPed ( 19, -3400, 140, 0, 270 )
	attachElements ( peds[2], vehicles[1], -0.6, -0.2, 1, 0, 160 )
	setPedAnimation ( peds[2], "BEACH", "ParkSit_M_loop" ) 
	peds[3] = createPed ( 26, -3400, 140, 0, 270 )
	attachElements ( peds[3], vehicles[1], -0.6, -0.2, 1, 0, 160 )
	setPedAnimation ( peds[3], "BEACH", "ParkSit_M_loop" ) 
	peds[4] = createPed ( 130, -3400, 140, 0, 270 )
	attachElements ( peds[4], vehicles[1], 0.6, -1.2, 1, 0, 160 )
	setPedAnimation ( peds[4], "BEACH", "ParkSit_M_loop" ) 
	peds[5] = createPed ( skin, -3400, 140, 0, 270 )
	attachElements ( peds[5], vehicles[1], 0.6, -1.2, 1, 0, 160 )  
	setPedAnimation ( peds[5], "BEACH", "ParkSit_M_loop" ) 
	peds[6] = createPed ( 15, -2907.9, 156.23, 4.613, 90 )
	setPedAnimation ( peds[6], "ON_LOOKERS", "wave_loop" )
	setElementFrozen ( peds[6], true )
	local allvehicle = getElementsByType ( "vehicle" )
	for i=1, #allvehicle do
		setElementCollidableWith ( vehicles[2], allvehicle[i], false )
	end
	local allplayer = getElementsByType ( "player" )
	for i=1, #allplayer do
		setElementCollidableWith ( vehicles[2], allplayer[i], false )
	end
	for i=1, #peds do
		setElementCollidableWith ( vehicles[2], peds[i], false )
	end
end


function scene1 ( )
	tutsound = playSound ( "sounds/tutsound.mp3" ) 
	setSoundVolume ( tutsound, 0.6 )
	addEventHandler ( "onClientSoundStopped", tutsound, scene2 )
	setPedControlState ( peds[1], "accelerate", true )
	fadeCamera ( true )
	followElementWithElement ( objects[2], objects[1] )
	setTimer ( scene1follow, 1800, 1 )
end


function scene1follow ( )
	moveObject ( objects[1], 7000, -3310, 150, 5 )
	moveObject ( objects[2], 4000, -3351, 170, 5 )
	setTimer ( scene1fly, 6000, 1 )
end


function scene1fly ( )
	moveObject ( objects[1], 24000, -2000, 140, 30 )
	moveObject ( objects[2], 30000, -2020, 250, 70 )
	setTimer ( showScene1Logo, 30500, 1 )
end 


function showScene1Logo ( )
	addEventHandler ( "onClientRender", root, showTutUltimate )
	setElementDimension ( objects[1], dimension )
	setElementDimension ( objects[2], dimension )
	for i=1, #peds do
		detachElements ( peds[i] )
	end
	setPedControlState ( peds[1], "accelerate", false )
	setElementPosition ( vehicles[1], -2929.62, 156.1, 0.75 )
	setPedAnimation ( peds[6] )
	setElementPosition ( peds[5], -2908.9, 156.23, 5.12 )
	setElementRotation ( peds[5], 0, 0, 270 )
end


function showTutUltimate ( )
	dxDrawText ( "Ultimate Reallife", 0, 0, screenX, screenY, tocolor ( 25, 96, 178 ), 8, "pricedown", "center", "center", false, true, true )
end


function scene2 ( )
	removeEventHandler ( "onClientRender", root, showTutUltimate ) 
	setElementPosition ( objects[2], -2913.3, 156.23, 3.27 ) 
	setElementPosition ( objects[1], -2911.3, 156.23, 4.47 ) 
	moveObject ( objects[2], 5000, -2910.9, 156.23, 5.47 ) 
	moveObject ( objects[1], 5000, -2908.9, 156.23, 5.17 ) 
	setPedAnimation ( peds[5] )
	setPedAnimation ( peds[3] )
	setElementPosition ( peds[3], -2907.9, 154.23, 4.613 )
	setElementRotation ( peds[3], 0, 0, 270 )
	setElementPosition ( peds[2], -2905.9, 158.23, 4.713 )
	setElementRotation ( peds[2], 0, 0, 90 )
	setPedAnimation ( peds[6], "MISC", "Idle_Chat_02" )
	setTimer ( scene2Talk, 5500, 1 )
end


function scene2Talk ( )
	progress = 0
	addEventHandler ( "onClientRender", root, showIfYouWantTut )
end


function showIfYouWantTut ( )
	local x, y, z = getPedBonePosition ( peds[6], 8 )
	local xScreen, yScreen = getScreenFromWorldPosition ( x, y, z+0.3 )
	local text = ""
	if progress <= 200 then
		text = "Willkommen in San Fierro!"
	elseif progress <= 400 then
		text = "Ich bin auch erst\nvor wenigen Jahren hierher geflüchtet."
	elseif progress <= 600 then
		text = "Daher weiß ich, wie es\nist hier neu zu sein."
	elseif progress <= 800 then
		text = "Oder wie hart die Flucht\nvor dem Krieg war."
	elseif progress <= 1000 then
		text = "Gleich zeige ich den\nLeuten hier alle wichtigen Orte."
	else
		text = "Willst du bei der Tour mitmachen?"
	end
	if safetyquestion then
		text = "Bist du dir sicher?"
	end
	if progress == 1150 then
		showCursor ( true )
		choicegui[1] = guiCreateButton ( 0, 0, 0.5, 1, "", true )
		choicegui[2] = guiCreateButton ( 0.5, 0, 1, 1, "", true )
		guiSetAlpha ( choicegui[1], 0 )
		guiSetAlpha ( choicegui[2], 0 )
		addEventHandler ( "onClientGUIClick", choicegui[1], clickOnTutChoice )
		addEventHandler ( "onClientGUIClick", choicegui[2], clickOnTutChoice )
		setPedAnimation ( peds[6] )
	end
	if progress >= 1150 then
		local xm = getCursorPosition()
		dxDrawText ( xm < 0.5 and "Ja" or "Nein", 0, screenY*0.05, screenX, screenY*0.1, tocolor ( 255, 255, 255 ), 3, "default", "center", "center", false, false, true )
		dxDrawRectangle ( 0, 0, 0.5*screenX, screenY, tocolor ( 0, 255, 0, 5 ), false )
		dxDrawRectangle ( 0.5*screenX, 0, screenX, screenY, tocolor ( 255, 0, 0, 5 ), false )
	end
	dxDrawText ( text, xScreen+1, yScreen, xScreen+1, yScreen, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, xScreen+1, yScreen+1, xScreen+1, yScreen+1, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, xScreen, yScreen+1, xScreen, yScreen+1, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, xScreen, yScreen, xScreen, yScreen, tocolor ( 255, 255, 255 ), 3, "default", "center", "center", false, false, true )
	progress = progress + 1
end


function clickOnTutChoice ( button, state, x, y )
	if button == "left" and state == "up" then
		if x < screenX*0.5 then
			if safetyquestion == 1 then
				showTutorialImportantPlaces()
			elseif safetyquestion == 2 then
				setTimer ( endtutorial, 2000, 1 )
				fadeCamera ( false )
			else
				safetyquestion = 1
			end
		else
			if safetyquestion then
				safetyquestion = nil
			else
				safetyquestion = 2 
			end
			return 
		end
		destroyElement ( choicegui[1] )
		destroyElement ( choicegui[2] )
		showCursor ( false )
		removeEventHandler ( "onClientRender", root, showIfYouWantTut )
	end
end



function showTutorialImportantPlaces ( )
	registersound = playSound ( "sounds/registermusik.mp3" )
	setSoundVolume ( registersound, 0.3 )
	setElementPosition ( peds[5], -2814.56, 153.144, 6.87 )
	setElementRotation ( peds[5], 0, 0, 180 )
	warpPedIntoVehicle ( peds[2], vehicles[2], 1 )
	warpPedIntoVehicle ( peds[6], vehicles[2] )
	attachElements ( peds[3], vehicles[2], -0.5, -0.9, 0.8, 0, 0, 90 )
	attachElements ( peds[5], vehicles[2], 0.5, -0.9, 0.8, 0, 0, 270 )
	attachElements ( objects[1], vehicles[2] )
	attachElements ( objects[2], vehicles[2], 0, -10, 3 )
	setPedAnimation ( peds[3], "BEACH", "ParkSit_M_loop" ) 
	setPedAnimation ( peds[5], "BEACH", "ParkSit_M_loop" ) 
	setTimer ( tutorialStartTheCarFirst, 2000, 1 )
	fadeCamera ( false, 4 )
end 


function tutorialStartTheCarFirst ( )
	setPedControlState ( peds[6], "accelerate", true )
	setTimer ( tutorialFadeCameraForFirstPlace, 3000, 1 )
end


function tutorialFadeCameraForFirstPlace ( )
	setPedControlState ( peds[6], "accelerate", false )
	setElementPosition ( vehicles[2], -2751.805, 407.687, 3.932 )
	setElementRotation ( vehicles[2], 0, 0, 180 )
	fadeCamera ( true )
	setTimer ( tutorialShowFirstPlace, 3500, 1 )
end


function tutorialShowFirstPlace ( )
	detachElements ( objects[1] )
	setElementPosition ( objects[1], -2751.7802734375, 374.80633544922, 3.9852495193481 )
	detachElements ( objects[2] )
	setElementPosition ( objects[2], -2751.7802734375, 384.80633544922, 6.9852495193481 )
	moveObject ( objects[1], 3000, -2761.7802734375, 378.80633544922, 6.9852495193481 )
	progress = 0
	addEventHandler ( "onClientRender", root, tutorialDrawFirstPlaceText )
end


function tutorialDrawFirstPlaceText ( )
	local text = ""
	if progress <= 200 then
		text = "Hier ist die Stadthalle\nbzw. das Rathaus"
	elseif progress <= 400 then
		text = "Sie ist das Herzstück\ndieser kleinen Stadt."
	elseif progress <= 600 then
		text = "Falls du Lizenzen oder Scheine brauchst,\nkannst du sie hier bekommen."
	elseif progress <= 800 then
		text = "Außerdem kannst du hier\ndie Erlaubnis für mehr Fahrzeuge\nerkaufen oder alle Jobs sehen."
	end
	if progress == 700 then
		local x, y, z = getElementPosition ( objects[1] )
		moveObject ( objects[1], 3000, x+20, y, z )
	end
	if progress == 1000 then
		removeEventHandler ( "onClientRender", root, tutorialDrawFirstPlaceText )
		attachElements ( objects[1], vehicles[2] )
		attachElements ( objects[2], vehicles[2], 0, -10, 3 )
		setTimer ( tutorialStartTheCarSecond, 2000, 1 )
		fadeCamera ( false, 4 )
	end
	dxDrawText ( text, screenX/2+1, screenY/3+1, screenX/2+1, screenY/3+1, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2+1, screenY/3, screenX/2+1, screenY/3, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2, screenY/3+1, screenX/2, screenY/3+1, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2, screenY/3, screenX/2, screenY/3, tocolor ( 255, 255, 255 ), 3, "default", "center", "center", false, false, true )  
	progress = progress + 1
end


function tutorialStartTheCarSecond ( )
	setPedControlState ( peds[6], "accelerate", true )
	setTimer ( tutorialStartSecondPlace, 3000, 1 )
end


function tutorialStartSecondPlace ( )
	setPedControlState ( peds[6], "accelerate", false )
	setElementPosition ( vehicles[2], -2009.278, 199.189, 27.305832 )
	setElementRotation ( vehicles[2], 0, 0, 180 )
	fadeCamera ( true )
	setTimer ( tutorialShowSecondPlace, 3500, 1 )
end


function tutorialShowSecondPlace ( )
	detachElements ( objects[1] )
	setElementPosition ( objects[1], -2009.2779541016, 150.17945861816, 27.377531051636 )
	detachElements ( objects[2] )
	setElementPosition ( objects[2], -2009.2779541016, 160.17945861816, 30.377531051636 )
	moveObject ( objects[1], 3000, -1999.2779541016, 154.17945861816, 30.377531051636 )
	progress = 0
	addEventHandler ( "onClientRender", root, tutorialDrawSecondPlaceText )
end


function tutorialDrawSecondPlaceText ( )
	local text = ""
	if progress <= 200 then
		text = "Das ist der Treffpunkt\nder Bürger von SF."
	elseif progress <= 400 then
		text = "Es ist der Bahnhof\nvon San Fierro."
	elseif progress <= 600 then
		text = "Hier halten sich\ndie meisten auf.\nDaher ist hier das meiste los."
	elseif progress <= 800 then
		text = "Komm also her,\nwenn du dich mit\nanderen Leuten unterhalten willst."
	end
	if progress == 700 then
		local x, y, z = getElementPosition ( objects[1] )
		moveObject ( objects[1], 3000, x-20, y, z )
	end
	if progress == 1000 then
		removeEventHandler ( "onClientRender", root, tutorialDrawSecondPlaceText )
		attachElements ( objects[1], vehicles[2] )
		attachElements ( objects[2], vehicles[2], 0, -10, 3 )
		setTimer ( tutorialStartTheCarThird, 2000, 1 )
		fadeCamera ( false, 4 )
	end
	dxDrawText ( text, screenX/2+1, screenY/3+1, screenX/2+1, screenY/3+1, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2+1, screenY/3, screenX/2+1, screenY/3, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2, screenY/3+1, screenX/2, screenY/3+1, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2, screenY/3, screenX/2, screenY/3, tocolor ( 255, 255, 255 ), 3, "default", "center", "center", false, false, true )  
	progress = progress + 1
end


function tutorialStartTheCarThird ( )
	setPedControlState ( peds[6], "accelerate", true )
	setTimer ( tutorialStartThirdPlace, 3000, 1 )
end


function tutorialStartThirdPlace ( )
	setPedControlState ( peds[6], "accelerate", false )
	setElementPosition ( vehicles[2], -1583.587, 736.078, 8 )
	setElementRotation ( vehicles[2], 0, 0, 90 )
	setElementFrozen ( vehicles[2], true )
	fadeCamera ( true )
	setTimer ( tutorialShowThirdPlace, 3500, 1 )
end


function tutorialShowThirdPlace ( )
	detachElements ( objects[1] )
	setElementPosition ( objects[1], -1583.3830566406, 740.07946777344, 7.6930375099182 )
	detachElements ( objects[2] )
	setElementPosition ( objects[2], -1579.3830566406, 740.07946777344, 10.6930375099182 )
	moveObject ( objects[1], 3000, -1587.3830566406, 730.07946777344, 11.6930375099182 )
	progress = 0
	addEventHandler ( "onClientRender", root, tutorialDrawThirdPlaceText )
end


function tutorialDrawThirdPlaceText ( )
	local text = ""
	if progress <= 150 then
		text = "Das ist das\nPolice Department."
	elseif progress <= 300 then
		text = "Es ist die Hauptbasis\nder Polizisten."
	elseif progress <= 450 then
		text = "Falls du gesucht wirst\nkannst du dich hier stellen."
	elseif progress <= 600 then
		text = "In und außerhalb San Fierro\ngibt es noch viele Basen ..."
	elseif progress <= 800 then
		text = "Da wäre die\nBasis des FBI"
	elseif progress <= 1000 then
		text = "oder die Area51,\nBasis der Army"
	elseif progress <= 1100 then
		text = "Die Basis der Triaden,\nder chinesischen Mafia."
	elseif progress <= 1200 then
		text = "Die italienische Mafia\nCosa Nostra."
	elseif progress <= 1300 then
		text = "Angels of Death,\nBiker"
	elseif progress <= 1400 then
		text = "Grove Street"
	elseif progress <= 1500 then
		text = "Mexikanische Mafia\nLos Aztecas."
	elseif progress <= 1600 then
		text = "Ballas"
	elseif progress <= 1700 then
		text = "Mechaniker"
	elseif progress <= 1800 then
		text = "Medic"
	elseif progress <= 1900 then
		text = "und zuletzt Reporter"
	end
	if progress == 600 then
		setElementPosition ( objects[1], -2392.37, 496.68, 33.48 )
		setElementPosition ( objects[2], -2388.055, 495.03, 34.563 )
	elseif progress == 800 then
		setElementPosition ( objects[1], 80.8246, 1922.54895, 38.95 )
		setElementPosition ( objects[2], 49.8246, 1922.54895, 40.86 )
	elseif progress == 1000 then
		setElementPosition ( objects[1], -2268.18, 650.44, 49.1 )
		setElementPosition ( objects[2], -2270.35864, 652.45, 49.06 )
	elseif progress == 1100 then
		setElementPosition ( objects[1], -735.806, 982.2967, 25.442 )
		setElementPosition ( objects[2], -741.68, 987.0436, 27.8 )
	elseif progress == 1200 then
		setElementPosition ( objects[1], -2203.665, -2373.256347, 50.4415 )
		setElementPosition ( objects[2], -2202.576, -2379.777, 53.677 )
	elseif progress == 1300 then
		setElementPosition ( objects[1], -2492.59497, -130, 40.8 )
		setElementPosition ( objects[2], -2525.766357, -130, 44.2 )
	elseif progress == 1400 then
		setElementPosition ( objects[1], -1245.434, 2479.83, 109.4 )
		setElementPosition ( objects[2], -1232.8033, 2474.05, 111.73 )
	elseif progress == 1500 then
		setElementPosition ( objects[1], -2208, 20, 52.41 )
		setElementPosition ( objects[2], -2208, 10, 53.41 )
	elseif progress == 1600 then
		setElementPosition ( objects[1], -2352.78, -108.52, 50.43 )
		setElementPosition ( objects[2], -2348.98, -103.6846, 51.455 )
	elseif progress == 1700 then
		setElementPosition ( objects[1], -2607.223, 587.654, 23.21 )
		setElementPosition ( objects[2], -2603.1, 584.95, 23.86 )
	elseif progress == 1800 then
		setElementPosition ( objects[1], -2474.964, -595.31, 141.77 )
		setElementPosition ( objects[2], -2467.79, -591.1854, 143.3886 )	
	elseif progress == 1900 then
		removeEventHandler ( "onClientRender", root, tutorialDrawThirdPlaceText )
		attachElements ( objects[1], vehicles[2] )
		attachElements ( objects[2], vehicles[2], 0, -10, 3 )
		setTimer ( tutorialStartTheCarFourth, 2000, 1 )
		setElementFrozen ( vehicles[2], false )
		fadeCamera ( false, 4 )
	end
	dxDrawText ( text, screenX/2+1, screenY/3+1, screenX/2+1, screenY/3+1, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2+1, screenY/3, screenX/2+1, screenY/3, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2, screenY/3+1, screenX/2, screenY/3+1, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2, screenY/3, screenX/2, screenY/3, tocolor ( 255, 255, 255 ), 3, "default", "center", "center", false, false, true )  
	progress = progress + 1
end


function tutorialStartTheCarFourth ( )
	setPedControlState ( peds[6], "accelerate", true )
	setTimer ( tutorialStartFourthPlace, 3000, 1 )
end


function tutorialStartFourthPlace ( )
	setPedControlState ( peds[6], "accelerate", false )
	setElementPosition ( vehicles[2], -2009.2779541016, 196.17945861816, 27.377531051636 )
	setElementRotation ( vehicles[2], 0, 0, 180 )
	setElementFrozen ( vehicles[2], true )
	fadeCamera ( true )
	setTimer ( tutorialShowFourthPlace, 3500, 1 )
end


function tutorialShowFourthPlace ( )
	progress = 0
	addEventHandler ( "onClientRender", root, tutorialDrawFourthPlaceText )
end


function tutorialDrawFourthPlaceText ( )
	local text = ""
	if progress <= 200 then
		text = "Das war es mit der Tour."
	elseif progress <= 400 then
		text = "Bevor ihr geht noch\nein paar Geschenke."
	elseif progress <= 600 then
		text = "Hier, eine Karte für euch."
	elseif progress <= 800 then
		text = "Damit wisst ihr immer, wo ihr seid und wo etwas ist."
	elseif progress <= 1100 then
		text = "Außerdem gebe ich noch etwas Geld mit."
	elseif progress <= 1300 then
		text = "Wir sehen uns hoffentlich bald wieder."	
	end
	if progress == 400 then
		setPlayerHudComponentVisible ( "radar", true )
	elseif progress == 420 then
		setPlayerHudComponentVisible ( "radar", false )
	elseif progress == 440 then
		setPlayerHudComponentVisible ( "radar", true )
	elseif progress == 460 then
		setPlayerHudComponentVisible ( "radar", false )
	elseif progress == 480 then
		setPlayerHudComponentVisible ( "radar", true )
	elseif progress == 500 then
		setPlayerHudComponentVisible ( "radar", false )
	elseif progress == 520 then
		setPlayerHudComponentVisible ( "radar", true )
	elseif progress == 540 then
		setPlayerHudComponentVisible ( "radar", false )
	elseif progress == 560 then
		setPlayerHudComponentVisible ( "radar", true )
	elseif progress == 580 then
		setPlayerHudComponentVisible ( "radar", false )
	elseif progress == 600 then
		setPlayerHudComponentVisible ( "radar", true )
	elseif progress == 620 then
		setPlayerHudComponentVisible ( "radar", false )
	elseif progress == 640 then
		setPlayerHudComponentVisible ( "radar", true )
	elseif progress == 660 then
		setPlayerHudComponentVisible ( "radar", false )
	elseif progress == 680 then
		setPlayerHudComponentVisible ( "radar", true )
	elseif progress == 1200 then
		triggerServerEvent ( "setPlayerTutorialMoney", lp )
	elseif progress == 1300 then
		fadeCamera ( false )
		setTimer ( endtutorial, 2000, 1 )
	end
	dxDrawText ( text, screenX/2+1, screenY/3+1, screenX/2+1, screenY/3+1, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2+1, screenY/3, screenX/2+1, screenY/3, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2, screenY/3+1, screenX/2, screenY/3+1, tocolor ( 0, 0, 0 ), 3, "default", "center", "center", false, false, true )
	dxDrawText ( text, screenX/2, screenY/3, screenX/2, screenY/3, tocolor ( 255, 255, 255 ), 3, "default", "center", "center", false, false, true )  
	progress = progress + 1
end

-- Rathaus: -2751.7802734375 369.80633544922 3.9852495193481
-- Bahnhof: -2009.2779541016 196.17945861816 27.377531051636
-- PD: -1583.3830566406 736.07946777344 7.6930375099182

function endtutorial ( )
	setCameraTarget ( localPlayer )
	for _, v in pairs ( objects ) do
		destroyElement ( v ) 
	end
	for _, v in pairs ( peds ) do
		destroyElement ( v ) 
	end
	for _, v in pairs ( vehicles ) do
		destroyElement ( v ) 
	end
	for _, v in pairs ( choicegui ) do
		if isElement ( v ) then
			destroyElement ( v )
		end
	end
	fadeCamera ( true )
	stopSound ( registersound )
	bindKey ("b", "down", showOtherHud)
	setPlayerHudComponentVisible ( "all", true )
	showOtherHud ()
	triggerServerEvent ( "tutorialended", localPlayer )
end




