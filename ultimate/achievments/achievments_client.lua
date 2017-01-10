function showAchievmentBox_func ( achievename, punkte, sichtbarzeit )

	achievsound_func ()
	guiSetText ( AchievmentName, achievename )
	guiSetText ( AchievmentBelohnung, "+"..punkte.." Punkte" )
	guiSetVisible ( AchievmentWindow, true )
	guiBringToFront ( AchievmentWindow )
	setTimer ( hideAchievmentBox, sichtbarzeit, 1 )
end
addEvent ( "showAchievmentBox", true )
addEventHandler ( "showAchievmentBox", getRootElement(), showAchievmentBox_func )

function hideAchievmentBox ()

	guiSetVisible ( AchievmentWindow, false )
end

function _CreateAchievbox ()

	local screenwidth, screenheight = guiGetScreenSize ()
	
	AchievmentWindow = guiCreateWindow(screenwidth-165,0,165,105,"Achievment erhalten!",false)
	guiSetAlpha(AchievmentWindow,1)
	AchievmentIcon = guiCreateStaticImage(5,25,75,75,"images/pokal.bmp",false,AchievmentWindow)
	guiSetAlpha(AchievmentIcon,1)
	AchievmentName = guiCreateLabel(0.53,0.2952,1,0.7048," King of the\n       Hill",true,AchievmentWindow)
	guiSetAlpha(AchievmentName,1)
	guiLabelSetColor(AchievmentName,255,255,255)
	guiLabelSetVerticalAlign(AchievmentName,"top")
	guiLabelSetHorizontalAlign(AchievmentName,"left",false)
	guiSetFont(AchievmentName,"default-bold-small")
	AchievmentBelohnung = guiCreateLabel(0.53,0.7048,0.4645,0.2095,"+15 Punkte",true,AchievmentWindow)
	guiSetAlpha(AchievmentBelohnung,1)
	guiLabelSetColor(AchievmentBelohnung,000,125,000)
	guiLabelSetVerticalAlign(AchievmentBelohnung,"top")
	guiLabelSetHorizontalAlign(AchievmentBelohnung,"left",false)
	guiSetFont(AchievmentBelohnung,"default-bold-small")
	guiBringToFront ( AchievmentIcon )
	guiSetVisible ( AchievmentWindow, false )
	guiWindowSetMovable ( AchievmentWindow, false )
	guiWindowSetSizable ( AchievmentWindow, false )
end

addEventHandler("onClientResourceStart", resourceRoot, 
	function ()
		_CreateAchievbox()
	end
)