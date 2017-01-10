function loadAddictionsForPlayer ( player )

	local pname = getPlayerName ( player )
	local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "Rausch", "Sucht", "userdata", "UID", playerUID[pname] ), -1 )
	if result and result[1] then
		local dataString1 = result[1]["Rausch"]
		local dataString2 = result[1]["Sucht"]
		
		local cigarettFlushPoints = tonumber ( gettok ( dataString1, 1, string.byte ( '|' ) ) )
		local alcoholFlushPoints = tonumber ( gettok ( dataString1, 2, string.byte ( '|' ) ) )
		local drugFlushPoints = tonumber ( gettok ( dataString1, 3, string.byte ( '|' ) ) )
		
		local cigarettAddictPoints = tonumber ( gettok ( dataString2, 1, string.byte ( '|' ) ) )
		local alcoholAddictPoints = tonumber ( gettok ( dataString2, 2, string.byte ( '|' ) ) )
		local drugAddictPoints = tonumber ( gettok ( dataString2, 3, string.byte ( '|' ) ) )
		
		vioSetElementData ( player, "cigarettFlushPoints", cigarettFlushPoints )
		vioSetElementData ( player, "alcoholFlushPoints", alcoholFlushPoints )
		vioSetElementData ( player, "drugFlushPoints", drugFlushPoints )

		vioSetElementData ( player, "cigarettAddictPoints", cigarettAddictPoints )
		vioSetElementData ( player, "alcoholAddictPoints", alcoholAddictPoints )
		vioSetElementData ( player, "drugAddictPoints", drugAddictPoints )
	end
end

function saveAddictionsForPlayer ( player )

	local pname = getPlayerName ( player )
	
	local dataString1 = vioGetElementData ( player, "cigarettFlushPoints" ).."|"..vioGetElementData ( player, "alcoholFlushPoints" ).."|"..vioGetElementData ( player, "drugFlushPoints" ).."|"
	local dataString2 = vioGetElementData ( player, "cigarettAddictPoints" ).."|"..vioGetElementData ( player, "alcoholAddictPoints" ).."|"..vioGetElementData ( player, "drugAddictPoints" ).."|"
	
	dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "userdata", "Rausch", dataString1, "Sucht", dataString2, "UID", playerUID[pname] )
end