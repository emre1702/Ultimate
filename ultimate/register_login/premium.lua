function isPremium ( player )

	--[[local pname = getPlayerName ( player )
	local curtime = getRealTime()
	local year = curtime.year + 1900
	local month = curtime.month
	local day = curtime.monthday
	local hour = curtime.hour
	local minute = curtime.minute
	local yearday  = curtime.yearday+1
	local PremDay = tonumber ( MySQL_GetString("bonustable", "PremiumUntilDay", "Name LIKE '" ..pname.."'") )
	local PremYear = tonumber ( MySQL_GetString("bonustable", "PremiumUntilYear", "Name LIKE '" ..pname.."'") )
	if PremDay and PremYear then
		if PremDay >= yearday and PremYear >= year then
			local restdays = (PremYear-year)*365+(PremDay-yearday)
			outputChatBox ( "Premium-Status: Aktiv fuer "..restdays.." weitere Tage!", player, 0, 125, 0 )
			vioSetElementData ( player, "premium", true )
		elseif PremYear > year then
			local restdays = (PremYear-year)*365+(PremDay-yearday)
			outputChatBox ( "Premium-Status: Aktiv fuer "..restdays.." weitere Tage!", player, 0, 125, 0 )
			vioSetElementData ( player, "premium", true )
		elseif tonumber ( vioGetElementData ( player, "adminlvl" ) ) >= 1 then
			outputChatBox ( "Premium-Status: Aktiv (Du bist Admin)", player, 0, 125, 0 )
			vioSetElementData ( player, "premium", true )
		else
			outputChatBox ( "Premium-Status: Nicht aktiv", player, 125, 0, 0 )
			vioSetElementData ( player, "premium", false )
		end
	end]]
end

function setPremiumData ( player )

	--[[if vioGetElementData ( player, "premium" ) then
		vioSetElementData ( player, "maxcars", 10 )
		triggerClientEvent ( player, "loadFriendlist", getRootElement() )
	else
		if tonumber ( vioGetElementData ( player, "maxcars" ) ) > 5 then
			if vioGetElementData ( player, "carslotupgrade" ) == "buyed" then
				vioSetElementData ( player, "maxcars", 5 )
			else
				vioSetElementData ( player, "maxcars", 3 )
			end
		end
	end
	if vioGetElementData ( player, "adminlvl" ) >= 1 then
	elseif vioGetElementData ( player, "carslotupgrade" ) == "buyed" then
		vioSetElementData ( player, "maxcars", 5 )
	else
		vioSetElementData ( player, "maxcars", 3 )
	end]]
end
--[[
Aktuelle Premium Funktionen:

10 Carslots

Gratis PMs

Beim Tod 50% weniger Geld verlieren

Spawn mit Schlagring

Friendlist

Premium Autohaus mit:
Oceanic, Euros, Stunflugzeug, Burrito, Phoenix, Sabre, Hotknife
]]