function number_func ( player, cmd, target )
	if target then
		local targetNR = getPlayerFromName ( target )
		if targetNR then
			local nr = vioGetElementData ( targetNR, "telenr" )
			if nr then
				outputChatBox ( "NR von "..target..": "..nr, player, 200, 200, 0 )
			end
		end
	end
end
addCommandHandler ( "number", number_func )

function sprunkAutomatUse_func ( )
	playSoundFrontEnd ( client, 40 )
	vioSetElementData ( client, "money", vioGetElementData ( client, "money" ) - 1 )
	if getElementHealth ( client ) + sprunkheal < 100 then
		setElementHealth ( client, getElementHealth ( client ) + sprunkheal )
	else
		setElementHealth ( client, 100 )
	end
	bizArray["Sprunk"]["kasse"] = bizArray["Sprunk"]["kasse"] + 5
end
addEvent ( "sprunkAutomatUse", true )
addEventHandler ( "sprunkAutomatUse", getRootElement(), sprunkAutomatUse_func )

function radiochange_func ( player, favchannel )
	vioSetElementData ( player, "favchannel", favchannel )
end
addEvent ( "radiochange", true )
addEventHandler ( "radiochange", getRootElement(), radiochange_func )

function showLicenses_func ( player )

	if player == client then
		local target = getPlayerFromName ( vioGetElementData ( player, "curclicked" ) )
		local pname = getPlayerName ( player )
		local licenses = ""
		if vioGetElementData ( player, "carlicense" ) == 1 then licenses = licenses.."Fuehrerschein " end
		if vioGetElementData ( player, "bikelicense" ) == 1 then licenses = licenses.."Motorradschein " end
		if vioGetElementData ( player, "fishinglicense" ) == 1 then licenses = licenses.."Angelschein " end
		if vioGetElementData ( player, "lkwlicense" ) == 1 then licenses = licenses.."LKW-Fuehrerschein " end
		if vioGetElementData ( player, "gunlicense" ) == 1 then licenses = licenses.."Waffenschein " end
		if vioGetElementData ( player, "motorbootlicense" ) == 1 then licenses = licenses.."Bootsfuehrerschein " end
		if vioGetElementData ( player, "segellicense" ) == 1 then licenses = licenses.."Segelschein " end
		if vioGetElementData ( player, "planelicenseb" ) == 1 then licenses = licenses.."Flugschein A " end
		if vioGetElementData ( player, "planelicensea" ) == 1 then licenses = licenses.."Flugschein B " end
		if vioGetElementData ( player, "helilicense" ) == 1 then licenses = licenses.."Flugschein C " end
		outputChatBox ( "Vorhandene Lizensen von "..pname..": ", target, 200, 0, 200 )
		outputChatBox ( licenses, target, 200, 200, 0 )
		outputChatBox ( "Du hast "..getPlayerName(target).." deine Scheine gezeigt!", player, 0, 125, 0 )
	end
end
addEvent ( "showLicenses", true )
addEventHandler ( "showLicenses", getRootElement(), showLicenses_func )

function showGWD_func ( player )

	if player == client then
		local target = getPlayerFromName ( vioGetElementData ( player, "curclicked" ) )
		local pname = getPlayerName ( player )
		outputChatBox ( "Du hast "..getPlayerName ( target ).." deine GWD-Note gezeigt!", player, 0, 125, 0 )
		outputChatBox ( getPlayerName ( player ).." zeigt dir seine GWD-Note: "..tostring(vioGetElementData(player,"armyperm10")).." %!", target, 125, 200, 125 )
	end
end
addEvent ( "showGWD", true )
addEventHandler ( "showGWD", getRootElement(), showGWD_func )