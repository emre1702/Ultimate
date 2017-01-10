-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function refreshSavety ()

	if isElement ( gWindow["register"] ) and guiGetVisible ( gWindow["register"] ) then
		local pw = guiGetText ( gEdit["passwort_register"] )
		safety = # pw
		if safety >= 10 then
			safety = 50
		elseif safety >= 7 then
			safety = 30
		else
			safety = 10
		end
		if tonumber ( pw ) then	
			safety = safety
		else
			safety = safety + 25
		end
		if pw ~= "123456" then
			safety = safety + 25
		end
		if # pw < 6 then
			safety = 0
		end
		guiProgressBarSetProgress ( gProgress["password"], safety )
		setTimer ( refreshSavety, 250, 1 )
	end
end

function SubmitRegisterBtn(button)
	
	if button == "left" then
		local pname = getPlayerName ( lp )
		local passwort = guiGetText ( gEdit["passwort_register"] )
		local pwlaenge = #passwort
		if guiGetText ( gEdit["passwort_register2"] ) ~= passwort then
			outputChatBox ( "Die beiden Passwörter stimmen nicht überein!", 125, 0, 0 )
		elseif pwlaenge < 6 or passwort == "******" or passwort == pname or passwort == "123456" then
			outputChatBox ("Fehler: Ungültiges Passwort", 255, 0 ,0 )
		else
			local birth_correct = 0
			bday = tonumber(guiGetText ( gEdit["registerDay"] ))
			bmon = tonumber(guiGetText ( gEdit["registerMonth"] ))
			byear = tonumber(guiGetText ( gEdit["registerYear"] ))
			if math.floor(bday) == bday and math.floor(bmon) == bmon and byear == math.floor (byear) then
				if bday < 32 and  bday > 0 and byear < 2009 and byear > 1900 and bmon < 13 and bmon > 0 then
					if bday < 29 then
						birth_correct = 1
					elseif (bday == 29 or bday == 30) and bmon ~= 2 then
						birth_correct = 1
					elseif bday == 31 and ( bmon == 1 or bmon == 3 or bmon == 5 or bmon == 7 or bmon == 8 or bmon == 10 or bmon == 12 ) then
						birth_correct = 1
					elseif bday == 29 and bmony == 2 and math.floor((byear/4)) == byear/4 then
						birth_correct = 1
					end
				else
					birth_correct = 0
				end
			else
				birth_correct = 0
			end
			if birth_correct == 1 then
				if guiRadioButtonGetSelected(gRadio["male"]) == true then
					geschlecht = 0
				else
					geschlecht = 1
				end
				player = lp
				triggerServerEvent ( "register", lp, player, hash ( "sha512", passwort ), bday, bmon, byear, geschlecht )
			else
				outputChatBox ("Fehler: Ungültiges Geburtsdatum!", 255, 0 , 0 )
			end
		end
	end
end

function renderRegisterBrowser ()
	if hatgeladenbro then
		dxDrawImage(0, 0, screenwidth, screenheight, loginBrowser, 0, 0, 0, tocolor(255,255,255,255), false)
	end
