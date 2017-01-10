local logsArray = {}
local logsTypes = { ["allround"] = 1, ["admin"] = 2, ["damage"] = 3, ["Heilung"] = 4, ["Chat"] = 5, ["aktion"] = 6, ["Armor"] = 7, ["autodelete"] = 8, ["b-Chat"] = 9, ["casino"] = 10, 
					["death"] = 11, ["dmg"] = 12, ["drogen"] = 13, ["explodecar"] = 14, ["fguns"] = 15, ["fkasse"] = 15, ["gangwar"] = 16, ["Geld"] = 17, ["house"] = 18, ["kill"] = 19,
					["pwchange"] = 20, ["sellcar"] = 21, ["vehicle"] = 21, ["tazer"] = 22, ["Team-Chat"] = 23, ["weed"] = 24, ["werbung"] = 25 }

function outputLog ( text, logname )
	local logname = logname or "allround"
	logsArray[#logsArray+1] = { logsTypes[logname], logTimestamp()..": "..text, getRealTime().timestamp }
end


function logTimestamp ()
	local logtime = getRealTime()
	local year = tostring ( logtime.year + 1900 )
	local month = tostring ( logtime.month + 1 )
	local day = tostring ( logtime.monthday )
	local hour = tostring ( logtime.hour )
	local minute = tostring ( logtime.minute )
	local second = tostring ( logtime.second + 1 )
	
	if #month == 1 then
		month = "0"..month
	end
	if #day == 1 then
		day = "0"..day
	end
	if #hour == 1 then
		hour = "0"..hour
	end
	if #minute == 1 then
		minute = "0"..minute
	end
	if #second == 1 then
		second = "0"..second
	end
	
	return "["..day.."-"..month.."-"..year.." "..hour..":"..minute..":"..second.."]"
end


function putTheLogIntoMySQL ( )
	for i=1, #logsArray do
		dbExec ( handler, "INSERT INTO ?? (??,??,??) VALUE (?,?,?)", "logs", "Typ", "Text", "Timestamp", logsArray[i][1], logsArray[i][2], logsArray[i][3] )
	end
	logsArray = {}
end 
setTimer ( putTheLogIntoMySQL, 1*60*1000, 0 )
addEventHandler ( "onResourceStop", resourceRoot, putTheLogIntoMySQL )

