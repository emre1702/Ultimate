-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

mothership = createVehicle ( 483, -1111.3237304688, -1681.3969726563, 76.469535827637, 0, 0, 94 )
setVehiclePaintjob ( mothership, 0 )
setVehicleColor ( mothership, 1, 1, 1, 1 )
setVehicleDamageProof ( mothership, true )
setVehicleDoorsUndamageable ( mothership, true )
setVehicleLocked ( mothership, true )
setElementData ( mothership, "owner", "console", false )

TheTruthBlip = createBlip ( -1111.3237304688, -1681.3969726563, 76.469535827637, 40, 2, 255, 0, 0, 255, 0, 200 )
TheTruthMarker = createMarker ( -1112.7618408203, -1683.4317626953, 74.919799804688, "cylinder", 1, 255, 20, 20, 175 )

function TheTruthMarkerHit ( hit, dim )

	if hit == getLocalPlayer() and dim then
		if not getPedOccupiedVehicle ( getLocalPlayer() ) then
			showChat ( false )
			screenWidth, screenHeight = guiGetScreenSize()
			toggleAllControls ( false )
			setElementPosition ( getLocalPlayer(), -1113.1279296875, -1683, 76.02 )
			setPedRotation ( getLocalPlayer(), 0 )
			fadeCamera ( false, 1, 0, 0, 0 )
			triggerServerEvent ( "dimensionFixArea51", getLocalPlayer(), getLocalPlayer() )
			setElementDimension ( mothership, tonumber ( vioClientGetElementData( "playerid" ) ) + 1 )
			setElementPosition ( mothership, -1111.3237304688, -1681.3969726563, 76.469535827637 )
			setTimer ( showMissionBriefing, 5000, 1 )
			MissionName = "The Truth is out there!"
			addEventHandler("onClientRender",getRootElement(), createMissionName)
			setPlayerHudComponentVisible ( "radar", false )
		end
	end
end
addEventHandler ( "onClientMarkerHit", TheTruthMarker, TheTruthMarkerHit )

function showMissionBriefing ()
	fadeCamera ( true, 1 )
	TheTruth = createPed ( 166, -1110.2340087891, -1682.6223144531, 76.023162841797 )
	setPedRotation ( TheTruth, 180 )
	setTimer ( briefingStep1, 300, 1 )
	setElementDimension ( TheTruth, tonumber ( vioClientGetElementData("playerid" ) ) + 1 )
	setCameraMatrix ( -1107.5256347656, -1689.1846923828, 76.0, getElementPosition ( mothership ) )
end
function briefingStep1 ()
	removeEventHandler("onClientRender",getRootElement(), createMissionName)
	setPedAnimation( TheTruth, "smoking", "M_smklean_loop",-1,true,false,true)
	setTimer ( killTruthBotAnimation, 1500, 1 )
	setTimer ( briefingStep2, 500, 1 )
end
function briefingStep2 ()
	setPedAnimation ( getLocalPlayer(), "COP_AMBIENT", "Coplook_watch" )
	setTimer ( briefingStep3, 1000, 1 )
end
function briefingStep3 ()
	setPedAnimation ( getLocalPlayer() )
	local x1, y1, z1 = getElementPosition ( getLocalPlayer() )
	local x2, y2, z2 = getElementPosition ( getLocalPlayer() )
	setPedRotation ( getLocalPlayer(), findRotation(x1,y1,-1110,-1684) )
	setPedAnimation ( getLocalPlayer(), "ped", "WALK_civi" )
	setTimer ( briefingStep4, 2000, 1 )
end
function killTruthBotAnimation ()
	setPedAnimation ( TheTruth )
	setPedAnimation( TheTruth, "smoking", "M_smklean_loop",-1,true,false,true)
end
function briefingStep4 ()
	setPedAnimation ( getLocalPlayer() )
	local rotDiff = getPedRotation ( getLocalPlayer() ) - getPedRotation ( TheTruth )
	setTimer ( briefingStep5, 50, 10, rotDiff )
	setTimer ( briefingStep6, 500, 1 )
end
function briefingStep5 ( rotDiff )
	setPedRotation ( getLocalPlayer(), getPedRotation (getLocalPlayer())+rotDiff/10 )
end
function briefingStep6 ()
	setPedAnimation ( getLocalPlayer(), "ped", "IDLE_chat", -1, true, true, true )
	setPedAnimation ( TheTruth )
	r, g, b = 255, 255, 255
	DialogText = "\nBist du The Truth?"
	addEventHandler("onClientRender",getRootElement(), createDialogText)
	setTimer ( dialog2, 2000, 1 )
	setTimer ( briefingStep7, 29500, 1 )
end
function dialog2 ()
	r, g, b = 200, 200, 20
	setPedAnimation ( getLocalPlayer() )
	setPedAnimation ( TheTruth, "ped", "IDLE_chat", -1, true, false, true )
	DialogText = "\nSeh ich aus wie ein verdammter Hippie?"
	setTimer ( dialog3, 2000, 1 )
end
function dialog3 ()
	DialogText = "Aber ich weiß, wo er ist - offenbar\nhat er seine Hippiefresse zu tief in Regierungs-\nAngelegenheiten gesteckt."
	setTimer ( dialog4, 6500, 1 )
end
function dialog4 ()
	DialogText = "Hat versucht, in der Area 51 Beweise fuer\nirgend eine Ufo-Verschwoerung zu finden.\nIst keine 2 Meter weit gekommen. Verdammter Idiot."
	setTimer ( dialog5, 6500, 1 )
