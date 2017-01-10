local gMysqlHost = "HOST"
local gMysqlUser = "USER"
local gMysqlPass = "PASS"
local gMysqlDatabase = "DATABASE"
handler = nil
playerUID = {}
playerUIDName = {}


function MySQL_Startup ( ) 
	handler = dbConnect ( "mysql", "dbname=".. gMysqlDatabase .. ";host="..gMysqlHost..";port=3306", gMysqlUser, gMysqlPass )
	if not handler then
		outputDebugString("[MySQL_Startup] Couldn't run query: Unable to connect to the MySQL server!")
		outputDebugString("[MySQL_Startup] Please shutdown the server and start the MySQL server!")
		return
	end	
	local result = dbPoll ( dbQuery ( handler, "SELECT ??,?? FROM ??", "UID", "Name", "players" ), -1 )
	for i=1, #result do
		local id = tonumber ( result[i]["UID"] )
		local name = result[i]["Name"]
		playerUID[name] = id
		playerUIDName[id] = name
	end
	playerUIDName[0] = "none"
	playerUID["none"] = 0
end
MySQL_Startup()


function saveEverythingForScriptStop ( )
	saveDepotInDB()
	updateBizKasse()
end
addEventHandler ( "onResourceStop", resourceRoot, saveEverythingForScriptStop )
