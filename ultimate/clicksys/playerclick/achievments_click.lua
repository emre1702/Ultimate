function showAchievmentWindow ()

	if gWindow["achievmentList"] then
		destroyElement ( gWindow["achievmentList"] )
	end
	
	gWindow["achievmentList"] = guiCreateWindow(screenwidth/2-300/2,120,300,422,"Achievments",false)
	guiSetAlpha ( gWindow["achievmentList"], 1 )
	guiWindowSetMovable ( gWindow["achievmentList"], false )
	guiWindowSetSizable ( gWindow["achievmentList"], false )
	
	gImage[2] = guiCreateStaticImage(10,29,50,50,"images/pokal.bmp",false,gWindow["achievmentList"])
	gLabel[4] = guiCreateLabel(78,33,186,47,"Hier kannst du sehen,\nwelche Achievments du bereits\nerreicht hast.",false,gWindow["achievmentList"])
	guiLabelSetColor(gLabel[4],255,255,255)
	guiLabelSetVerticalAlign(gLabel[4],"top")
	guiLabelSetHorizontalAlign(gLabel[4],"left",false)
	guiSetFont(gLabel[4],"default-bold-small")
	
	currentAchievments = 0

	addAchievment ( "Schlaflos in SA", vioClientGetElementData ( "schlaflosinsa" ) == "done" )
	addAchievment ( "Waffenschieber", vioClientGetElementData ( "gunloads" ) == "done" )
	addAchievment ( "Angler", vioClientGetElementData ( "angler_achiev" ) == "done" )
	addAchievment ( "Mr. License", vioClientGetElementData ( "licenses_achiev" ) == "done" )
	addAchievment ( "Der Sammler", vioClientGetElementData ( "collectr_achiev" ) == "done" )
	addAchievment ( "The Truth is out there", vioClientGetElementData ( "thetruthisoutthere_achiev" ) == "done" )
	addAchievment ( "Silent Assassin", vioClientGetElementData ( "silentassasin_achiev" ) == "done" )
	addAchievment ( "Reallife WTF?", vioClientGetElementData ( "rl_achiev" ) == "done" )
	addAchievment ( "Eigene Fuesse", vioClientGetElementData ( "own_foots" ) == "done" )
	addAchievment ( "King of the Hill", vioClientGetElementData ( "kingofthehill_achiev" ) == "done" )
	addAchievment ( "Highway to Hell", vioClientGetElementData ( "highwaytohell_achiev" ) == "done" )
	addAchievment ( "Schmied", vioClientGetElementData ( "totalHorseShoes" ) == 25 )	
	addAchievment ( "Revolverheld", vioClientGetElementData ( "revolverheld_achiev" ) == 1 )
	addAchievment ( "Chicken Dinner", vioClientGetElementData ( "chickendinner_achiev" ) == 1 )
	addAchievment ( "Nichts geht mehr", vioClientGetElementData ( "nichtsgehtmehr_achiev" ) == 1 )
	addAchievment ( "Highscore", vioClientGetElementData ( "highscore_achiev" ) )
end

function addAchievment ( text, done )

	currentAchievments = currentAchievments + 1
	local x = 11
	if currentAchievments / 2 == math.floor ( currentAchievments / 2 ) then
		x = 151
	end
	
	local y = 90 + math.floor ( currentAchievments / 2 ) * 32
	
	gLabel["achievment"..currentAchievments] = guiCreateLabel(x,y,130,14,text,false,gWindow["achievmentList"])
	guiLabelSetVerticalAlign(gLabel["achievment"..currentAchievments],"top")
	guiLabelSetHorizontalAlign(gLabel["achievment"..currentAchievments],"left",false)
	guiSetFont(gLabel["achievment"..currentAchievments],"default-bold-small")
	
	if done then
		guiLabelSetColor(gLabel["achievment"..currentAchievments],0,200,0)
		gImage["achievment"..currentAchievments] = guiCreateStaticImage( x + 68, y + 7, 43, 21,"images/gui/done.png",false,gWindow["achievmentList"])
	else
		guiLabelSetColor(gLabel["achievment"..currentAchievments],200,200,0)
	end
end