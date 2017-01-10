-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

internetImages = {}


function showFruitDesktop_func ()

	
	lastWebpages = nil
	lastWebpages = {}
	
	hideInventory()
	showCursor ( true )
	setElementClicked ( true )
	toggleControl ( "chatbox", false )
	setElementClicked ( true )
	if gImage["desktopBG"] then
		guiSetVisible ( gImage["desktopBG"], true )
		guiSetAlpha ( gImage["desktopBG"], 0 )
		setTimer ( fadeFruitImage, 50, 20, gImage["desktopBG"] )
	else
		gImage["desktopBG"] = guiCreateStaticImage(screenwidth/2-480/2,screenheight/2-272/2,480,272,"images/internet/bg.png",false)
		guiSetAlpha ( gImage["desktopBG"], 0 )
		setTimer ( fadeFruitImage, 50, 20, gImage["desktopBG"] )
		gImage["desktopEmail"] = guiCreateStaticImage(43,48,60,46,"images/internet/email.png",false,gImage["desktopBG"])
		gLabel["desktopEmail"] = guiCreateLabel(55,90,37,15,"E-Mail",false,gImage["desktopBG"])
		guiLabelSetColor(gLabel["desktopEmail"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["desktopEmail"],"top")
		guiLabelSetHorizontalAlign(gLabel["desktopEmail"],"left",false)
		guiSetFont(gLabel["desktopEmail"],"default-bold-small")
		gImage["desktopLogout"] = guiCreateStaticImage(48,176,62,46,"images/internet/logout.png",false,gImage["desktopBG"])
		gLabel["desktopAbmelden"] = guiCreateLabel(46,217,61,15,"Abmelden",false,gImage["desktopBG"])
		guiLabelSetColor(gLabel["desktopAbmelden"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["desktopAbmelden"],"top")
		guiLabelSetHorizontalAlign(gLabel["desktopAbmelden"],"left",false)
		guiSetFont(gLabel["desktopAbmelden"],"default-bold-small")
		gImage["desktopBank"] = guiCreateStaticImage(345,52,104,35,"images/internet/bank.png",false,gImage["desktopBG"])
		gLabel["desktopTime"] = guiCreateLabel(406,2,73,15,"So, 15:50",false,gImage["desktopBG"])
		guiLabelSetColor(gLabel["desktopTime"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["desktopTime"],"top")
		guiLabelSetHorizontalAlign(gLabel["desktopTime"],"left",false)
		guiSetFont(gLabel["desktopTime"],"default-bold-small")
		gLabel["desktopOnlineBanking"] = guiCreateLabel(355,89,86,15,"Online Banking",false,gImage["desktopBG"])
		guiLabelSetColor(gLabel["desktopOnlineBanking"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["desktopOnlineBanking"],"top")
		guiLabelSetHorizontalAlign(gLabel["desktopOnlineBanking"],"left",false)
		guiSetFont(gLabel["desktopOnlineBanking"],"default-bold-small")
		gLabel["desktopWebbrowser"] = guiCreateLabel(206,190,75,16,"Webbrowser",false,gImage["desktopBG"])
		guiLabelSetColor(gLabel["desktopWebbrowser"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["desktopWebbrowser"],"top")
		guiLabelSetHorizontalAlign(gLabel["desktopWebbrowser"],"left",false)
		guiSetFont(gLabel["desktopWebbrowser"],"default-bold-small")
		gButton["desktopWebbrowser"] = guiCreateButton(159,65,158,149,"",false,gImage["desktopBG"])
		guiSetAlpha(gButton["desktopWebbrowser"],0)
		local pname = getPlayerName ( lp )
		gLabel["desktopInfo"] = guiCreateLabel(37,253,441,17,"Angemeldet als: "..pname.." ( "..pname.."@ulti-rl.de )",false,gImage["desktopBG"])
		guiLabelSetColor(gLabel["desktopInfo"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["desktopInfo"],"top")
		guiLabelSetHorizontalAlign(gLabel["desktopInfo"],"left",false)
		guiSetFont(gLabel["desktopInfo"],"default-bold-small")
		gImage["desktopAmmunation"] = guiCreateStaticImage(343,180,113,32,"images/internet/ammunation.bmp",false,gImage["desktopBG"])
		gLabel["desktopAmmunation"] = guiCreateLabel(340,225,123,15,"Ammunation Versand",false,gImage["desktopBG"])
		guiLabelSetColor(gLabel["desktopAmmunation"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["desktopAmmunation"],"top")
		guiLabelSetHorizontalAlign(gLabel["desktopAmmunation"],"left",false)
		guiSetFont(gLabel["desktopAmmunation"],"default-bold-small")
		
		table.insert ( internetImages, gImage["desktopBG"] )
		table.insert ( internetImages, gImage["desktopEmail"] )
		table.insert ( internetImages, gImage["desktopLogout"] )
		table.insert ( internetImages, gImage["desktopBank"] )
		table.insert ( internetImages, gImage["desktopAmmunation"] )
		
		addEventHandler("onClientGUIClick", gImage["desktopBG"], 
			function ( btn, state )
				if state == "up" then
					mousesound_func ()
					if gWindow["basicMainPage"] then
						guiBringToFront ( gWindow["basicMainPage"] )
					end
				end
			end
		)
		
		addEventHandler("onClientGUIClick", gImage["desktopEmail"], 
			function ( btn, state )
				if state == "up" then
					showEmailRecieveCenter_func ()
				end
			end,
		false)
		
		addEventHandler("onClientGUIClick", gImage["desktopAmmunation"], 
			function ( btn, state )
				if state == "up" then
					showWebbrowser ( "www.ammunation.com" )
				end
			end,
		false)
		
		addEventHandler("onClientGUIClick", gImage["desktopBank"], 
			function ( btn, state )
				if state == "up" then
					showWebbrowser ( "bank.de" )
				end
			end,
		false)

		addEventHandler("onClientGUIClick", gButton["desktopWebbrowser"], 
			function ( btn, state )
				if state == "up" then
					showWebbrowser ( "www.eyefind.com" )
				end
			end,
		false)

		addEventHandler("onClientGUIClick", gImage["desktopLogout"], 
			function ()
				gImage["blackScreen"] = guiCreateStaticImage(screenwidth/2-480/2,screenheight/2-272/2,480,272,"images/colors/c_black.jpg",false)
				guiSetAlpha ( gImage["blackScreen"], 0 )
				setTimer ( fadeFruitImage, 50, 20, gImage["blackScreen"] )
				showCursor ( false )
				setElementClicked ( false )
				setTimer ( hideFruitPC, 1000, 1 )
				setElementClicked ( false )
			end,
		false)
	end
	refreshFruitTime ()
end
addEvent ( "showFruitDesktop", true )
addEventHandler ( "showFruitDesktop", getRootElement(), showFruitDesktop_func )

function fadeFruitImage ( img )

	if isElement ( img ) then
		guiSetAlpha ( img, guiGetAlpha ( img ) + 0.05 )
	end
end

function fadeFruitBackImage ( img )

	if isElement ( img ) then
		guiSetAlpha ( img, guiGetAlpha ( img ) - 0.1 )
	end
end

function refreshFruitTime ()

	if guiGetVisible ( gImage["desktopBG"] ) then
		local time = getRealTime()
		local hour = time.hour
		local minute = tostring ( time.minute )
		local weekday = daynames[time.weekday+1]
		if #minute <= 1 then
			minute = "0"..minute
		end
		guiSetText ( gLabel["desktopTime"], weekday..", "..hour..":"..minute )
		setTimer ( refreshFruitTime, 1000, 1 )
	end
end

function hideFruitPC ()

	guiSetVisible ( gImage["desktopBG"], false )
	toggleControl ( "chatbox", true )
	setTimer ( fadeFruitBackImage, 50, 10, gImage["blackScreen"] )
	setTimer ( destroyElement, 600, 1, gImage["blackScreen"] )
end