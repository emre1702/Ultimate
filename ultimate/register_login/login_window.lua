-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------
addEvent('ShowLoginWindow', true )
addEvent ( "aktualisiereMemberTabelle", true )

-- preliminary
local resX, resY = guiGetScreenSize()
local segoeui = dxCreateFont('fonts/segoeui.ttf', 20)
local selected = 'username'
local username = ''
local password = ''
local showPassword = false
local inService = false
local hatPasswortDrin = true
hatgeladenbro = false
youtubevideoon = false
local theurl = ""
local limits = {
	username = 241,
	password = 195
}
local videoURLs = { "b60-sEXUPBY", "TTB6eEHCAko", "Vd85aPZ-QAE", "AjUNNXHdGwo", "7nUdHAVSLr4", "DKoY1fw7yCo", "CL1GEyK9Y0o", "DMg9idvVY8M", "j0uQBwFMfBk", "7ZkejDqTuSM", "PNjG22Gbo6U", "Fc50eXfe13U", "8C4-UEjadbU", 
"Slei8n08Cqk", "ID63iNLqrFU", "WG-KtnIMJY8", "CCJyJ_8gqqg", "Lrr7thWou8I", "C03n4AAiL9w", "RTlzQEA-4oc", "WPFLAjmWCtk", "PNjG22Gbo6U", "zG3z0tX-f6Q", "S0J07N7smd8", "lQlIhraqL7o", "iK18_Hz7NLc", "Lh8Mp76mqP8", 
"ywouLExEXqk", "UFXOd179kOA", "OYYJUt-V9oA", "1RNftSQj4cM", "Zt5W35sCCXw", "LU34CP8jUWU", "otCsqeMqqlM", "7Roa3aKnFoE", "AvKCib3O03g", "EO33DZpS82s", "m4FVcZMhunw", "Jm5DjptGtJo", "ntLop32pYd0", "qo6ygYSxwEY", 
"pVLmZMjxfjw", "Jq2T5n24kEo", "PeZ3dl8DgZg", "zv_d6k8DSIk", "cITCvGXaFDU", "4KpljzoEZsU", "zCfm-vWuQRk" }


-- animation
local state = 'starting'
local phase = 0
local alpha = 0
local lastTick = getTickCount()

-- recognizable
showChat( false )
showCursor( true )
setPlayerHudComponentVisible('all', false)
setPlayerHudComponentVisible('crosshair', true)


