local curTicketToAnswere = ""
local curTicketTyp = 1

function showSupportMenue ()

	if not isCursorShowing () and not getElementClicked() then
		gWindow["helpMenue"] = guiCreateWindow(screenwidth/2-310/2,screenheight/2-300/2,310,300,"Hilfemenü",false)
		guiSetAlpha(gWindow["helpMenue"],1)
		
		gRadio["fastHelp"] = guiCreateRadioButton(9,68,111,21,"Schnellhilfe",false,gWindow["helpMenue"])
		guiSetAlpha(gRadio["fastHelp"],1)
		guiSetFont(gRadio["fastHelp"],"default-bold-small")
		gRadio["questions"] = guiCreateRadioButton(122,68,80,21,"Fragen",false,gWindow["helpMenue"])
		guiSetAlpha(gRadio["questions"],1)
		guiSetFont(gRadio["questions"],"default-bold-small")
		gRadio["requests"] = guiCreateRadioButton(204,68,96,21,"Anfragen",false,gWindow["helpMenue"])
		guiSetAlpha(gRadio["requests"],1)
		guiSetFont(gRadio["requests"],"default-bold-small")
		
		addToolTip ( gRadio["fastHelp"],  "Hier kannst du\num Hilfe fragen,\nwenn du schnelle\nHilfe benötigst - z.B.\nwenn du irgendwo\nhängen bleibst" )
		addToolTip ( gRadio["questions"], "Hier kannst du\nnach kleineren\nSachen fragen -\nz.B. wie man\neiner Fraktion bei-\ntreten kann." )
		addToolTip ( gRadio["requests"],  "Hier kannst du\nbei Admins z.B.\nFahrzeugersatz be-\nantragen." )
		
		guiRadioButtonSetSelected ( gRadio["fastHelp"], true )
		
		gMemo["text"] = guiCreateMemo(9,107,292,132,"",false,gWindow["helpMenue"])
		guiSetAlpha(gMemo["text"],1)
		
		gButton["sendSupportQuestion"] = guiCreateButton(38,251,89,37,"Senden",false,gWindow["helpMenue"])
		guiSetAlpha(gButton["sendSupportQuestion"],1)
		guiSetFont(gButton["sendSupportQuestion"],"default-bold-small")
		gButton["cancelSupport"] = guiCreateButton(181,251,89,37,"Abbrechen",false,gWindow["helpMenue"])
		guiSetAlpha(gButton["cancelSupport"],1)
		guiSetFont(gButton["cancelSupport"],"default-bold-small")

		gLabel[1] = guiCreateLabel(10,21,290,47,"Hier kannst du dich mit Administratoren in Verbin-\ndung setzen, wenn du schnelle Hilfe brauchst. Für\ngrößere Probleme nutze das Forum. ",false,gWindow["helpMenue"])
		guiSetAlpha(gLabel[1],1)
		guiLabelSetColor(gLabel[1],200,200,0)
		guiLabelSetVerticalAlign(gLabel[1],"top")
		guiLabelSetHorizontalAlign(gLabel[1],"left",false)
		guiSetFont(gLabel[1],"default-bold-small")
		gLabel[2] = guiCreateLabel(0,90,310,14,"Schildere dein Problem:",false,gWindow["helpMenue"])
		guiSetAlpha(gLabel[2],1)
		guiLabelSetColor(gLabel[2],0,255,0)
		guiLabelSetVerticalAlign(gLabel[2],"top")
		guiLabelSetHorizontalAlign(gLabel[2],"center",false)
		guiSetFont(gLabel[2],"default-bold-small")
		
		showCursor ( true )
		setElementClicked ( true )
		
		addEventHandler ( "onClientGUIClick", gButton["sendSupportQuestion"],
			function ()
				local text = guiGetText ( gMemo["text"] )
				if #text > 5 then
					local kathegory
					if guiRadioButtonGetSelected ( gRadio["fastHelp"] ) then
						kathegory = 1
					elseif guiRadioButtonGetSelected ( gRadio["questions"] ) then
						kathegory = 2
					elseif guiRadioButtonGetSelected ( gRadio["requests"] ) then
						kathegory = 3
					end
					triggerServerEvent ( "orderSupportTicket", lp, kathegory, text )
				else
					outputChatBox ( "Bitte gib einen Text ein!", 200, 0, 0 )
				end
			end,
		false )
		addEventHandler ( "onClientGUIClick", gButton["cancelSupport"],
			function ()
				showCursor ( false )
				setElementClicked ( false )
				destroyElement ( gWindow["helpMenue"] )
			end,
		false )
	end
end
--addCommandHandler ( "support", showSupportMenue )

function recieveTicketDetails ( text )

	guiSetText ( gMemo["ticketText"], text )
end
addEvent ( "recieveTicketDetails", true )
addEventHandler ( "recieveTicketDetails", getRootElement (), recieveTicketDetails )

