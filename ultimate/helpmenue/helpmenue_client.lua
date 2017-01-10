-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

gButtons = {}
gGrid = {}
gThemes = {}
local helpmenueText = {
	["Erste Schritte"] = "Erste Schritte\n\nDas Hud kann durch\nDrücken von \"B\" geändert werden.\nAn Geldautomaten kann man Geld  vom Konto abheben\n(s.h. \"Geld\" bzw. \"Clicksystem\")\nIn der Stadthalle ( gelber Punkt\nauf der Minimap ) kannst du dir Scheine\n, Ausweise und Fahrzeugslots erwerben oder\nnach einem Job suchen.\nFahrzeuge findest du am Auto-, Skins am T-Shirt- und Jobs am blauen-Männchen-Symbol auf der Karte",
	["Serverregeln"] = "Serverregeln\n\nDie Serverregeln kannst\ndu per F9 oder\nim Forum unter\nwww.Ultimate-RL.de\nnachlesen!",
	["Account"] = "Account\n\nIn deinem Account werden alle deine Daten\nwie z.b. Spielerfolge automatisch gespeichert.\nAn einem Computer kannst du nur mit einem Account spielen, für mehr Accounts (z.B. für Geschwister) wird eine Erlaubnis vom Projektleiter gebraucht.",
	["Probleme"] = "Probleme\n\nFalls du ein Problem hast\n(z.b. einen Buguser),\ndann kannst du ihn per /report [text]\nan einen der Admins melden.\nFür Fragen bezueglich des Spiels,\nfrage einfach einen deiner Mitspieler. Beschwerden kannst du im Forum schreiben.",
	["Admins"] = "Admins\n\nEs gibt 5 Arten von Teammitglieder:\n1. Ticketsupporter, 2. Supporter, \n3. Moderator, 4. Administrator\nund 5. Projektleiter.\nDiese unterscheiden sich durch einige Befehle\nbzw. Zugriffsrechte und dürfen ihre Rechte nicht ausnutzen.\n\nAnfragen wie\n\"Wie verdiene ich am meisten Geld?\",\n\"XY greift mich an/hat etwas zerstört\"\nwerden ignoriert.\nMit /report [text] könnt ihr sie\nkontaktieren und mit /admins sehen,\nwer gerade online ist. Alle Adminbefehle könnt ihr durch /admincommands einsehen.",
	["Changelog"] = "Changelog\n\nDie Changelogs stehen\nim Forum unter www.Ultimate-RL.de",
	["Fahrzeuge"] = "Fahrzeuge\n\nDie Fahrzeuge sind bedingt zerstörbar,\nd.h. sie können nur durch sehr starke\nExplosionen usw. beschädigt werden,\nfalls niemand in ihnen sitzt.\nDie Reifen sind dauerhaft zerstörbar.\nWenn jemand als Fahrer im\nFahrzeug ist, lässt es sich durch\nKugeln usw. zerstören - für immer weg sind sie, wenn der Besitzer in der Nähe ist.\nDamit dein Fahrzeug fahren kann, benötigt\nes ausserdem Benzin (Tankstelle).\n\nSteuerung:\n\"X\" = Motor anlassen,\n\"L\" = Licht an/ausschalten\n\nFahrzeuge können bei Autohäusern\nfür Geld erworben werden.\nMehr unter /vehhelp.",
	["Haeuser"] = "Häuser\n\nHäuser können mit /buyhouse [bar/bank]\nerworben werden, sofern du über\ngenug Geld verfügst,\nnirgends eingemietet bist und\nnoch kein Haus hast. Befehle sind per /commands einsehbar.",
	["Bonuspunkte"] = "Bonuspunkte\n\nBonuspunkte erhälst du,\nwenn du Achievments erhälst oder\nPäckchen/Hufeisen/Aussichtspunkte sammelst.\nMit diesen kannst du unter \"Optionen\"\nbesondere Boni für Punkte freischalten.",
	["Geld"] = "Geld\n\nGeld ist auf dem Server nötig, um\nAutos, neue Skins usw. zu kaufen,\ndurch Arbeit, Zinsen und von\nanderen Spielern kann es erhalten werden.\nAn Geldautomaten kann der Kontostand\neingesehen werden, Geld ab/eingezahlt\nwerden oder ueberwiesen werden,\nin dem du AlT-GR / M drueckst und\neinen Geldautomaten anklickst.",
	["Waffen"] = "Waffen\n\nUm Waffen erwerben zu können,\nbenötigst du einen Waffenschein.\nDiesen erhälst du wie alle\nScheine in der Stadthalle.\nPolizisten werden dir - falls\ndu mehrfach wegen sinnlosem Waffengebrauchs\nauffällst - diesen wieder entziehen.\nAusserdem ist es möglich, Waffen in\nWaffenkisten zu speichern - bei jedem\nWaffenhändler steht je eine - klicke\nsie einfach an!",
	["Gangs"] = { 	[0] = "Gangs\n\nDie Gangs machen böse Aktivitäten wie Matstruck, Drogentruck, Carrob, Bankraub usw., um Geld zu verdienen.\nGehe ihnen am Anfang aus dem Weg -\noder freunde dich mit ihnen an.",
					[2] = "Cosa Nostra\n\nDie Cosa Nostra besitzt die Pizzeria und verdient nebenbei dadurch Geld. Sie ist die reichste Gang in San Andreas und ist hauptsächlich für Aktionen gegen Polizisten zuständig.",
					[3] = "Triaden\n\nDie Triaden haben eine der mächtigsten Waffen, die Katana, und eine sehr gute Basis mitten in der Stadt. Sie sind zusammen eine mächtige Gang, die gegen jeden bestehen kann. Befehle können durch /fraktioncommands eingesehen werden.",
					[4] = "Terroristen\n\nErklärung folgt ..  Befehle können durch /fraktioncommands eingesehen werden.",
					[7] = "Los Aztecas\n\nLos Aztecas sind die Drogen- und Matsbosse unter den bösen Fraktionen. Sie können bei Töten von Gegnern Materialien einsammeln und diese zu Waffen umbauen. Befehle können durch /fraktioncommands eingesehen werden.",
					[9] = "Angels of Death\n\nDie Angels of Death sind die Biker unter den Gangs. Sie können mit /formation und ihren Freeways sehr schnell fahren und jeden überholen oder abschütteln. Befehle können durch /fraktioncommands eingesehen werden.",
					[12] = "",
					[13] = "" },
	["Scheine"] = "Scheine\n\nUm Fahrzeuge benutzen zu können,\nbenötigst du einen jeweiligen Schein\n- Ebenso zum Angeln/Waffenerwerb.\nDiese erhälst du in der Stadthalle,\nwelche als gelber Punkt\nauf deinem Radar dargestellt ist.",
	["Ganggebiete"] = "Ganggebiete\n\nDie einzelnen Ganggebiete generieren -\nje nach Art - Geld, Drogen und\nMaterials. Die einzelnen Gangs können\ngegnerische Ganggebiete auch erobern, indem sie diese angreifen. Alle Gangwars finden in einer anderen Dimension statt und sind vom Script gesichert vor unerlaubten Waffen usw. Gangwarbefehle einsehbar per /gwbefehle",
	["Polizei"] = { [0] = "Polizei\n\nDie Aufgabe der Polizei ist es,\nfür Ordnung auf der Straße zu sorgen.\n\nFalls du ein Verbrechen begehst,\nwerden sie dich von weiteren Straftaten\nabhalten - notfalls mit Gewalt!\n\nHotline bei Verbrechen: 110",
					[1] = "San Fierro Police Department\n\nDeine Aufgabe als Polizist ist es,\nfür Ordnung auf der Strasse zu sorgen.\nUm den Polizeicomputer zu verwenden,\ndrücke die Spez. Missionen-Taste\nin einem Polizeifahrzeug oder\nklicke einen Computer an.\n\nBefehle:\n/tazer (Hotkey: 1)\n/(c)arrest [Name] [Zeit] [Geldstrafe] [Kaution]\n/takeweapons [Name] - Entwaffnen\n/cuff [Name]\n/takeillegal [Name] /frisk [Name]\n/duty /swat /offduty\n/t /g /mv /barricade\n/ticket /fstate /fdraw",
					[6] = "Federal Bureau of Investigation\n\nDeine Aufgabe als Agent ist es,\nAktionen aufzuhalten und Verbrecher zu fassen.\nUm den Polizeicomputer zu verwenden,\ndrücke die Spez. Missionen-Taste\nin einem SFPD/FBI Fahrzeug oder\nklicke einen Computer an. Befehle können durch /fraktioncommands eingesehen werden.",
					[8] = "Army\n\nDeine Aufgabe als Soldat ist es,\nGWDler auszubilden und Verbrecher zu fassen.\nUm den Polizeicomputer zu verwenden,\ndrücke die Spez. Missionen-Taste\nin einem Army Fahrzeug oder\nklicke einen Computer an.\n\n Befehle können durch /fraktioncommands eingesehen werden." },
	["Clicksystem"] = "Clicksystem\n\nBei Ultimate-Reallife gibt es zwei verschiedene\nArten, mit Objekten und Spielern\nzu interagieren.\nZum einen die klassischen Befehle,\nzum anderen ist es möglich,\nbestimmte Objekte nach drücken\nder Alt-Gr-Taste oder M anzuklicken und zu\ninteragieren.",
	["Job"] = { [0] = "Jobs\n\nBei Ultimate-Reallife verschiedene Arten, an Geld\nzu kommen. Am Anfang ist es am besten, sich\neinen Job zu suchen. Dazu trete in der\nStadthalle in den entsprechenden Kegel-\nnun hast du eine Markierung auf dem Radar,\nwo sich der Arbeitgeber befindet.\n\nInfo: Tippe /job, wenn du sie\nlöschen willst!",
				["fischer"] = "Job - Fischer\n\nDu bist im Moment Fischer - das heißt, du\nkannst Geld dadurch verdienen, indem du mit den\nFischerbooten, die durch ein Ankersymbol auf der\nKarte vermerkt sind, Checkpoints abfährst.\nJe mehr Fische gefangen werden, desto geringer ist der\nPreis, der für weitere Fische gezahlt wird -\mjedoch steigt dieser pro Stunde wieder an.\nBefehle können per /commands eingesehen werden!",
				["taxifahrer"] = "Job - Taxifahrer\n\nDu bist im Moment Taxifahrer - das heißt, du\nkannst Geld dadurch verdienen, indem du mit dem\nTexi ( erhältlich am $-Symbol auf der Karte )\nLeute von Ort zu Ort transportierst.\nDazu drücke die Spezialmissionen-Taste und\ndein Taxischild leutet auf. Nun zahlt dir jeder,\nder in dein Taxi steigt pro Zeit Geld.\nBefehle können per /commands eingesehen werden!",
				["dealer"] = "Job - Dealer\n\nDu bist im Moment Dealer - das heißt, du\nkannst Geld dadurch verdienen, indem du Drogen\nan deine Mitspieler verkaufst ( /givedrugs oder\nim Clickmenü unter \"Geben\" ). Neue\n\"Ware\" bekomsmt du, in dem du entweder\nfür Geld auf der Farm\nStoff kaufst oder aber Minimissionen\nmachst ( Lila Figur auf der Minimap ).\nBefehle können per /commands eingesehen werden!",
				["mechaniker"] = "Job - Mechaniker\n\nDu bist im Moment Mechaniker, d.h. du\nbist in der Lage, mit /repair [Name] [Preis]\nFahrzeuge deiner Mitspieler gegen Geld zu\nreparieren. Ausserdem kannst du Fahrzeuge von\nanderen Spielern Nitro einbauen.\nBefehle können per /commands eingesehen werden!",
				["wdealer"] = "Job - Waffendealer\n\nDu bist im Moment Waffendealer, d.h. du\nbist in der Lage, dir alle 10 Minuten\nneue Materialien mit /buymats beim Jobicon\nzu kaufen. Wenn du genug Materialien hast,\nkannst du mit /gunhelp eine Liste\nvon mgl. Waffen anzeigen, die du\ndann mit /sellgun [Name]\n[Gegenstand] verkaufen kannst.\nBefehle können per /commands eingesehen werden!",
				["trucker"] = "Job - Trucker\n\nDu bist im Moment Trucker, d.h. du\nkannst dir einen Truck gegen Vorschuss bei\ndem Truck-Icon mieten, und zu den ange-\ngebenen Koordinaten bringen - dort erhaelst\ndu dann dein Geld. Besser bezahlte\nAuftraege kannst du mit hoeherem Trucker-\nLevel ausfuehren (steigt bei erfolgreichen\nTransporten), jedoch nimmt der Schwierigkeitsgrad\nzu.\nBefehle können per /commands eingesehen werden!",
				["pizzaboy"] = "Job - Pizzabote\n\nDu bist im Moment Pizzabote, d.h. du kannst dein Geld durch das Beliefern von Pizza verdienen.\nBefehle können per /commands eingesehen werden!",
				["airport"] = "Job - Flughafenmitarbeiter\n\nDu arbeitest im Moment am Flughafen\nvon San Fierro.\nJe höher dein Flughafen-Level ist,\ndesto besser bezahlt kannst du arbeiten\n- vom Kofferpacker bis zum Jet-Pilot!\nUm einen Auftrag anzunehmen, gehe\nin das \"i\"-Symbols unterhalb des Terminals\nbeim Eingang des Parkhauses, um\nAufträge anzunehmen.\nBefehle können per /commands eingesehen werden!",
				["hitman"] = "Job - Hitman\n\nDu arbeitest im Moment als Profikiller.\nBefehle können per /commands eingesehen werden!",
				["hotdog"] = "Job - Hotdogverkäufer\n\nDu arbeitest im Moment als Hotdog-\nverkaeufer. Begib dich zum Besteck-Symbol,\nschnapp dir einen Hotdogwagen, belade ihn\nund klicken auf einen Spieler,\nwährend du im Truck sitzt und waehle \"geben\"\n->\"job\".\n\nBefehle können per /commands eingesehen werden!",
				["streetclean"] = "Job - Straßenreinigung\n\nDu arbeitest im Moment als\nStraßenreiniger; Begib dich zum\nSchrottplatz am Fuße des Mt. Chilliard,\num mit der Arbeit zu beginnen.\nBefehle können per /commands eingesehen werden!",
				["farmer"] = "Job - Farmer\n\nDu arbeitest im Moment als\nFarmer. Begib dich zur\nFarm an der Grenze von SF\nund LV nahe der Fleischberg-\nFabrik für mehr Infos.\nBefehle können per /commands eingesehen werden!",
				["bauarbeiter"] = "Job - Bauarbeiter\n\nDu arbeitest im Moment als Bauarbeiter.\nAb bestimmten Leveln kannst du besser verdienen.\nBefehle können per /commands eingesehen werden!",
				["busfahrer"] = "Job - Busfahrer\n\nDu bist Busfahrer, das heißt dein Job ist es\nvon Busstation zu Busstation\nzu fahren und falls vorhanden Passanten\nmitzunehmen.\nBefehle können per /commands eingesehen werden!",
				["transporteur"] = "\nBefehle können per /commands eingesehen werden!",
				["zugfuehrer"] = "Job - Zugführer\n\nDein Job ist es von Station zu Station\nzu fahren und\nfalls möglich Passanten mitzunehmen.\nBefehle können per /commands eingesehen werden!",
				--["gabelstablerjob"] = "\nBefehle können per /commands eingesehen werden!",
				["tramfuehrer"] = "Job - Tramführer\n\nAls Tramführer ist es\ndeine Aufgabe durch San Fierro\nzu fahren und Leute\neinsteigen zu lassen.\nBefehle können per /commands eingesehen werden!" },
	["Karte"] = "Karte\n\nDurch Drücken der \"F11\"-Taste kannst du\ndie Landkarte öffnen.\nGelber Punkt = Stadthalle\nBlaue Figur = Jobs\nAutosymbol = Autohaus\nAnker = Boot-Shop\nSirene = San Fierro Police Department\nSprühdose = Pay'n Spray ( Autolackierung )\nT-Shirt = Zip ( Kleidungsladen )\nPizzastück = Well Stacked Pizza\nRotes S = 24-7\nHerz = Stripclub\nTT = \"The Truth is out there!\"\nFlugzeug = Flugzeugverkauf\nTürkiser Totenkopf = Mistys Bar\nBurger = Burgershot\nGelbes Männchen = Präsident\nTruck - Matstruck/Drogentruck\nC = Carrob\ngrüner Dollar = Bank/Museum",
	["Daten"] = "Daten\n\nServeradresse:\n"..serverip.."\n\nTeamspeak 3:\n"..tsip.."\n\nForum:\n"..forumURL,
	["Befehle"] = "Befehle\n\nBefehle können per /commands eingesehen werden.\n\nAdminspezifische Befehle sind unter /admincommands\nFraktionsspezifische unter /fraktioncommands",
	["Hunger"] = "Auf diesem Server musst du\nregelmässig essen, um nicht zu\nverhungern. Drücke \"B\",um deinen aktuellen\nHunger anzuzeigen ( grüne Leiste ).\nSinkt sie unter 25%, so fängst du an,\nLeben zu verlieren. Essen kannst\ndu an Restaurants, an\nAutomaten oder auch bei Hot-\ndogverkäufern."
}
	