function checkBrowserActivated ( )
	if fileExists ( "einloggvideo.txt" ) then
		local file = fileOpen ( "einloggvideo.txt" )
		local status = fileRead ( file, fileGetSize ( file ) )
		fileClose ( file )
		if status == "on" then
			loginBrowser = createBrowser(resX, resY, false, false)
			youtubevideoon = true
			addEventHandler("onClientBrowserCreated", loginBrowser, function()
				local zahl = math.random ( #videoURLs )
				loadBrowserURL(loginBrowser, "https://www.youtube.com/embed/"..videoURLs[zahl].."?vq=large&playlist=gn2DVQompvs&autoplay=1&controls=0&disablekb=1&modestbranding=1&showinfo=0&loop=1&cc_load_policy=1&iv_load_policy=3&ap=%2526fmt%3D18&html5=1&rel=0")
				theurl = zahl..": "..videoURLs[zahl]
				hatgeladenbro = true
				addCommandHandler ( "testlogin", setNewLink )
			end )
			return
		end
	end
	loginCamDrive ()
end


-- utilities
local function convertingUserdata()
	local pass = password
	if not showPassword then
		pass = pass:gsub(".","*")
	end
	if #pass == 0 then
		pass = 'Password'
	end
	local user = username
	if #user == 0 then
		user = 'Username'
	end
	return user, pass 
end

local function setSettings( s, p ) 
	state = s or 'starting'
	phase = p or 0
	lastTick = getTickCount()
end 

local function getProgress( addtick )
	local now = getTickCount()
	local elapsedTime = now - lastTick
	local duration = lastTick+addtick - lastTick
	local progress = elapsedTime / duration
	return progress
end

local function sendUserdata()
	if #username > 0 and #password > 0 then
		triggerServerEvent ( "einloggen", lp, lp, hash ( "sha512", password ), hatPasswortDrin )
		inService = true
	end
end

local function removeLetter(button, press)
	if ( state ~= 'ready' or isChatBoxInputActive() or isConsoleActive() or isMainMenuActive() ) then 
		return
	end
	if press then
		if button == 'backspace' then
			local text = ( selected == 'username' and username or password )
			if #text > 0 then 
				text = string.sub(text, 1, #text - 1)
			end
			if selected ~= 'username' then
				password = text
			end
		end
	end
end

local function mainClick(button, _state, x, y)
	if state ~= 'ready' then 
		return 
	end
	if ( button == 'left' and _state == 'down' ) then
		-- username
		local checkX = ( x > resX/2-20 and x < resX/2-20+250 ) 
		local checkY = ( y >  resY/2-12.5 and y <  resY/2-12.5+25 )
		if ( checkX and checkY ) then
			selected = 'username'
			if ( not inService ) then
				lastTick = getTickCount()
			end
		end
		-- password
		local checkX = ( x > resX/2-20 and x < resX/2-20+250 ) 
		local checkY = ( y >  resY/2-12.5+37.5 and y <  resY/2-12.5+25+37.5 )
		if ( checkX and checkY ) then
			selected = 'password'
			if ( not inService ) then
				lastTick = getTickCount()
			end
		end
		-- login
		local checkX = ( x > resX/2-45+250 and x < resX/2-20+250 ) 
		local checkY = ( y >  resY/2-12.5+37.5 and y <  resY/2-12.5+25+37.5 )
		if ( checkX and checkY ) then
			sendUserdata()
		end
	end
	-- showPassword
	local checkX = ( x > resX/2-70+250 and x < resX/2-70+275 ) 
	local checkY = ( y > resY/2-11.25+35 and y <  resY/2-11.25+37.5+25 )
	if ( checkX and checkY ) then
		if _state == 'down' then
			showPassword = true
		else
			showPassword = false
		end
	end
end

local function addLetter(button)
	if ( state ~= 'ready' or isChatBoxInputActive() or isConsoleActive() or isMainMenuActive() ) then 
		return
	end
	local text = ( selected == 'username' and username or password )
	if dxGetTextWidth(text,0.5, segoeui ) >= limits[selected]-1 then
		return 
	end
	text = text..button
	if ( button == 'space' ) then
		text = text .. ' '
	end
	if ( selected ~= 'username' ) then
		password = text
	end
end

-- main
local function mainRender()
	local user, pass = convertingUserdata()
	if youtubevideoon and hatgeladenbro then
		setBrowserVolume ( 0.05 )
		dxDrawImage(0, 0, resX, resY, loginBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
		dxDrawText ( theurl, 0, 0, resX, resY, tocolor ( 255, 255, 255 ), 1, "default", "right", "top" )
		dxDrawText ( theurl, 0, 0, resX, resY, tocolor ( 0, 0, 0 ), 1, "default", "left", "top" )
	end
	if ( state == 'starting' ) then
		dxDrawRectangle( resX/2-112.5, resY/2-112.5, 225, 225, tocolor( 255, 255, 255, 25) )
		dxDrawImage( resX/2-100, resY/2-100, 200, 200, 'images/profil.png' )
		if ( lastTick+1000 <= getTickCount() ) then
			setSettings( 'animation', 1 )
		end
	elseif ( state == 'animation' ) then
		if ( phase == 1 ) then
			local fringeX, imageX, _ = interpolateBetween( resX/2-112.5, resX/2-100, 0, resX/2-243.75, resX/2-231.25, 0, getProgress( 900 ), 'Linear' )
			dxDrawRectangle( fringeX, resY/2-112.5, 225, 225, tocolor( 255, 255, 255, 25) )
			dxDrawImage( imageX, resY/2-100, 200, 200, 'images/profil.png' )
			if ( lastTick+925 <= getTickCount() ) then
				setSettings( 'animation', 2 )
			end
		elseif ( phase == 2 ) then
			local posX, alpha, size = interpolateBetween( resX/2-300, 0, 225, resX/2-20, 255, 487.5, getProgress( 1500 ), 'OutBack' )
			local alpha = (alpha > 255 and 255 or alpha)
			dxDrawText('Ultimate-RL', posX, resY/2-55, left, top, tocolor(255,255,0,alpha), 1, segoeui, 'left', 'center') 
			dxDrawRectangle( posX, resY / 2 - 12.5 , 250, 25, tocolor(255, 255, 255, alpha))
			dxDrawRectangle( posX, resY / 2 - 12.5+37.5 , 250, 25, tocolor(255, 255, 255, alpha))
			dxDrawRectangle( posX+225, resY / 2 - 12.5+37.5 , 25, 25, tocolor(255, 64, 0, alpha))
			dxDrawImage(posX+225+6.25, resY / 2 - 12.5+37.5+6.25, 12.5, 12.5, 'images/arrow.png')
			dxDrawText( user, posX+5, resY / 2 , left, top,(#username == 0 and tocolor(150, 150, 150, 255) or tocolor(0, 0, 0, 255)), 0.5, segoeui, 'left', 'center')
			dxDrawText( pass, posX+5, resY / 2+37.5 , left, top,(#username == 0 and tocolor(150, 150, 150, 255) or tocolor(0, 0, 0, 255)), 0.5, segoeui, 'left', 'center')
			dxDrawRectangle( resX/2-243.75, resY/2-112.5, size, 225, tocolor( 255, 255, 255, 25) )
			dxDrawImage( resX/2-231.25, resY/2-100, 200, 200, 'images/profil.png' )
			dxDrawText ( "Ultimate-RL", resX-375, resY-100, 375, screenheight, tocolor ( 255, 255, 0 ), 2, "pricedown", "left", "top" )
			if ( lastTick+1500 <= getTickCount() ) then
				setSettings( 'ready', 0 )
			end
		end
	elseif ( state == 'ready' ) then
		dxDrawText('Ultimate-RL', resX/2-20, resY/2-55, left, top, tocolor(255,255,0,255), 1, segoeui, 'left', 'center') 
		dxDrawRectangle( resX/2-20, resY / 2 - 12.5 , 250, 25, tocolor(255, 255, 255, 255))
		dxDrawRectangle( resX/2-20, resY / 2 - 12.5+37.5 , 250, 25, tocolor(255, 255, 255, 255))
		dxDrawRectangle( resX/2-20+225, resY / 2 - 12.5+37.5 , 25, 25, tocolor(255, 64, 0, 255))
		dxDrawImage(resX/2-20+225+6.25, resY / 2 - 12.5+37.5+6.25, 12.5, 12.5, 'images/arrow.png')
		dxDrawText( user, resX/2-20+5, resY / 2 , left, top,(#username == 0 and tocolor(150, 150, 150, 255) or tocolor(0, 0, 0, 255)), 0.5, segoeui, 'left', 'center')
		dxDrawText( pass, resX/2-20+5, resY / 2+37.5 , left, top,(#password == 0 and tocolor(150, 150, 150, 255) or tocolor(0, 0, 0, 255)), 0.5, segoeui, 'left', 'center')
		dxDrawRectangle( resX/2-243.75, resY/2-112.5, 487.5, 225, tocolor( 255, 255, 255, 25) )
		dxDrawImage( resX/2-231.25, resY/2-100, 200, 200, 'images/profil.png' )
		dxDrawText ( "Ultimate-RL", resX-375, resY-100, 375, screenheight, tocolor ( 255, 255, 0 ), 2, "pricedown", "left", "top" )
		if #password > 0 then
			dxDrawImage( resX/2-70+250, resY/2-11.25+37.5 , 22.5, 22.5, 'images/show.png')
		end
		if ( getTickCount() - lastTick >= 750 ) then
			if ( getTickCount() - lastTick >= 1500 ) then
				lastTick = getTickCount()
			end
			if ( selected == 'username' ) then
				dxDrawRectangle( resX/2-20+5+dxGetTextWidth((#username == 0 and username) or user, 0.5,segoeui), resY / 2 - 10, 1, 20, tocolor(0, 0, 0, 255))
			elseif ( selected == 'password' ) then
				dxDrawRectangle( resX/2-20+5+dxGetTextWidth((#password == 0 and password) or pass, 0.5,segoeui), resY/2-10+37.5, 1, 20, tocolor(0, 0, 0, 255))
			end
		end
		-- hover
		showCursor( true )
		local cx, cy = getCursorPosition()
		local x, y = cx*resX, cy*resY
		setElementData(localPlayer, 'cursor', 'cursor')
		if ( ( x > resX/2-20 and x < resX/2-20+250 )   and ( y >  resY/2-12.5 and y <  resY/2-12.5+25 ) ) then
			setElementData(localPlayer, 'cursor', 'text_cursor')
		end
		if ( ( x > resX/2-20 and x < resX/2-70+250 ) and ( y >  resY/2-12.5+37.5 and y <  resY/2-11.25+37.5+25  ) ) then
			setElementData(localPlayer, 'cursor', 'text_cursor')
		end
		if ( ( x > resX/2-45+250 and x < resX/2-20+250 )  and ( y >  resY/2-12.5+37.5 and y <  resY/2-12.5+25+37.5 ) ) then
			setElementData(localPlayer, 'cursor', 'link_cursor')
		end
		if ( #password > 0 ) then
			if ( ( x > resX/2-70+250 and x < resX/2-70+275 )  and ( y > resY/2-11.25+35 and y <  resY/2-11.25+37.5+25 ) ) then
				setElementData(localPlayer, 'cursor', 'link_cursor')
			end
		end
		if ( phase == 1 ) then
			alpha, _, _ = interpolateBetween( 0, 0, 0, 255, 0, 0, getProgress( 1500 ), 'Linear' )
			if ( lastTick+1475 <= getTickCount() ) then
				setSettings( 'ready', 0 )
				alpha = 255
				inService = false
			end
		end
		local msg = 'Wrong username or password!'
		dxDrawText(msg, resX/2-20+250/2-dxGetTextWidth(msg, 0.5, segoeui)/2 , resY/2+75, left, top, tocolor(255,0,0,alpha), 0.5, segoeui, 'left', 'center')
	elseif ( state == 'finished' ) then
		local posX, alpha, alpha1 = interpolateBetween(  resX/2-231.25, 255, 25, resX, 0, 0, getProgress( 950 ), 'Linear' )
		
		dxDrawText('Ultimate-Reallife', posX+220, resY/2-55, left, top, tocolor(255,255,0,255), 1, segoeui, 'left', 'center') 
		dxDrawRectangle( posX+220, resY / 2 - 12.5 , 250, 25, tocolor(255, 255, 255, alpha))
		dxDrawRectangle( posX+220, resY / 2 - 12.5+37.5 , 250, 25, tocolor(255, 255, 255, alpha))
		dxDrawRectangle( posX+220+225, resY / 2 - 12.5+37.5 , 25, 25, tocolor(255, 64, 0, alpha))
		
		dxDrawImage(posX+220+225+6.25, resY / 2 - 12.5+37.5+6.25, 12.5, 12.5, 'images/arrow.png',0,0,0,tocolor(255,255,255,alpha))
		dxDrawText( user, posX+220+5, resY / 2 , left, top,(#username == 0 and tocolor(150, 150, 150, alpha) or tocolor(0, 0, 0, alpha)), 0.5, segoeui, 'left', 'center')
		dxDrawText( pass, posX+220+5, resY / 2+37.5 , left, top,(#password == 0 and tocolor(150, 150, 150, alpha) or tocolor(0, 0, 0, alpha)), 0.5, segoeui, 'left', 'center')
		dxDrawRectangle(posX-12.5, resY/2-112.5, 487.5, 225, tocolor( 255, 255, 255, alpha1) )
		dxDrawImage( posX, resY/2-100, 200, 200, 'images/profil.png',0,0,0,tocolor(255,255,255,alpha))
		dxDrawText ( "Ultimate-RL", resX-375, resY-100, 375, screenheight, tocolor ( 255, 255, 0 ), 2, "pricedown", "left", "top" )
		if #password > 0 then
			dxDrawImage( posX+220-70+250, resY/2-11.25+37.5 , 22.5, 22.5, 'images/show.png',0,0,0,tocolor(255,255,255,alpha))
		end
		if ( lastTick+955 <= getTickCount() ) then
			if not youtubevideoon then
				cancelCameraIntro ()
			end
			removeEventHandler('onClientRender', root, mainRender)
			removeEventHandler('ShowLoginWindow', root, startRender )
			removeEventHandler('onClientKey', root, removeLetter)
			removeEventHandler('onClientClick', root, mainClick)
			removeEventHandler('onClientCharacter', root, addLetter)
			showCursor ( false )
			if isElement ( loginBrowser ) then
				destroyElement ( loginBrowser )
			end
			setCameraTarget ( lp )
			showChat ( true )
			unbindKey ( "enter", "down", sendUserdata )
			bindKey ("b", "down", showOtherHud)
			showOtherHud()
			setElementClicked ( false )
			setElementHunger ( 60 )
			
			setTimer ( checkForSocialStateChanges, 60000, 0 )
			setTimer ( getPlayerSocialAvailableStates, 1000, 1 )
			removeCommandHandler ( "testlogin", setNewLink )
			if not fileExists("@files/login.txt") then
				outputChatBox ("Gebe \"/auto 1\" zum Speichern deines Passwortes ein.")
			end
		end
	end
end


local function respondServer( )
	setSettings( 'finished', 0)
	triggerEvent('onRequestLobby', localPlayer )
end
addEvent ( "DisableLoginWindow", true )
addEventHandler ( "DisableLoginWindow", getRootElement(), respondServer)


function ShowInfoWindow ()
	infobox_start_func("\nHerzlich Willkommen\nauf Ultimate Reallife!!", 7500 )
end

function startRender ( name, boolean )
	if boolean then
		if fileExists("@files/login.txt") then
			local autofile = fileOpen("@files/login.txt")
			password = tostring(fileRead(autofile, 500))
			fileClose(autofile)
		end
		hatPasswortDrin = true
	else
		hatPasswortDrin = false
		setTimer ( infobox_start_func, 1000, 1, "Du hast\nkein Passwort!\nGib bitte dein\nzukünftiges Passwort ein!\n(wird gespeichert)", 6000, 255, 0, 0  )
	end
	username = name
	showCursor(true)
	bindKey ( "enter", "down", sendUserdata )	
	addEventHandler('onClientRender', root, mainRender)
end


function startedTheResource ()
	for i = 1, 100 do
		outputChatBox (" ")
	end
	setTimer ( ShowInfoWindow, 1000, 1 )
	triggerServerEvent ( "regcheck", getLocalPlayer(), getLocalPlayer() )
	addEventHandler('ShowLoginWindow', root, startRender )
	addEventHandler('onClientKey', root, removeLetter)
	addEventHandler('onClientClick', root, mainClick)
	addEventHandler('onClientCharacter', root, addLetter)
end

addEventHandler('onClientResourceStart', resourceRoot, startedTheResource)


local version = string.gsub(getVersion().mta, '%.', '')
if tonumber(version) >= 132 then
	local ox, oy = 0, 0
	local x, y = getCursorPosition()
	setCursorAlpha(0)
	if x and y then
		sx, sy = guiGetScreenSize()
		ox, oy = x * sx, y * sy 
		x, y = nil, nil
		sx, sy = nil, nil
	end

	addEventHandler('onClientCursorMove', getRootElement(),
		function(_, _, x, y)
			if isCursorShowing() or isConsoleActive() or isChatBoxInputActive()  then
				ox, oy = x, y
			end	
		end
	)
	
	addEventHandler('onClientRender', getRootElement(),
		function()
			if isCursorShowing() or isConsoleActive() or isChatBoxInputActive() then
				dxDrawImage(ox, oy, 32, 32, 'images/cursor.png', 0, 0, 0, tocolor(255,255,255), true)
			end	
		end
	)
end


-- Kameraflug --
function loginCamDrive1 () -- 1 & 2

	local x1, y1, z1 = -2681.7158203125, 1934.0498046875, 216.9231262207
	local x2, y2, z2 = -2682.2709960938, 1825.5369873047, 152.13279724121
	local x1t, y1t, z1t = -2681.8959960938, 1834.5554199219, 204.25393676758
	local x2t, y2t, z2t = -2682.4833984375, 1726.5500488281, 142.3770904541
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive2, time + 5, 1 )
end

function loginCamDrive2 () -- 2 & 3

	local x1, y1, z1 = -2682.2709960938, 1825.5369873047, 152.13279724121
	local x2, y2, z2 = -2681.4150390625, 1594.8540039063, 110.92800140381
	local x1t, y1t, z1t = -2682.4833984375, 1726.5500488281, 142.3770904541
	local x2t, y2t, z2t = -2681.6276855469, 1495.1013183594, 99.998870849609
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor
	
	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive3, time + 5, 1 )
end

function loginCamDrive3 () -- 3 & 4

	local x1, y1, z1 = -2681.4150390625, 1594.8540039063, 110.92800140381
	local x2, y2, z2 = -2681.6447753906, 1422.8494873047, 67.56616973877
	local x1t, y1t, z1t = -2681.6276855469, 1495.1013183594, 99.998870849609
	local x2t, y2t, z2t = -2681.5173339844, 1352.2436523438, 66.19132232666
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive4, time + 5, 1 )
end

function loginCamDrive4 () -- 4 & 5

	local x1, y1, z1 = -2681.6447753906, 1422.8494873047, 67.56616973877
	local x2, y2, z2 = -2676.8818359375, 1286.3806152344, 56.828914642334
	local x1t, y1t, z1t = -2681.5173339844, 1352.2436523438, 66.19132232666
	local x2t, y2t, z2t = -2677.1591796875, 1271.5997314453, 55.728954315186
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive5, time + 5, 1 )
end

function loginCamDrive5 () -- 5 & 6

	local x1, y1, z1 = -2676.8818359375, 1286.3806152344, 56.828914642334
	local x2, y2, z2 = -2678.3664550781, 1233.8521728516, 64
	local x1t, y1t, z1t = -2677.1591796875, 1271.5997314453, 55.728954315186
	local x2t, y2t, z2t = -2660.7592773438, 1188.1033935547, 65.842964172363
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive6, time + 5, 1 )
end

function loginCamDrive6 () -- 6 & 7

	local x1, y1, z1 = -2678.3664550781, 1233.8521728516, 66.589385986328
	local x2, y2, z2 = -2622.5700683594, 1189.6419677734, 61.302570343018
	local x1t, y1t, z1t = -2660.7592773438, 1188.1033935547, 65.842964172363
	local x2t, y2t, z2t = -2600.3303222656, 1200.1820068359, 34.821102142334
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive7, time + 5, 1 )
end

function loginCamDrive7 () -- 7 & 8

	local x1, y1, z1 = -2622.5700683594, 1189.6419677734, 61.302570343018
	local x2, y2, z2 = -2608.8449707031, 1199.6995849609, 39.6725730896
	local x1t, y1t, z1t = -2600.3303222656, 1200.1820068359, 34.821102142334
	local x2t, y2t, z2t = -2538.4426269531, 1269.5288085938, 35.954319000244
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive8, time + 5, 1 )
end

function loginCamDrive8 () -- 8 & 9

	local x1, y1, z1 = -2608.8449707031, 1199.6995849609, 39.6725730896
	local x2, y2, z2 = -2583.2880859375, 1229.4835205078, 39.4225730896
	local x1t, y1t, z1t = -2538.4426269531, 1269.5288085938, 35.954319000244
	local x2t, y2t, z2t = -2553.7490234375, 1324.2071533203, 30.522205352783
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive9, time + 5, 1 )
end

function loginCamDrive9 () -- 9 & 10

	local x1, y1, z1 = -2583.2880859375, 1229.4835205078, 39.4225730896
	local x2, y2, z2 = -2569.6552734375, 1311.4398193359, 18.645280838013
	local x1t, y1t, z1t = -2553.7490234375, 1324.2071533203, 30.522205352783
	local x2t, y2t, z2t = -2574.12890625, 1410.6734619141, 19.313352584839
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive10, time + 5, 1 )
end

function loginCamDrive10 () -- 10 & 11

	local x1, y1, z1 = -2569.6552734375, 1311.4398193359, 18.645280838013
	local x2, y2, z2 = -2653.9934082031, 1448.3275146484, 67.121849060059
	local x1t, y1t, z1t = -2574.12890625, 1410.6734619141, 19.313352584839
	local x2t, y2t, z2t = -2713.8569335938, 1503.0798339844, 104.99078369141
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive11, time + 5, 1 )
end

function loginCamDrive11 () -- 11 & 12

	local x1, y1, z1 = -2653.9934082031, 1448.3275146484, 67.121849060059
	local x2, y2, z2 = -2672.4709472656, 1593.65625, 183.23147583008
	local x1t, y1t, z1t = -2713.8569335938, 1503.0798339844, 104.99078369141
	local x2t, y2t, z2t = -2673.0710449219, 1677.3735351563, 222.607421875
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive12, time + 5, 1 )
end

function loginCamDrive12 () -- 12 & 13

	local x1, y1, z1 = -2672.4709472656, 1593.65625, 183.23147583008
	local x2, y2, z2 = -2681.8708496094, 1933.7674560547, 181.23147583008
	local x1t, y1t, z1t = -2673.0710449219, 1677.3735351563, 222.607421875
	local x2t, y2t, z2t = -2741.1096191406, 2007.708984375, 179.04406738281
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive13, time + 5, 1 )
end

function loginCamDrive13 () -- 13 & 14

	local x1, y1, z1 = -2681.8708496094, 1933.7674560547, 181.23147583008
	local x2, y2, z2 = -2704.6545410156+5, 1964.7253417969, 238.45220947266
	local x1t, y1t, z1t = -2741.1096191406, 2007.708984375, 179.04406738281
	local x2t, y2t, z2t = -2682.2709960938, 1825.5369873047, 152.13279724121
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive14, time + 5, 1 )
end

function loginCamDrive14 () -- 14 & 1

	local x1, y1, z1 = -2704.6545410156+5, 1964.7253417969, 238.45220947266
	local x2, y2, z2 = -2681.7158203125, 1934.0498046875, 216.9231262207
	local x1t, y1t, z1t = -2682.2709960938, 1825.5369873047, 152.13279724121
	local x2t, y2t, z2t = -2681.8959960938, 1834.5554199219, 204.25393676758
	local time = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / speedfactor

	smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	cameraTimer = setTimer ( loginCamDrive1, time + 5, 1 )
end

function smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	
	object1 = createObject ( 1337, x1, y1, z1 )
	object2 = createObject ( 1337, x1t, y1t, z1t )
	setElementAlpha ( object1, 0 )
	setElementAlpha ( object2, 0 )
	moveObject ( object1, time, x2, y2, z2 )
	moveObject ( object2, time, x2t, y2t, z2t )
	
	addEventHandler ( "onClientRender", getRootElement(), camRender )
	setTimer ( removeCamHandler, time, 1 )
	object1killtimer = setTimer ( destroyElement, time, 1, object1 )
	object2killtimer = setTimer ( destroyElement, time, 1, object2 )
end


function removeCamHandler ()
	removeEventHandler ( "onClientRender", getRootElement(), camRender )
end

function camRender ()

	if not isHalloween then
		if not getCameraTarget ( lp ) then
			local x1, y1, z1 = getElementPosition ( object1 )
			local x2, y2, z2 = getElementPosition ( object2 )
			setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
		else
			removeCamHandler ()
			if isTimer ( LVCamFlightTimer ) then
				killTimer ( LVCamFlightTimer )
			end
		end
	end
end

function cancelCameraIntro ()

	removeEventHandler ( "onClientRender", getRootElement(), camRender )
	if not isHalloween then
		destroyElement ( object1 )
		destroyElement ( object2 )
		if isTimer ( cameraTimer ) then
			killTimer ( cameraTimer )
		end
		if isTimer ( object1killtimer ) then
			killTimer ( object1killtimer )
			killTimer ( object2killtimer )
		end
	else
		stopHalloweenCamFlight ()
	end
end

function loginCamDrive ()

	if not isHalloween then
		speedfactor = getDistanceBetweenPoints3D ( -2681.7158203125, 1934.0498046875, 216.9231262207, -2682.2709960938, 1825.5369873047, 152.13279724121 ) / 10000
		loginCamDrive1 ()
	else
		startHalloweenCamFlight ()
	end
end
checkBrowserActivated()


saveLogin = function(ERROR_nil, ERROR_nil)
	if ERROR_nil == "1" then
		if fileExists("@files/login.txt") then
			fileDelete("@files/login.txt")
		end
		local loginfile = fileCreate("@files/login.txt")
		fileWrite(loginfile, password)
		fileClose(loginfile)
		outputChatBox("#C8C800[INFO]: #FFFFFFAuto-Login aktiviert!", 0, 0, 0,true)
	else
		fileDelete("@files/login.txt")
		outputChatBox("#C8C800[INFO]: #FFFFFFAuto-Login deaktiviert!", 0, 0, 0,true)
	end
end
addCommandHandler("auto", saveLogin)


function setNewLink ( _, i )
	local i = tonumber ( i )
	if videoURLs[i] then
		local zahl = i
		loadBrowserURL(loginBrowser, "https://www.youtube.com/embed/"..videoURLs[zahl].."?vq=large&playlist=gn2DVQompvs&autoplay=1&controls=0&disablekb=1&modestbranding=1&showinfo=0&loop=1&cc_load_policy=1&iv_load_policy=3&ap=%2526fmt%3D18&html5=1&rel=0")
		theurl = videoURLs[zahl]
		setTimer ( setNewLink, 4000, 1, i + 1 )
	end
end


