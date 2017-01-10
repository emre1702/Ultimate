
local ppanel = {}
local width, height = guiGetScreenSize()
ppanel.window = guiCreateWindow(width/2-182, height/2-77, 364, 153, "Ultimate-RL Premium Panel", false)
guiWindowSetSizable(ppanel.window, false)
guiWindowSetMovable(ppanel.window ,true)

local tankenbutton = guiCreateButton(14, 30, 159, 27, "Fahrzeug Tanken", false, ppanel.window)
local repairvehbutton = guiCreateButton(189, 30, 159, 27, "Fahrzeug reparieren [100$]", false, ppanel.window)
local radiobutton = guiCreateButton(14, 81, 159, 27, "Radio", false, ppanel.window)
local lebenessenbutton = guiCreateButton(189, 81, 159, 27, "Leben auffüllen [300$]", false, ppanel.window)
local endebutton = guiCreateButton(138, 119, 85, 25, "Verlassen", false, ppanel.window)

guiSetVisible( ppanel.window, false)

function enterClickpp ()
    guiSetVisible(ppanel.window, true)
	showCursor ( true )
	setElementClicked ( true )
end
addEvent("ppstart",true)
addEventHandler("ppstart", getRootElement(), enterClickpp)

function exitClickpp ( button )
	if button == "left" then  
		guiSetVisible(ppanel.window, false)
		showCursor ( false )
		setElementClicked ( false )
	end
end
addEventHandler("onClientGUIClick", endebutton, exitClickpp)

function fixvehClick ( button )
	if button == "left" then  
		guiSetVisible(ppanel.window, false)
		triggerServerEvent ( "fixveh1", getLocalPlayer(), getLocalPlayer() )
		showCursor ( false )
		setElementClicked ( false )
	end
end
addEventHandler("onClientGUIClick", repairvehbutton, fixvehClick)

function lebenClick ( button )
   	if button == "left" then 
		guiSetVisible(ppanel.window, false)
		triggerServerEvent ( "lebenessen", getLocalPlayer(), getLocalPlayer() )
		showCursor ( false )
		setElementClicked ( false )
	end
end
addEventHandler("onClientGUIClick", lebenessenbutton, lebenClick)

function radioClick ( button )
	if button == "left" then
		guiSetVisible(ppanel.window, false)
		triggerEvent ( "onPlayerViewSpeakerManagment", getLocalPlayer(), getLocalPlayer() )
	end
end
addEventHandler("onClientGUIClick", radiobutton, radioClick)

function tankenClick ( button )
	if button == "left" then  
		guiSetVisible(ppanel.window, false)
		triggerServerEvent ( "fillComplete1", getLocalPlayer(), getLocalPlayer() )
		showCursor ( false )
		setElementClicked ( false )
	end
end
addEventHandler("onClientGUIClick", tankenbutton, tankenClick)