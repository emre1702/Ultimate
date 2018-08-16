drugSettings = {}
drugColors = {}
drugSettings.interval = 250
drugSettings.aimDisturbe = 10
drugSettings.maxColor = 0.7

timeToGo = 0
strenght = 0

drugRunSwitch = false

function startDrugEffect_func ( time, amount, drunk, stone ) -- In 1000tel Sekunden bzw. MS; 0-1 in Heftigkeit -> 1 = Extrem, 0 = Nicht spürbar

	if drunk then
		drunken = true
	elseif stone then
		stoned = true
		setGameSpeed ( 1.08 )
	end

	strenght = amount
	
	if drugColors["white"] then
		guiSetVisible ( drugColors["white"], true )
		guiSetVisible ( drugColors["red"], true )
		guiSetVisible ( drugColors["green"], true )
		guiSetVisible ( drugColors["blue"], true )
	else
		drugColors["white"] = guiCreateStaticImage ( 0, 0, screenwidth, screenheight, "images/white.bmp", false )
		guiSetAlpha ( drugColors["white"], 0.5 )
		guiMoveToBack ( drugColors["white"] )
		
		drugColors["red"] = guiCreateStaticImage ( 0, 0, screenwidth, screenheight, "images/colors/c_red.jpg", false )
		guiSetAlpha ( drugColors["red"], 0 )
		guiMoveToBack ( drugColors["red"] )
		
		drugColors["green"] = guiCreateStaticImage ( 0, 0, screenwidth, screenheight, "images/colors/c_green.jpg", false )
		guiSetAlpha ( drugColors["green"], 0 )
		guiMoveToBack ( drugColors["green"] )
		
		drugColors["blue"] = guiCreateStaticImage ( 0, 0, screenwidth, screenheight, "images/colors/c_blue.jpg", false )
		guiSetAlpha ( drugColors["blue"], 0 )
		guiMoveToBack ( drugColors["blue"] )
	end
	
	if isTimer ( drugEffectTimer ) then
		killTimer ( drugEffectTimer )
		timeToGo = time + timeToGo
	else
		timeToGo = time
	end
	
	drugEffectTimer = setTimer ( drugEffectRepeat, drugSettings.interval, 0 )
end
addEvent ( "startDrugEffect", true )
addEventHandler ( "startDrugEffect", getRootElement(), startDrugEffect_func )

function drugEffectRepeat ()

	if getElementHealth ( lp ) <= 0 then
		deactivateDrugEffect_func ()
		return
	end
	if strenght > 0.1 then
		if math.random ( 1, 10000 ) / 1000 <= strenght then
			if drunken then
				triggerServerEvent ( "drunkAnimation", lp )
			end
		end
	end
	if math.random ( 1, 50000 ) / 100 <= strenght then
		if stoned then
			triggerServerEvent ( "crackAnimation", lp )
		end
	end
	local count = math.floor ( drugSettings.interval / 50 )
	setTimer ( drugFalshEffect, 50, count )
	setTimer ( drugAiming, 50, count )
	if drugRunSwitch then
		drunkDiveMode ()
	end
	drugRunSwitch = not drugRunSwitch
	timeToGo = timeToGo - drugSettings.interval
	if timeToGo <= 0 then
		deactivateDrugEffect_func ()
	elseif timeToGo <= 5000 then
		strenght = strenght * 0.8
	end
end

function drugFalshEffect ()

	local rnd
	if stoned then
		guiSetAlpha ( drugColors["white"], 0 )
		
		rnd = math.random ( 1, 10 ) / 10 * strenght * drugSettings.maxColor
		guiSetAlpha ( drugColors["red"], rnd )
		rnd = math.random ( 1, 10 ) / 10 * strenght * drugSettings.maxColor
		guiSetAlpha ( drugColors["green"], rnd )
		rnd = math.random ( 1, 10 ) / 10 * strenght * drugSettings.maxColor
		guiSetAlpha ( drugColors["blue"], rnd )
		
		guiMoveToBack ( drugColors["white"] )
		guiMoveToBack ( drugColors["red"] )
		guiMoveToBack ( drugColors["green"] )
		guiMoveToBack ( drugColors["blue"] )
	else
		local alpha = guiGetAlpha ( drugColors["white"] )
		if alpha > 0.05 then
			rnd = math.random ( -10, 10 )
		else
			rnd = math.random ( 1, 20 )
		end
		alpha = alpha + ( rnd / 100 )
		if alpha > 0.6 * strenght then
			alpha = 0.6 * strenght
		end
		guiSetAlpha ( drugColors["white"], alpha )
		guiMoveToBack ( drugColors["white"] )
	end
end

function deactivateDrugEffect_func ()

	guiSetAlpha ( drugColors["white"], 0 )
	
	killTimer ( drugEffectTimer )
	
	timeToGo = 0
	
	toggleControl ( "vehicle_left", true )
	toggleControl ( "vehicle_right", true )
	
	setPedControlState ( "vehicle_left", false )
	setPedControlState ( "vehicle_right", false )
	
	drunken = false
	stoned = false
	
	setGameSpeed ( 1 )
end
addEvent ( "deactivateDrugEffect", true )
addEventHandler ( "deactivateDrugEffect", getRootElement(), deactivateDrugEffect_func )

function drugAiming ()

	if getPedControlState ( "aim_weapon" ) then
		--[[local x, y, z = getPedTargetEnd ( lp )
		local drugAimS = drugSettings.aimDisturbe * strenght
		x = x + math.random ( -drugAimS, drugAimS )
		y = y + math.random ( -drugAimS, drugAimS )
		z = z + math.random ( -drugAimS, drugAimS )
		--triggerServerEvent ( "drugAimTarget", lp, x, y, z )
		--setPedCameraRotation ( lp, float cameraRotation )
		setPedRotation ( lp, getPedRotation ( lp ) + 2 )]]
	end
end

function drunkDiveMode ()

	if not isControlEnabled ( "vehicle_right" ) then
		toggleControl ( "vehicle_right", true )
		toggleControl ( "vehicle_left", true )
		if lastDrugControl == "left" then
			setPedControlState ( "vehicle_left", false )
		else
			setPedControlState ( "vehicle_right", false )
		end
	end
	
	local rnd = math.random ( 1, 150 ) / 100
	if rnd <= strenght then
		if math.random ( 1, 2 ) == 1 then
			setTimer ( drunkModeLeft, math.random ( 50, 250 ), 1 )
		else
			setTimer ( drunkModeRight, math.random ( 50, 250 ), 1 )
		end
	end
end

function drunkModeLeft ()

	toggleControl ( "vehicle_left", false )
	toggleControl ( "vehicle_right", false )
	lastDrugControl = "left"
	setPedControlState ( "vehicle_left", true )
end

function drunkModeRight ()

	toggleControl ( "vehicle_right", false )
	toggleControl ( "vehicle_left", false )
	lastDrugControl = "right"
	setPedControlState ( "vehicle_right", true )
end