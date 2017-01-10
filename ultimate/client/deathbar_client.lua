function showProgressBar_func ( time )

	if gWindow["reviveProgress"] then
		guiSetVisible ( gWindow["reviveProgress"], true )
	else
		gWindow["reviveProgress"] = guiCreateWindow(screenwidth/2-264/2,screenheight/2-344/2,264,344,"Krankenhaus",false)
		guiSetAlpha(gWindow["reviveProgress"],1)
		gImage["death"] = guiCreateStaticImage(0.0758,0.0698,0.803,0.5349,"images/medic.jpg",true,gWindow["reviveProgress"])
		guiSetAlpha(gImage["death"],1)
		gLabel["deathbarText1"] = guiCreateLabel(0.0341,0.6076,0.9356,0.1366,"\nDu bist gestorben und wirst nun\nim Krankenhaus wieder zusammengeflickt.",true,gWindow["reviveProgress"])
		guiSetAlpha(gLabel["deathbarText1"],1)
		guiLabelSetColor(gLabel["deathbarText1"],200,200,000)
		guiLabelSetVerticalAlign(gLabel["deathbarText1"],"top")
		guiLabelSetHorizontalAlign(gLabel["deathbarText1"],"left",false)
		guiSetFont(gLabel["deathbarText1"],"default-bold-small")
		gProgress["progressDeathtime"] = guiCreateProgressBar(0.1705,0.8285,0.6667,0.1366,true,gWindow["reviveProgress"])
		guiSetAlpha(gProgress["progressDeathtime"],1)
		guiProgressBarSetProgress(gProgress["progressDeathtime"],0)
		gLabel["deathbarText2"] = guiCreateLabel(0.2727,0.7733,0.5152,0.0523,"Behandlungsfortschritt:",true,gWindow["reviveProgress"])
		guiSetAlpha(gLabel["deathbarText2"],1)
		guiLabelSetColor(gLabel["deathbarText2"],125,125,200)
		guiLabelSetVerticalAlign(gLabel["deathbarText2"],"top")
		guiLabelSetHorizontalAlign(gLabel["deathbarText2"],"left",false)
		guiSetFont(gLabel["deathbarText2"],"default-bold-small")
	end
	--setTimer ( updateDeathBar_func, time*10, 100 )
	--setTimer ( hideUpdateBar, time*1000, 1 )
end
addEvent ( "showProgressBar", true )
addEventHandler ( "showProgressBar", getRootElement(), showProgressBar_func )

function updateDeathBar_func ( new )

	local newBarSize = new
	guiProgressBarSetProgress(gProgress["progressDeathtime"],newBarSize)
	if newBarSize >= 100 then
		hideUpdateBar ()
	end
end
addEvent ( "updateDeathBar", true )
addEventHandler ( "updateDeathBar", getRootElement(), updateDeathBar_func )

function hideUpdateBar ()

	guiSetVisible ( gWindow["reviveProgress"], false )
end
addEvent ( "hideDeathBar", true )
addEventHandler ( "hideDeathBar", getRootElement(), hideUpdateBar )


addEventHandler ( "onClientPlayerWasted", localPlayer, function ( killer, weapon, bodypart )
	triggerServerEvent ( "onPlayerWastedTriggered", lp, killer, weapon, bodypart )
end )