end
function dialog5 ()
	DialogText = "Aber seine Quelle war zuverlaessig - irgend so ein hohes Tier bei\nder Regierung. Im Austausch fuer die \"Beweise\" setzt er ein paar Hebel\nin Bewegung, um ihn rauszuholen. Wenn sie ihn wollen, mitkommen."
	setTimer ( dialog6, 6500, 1 )
end
function dialog6 ()
	r, g, b = 255, 255, 255
	setPedAnimation ( TheTruth )
	setPedAnimation ( getLocalPlayer(), "ped", "IDLE_chat", -1, true, true, true )
	DialogText = "Und was haben sie fuer ein Interesse an ihm?"
	setTimer ( dialog7, 1500, 1 )
end
function dialog7 ()
	r, g, b = 200, 200, 20
	setPedAnimation ( getLocalPlayer() )
	setPedAnimation ( TheTruth, "ped", "IDLE_chat", -1, true, false, true )
	DialogText = "Druecken wir es so aus: Die Leute, die ihn haben, sollten nichts von\nmeiner Verbindung zu ihm erfahren. Folgen sie mir, ich stelle die Ausruestung."
end
function briefingStep7 ()
	setPedRotation ( getLocalPlayer(), 90 )
	setPedRotation ( TheTruth, 90 )
	setPedAnimation ( getLocalPlayer(), "ped", "WALK_civi" )
	setPedAnimation ( TheTruth, "ped", "WALK_civi" )
	DialogText = ""
	setTimer ( briefingStep8, 2000, 1 )
end
function briefingStep8 ()
	fadeCamera ( false, 3, 0, 0, 0 )
	setTimer ( briefingStep9, 5000, 1 )
end
function briefingStep9 ()
	setTimer ( briefingStep10, 1500, 1 )
end
function briefingStep10 ()
	setCameraMatrix ( 173.109375, 1933.474609375, 17.908861160278, 162.29296875, 1929.091796875, 20.908861160278 )
	setElementPosition ( getLocalPlayer(), 81.124649047852, 1920.7708740234, 17.298387527466 )
	fadeCamera ( true, 1 )
	r, g, b = 255, 255, 255
	DialogText = "Dring in das Gebaeude ein und berge die Beweise -\naber pass auf die Wachen auf, sie werden sofort das Feuer eroeffnen."
	setTimer ( briefingStep10_5, 6000, 1 )
end
function briefingStep10_5 ()
	DialogText = ""
	fadeCamera ( false, 1, 0, 0, 0 )
	setTimer ( briefingStep11, 1000, 1 )
end
function briefingStep11 ()
	setCameraMatrix ( 286.85385131836, 1830.0216064453, 8.7437839508057, 294.75048828125, 1836.0268554688, 8.2902698516846 )
	setElementPosition ( getLocalPlayer(), 81.124649047852, 1920.7708740234, 17.298387527466 )
	fadeCamera ( true, 1 )
	DialogText = "Die Wachen werden dich nicht bemerken, wenn\ndu schleichst - versuche am besten, ihnen komplett auszuweichen."
	setTimer ( briefingFinalStep1, 6000, 1 )
end
function briefingFinalStep1 ()
	DialogText = ""
	fadeCamera ( false, 1, 0, 0, 0 )
	setTimer ( briefingFinalStep2, 1000, 1 )
end
function briefingFinalStep2 ()
	removeEventHandler("onClientRender",getRootElement(), createDialogText)
	fadeCamera ( true, 1 )
	setCameraTarget ( getLocalPlayer() )
	setPlayerHudComponentVisible ( "radar", true )
	showChat ( true )
	toggleAllControls ( true )
	greenGooBlip = createBlip ( 268.71075439453, 1883.5866699219, -30.48, 0, 2, 255, 0, 0, 255, 0, 99999.0, getLocalPlayer() )
	setElementDimension ( greenGooBlip, getElementDimension ( getLocalPlayer() ) )
end

function createMissionSolvedText_func ()

	addEventHandler("onClientRender",getRootElement(), createSolved)
	setTimer ( removeMissionSolvedText, 7000, 1 )
end
addEvent ( "createMissionSolvedText", true )
addEventHandler ( "createMissionSolvedText", getRootElement(), createMissionSolvedText_func )
function removeMissionSolvedText ()
	removeEventHandler("onClientRender",getRootElement(), createSolved)
end

--createBlip ( float x, float y, float z, [int icon=0, int size=2, int r=255, int g=0, int b=0, int a=255, int ordering=0, float visibleDistance ] )

function createMissionName ()
	
	dxDrawText( MissionName, screenWidth-397, screenHeight-72, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.50, "pricedown" )
	dxDrawText( MissionName, screenWidth-400, screenHeight-75, screenWidth, screenHeight, tocolor ( 255, 160, 20, 255 ), 1.50, "pricedown" )
end
function createSolved ()
	dxDrawText( "mission erfuellt!\nto be continued...", screenWidth/2-3-200, screenHeight/2-3, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 2, "pricedown" )
	dxDrawText( "mission erfuellt!\nto be continued...", screenWidth/2-200, screenHeight/2, screenWidth, screenHeight, tocolor ( 255, 160, 20, 255 ), 2, "pricedown" )
end
function createDialogText ()
	dxDrawText( DialogText, screenWidth/2-219-150, screenHeight-124, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.50, "arial" )
	dxDrawText( DialogText, screenWidth/2-220-150, screenHeight-125, screenWidth, screenHeight, tocolor ( r, g, b, 255 ), 1.50, "arial" )
end