end
	
	
function showRegisterGui_func ()

	gWindow["register"] = guiCreateWindow(screenwidth/2-395/2,screenheight/2-422/2,395,422,"Registration",false)
	guiSetAlpha(gWindow["register"],1)
	
	showCursor ( true )
	setElementClicked ( true )
	addEventHandler ( "onClientRender", getRootElement(), renderRegisterBrowser )
	
	-- Texte --
	gLabel[1] = guiCreateLabel(8,121,381,59,"Herzlich willkommen bei Ultimate Reallife!\nBevor du anfangen kannst, musst du dich registrieren, damit deine\nDaten gespeichert werden koennen.",false,gWindow["register"])
	guiSetAlpha(gLabel[1],1)
	guiLabelSetColor(gLabel[1],255,255,255)
	guiLabelSetVerticalAlign(gLabel[1],"top")
	guiLabelSetHorizontalAlign(gLabel[1],"left",false)
	guiSetFont(gLabel[1],"default-bold-small")
	gLabel[2] = guiCreateLabel(18,212,23,16,"Tag",false,gWindow["register"])
	guiSetAlpha(gLabel[2],1)
	guiLabelSetColor(gLabel[2],200,200,0)
	guiLabelSetVerticalAlign(gLabel[2],"top")
	guiLabelSetHorizontalAlign(gLabel[2],"left",false)
	guiSetFont(gLabel[2],"default-bold-small")
	gLabel[3] = guiCreateLabel(58,213,39,16,"Monat",false,gWindow["register"])
	guiSetAlpha(gLabel[3],1)
	guiLabelSetColor(gLabel[3],200,200,0)
	guiLabelSetVerticalAlign(gLabel[3],"top")
	guiLabelSetHorizontalAlign(gLabel[3],"left",false)
	guiSetFont(gLabel[3],"default-bold-small")
	gLabel[4] = guiCreateLabel(109,213,27,16,"Jahr",false,gWindow["register"])
	guiSetAlpha(gLabel[4],1)
	guiLabelSetColor(gLabel[4],200,200,0)
	guiLabelSetVerticalAlign(gLabel[4],"top")
	guiLabelSetHorizontalAlign(gLabel[4],"left",false)
	guiSetFont(gLabel[4],"default-bold-small")
	gLabel[5] = guiCreateLabel(40,183,89,17,"Geburtsdatum",false,gWindow["register"])
	guiSetAlpha(gLabel[5],1)
	guiLabelSetColor(gLabel[5],0,0,200)
	guiLabelSetVerticalAlign(gLabel[5],"top")
	guiLabelSetHorizontalAlign(gLabel[5],"left",false)
	guiSetFont(gLabel[5],"default-bold-small")
	gLabel[6] = guiCreateLabel(159,184,89,16,"Geschlecht",false,gWindow["register"])
	guiSetAlpha(gLabel[6],1)
	guiLabelSetColor(gLabel[6],0,0,200)
	guiLabelSetVerticalAlign(gLabel[6],"top")
	guiLabelSetHorizontalAlign(gLabel[6],"left",false)
	guiSetFont(gLabel[6],"default-bold-small")
	gLabel[7] = guiCreateLabel(10,268,153,15,"( hat keinen spielerischen Effekt )",false,gWindow["register"])
	guiSetAlpha(gLabel[7],1)
	guiLabelSetColor(gLabel[7],255,255,255)
	guiLabelSetVerticalAlign(gLabel[7],"top")
	guiLabelSetHorizontalAlign(gLabel[7],"left",false)
	guiSetFont(gLabel[7],"default-small")
	gLabel[8] = guiCreateLabel(48,292,60,18,"Passwort",false,gWindow["register"])
	guiSetAlpha(gLabel[8],1)
	guiLabelSetColor(gLabel[8],255,0,0)
	guiLabelSetVerticalAlign(gLabel[8],"top")
	guiLabelSetHorizontalAlign(gLabel[8],"left",false)
	guiSetFont(gLabel[8],"default-bold-small")
	gLabel[9] = guiCreateLabel(13,345,129,18,"Passwort wiederholen",false,gWindow["register"])
	guiSetAlpha(gLabel[9],1)
	guiLabelSetColor(gLabel[9],255,0,0)
	guiLabelSetVerticalAlign(gLabel[9],"top")
	guiLabelSetHorizontalAlign(gLabel[9],"left",false)
	guiSetFont(gLabel[9],"default-bold-small")
	gLabel[10] = guiCreateLabel(157,304,59,15,"Sicherheit",false,gWindow["register"])
	guiSetAlpha(gLabel[10],1)
	guiLabelSetColor(gLabel[10],0,125,0)
	guiLabelSetVerticalAlign(gLabel[10],"top")
	guiLabelSetHorizontalAlign(gLabel[10],"left",false)
	guiSetFont(gLabel[10],"default-bold-small")
	gLabel[11] = guiCreateLabel(150,349,237,63,"Merke dir dein Passwort gut und gib es\nnicht weiter! Du benoetigst es, um deine\nDaten zu laden! Wir werden dich nie nach\ndeinem Passwort fragen.",false,gWindow["register"])
	guiSetAlpha(gLabel[11],1)
	guiLabelSetColor(gLabel[11],255,255,255)
	guiLabelSetVerticalAlign(gLabel[11],"top")
	guiLabelSetHorizontalAlign(gLabel[11],"left",false)
	guiSetFont(gLabel[11],"default-bold-small")
	gLabel[12] = guiCreateLabel(12,98,150,17,"Ultimate-RL.de",false,gWindow["register"])
	guiSetAlpha(gLabel[12],1)
	guiLabelSetColor(gLabel[12],255,255,255)
	guiLabelSetVerticalAlign(gLabel[12],"top")
	guiLabelSetHorizontalAlign(gLabel[12],"left",false)
	guiSetFont(gLabel[12],"default-bold-small")
	gLabel[13] = guiCreateLabel(268,182,85,22,"Accountname",false,gWindow["register"])
	guiSetAlpha(gLabel[13],1)
	guiLabelSetColor(gLabel[13],200,200,0)
	guiLabelSetVerticalAlign(gLabel[13],"top")
	guiLabelSetHorizontalAlign(gLabel[13],"left",false)
	guiSetFont(gLabel[13],"default-bold-small")
	gLabel[14] = guiCreateLabel(265,215,103,18,getPlayerName(lp),false,gWindow["register"])
	guiSetAlpha(gLabel[14],1)
	guiLabelSetColor(gLabel[14],255,255,255)
	guiLabelSetVerticalAlign(gLabel[14],"top")
	guiLabelSetHorizontalAlign(gLabel[14],"left",false)
	guiSetFont(gLabel[14],"default-bold-small")
	gLabel[15] = guiCreateLabel(266,238,88,29,"( Kann nicht selber\ngeaendert werden! )",false,gWindow["register"])
	guiSetAlpha(gLabel[15],1)
	guiLabelSetColor(gLabel[15],255,255,255)
	guiLabelSetVerticalAlign(gLabel[15],"top")
	guiLabelSetHorizontalAlign(gLabel[15],"left",false)
	guiSetFont(gLabel[15],"default-small")
	gLabel[16] = guiCreateLabel(28,400,85,15,"( mind. 6 Zeichen )",false,gWindow["register"])
	guiSetAlpha(gLabel[16],1)
	guiLabelSetColor(gLabel[16],255,255,255)
	guiLabelSetVerticalAlign(gLabel[16],"top")
	guiLabelSetHorizontalAlign(gLabel[16],"left",false)
	guiSetFont(gLabel[16],"default-small")
	
	-- Buttons --
	gButtons["register"] = guiCreateButton(270,295,76,40,"Anmelden",false,gWindow["register"])
	guiSetAlpha(gButtons["register"],1)
	
	gEdit["passwort_register"] = guiCreateEdit(21,310,109,32,"",false,gWindow["register"])
	guiSetAlpha(gEdit["passwort_register"],1)
	gEdit["passwort_register2"] = guiCreateEdit(22,365,109,32,"",false,gWindow["register"])
	guiSetAlpha(gEdit["passwort_register2"],1)
	
	gProgress["password"] = guiCreateProgressBar(148,321,77,20,false,gWindow["register"])
	guiSetAlpha(gProgress["password"],1)
	guiProgressBarSetProgress(gProgress["password"],0)
	
	gRadio["male"] = guiCreateRadioButton(157,215,82,16,"Maennlich",false,gWindow["register"])
	guiSetAlpha(gRadio["male"],1)
	gRadio["female"] = guiCreateRadioButton(158,239,82,16,"Weiblich",false,gWindow["register"])
	guiSetAlpha(gRadio["female"],1)
	guiRadioButtonSetSelected(gRadio["male"],true)
	
	gEdit["registerDay"] = guiCreateEdit(13,233,36,30,"",false,gWindow["register"])
	guiSetAlpha(gEdit["registerDay"],1)
	gEdit["registerMonth"] = guiCreateEdit(56,233,36,30,"",false,gWindow["register"])
	guiSetAlpha(gEdit["registerMonth"],1)
	gEdit["registerYear"] = guiCreateEdit(97,233,45,30,"",false,gWindow["register"])
	guiSetAlpha(gEdit["registerYear"],1)
	addEventHandler("onClientGUIClick", gButtons["register"], SubmitRegisterBtn, false)

	setTimer ( refreshSavety, 250, 1 )
	addEventHandler ( "onClientRender", root, setBrowserVolumeForRegisterLow )