function answereTickets ()

	if not getElementClicked() then
		curTicketToAnswere = ""
		
		setElementClicked ( true )
		showCursor ( true )
		gWindow["supporterWindow"] = guiCreateWindow(screenwidth/2-426/2,screenheight/2-465/2,426,465,"Supportmenü",false)
		guiSetAlpha(gWindow["supporterWindow"],1)
		gGrid["availableTickets"] = guiCreateGridList(9,23,195,279,false,gWindow["supporterWindow"])
		guiGridListSetSelectionMode(gGrid["availableTickets"],2)
		gColumn["ticketName"] = guiGridListAddColumn(gGrid["availableTickets"],"Von",0.8)
		guiSetAlpha(gGrid["availableTickets"],1)
		
		addEventHandler ( "onClientGUIClick", gGrid["availableTickets"],
			function ()
				local text = guiGridListGetItemText ( gGrid["availableTickets"], guiGridListGetSelectedItem ( gGrid["availableTickets"] ), 1 )
				if text then
					guiSetText ( gMemo["ticketText"], "Ticket wird geladen..." )
					triggerServerEvent ( "recieveTicketDetails", lp, text )
					curTicketToAnswere = text
				end
			end,
		false )
		
		gRadio["questions"] = guiCreateRadioButton(222,41,100,19,"Fragen",false,gWindow["supporterWindow"])
		guiSetAlpha(gRadio["questions"],1)
		guiSetFont(gRadio["questions"],"default-bold-small")
		guiRadioButtonSetSelected ( gRadio["questions"], true )
		gRadio["fastHelp"] = guiCreateRadioButton(222,60,100,19,"Schnellhilfe",false,gWindow["supporterWindow"])
		guiSetAlpha(gRadio["fastHelp"],1)
		guiSetFont(gRadio["fastHelp"],"default-bold-small")
		gRadio["requests"] = guiCreateRadioButton(222,80,100,19,"Anfragen",false,gWindow["supporterWindow"])
		guiSetAlpha(gRadio["requests"],1)
		guiSetFont(gRadio["requests"],"default-bold-small")
		
		gMemo["ticketText"] = guiCreateMemo(209,119,207,184,"Bitte wähle ein Ticket aus der Liste!",false,gWindow["supporterWindow"])
		guiSetAlpha(gMemo["ticketText"],1)
		guiMemoSetReadOnly(gMemo["ticketText"],true)
		gMemo["ticketAnswere"] = guiCreateMemo(9,323,194,130,"",false,gWindow["supporterWindow"])
		guiSetAlpha(gMemo["ticketAnswere"],1)
		
		gButton[1] = guiCreateButton(213,324,110,38,"Senden und Ticket\nschließen",false,gWindow["supporterWindow"])
		guiSetAlpha(gButton[1],1)
		guiSetFont(gButton[1],"default-bold-small")
		addEventHandler ( "onClientGUIClick", gButton[1],
			function ()
				triggerServerEvent ( "ticketDone", lp, curTicketToAnswere, 1, guiGetText ( gMemo["ticketAnswere"] ) )
				checkForTickets ( curTicketTyp )
			end,
		false )
		gButton[2] = guiCreateButton(213,370,110,38,"Ticket\nschließen",false,gWindow["supporterWindow"])
		guiSetAlpha(gButton[2],1)
		guiSetFont(gButton[2],"default-bold-small")
		addEventHandler ( "onClientGUIClick", gButton[2],
			function ()
				triggerServerEvent ( "ticketDone", lp, curTicketToAnswere, 0 )
				checkForTickets ( curTicketTyp )
			end,
		false )
		gButton[3] = guiCreateButton(213,416,110,38,"Fenster\nschließen",false,gWindow["supporterWindow"])
		guiSetAlpha(gButton[3],1)
		guiSetFont(gButton[3],"default-bold-small")
		addEventHandler ( "onClientGUIClick", gButton[3],
			function ()
				destroyElement ( gWindow["supporterWindow"] )
				setElementClicked ( false )
				showCursor ( false )
			end,
		false )
		
		addEventHandler ( "onClientGUIClick", gRadio["questions"],
			function ()
				checkForTickets ( 2 )
				curTicketTyp = 2
			end,
		false )
		addEventHandler ( "onClientGUIClick", gRadio["fastHelp"],
			function ()
				checkForTickets ( 1 )
				curTicketTyp = 1
			end,
		false )
		addEventHandler ( "onClientGUIClick", gRadio["requests"],
			function ()
				checkForTickets ( 3 )
				curTicketTyp = 3
			end,
		false )
		
		gLabel[1] = guiCreateLabel(209,24,92,17,"Art des Tickets:",false,gWindow["supporterWindow"])
		guiSetAlpha(gLabel[1],1)
		guiLabelSetColor(gLabel[1],255,255,255)
		guiLabelSetVerticalAlign(gLabel[1],"top")
		guiLabelSetHorizontalAlign(gLabel[1],"left",false)
		guiSetFont(gLabel[1],"default-bold-small")
		gLabel[2] = guiCreateLabel(210,101,35,16,"Text:",false,gWindow["supporterWindow"])
		guiSetAlpha(gLabel[2],1)
		guiLabelSetColor(gLabel[2],255,255,255)
		guiLabelSetVerticalAlign(gLabel[2],"top")
		guiLabelSetHorizontalAlign(gLabel[2],"left",false)
		guiSetFont(gLabel[2],"default-bold-small")
		gLabel[3] = guiCreateLabel(9,306,53,17,"Antwort:",false,gWindow["supporterWindow"])
		guiSetAlpha(gLabel[3],1)
		guiLabelSetColor(gLabel[3],255,255,255)
		guiLabelSetVerticalAlign(gLabel[3],"top")
		guiLabelSetHorizontalAlign(gLabel[3],"left",false)
		guiSetFont(gLabel[3],"default-bold-small")
		
		checkForTickets ( 1 )
	end