-- TO DO! AKTUALISIEREN! -- 

function SubmitHelpMenueAbbrechenBtn ( button )

	guiSetVisible(helpmenue_window,false)
	showCursor(false)
	setElementClicked ( false )
end

function SubmitGridClick( button )

	if button == "left" then
		local row = tostring ( guiGridListGetItemText ( gGrid["helpmenue"], guiGridListGetSelectedItem ( gGrid["helpmenue"] ), 1 ) )
		if row == "Gangs" or row == "Polizei" then
			local frac = getElementData ( lp, "fraktion" )
			if helpmenueText[row][frac] then
				guiSetText ( gLabel["helptext"], helpmenueText[row][frac] )
			else
				guiSetText ( gLabel["helptext"], helpmenueText[row][0] )
			end
		elseif row == "Job" then
			local job = vioClientGetElementData ( "job" )
			if helpmenueText[row][job] then
				guiSetText ( gLabel["helptext"], helpmenueText[row][job] )
			else
				guiSetText ( gLabel["helptext"], helpmenueText[row][0] )			
			end
		else
			guiSetText ( gLabel["helptext"], helpmenueText[row] )
		end
	end
end

function ShowHelpmenueGui_func()

	_CreateHelpmenueGui()
end
addEvent ( "ShowHelpmenueGui", true)
addEventHandler ( "ShowHelpmenueGui", getRootElement(), ShowHelpmenueGui_func)

