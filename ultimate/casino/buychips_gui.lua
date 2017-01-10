function showChipBuy_func ()

	showCursor ( true )
	setElementClicked ( true )
	if gWindow["chipBuy"] then
		guiSetVisible ( gWindow["chipBuy"], true )
	else
		gWindow["chipBuy"] = guiCreateWindow(screenwidth/2-229/2,screenheight/2-188/2,229,188,"Chips",false)
		guiWindowSetMovable(gWindow["chipBuy"],false)
		guiWindowSetSizable(gWindow["chipBuy"],false)
		gLabel[1] = guiCreateLabel(16,21,195,31,"Hier kannst du neue Chips kaufen\noder Chips in Geld umtauschen.",false,gWindow["chipBuy"])
		guiLabelSetColor(gLabel[1],200,200,0)
		guiLabelSetVerticalAlign(gLabel[1],"top")
		guiLabelSetHorizontalAlign(gLabel[1],"left",false)
		guiSetFont(gLabel[1],"default-bold-small")
		gLabel[2] = guiCreateLabel(15,67,28,17,"Fuer",false,gWindow["chipBuy"])
		guiLabelSetColor(gLabel[2],255,255,255)
		guiLabelSetVerticalAlign(gLabel[2],"top")
		guiLabelSetHorizontalAlign(gLabel[2],"left",false)
		guiSetFont(gLabel[2],"default-bold-small")
		gLabel[3] = guiCreateLabel(139,67,13,26,"$",false,gWindow["chipBuy"])
		guiLabelSetColor(gLabel[3],0,200,0)
		guiLabelSetVerticalAlign(gLabel[3],"top")
		guiLabelSetHorizontalAlign(gLabel[3],"left",false)
		guiSetFont(gLabel[3],"default-bold-small")
		gLabel[4] = guiCreateLabel(156,67,56,20,"Chips",false,gWindow["chipBuy"])
		guiLabelSetColor(gLabel[4],255,255,255)
		guiLabelSetVerticalAlign(gLabel[4],"top")
		guiLabelSetHorizontalAlign(gLabel[4],"left",false)
		guiSetFont(gLabel[4],"default-bold-small")
		gImage[1] = guiCreateStaticImage(153,94,50,50,"images/inventory/chip.png",false,gWindow["chipBuy"])
		
		gButton["chipEintauschen"] = guiCreateButton(9,151,87,29,"Eintauschen",false,gWindow["chipBuy"])
		gButton["chipClose"] = guiCreateButton(118,151,87,29,"Schliessen",false,gWindow["chipBuy"])

		gEdit["chipAmount"] = guiCreateEdit(43,61,93,30,"",false,gWindow["chipBuy"])
		gRadio["chipsBuy"] = guiCreateRadioButton(14,123,91,15,"kaufen",false,gWindow["chipBuy"])
		guiSetFont(gRadio["chipsBuy"],"default-bold-small")
		gRadio["chipsSwap"] = guiCreateRadioButton(13,98,91,15,"tauschen",false,gWindow["chipBuy"])
		guiSetFont(gRadio["chipsSwap"],"default-bold-small")
		guiRadioButtonSetSelected(gRadio["chipsBuy"],true)
		
		guiSetAlpha ( gWindow["chipBuy"], 1 )
		
		addEventHandler ( "onClientGUIClick", gButton["chipClose"],
			function ()
				guiSetVisible ( gWindow["chipBuy"], false )
				showCursor ( false )
				setElementClicked ( false )
			end,
		false )
		addEventHandler ( "onClientGUIClick", gButton["chipEintauschen"],
			function ()
				triggerServerEvent ( "buyChips", lp, guiGetText ( gEdit["chipAmount"] ), guiRadioButtonGetSelected ( gRadio["chipsBuy"] ) )
			end,
		false )
	end
	guiSetText ( gEdit["chipAmount"], "0" )
end
addEvent ( "showChipBuy", true )
addEventHandler ( "showChipBuy", getRootElement(), showChipBuy_func )