end
--addCommandHandler ( "tickets", answereTickets )

function checkForTickets ( typ )

	guiSetText ( gMemo["ticketText"], "Bitte wähle ein Ticket aus der Liste!" )
	guiSetText ( gMemo["ticketAnswere"], "" )
	
	guiGridListClear ( gGrid["availableTickets"] )
	local row = guiGridListAddRow ( gGrid["availableTickets"] )
	guiGridListSetItemText ( gGrid["availableTickets"], row, gColumn["ticketName"], "Lade tickets...", true, false )
	
	triggerServerEvent ( "retrieveTicketList", lp, typ )
end

function thereAreNoTickets ()

	guiGridListClear ( gGrid["availableTickets"] )
	local row = guiGridListAddRow ( gGrid["availableTickets"] )
	guiGridListSetItemText ( gGrid["availableTickets"], row, gColumn["ticketName"], "Keine Tickets vorhanden!", true, false )
end
addEvent ( "thereAreNoTickets", true )
addEventHandler ( "thereAreNoTickets", getRootElement (), thereAreNoTickets )

function recieveTicketList ( typ, tickets )

	if isElement ( gWindow["supporterWindow"] ) then
		if typ == 1 then 	 -- Schnellhilfe
			guiGridListClear ( gGrid["availableTickets"] )
			for key, index in pairs ( tickets ) do
				local row = guiGridListAddRow ( gGrid["availableTickets"] )
				guiGridListSetItemText ( gGrid["availableTickets"], row, gColumn["ticketName"], index["name"], false, false )
			end
		elseif typ == 2 then -- Fragen
			guiGridListClear ( gGrid["availableTickets"] )
			for key, index in pairs ( tickets ) do
				local row = guiGridListAddRow ( gGrid["availableTickets"] )
				guiGridListSetItemText ( gGrid["availableTickets"], row, gColumn["ticketName"], index, false, false )
			end
		elseif typ == 3 then -- Anfragen
			guiGridListClear ( gGrid["availableTickets"] )
			for key, index in pairs ( tickets ) do
				local row = guiGridListAddRow ( gGrid["availableTickets"] )
				guiGridListSetItemText ( gGrid["availableTickets"], row, gColumn["ticketName"], index, false, false )
			end
		end
	end
end
addEvent ( "recieveTicketList", true )
addEventHandler ( "recieveTicketList", getRootElement(), recieveTicketList )

function readTicketAnswere ( text, supporter )

	setElementClicked ( true )
	showCursor ( true )
	
	gWindow["supportTicket"] = guiCreateWindow(screenwidth/2-299/2,screenheight/2-271/2,299,271,"Ticket",false)
	guiSetAlpha(gWindow["supportTicket"],1)
	gMemo["ticketAnswere"] = guiCreateMemo(10,42,280,168,text,false,gWindow["supportTicket"])
	guiSetAlpha(gMemo["ticketAnswere"],1)
	guiMemoSetReadOnly(gMemo["ticketAnswere"],true)
	gLabel[1] = guiCreateLabel(12,22,265,17,"Antwort von "..supporter..":",false,gWindow["supportTicket"])
	guiSetAlpha(gLabel[1],1)
	guiLabelSetColor(gLabel[1],255,255,255)
	guiLabelSetVerticalAlign(gLabel[1],"top")
	guiLabelSetHorizontalAlign(gLabel[1],"left",false)
	guiSetFont(gLabel[1],"default-bold-small")
	
	gButton[1] = guiCreateButton(102,220,107,40,"Schließen",false,gWindow["supportTicket"])
	guiSetAlpha(gButton[1],1)
	guiSetFont(gButton[1],"default-bold-small")
	addEventHandler ( "onClientGUIClick", gButton[1],
		function ()
			destroyElement ( gWindow["supportTicket"] )
			setElementClicked ( false )
			showCursor ( false )
		end,
	false )
end
addEvent ( "readTicketAnswere", true )
addEventHandler ( "readTicketAnswere", getRootElement (), readTicketAnswere )