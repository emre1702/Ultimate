lottoJackpotPath = "vio_stored_files/lotto/jackpot.vio"
local jackpotFile = fileOpen ( lottoJackpotPath, false )
local filesize = fileGetSize ( jackpotFile )
lottoJackpot = tonumber ( fileRead ( jackpotFile, filesize ) )
fileClose ( jackpotFile )

function lotto ( player )

	if vioGetElementData ( player, "loggedin" ) == 1 and string.upper ( getPlayerName ( player ) ) == string.upper ( "[Vio]Zipper" ) then
		drawLottoWinners ()
	end
end
addCommandHandler ( "lotto", lotto )

function drawLottoWinners ()

	local l1, l2, l3
	l1 = math.random ( 1, 12 )
	l2 = l1
	while l2 == l1 do
		l2 = math.random ( 1, 12 )
	end
	l3 = l2
	while l1 == l3 or l2 == l3 do
		l3 = math.random ( 1, 12 )
	end
	
	local array = { [1]=l1, [2]=l2, [3]=l3 }
	
	array = sortArray ( array )
	
	l1 = array[1]
	l2 = array[2]
	l3 = array[3]
	
	outputChatBox ( "Die Lottozahlen:", getRootElement(), 0, 125, 0 )
	
	setTimer ( outputChatBox, 50, 1, tostring ( l1 ), getRootElement(), 200, 0, 0 )
	setTimer ( outputChatBox, 100, 1, tostring ( l2 ), getRootElement(), 200, 0, 0 )
	setTimer ( outputChatBox, 150, 1, tostring ( l3 ), getRootElement(), 200, 0, 0 )
	
	setTimer ( getLottoWinners, 200, 1, l1, l2, l3 )
end

function getLottoWinners ( l1, l2, l3 )
	local jackpotArray = getLottoJackpotWinnerMySQL ( l1, l2, l3 )
	if jackpotArray then
		local jackpotstring = formNumberToMoneyString ( lottoJackpot )
		for i=1, #jackpotArray do
			local winnerName = jackpotArray[i]["name"]
			local winnerID = lottoWinner["id"]
			outputChatBox ( winnerName.." hat den Jackpot geknackt und gewinnt: "..jackpotstring, root, 200, 200, 0 )
			local player = getPlayerFromName ( winnerName )
			if player then
				outputChatBox ( "Du hast soeben im Lotto "..jackpotstring.." gewonnen!", player, 0, 200, 0 )
				outputChatBox ( "Das Geld liegt jetzt auf deinem Konto - viel Spaß!", player, 0, 200, 0 )
				vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) + lottoJackpot )
			else
				local money = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "Bankgeld", "userdata", "UID", playerUID[winnerName] ), -1 )[1]["Bankgeld"]
				dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Bankgeld", lottoJackpot + money, "UID", playerUID[winnerName] )
				offlinemsg ( "Du hast im Lotto "..jackpotstring.." gewonnen! Das Geld ist auf deinem Konto.", "Lotto", winnerName )
			end
		end
		lottoJackpot = 10000
		local file = fileCreate ( lottoJackpotPath )
		fileWrite ( file, "10000" )
		fileClose ( file )
	else
		lottoJackpot = lottoJackpot + 10000
		if lottoJackpot > 200000 then
			lottoJackpot = 200000
		end
		outputChatBox ( "Der Jackpot wurde nicht geknackt - damit steigt er auf "..formNumberToMoneyString ( lottoJackpot ).."!", root, 125, 0, 0 )	
		local file = fileCreate ( lottoJackpotPath )
		fileWrite ( file, tostring ( lottoJackpot ) )
		fileClose ( file )
	end
	dbExec ( handler, "TRUNCATE TABLE lotto" )
end


function requestLottoJackpot ()

	triggerClientEvent ( client, "recieveLottoJackpot", client, lottoJackpot )
end
addEvent ( "requestLottoJackpot", true )
addEventHandler ( "requestLottoJackpot", getRootElement(), requestLottoJackpot )

function recieveClientLotto ( l1, l2, l3 )

	local player = client
	local pname = getPlayerName ( player )
	
	l1 = math.abs ( math.floor ( tonumber ( l1 ) ) )
	l2 = math.abs ( math.floor ( tonumber ( l2 ) ) )
	l3 = math.abs ( math.floor ( tonumber ( l3 ) ) )
	
	if l1 >= 1 and l2 >= 1 and l3 >= 1 and l1 <= 12 and l2 <= 12 and l3 <= 12 then
		if l1 ~= l2 and l1 ~= l3 and l2 ~= l3 then
			local money = vioGetElementData ( player, "money" )
			if money >= 10 then
				local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "UID", "lotto", "UID", playerUID[pname] ), -1 ) 
				if not result or not result[1] or #result < 3 then
					local array = { [1]=l1, [2]=l2, [3]=l3 }
					
					array = sortArray ( array )
					
					l1 = array[1]
					l2 = array[2]
					l3 = array[3]
					
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 50 )
					
					dbExec ( handler, "INSERT INTO ?? (??,??,??,??) VALUES (?,?,?,?)", "lotto", "UID", "z1", "z2", "z3", playerUID[pname], l1, l2, l3 )
					
					infobox ( player, "Du hast ein Los\nerworben - die Ziehung\nfindet jeden Tag\n um 20:00 statt!", 5000, 0, 125, 0 )
					
					factionDepotData["money"][5] = factionDepotData["money"][5] + 50
				else
					infobox ( player, "Du kannst maximal\n3 Scheine ausfuellen!", 5000, 125, 0, 0 )
				end
			else
				infobox ( player, "Du hast nicht\ngenug Geld, um\neinen Lottoschein\nzu kaufen!", 5000, 125, 0, 0 )
			end
		end
	end
end
addEvent ( "recieveClientLotto", true )
addEventHandler ( "recieveClientLotto", getRootElement(), recieveClientLotto )