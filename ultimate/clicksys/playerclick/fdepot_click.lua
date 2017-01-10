function showFDepot_func ( fmoney, fmats, fdrugs )

	if gWindow["gangDepot"] then
		guiSetVisible ( gWindow["gangDepot"], true )
	else
		gWindow["gangDepot"] = guiCreateWindow(screenwidth/2-180/2, screenheight/2-131/2,180,131,"Gang Depot",false)
		guiSetAlpha(gWindow["gangDepot"],1)

		gButton["DepotTake"] = guiCreateButton(0.0556,0.65,0.3278,0.2748,"Nehmen",true,gWindow["gangDepot"])
		guiSetAlpha(gButton["DepotTake"],1)
		gButton["DepotPut"] = guiCreateButton(0.4222,0.65,0.3111,0.2672,"Einlagern",true,gWindow["gangDepot"])
		guiSetAlpha(gButton["DepotPut"],1)
		gButton["closeGangDepot"] = guiCreateButton(0.7778,0.65,0.1667,0.2672,"X",true,gWindow["gangDepot"])
		guiSetAlpha(gButton["closeGangDepot"],1)
		
		addEventHandler("onClientGUIClick", gButton["DepotPut"],
			function ()
				local money = guiGetText ( gEdit["moneyDepot"] )
				local mats = guiGetText ( gEdit["matsDepot"] )
				local drugs = guiGetText ( gEdit["drugsDepot"] )
				triggerServerEvent ( "fDepotServer", getRootElement(), getLocalPlayer(), false, money, drugs, mats )
			end
		)
		addEventHandler("onClientGUIClick", gButton["DepotTake"],
			function ()
				local money = guiGetText ( gEdit["moneyDepot"] )
				local mats = guiGetText ( gEdit["matsDepot"] )
				local drugs = guiGetText ( gEdit["drugsDepot"] )
				triggerServerEvent ( "fDepotServer", getRootElement(), getLocalPlayer(), true, money, drugs, mats )
			end
		)
		addEventHandler("onClientGUIClick", gButton["closeGangDepot"],
			function ()
				guiSetVisible ( gWindow["gangDepot"], false )
				showCursor(false)
				triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
			end
		)

		gEdit["moneyDepot"] = guiCreateEdit(0.05,0.4275,0.3278,0.1756,"0",true,gWindow["gangDepot"])
		guiSetAlpha(gEdit["moneyDepot"],1)
		gEdit["matsDepot"] = guiCreateEdit(0.4111,0.4275,0.2556,0.1756,"0",true,gWindow["gangDepot"])
		guiSetAlpha(gEdit["matsDepot"],1)
		gEdit["drugsDepot"] = guiCreateEdit(0.7,0.4275,0.25,0.1756,"0",true,gWindow["gangDepot"])
		guiSetAlpha(gEdit["drugsDepot"],1)
		gLabel["moneyDepotInfo"] = guiCreateLabel(0.0444,0.1832,0.2389,0.1145,"Geld:",true,gWindow["gangDepot"])
		guiSetAlpha(gLabel["moneyDepotInfo"],1)
		guiLabelSetColor(gLabel["moneyDepotInfo"],200,200,020)
		guiLabelSetVerticalAlign(gLabel["moneyDepotInfo"],"top")
		guiLabelSetHorizontalAlign(gLabel["moneyDepotInfo"],"left",false)
		guiSetFont(gLabel["moneyDepotInfo"],"default-bold-small")
		gLabel["moneyMatsInfo"] = guiCreateLabel(0.4278,0.1832,0.2389,0.1111,"Mats:",true,gWindow["gangDepot"])
		guiSetAlpha(gLabel["moneyMatsInfo"],1)
		guiLabelSetColor(gLabel["moneyMatsInfo"],200,200,020)
		guiLabelSetVerticalAlign(gLabel["moneyMatsInfo"],"top")
		guiLabelSetHorizontalAlign(gLabel["moneyMatsInfo"],"left",false)
		guiSetFont(gLabel["moneyMatsInfo"],"default-bold-small")
		gLabel["moneyDrugsInfo"] = guiCreateLabel(0.6944,0.1832,0.2389,0.1111,"Drogen:",true,gWindow["gangDepot"])
		guiSetAlpha(gLabel["moneyDrugsInfo"],1)
		guiLabelSetColor(gLabel["moneyDrugsInfo"],200,200,020)
		guiLabelSetVerticalAlign(gLabel["moneyDrugsInfo"],"top")
		guiLabelSetHorizontalAlign(gLabel["moneyDrugsInfo"],"left",false)
		guiSetFont(gLabel["moneyDrugsInfo"],"default-bold-small")
		gLabel["moneyValue"] = guiCreateLabel(0.0444,0.2977,0.3389,0.1069,"0 $",true,gWindow["gangDepot"])
		guiSetAlpha(gLabel["moneyValue"],1)
		guiLabelSetColor(gLabel["moneyValue"],000,120,20)
		guiLabelSetVerticalAlign(gLabel["moneyValue"],"top")
		guiLabelSetHorizontalAlign(gLabel["moneyValue"],"left",false)
		gLabel["matsValue"] = guiCreateLabel(0.4278,0.2977,0.2722,0.1298,"0 St.",true,gWindow["gangDepot"])
		guiSetAlpha(gLabel["matsValue"],1)
		guiLabelSetColor(gLabel["matsValue"],125,020,020)
		guiLabelSetVerticalAlign(gLabel["matsValue"],"top")
		guiLabelSetHorizontalAlign(gLabel["matsValue"],"left",false)
		gLabel["drugsValue"] = guiCreateLabel(0.6944,0.2977,0.2833,0.1145,"0 g",true,gWindow["gangDepot"])
		guiSetAlpha(gLabel["drugsValue"],1)
		guiLabelSetColor(gLabel["drugsValue"],030,030,120)
		guiLabelSetVerticalAlign(gLabel["drugsValue"],"top")
		guiLabelSetHorizontalAlign(gLabel["drugsValue"],"left",false)
	end
	setDepotEntrys ( fmoney, fmats, fdrugs )
end
addEvent ( "showFDepot", true )
addEventHandler ( "showFDepot", getRootElement(), showFDepot_func )

function setDepotEntrys ( fmoney, fmats, fdrugs )

	guiSetText ( gLabel["moneyValue"], fmoney.." $" )
	guiSetText ( gLabel["matsValue"], fmats.." St." )
	guiSetText ( gLabel["drugsValue"], fdrugs.." g" )
	
	guiSetText ( gEdit["moneyDepot"], "0" )
	guiSetText ( gEdit["matsDepot"], "0" )
	guiSetText ( gEdit["drugsDepot"], "0" )
end