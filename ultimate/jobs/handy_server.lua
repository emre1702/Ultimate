function handychange_func ( player )

	if player == client then
		if vioGetElementData ( player, "handystate" ) == "on" then
			vioSetElementData ( player, "handystate", "off" )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nHandy ausgeschaltet!", 5000, 0, 200, 0 )
		else
			vioSetElementData ( player, "handystate", "on" )
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nHandy angeschaltet!", 5000, 0, 200, 0 )
		end
	end
end
addEvent ( "handychange", true )
addEventHandler ( "handychange", getRootElement(), handychange_func )

function smscmd_func ( player, cmd, number, ... )

	if number then
		local parametersTable = {...}
		local sendtext = table.concat( parametersTable, " " )
		if sendtext then
			if #sendtext >= 1 then
				SMS_func ( player, tonumber(number), sendtext )
			else
				outputChatBox ( "Bitte gib einen Text ein!", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Bitte gib einen Text ein!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Bitte gib eine gueltige Nummer an!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "sms", smscmd_func )

function callcmd_func ( player, cmd, number )

	callSomeone_func ( player, number )
end
addCommandHandler ( "call", callcmd_func )

function SMS_func ( player, sendnr, sendtext )

	if player == client or not client then
		if vioGetElementData ( player, "handystate" ) == "on" then
			local pmoney = vioGetElementData ( player, "money" )
			if ( vioGetElementData ( player, "handyType" ) == 2 and vioGetElementData ( player, "handyCosts" ) >= smsprice ) or vioGetElementData ( player, "handyType" ) ~= 2 then
				local players = getElementsByType("player")
				for i=1, #players do 
					local playeritem = players[i]
					if vioGetElementData ( playeritem, "telenr" ) then
						if vioGetElementData ( playeritem, "telenr" ) == sendnr then
							if vioGetElementData ( playeritem, "handystate" ) == "on" then
								triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSMS versendet!", 5000, 0, 200, 0 )
								playSoundFrontEnd ( player, 40 )
								triggerClientEvent ( playeritem, "phonesms", player )
								outputChatBox ( "SMS von "..getPlayerName(player).."("..vioGetElementData(player,"telenr").."): "..sendtext, playeritem, 255, 255, 0 )
								if vioGetElementData ( player, "handyType" ) == 2 then
									vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) - smsprice )
								elseif vioGetElementData ( player, "handyType" ) == 1 then
									vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) + smsprice )
								end
								return
							end
						end
					end
				end
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Das Handy des\nSpielers ist ausge-\nschaltet oder der\nSpieler ist nicht\nonline!", 7500, 125, 0, 0 )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\nmehr genug Guthaben!\nDu kannst im 24-7\ndein Guthaben\naufladen.", 5000, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDein Handy ist\naus!", 5000, 125, 0, 0 )
		end
	end
end
addEvent ( "SMS", true )
addEventHandler ( "SMS", getRootElement(), SMS_func )