function _CreateHelpmenueGui()

	if helpmenue_window then
		guiSetVisible ( helpmenue_window, true )
	else
		local screenwidth, screenheight = guiGetScreenSize ()
		
		helpmenue_window = guiCreateWindow(screenwidth/2-503/2, screenheight/2-389/2,503,389,"Hilfemenü",false)
		guiSetAlpha(helpmenue_window,1)
		gGrid["helpmenue"] = guiCreateGridList(0.0378,0.0925,0.3837,0.8586,true,helpmenue_window)
		guiGridListSetSelectionMode(gGrid["helpmenue"],2)
		
		gGrid["helpcolumn"] = guiGridListAddColumn(gGrid["helpmenue"],"Hilfemenue",1)
		
		gThemes["firststeps"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["rules"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["account"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["problems"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["admins"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["changelog"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["hunger"] = guiGridListAddRow(gGrid["helpmenue"])		
		gThemes["fahrzeuge"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["houses"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["punkte"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["geld"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["waffen"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["gangs"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["ganggs"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["scheine"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["polizei"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["clicksystem"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["job"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["karte"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["daten"] = guiGridListAddRow(gGrid["helpmenue"])
		gThemes["commands"] = guiGridListAddRow(gGrid["helpmenue"])		

		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["firststeps"], gGrid["helpcolumn"], "Erste Schritte", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["rules"], gGrid["helpcolumn"], "Serverregeln", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["account"], gGrid["helpcolumn"], "Account", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["problems"], gGrid["helpcolumn"], "Probleme", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["admins"], gGrid["helpcolumn"], "Admins", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["changelog"], gGrid["helpcolumn"], "Changelog", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["hunger"], gGrid["helpcolumn"], "Hunger", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["fahrzeuge"], gGrid["helpcolumn"], "Fahrzeuge", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["houses"], gGrid["helpcolumn"], "Häuser", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["punkte"], gGrid["helpcolumn"], "Bonuspunkte", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["geld"], gGrid["helpcolumn"], "Geld", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["waffen"], gGrid["helpcolumn"], "Waffen", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["gangs"], gGrid["helpcolumn"], "Gangs", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["ganggs"], gGrid["helpcolumn"], "Ganggebiete", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["scheine"], gGrid["helpcolumn"], "Scheine", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["polizei"], gGrid["helpcolumn"], "Polizei", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["clicksystem"], gGrid["helpcolumn"], "Clicksystem", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["job"], gGrid["helpcolumn"], "Job", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["karte"], gGrid["helpcolumn"], "Karte", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["daten"], gGrid["helpcolumn"], "Daten", false, false )
		guiGridListSetItemText ( gGrid["helpmenue"], gThemes["commands"], gGrid["helpcolumn"], "Befehle", false, false )
		
		addEventHandler("onClientGUIClick", gGrid["helpmenue"], SubmitGridClick, true)
		
		guiSetAlpha(gGrid["helpmenue"],1)
		gLabel["helptext"] = guiCreateLabel(0.4533,0.0951,0.5149,0.73,"Herzlich Wilkommen im Hilfemenü!\n\n\nUm es spüter erneut aufzurufen, drücke\ndie F1-Taste.\n\nHier findest du Informationen\nzu vielem, was du wissen solltest.\n\nBei weiteren Fragen wende dich bitte mit\n/report [Frage] direkt an einen\nder Admins",true,helpmenue_window) -- max. 19 Zeilen, ca. 45 Zeichen pro Zeile
		guiSetAlpha(gLabel["helptext"],1)
		guiLabelSetColor(gLabel["helptext"],255,255,0)
		guiLabelSetVerticalAlign(gLabel["helptext"],"top")
		guiLabelSetHorizontalAlign(gLabel["helptext"],"left",true)
		
		gButtons["abbrechenhelp"] = guiCreateButton(0.5964,0.8406,0.2167,0.108,"Abbrechen",true,helpmenue_window)
		guiSetAlpha(gButtons["abbrechenhelp"],1)
		addEventHandler("onClientGUIClick", gButtons["abbrechenhelp"], SubmitHelpMenueAbbrechenBtn, false)

		guiWindowSetSizable(helpmenue_window,false)
		guiWindowSetMovable(helpmenue_window,false)
		
		guiSetFont ( gLabel["helptext"], "default-bold-small" )
	end
end