end
addEvent ( "ShowRegisterGui", true)
addEventHandler ( "ShowRegisterGui", getRootElement(), showRegisterGui_func )

function GUI_DisableRegisterGui()

	cancelCameraIntro ()
	destroyElement ( gWindow["register"] )
	showCursor ( false )
	setElementClicked ( false )
	removeEventHandler ( "onClientRender", getRootElement(), renderRegisterBrowser )
	removeEventHandler ( "onClientRender", root, setBrowserVolumeForRegisterLow )
	destroyElement ( loginBrowser )
	showChat ( true )
	setElementHunger ( 60 )
end
addEvent ( "DisableRegisterGui", true )
addEventHandler ( "DisableRegisterGui", getRootElement(), GUI_DisableRegisterGui)

function showBeginGui_func ()

	gWindow["welcomeInfo"] = guiCreateWindow(507,285,445,266,"Fast geschafft!",false)
	guiSetAlpha(gWindow["welcomeInfo"],1)
	gLabel["anfangsText"] = guiCreateLabel(0.0225,0.0789,0.9303,0.3083,"Das Tutorial ist nun beendet!\nNun wäre es angebracht, sich im Hilfemenue ( Kurztaste: F1 ) erst einmal\nüber die Serverregeln und anfaenglichen Schritte zu informieren.\n\nViel Spaß auf Ultimate-RL!",true,gWindow["welcomeInfo"])
	guiSetAlpha(gLabel["anfangsText"],1)
	guiLabelSetColor(gLabel["anfangsText"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["anfangsText"],"top")
	guiLabelSetHorizontalAlign(gLabel["anfangsText"],"left",false)
	guiSetFont(gLabel["anfangsText"],"default-bold-small")
	gButton["HelmenueOpen"] = guiCreateButton(0.0225,0.406,0.2292,0.1466,"Hilfemenü aufrufen",true,gWindow["welcomeInfo"])
	guiSetAlpha(gButton["HelmenueOpen"],1)
	gButton["closeAnfangsWindow"] = guiCreateButton(0.2674,0.406,0.2292,0.1466,"Fenster\nschliessen",true,gWindow["welcomeInfo"])
	guiSetAlpha(gButton["closeAnfangsWindow"],1)
	gLabel["anfangsPS"] = guiCreateLabel(0.0225,0.609,0.9618,0.1391,"P.S.: Vergiss nicht, auch in unserem Forum vorbei zu schauen - dort erwarten\ndich zahlreiche Events und Informationen!",true,gWindow["welcomeInfo"])
	guiSetAlpha(gLabel["anfangsPS"],1)
	guiLabelSetColor(gLabel["anfangsPS"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["anfangsPS"],"top")
	guiLabelSetHorizontalAlign(gLabel["anfangsPS"],"left",false)
	guiSetFont(gLabel["anfangsPS"],"default-bold-small")
	gLabel["anfangsAdresse"] = guiCreateLabel(0.1011,0.7707,1,0.1729,"Ultimate-RL.de",true,gWindow["welcomeInfo"])
	guiSetAlpha(gLabel["anfangsAdresse"],1)
	guiLabelSetColor(gLabel["anfangsAdresse"],200,200,000)
	guiLabelSetVerticalAlign(gLabel["anfangsAdresse"],"top")
	guiLabelSetHorizontalAlign(gLabel["anfangsAdresse"],"left",false)
	guiSetFont(gLabel["anfangsAdresse"],"sa-header")
	addEventHandler("onClientGUIClick", gButton["HelmenueOpen"], SubmitOpenHelpMenueBtn, false)
	addEventHandler("onClientGUIClick", gButton["closeAnfangsWindow"], SubmitCloseThisWindowBtn, false)
end
addEvent ( "showBeginGui", true )
addEventHandler ( "showBeginGui", getRootElement(), showBeginGui_func )


function setBrowserVolumeForRegisterLow ( )
	setBrowserVolume ( 0.05 )
end


function SubmitCloseThisWindowBtn ()

	guiSetVisible ( gWindow["welcomeInfo"], false )
	showCursor(false)
	triggerServerEvent ( "cancel_gui_server", lp )
end
function SubmitOpenHelpMenueBtn ()

	guiSetVisible ( gWindow["welcomeInfo"], false )
	_CreateHelpmenueGui()
end