function callSomeone_func ( player, number )

	if player == client or not client then
		if vioGetElementData ( player, "handystate" ) == "on" then
			local pmoney = vioGetElementData ( player, "money" )
			if number == "*100#" then
				if vioGetElementData ( player, "handyType" ) == 2 then
					outputChatBox ( "Aktuelles Guthaben: "..vioGetElementData ( player, "handyCosts" ).." $", player, 200, 200, 0 )
				elseif vioGetElementData ( player, "handyType" ) == 3 then
					outputChatBox ( "Du hast eine Flatrate, Kosten pro Stunde: 50 $", player, 200, 200, 0 )
				elseif vioGetElementData ( player, "handyType" ) == 1 then
					outputChatBox ( "Aktuelle Kosten: "..vioGetElementData ( player, "handyCosts" ).." $", player, 200, 200, 0 )
				end
			elseif not speznr[tonumber(number)] then
				number = tonumber ( number )
				if ( vioGetElementData ( player, "handyType" ) == 2 and vioGetElementData ( player, "handyCosts" ) >= callprice ) or vioGetElementData ( player, "handyType" ) ~= 2 then
					local players = getElementsByType("player")
					for i=1, #players do 
						local playeritem = players[i]
						if vioGetElementData ( playeritem, "telenr" ) then
							if vioGetElementData ( playeritem, "telenr" ) == number then
								if vioGetElementData ( playeritem, "handystate" ) == "on" then
									if not vioGetElementData ( player, "call" ) then
										if not vioGetElementData ( playeritem, "call" ) then
											outputChatBox ( "Tippe /hangup ( /hup ), um aufzulegen!", player, 200, 200, 200 )
											outputChatBox ( getPlayerName(player).." (Nummer: "..vioGetElementData(player,"telenr")..") ruft an, tippe /pickup ( /pup ) um abzunehmen!", playeritem, 50, 125, 0 )
											vioSetElementData ( player, "calls", playeritem )
											vioSetElementData ( player, "call", true )
											vioSetElementData ( playeritem, "calledby", player )
											triggerClientEvent ( player, "phonewartezeichen", player )
											triggerClientEvent ( playeritem, "phonesound", player )
											if vioGetElementData ( player, "handyType" ) == 2 then
												vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) - callprice )
											elseif vioGetElementData ( player, "handyType" ) == 1 then
												vioSetElementData ( player, "handyCosts", vioGetElementData ( player, "handyCosts" ) + callprice )
											end
											return
										else
											outputChatBox ( "Besetzt...", player, 125, 0, 0 )
											triggerClientEvent ( player, "phonesound", player )
										end
									else
										outputChatBox ( "Du telefonierst bereits!", player, 125, 0, 0 )
									end
								else
									outputChatBox ( "Handy ist ausgeschaltet!", player, 125, 0, 0 )
								end
								return
							end
						end
					end
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Das Handy des\nSpielers ist ausge-\nschaltet oder der\nSpieler ist nicht\nonline!", 7500, 125, 0, 0 )
					triggerClientEvent ( player, "phonekeinanschluss", player )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast nicht\ngenug Geld!\nEin Anruf kostet\n"..callprice.." $!", 7500, 125, 0, 0 )
				end
			else
				--speznr = { [110]=true, [112]=true, [300]=true, [400]=true }
				number = tonumber ( number )
				if number == 110 then
					outputChatBox ( "Sie sprechen mit der Polizei von San Fierro - bitte nennen Sie den Namen des Täters.", player, 0, 0, 125 )
					vioSetElementData ( player, "callswithpolice", true )
				elseif number == 112 then
					if getFactionMembersOnline(10) > 0 then
						outputChatBox ( "Sie sprechen mit dem Krankenhaus von San Fierro - bitte nennen Sie uns ihr Anliegen.", player, 0, 0, 125 )
						vioSetElementData ( player, "callswithmedic", true )
					else
						outputChatBox ( "Tut uns Leid, jedoch sind alle Sanitäter anderweitig beschäftigt.", player, 0, 0, 125 )
					end
				elseif number == 300 then
					if getFactionMembersOnline(11) > 0 then
						outputChatBox ( "Sie sprechen mit dem Mechanikerzentrum von San Fierro - bitte nennen Sie uns ihr Anliegen.", player, 0, 0, 125 )
						vioSetElementData ( player, "callswithmechaniker", true )
					else
						outputChatBox ( "Tut uns Leid, jedoch sind alle Mechaniker anderweitig beschäftigt.", player, 0, 0, 125 )
					end
				elseif number == 400 then
					orderTaxi ( player )
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDein Handy ist\naus!", 7500, 125, 0, 0 )
		end
	end
end
addEvent ( "callSomeone", true )
addEventHandler ( "callSomeone", getRootElement(), callSomeone_func )

function hangup ( player )
	if isElement ( vioGetElementData ( player, "callswith" ) ) then
		local caller = vioGetElementData ( player, "callswith" )
		vioSetElementData ( caller, "call", false )
		vioSetElementData ( caller, "callswith", "none" )
		vioSetElementData ( caller, "calledby", "none" )
		vioSetElementData ( caller, "calls", "none" )
		outputChatBox ( "Aufgelegt.", caller, 200, 200, 200 )
		triggerClientEvent ( caller, "stopphonesound", caller )
	elseif isElement ( vioGetElementData ( player, "calledby" ) ) then
		local caller = vioGetElementData ( player, "calledby" )
		vioSetElementData ( caller, "call", false )
		vioSetElementData ( caller, "callswith", "none" )
		vioSetElementData ( caller, "calledby", "none" )
		vioSetElementData ( caller, "calls", "none" )
		triggerClientEvent ( caller, "stopphonesound", caller )
		outputChatBox ( "Aufgelegt.", caller, 200, 200, 200 )
	end
	vioSetElementData ( player, "call", false )
	vioSetElementData ( player, "callswith", "none" )
	vioSetElementData ( player, "calledby", "none" )
	vioSetElementData ( player, "calls", "none" )
	outputChatBox ( "Aufgelegt.", player, 200, 200, 200 )
	triggerClientEvent ( player, "stopphonesound", player )
end
addCommandHandler ( "hangup", hangup )
addCommandHandler ( "hup", hangup )


function pickup ( player )

	local caller = vioGetElementData ( player, "calledby" )
	vioSetElementData ( player, "calledby", "none" )
	if isElement ( caller ) then
		vioSetElementData ( player, "call", true )
		vioSetElementData ( caller, "call", true )
		vioSetElementData ( player, "callswith", caller )
		vioSetElementData ( caller, "callswith", player )
		vioSetElementData ( player, "calledby", "none" )
		vioSetElementData ( caller, "calledby", "none" )
		vioSetElementData ( player, "calls", "none" )
		vioSetElementData ( caller, "calls", "none" )
		triggerClientEvent ( player, "stopphonesound", player )
		triggerClientEvent ( caller, "stopphonesound", caller )
		outputChatBox ( "Abgehoben.", player, 0, 125, 0 )
		outputChatBox ( "Abgehoben.", caller, 0, 125, 0 )
	else
		outputChatBox ( "Du kannst keinen Anruf annehmen!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "pickup", pickup )
addCommandHandler ( "pup", pickup )