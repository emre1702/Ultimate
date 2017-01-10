local promptTimeToHide = 0

function prompt_func ( text, time )

	gWindow["promptWindow"] = guiCreateWindow(screenwidth/2-363/2,screenheight/2-292/2,363,292,"Wichtige Informationen",false)
	guiSetAlpha(gWindow["promptWindow"],1)
	local img = guiCreateStaticImage(86,54,190,170,"images/prompt.png",false,gWindow["promptWindow"])
	guiSetAlpha(img,0.5)
	
	gLabel["promptText"] = guiCreateLabel(11,26,343,223,text,false,gWindow["promptWindow"])
	guiSetAlpha(gLabel["promptText"],1)
	guiLabelSetColor(gLabel["promptText"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["promptText"],"top")
	guiLabelSetHorizontalAlign(gLabel["promptText"],"left",false)
	guiSetFont(gLabel["promptText"],"default-bold-small")
	timeLabel = guiCreateLabel(19,261,330,21,"Dieses Fenster schliesst sich automatisch in "..time.." Sekunden.",false,gWindow["promptWindow"])
	guiSetAlpha(timeLabel,1)
	guiLabelSetColor(timeLabel,200,0,0)
	guiLabelSetVerticalAlign(timeLabel,"top")
	guiLabelSetHorizontalAlign(timeLabel,"left",false)
	guiSetFont(timeLabel,"default-bold-small")
	
	promptTimeToHide = time
	
	time = time + 1
	setTimer (
		function ( timeLabel )
			guiSetText ( timeLabel, "Dieses Fenster schliesst sich automatisch in "..promptTimeToHide.." Sekunden." )
			promptTimeToHide = promptTimeToHide - 1
		end,
	1000, time, timeLabel )
	setTimer ( destroyElement, time*1000+1000, 1, gWindow["promptWindow"] )
end
addEvent ( "prompt", true )
addEventHandler ( "prompt", getRootElement(), prompt_func )

-- DEBUG --
--[[ "Du hast soeben dein erstes Fahrzeug erworben!\nHier einige kurze Hinweise:\n\n1. Du kannst dein Fahrzeug mit /park an einem neuen\nOrt abstellen - dort wird es nach einem Server-\nrestart oder wenn du /towveh eintippst, erscheinen.\n\n2. Den Motor schaltest du mit \"X\" ein und aus.\n\n3. Mit /lock kannst du dein Fahrzeug abschliessen.\n\n4. Parke dein Fahrzeug nur an angemessenen Stellen,\nsonst wird es moeglicherweise geloescht.\nNicht angemessene Stellen sind z.b. auf der Strasse oder\nan wichtigen Stellen ( z.b. dem Eingang der Stadthalle )." ]]
--[[ local text = "Du hast soeben dein erstes Fahrzeug erworben!\nHier einige kurze Hinweise:\n\n1. Du kannst dein Fahrzeug mit /park an einem neuen\nOrt abstellen - dort wird es nach einem Server-\nrestart oder wenn du /towveh eintippst, erscheinen.\n\n2. Den Motor schaltest du mit \"X\" ein und aus.\n\n3. Mit /lock kannst du dein Fahrzeug abschliessen.\n\n4. Parke dein Fahrzeug nur an angemessenen Stellen,\nsonst wird es moeglicherweise geloescht.\nNicht angemessene Stellen sind z.b. auf der Strasse oder\nan wichtigen Stellen ( z.b. dem Eingang der Stadthalle ).\n\nFuer mehr: /vehinfos"
prompt_func ( text, 30 )]]
-- DEBUG --