-----------------------------------------------------
--------	environment/rollerrent_c.lua	---------
-------------------- by Byte ------------------------
-----------------------------------------------------

local w, h = guiGetScreenSize()
local rollerverleih_window = guiCreateWindow(w/2-200/2, h/2-200/2, 400, 200, "Rollerverleih Noobspawn", false)
--local rollerverleih_window = guiCreateStaticImage(w/2-200/2, h/2-200/2, 450, 200,"images/hud/background.png", false)
guiWindowSetSizable(rollerverleih_window, false)

local text_label = guiCreateLabel(32, 22, 316, 76, "Willkommen beim Rollerverleih!\nHier kannst du dir einen Roller für 20 Minuten ausleihen.\nWenn du weniger als 15 Spielstunden hast,\nkostet dich der Roller nichts.\nAndernfalls musst du 75$ bezahlen.", false, rollerverleih_window)
local ausleih_button = guiCreateButton(22, 108, 158, 38, "Roller ausleihen", false, rollerverleih_window)
guiSetFont(ausleih_button, "default-bold-small")
guiSetProperty(ausleih_button, "NormalTextColour", "FFAAAAAA")
local close_button = guiCreateButton(260, 108, 158, 38, "Nein, danke.", false, rollerverleih_window)
guiSetFont(close_button, "default-bold-small")
guiSetProperty(close_button, "NormalTextColour", "FFAAAAAA")
guiSetVisible( rollerverleih_window, false )
local theid = nil

function clientRentWindow( id )
	showCursor( true )
	guiSetVisible( rollerverleih_window, true )
	guiBringToFront( rollerverleih_window )
	setElementClicked ( true )
	theid = id
	removeEventHandler("onClientGUIClick", ausleih_button, clientRentRoller)
	addEventHandler("onClientGUIClick", ausleih_button, clientRentRoller)
	addEventHandler("onClientGUIClick", close_button, 
	function()
		showCursor( false )
		setElementClicked ( false )
		guiSetVisible( rollerverleih_window, false )
	end)
end
addEvent("onClientRentRoller", true)
addEventHandler("onClientRentRoller", root, clientRentWindow)

function clientRentRoller( button )
	if button == "left" then
		showCursor( false )
		setElementClicked ( false )
		guiSetVisible( rollerverleih_window, false )
		triggerServerEvent ( "onServerRentRoller", localPlayer, theid )
	end
end
