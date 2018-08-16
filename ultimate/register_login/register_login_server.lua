_G["Clantag"] = "no"
setGlitchEnabled ( "fastsprint", true )

clanMembers = {}
ticketPermitted = {}

addEventHandler ( "onPlayerConnect", getRootElement(), function ( nick, ip, uname, serial )
	if nick == "Player" then
		cancelEvent ( true, "Bitte wähle einen Nickname ( Unter \"Settings\" )" )
	elseif string.find ( nick, "mtasa" ) then
		cancelEvent ( true, "Fuck you!" )
	elseif string.find ( nick, "'" ) then
		cancelEvent ( true, "Bitte kein ' benutzen!" )
	else
		local result = nil
		if playerUID[nick] then 
			result = dbPoll ( dbQuery ( handler, "SELECT STime, Grund, AdminUID FROM ?? WHERE UID=? OR ??=?", "ban", playerUID[nick], "Serial", serial ), -1 )
		else
			result = dbPoll ( dbQuery ( handler, "SELECT STime, Grund, AdminUID FROM ?? WHERE ??=?", "ban", "Serial", serial ), -1 )
		end
		local deleteit = false
		if result and result[1] then
			for i=1, #result do
				if result[i]["STime"] ~= 0 and ( result[i]["STime"] - getTBanSecTime ( 0 ) ) <= 0 then
					deleteit = true
				else
					local reason = result[i]["Grund"]
					local admin = playerUIDName[tonumber ( result[i]["AdminUID"] )]
					local diff = math.floor ( ( ( result[i]["STime"] - getTBanSecTime ( 0 ) ) / 60 ) * 100 ) / 100
					if diff >= 0 then
						cancelEvent ( true, "Du bist noch "..diff.." Stunden von "..tostring(admin).." gesperrt, Grund: "..tostring(reason) )
					else
						cancelEvent ( true, "Du wurdest permanent von "..tostring(admin).." gesperrt, Grund: "..tostring(reason) )
					end
					return
				end
			end
			if deleteit then
				if playerUID[nick] then
					dbExec ( handler, "DELETE FROM ?? WHERE UID=? OR Serial=?", "ban", "UID", playerUID[nick], serial )
				else
					dbExec ( handler, "DELETE FROM ?? WHERE Serial=?", "ban", serial )
				end
			end
		elseif getPlayerWarnCount ( nick ) >= 3 then
			cancelEvent ( true, "Du hast 3 Warns! Ablaufdatum des nächsten Warns: "..getLowestWarnExtensionTime ( nick ) )
		end
	end
	insertPlayerIntoLoggedIn ( nick, ip, serial )
end )


function regcheck_func ( player )

	setPedStat ( player, 22, 50 )
	setElementFrozen ( player, true )
	vioSetElementData  ( player, "loggedin", 0 )
	
	local pname = getPlayerName ( player )
	toggleAllControls ( player, false )
	if player == client then
		if isSerialValid ( getPlayerSerial(player) ) or isRegistered ( pname ) then
			if ( hasInvalidChar ( player ) or string.find ( pname, "'" ) ) and not isRegistered ( pname ) then
				kickPlayer ( player, "Dein Name enthält ungültige Zeichen!" )
			else
				if pname ~= "player" then
					if isRegistered ( pname ) then
						local serial = getPlayerSerial ( player )
						local thename = ""
						local haterlaubnis = false
						local result = dbPoll ( dbQuery ( handler, "SELECT ??, Erlaubnis FROM players WHERE Serial LIKE ?", "Name", serial ), -1 )
						if result and result[1] then
							thename = result[1]["Name"]
							if tonumber ( result[1]["Erlaubnis"] ) == 1 then
								thename = pname 
								haterlaubnis = true
							end
						else
							thename = pname
						end
						if string.lower(thename) ~= string.lower(getPlayerName ( player )) then
							if not haterlaubnis then
								kickPlayer ( player, "Du hast schon ein Account mit einem anderen Namen ("..thename..")" )
								return false
							end
						end
						triggerClientEvent ( player, "ShowLoginWindow", getRootElement(), thename, true )
					else
						local clantag = gettok ( pname, 1, string.byte(']') )
						if testmode == true then
							triggerClientEvent ( player, "ShowRegisterGui", getRootElement() )
						else
							local serial = getPlayerSerial ( player )
							if string.upper ( clantag ) == "[UTM" and not isThisTheBetaServer () then
								kickPlayer (player, "Du bist kein Mitglied des Clans!")
							elseif string.upper ( clantag ) == "[NOVA" or string.upper ( clantag ) == "[VIO" or string.upper ( clantag ) == "[EXO" or string.upper ( clantag ) == "[XTM" or string.upper ( clantag ) == "[GRS" or string.upper ( clantag ) == "[COA" or string.upper ( clantag ) == "[VITA" or string.upper ( clantag ) == "[UTM" or string.upper ( clantag ) == "[UL" then
								kickPlayer (player, "Dieses Clantag ist nicht erlaubt!")
							elseif #pname < 3 or #pname > 20 then
								kickPlayer ( player, "Bitte mindestens 3 und maximal 20 Zeichen als Nickname!" )
							elseif hasInvalidChar ( player ) or string.find ( pname, "'" ) then
								kickPlayer ( player, "Bitte nimm einen Nickname ohne ueberfluessige Zeichen!" )
							elseif string.lower (pname) == "niemand" or string.lower (pname) == "versteigerung" or string.lower (pname) == "none" then
								kickPlayer ( player, "Ungültiger Name!" )
							else
								triggerClientEvent ( player, "ShowRegisterGui", getRootElement() )
							end
						end
					end
				else
					kickPlayer ( player, "Bitte ändere deinen Nickname!" )
				end
			end
		else
			kickPlayer ( player, "Dein MTA verwendet einen ungültigen Serial. Bitte neu installieren!" )
		end
	end
end
addEvent ( "regcheck", true )
addEventHandler ("regcheck", getRootElement(), regcheck_func )


function register_func ( player, passwort, bday, bmon, byear, geschlecht )
	if player == client then
		local pname = getPlayerName ( player )
			if vioGetElementData ( player, "loggedin" ) == 0 and not isRegistered ( pname ) and player == client then
				setPlayerLoggedIn ( pname )
				
				dbExec ( handler, "DELETE FROM players WHERE Name LIKE '"..pname.."'" )
				dbExec ( handler, "DELETE FROM userdata WHERE Name LIKE '"..pname.."'" )
				
				toggleAllControls ( player, true )
				vioSetElementData ( player, "loggedin", 1 )

				triggerClientEvent ( source, "DisableRegisterGui", source )

				local ip = getPlayerIP ( player )
				
				if geschlecht == nil then
					geschlecht = 1
				end
				
				local regtime = getRealTime()
				local year = regtime.year + 1900
				local month = regtime.month + 1
				local day = regtime.monthday
				local hour = regtime.hour
				local minute = regtime.minute
				
				local registerdatum = tostring(day.."."..month.."."..year..", "..hour..":"..minute)
				local lastlogin = registerdatum
				
				passwort = hash ( "sha512", passwort )
				local lastLoginInt = getSecTime ( 0 )
				
				local id = tonumber ( dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE id=id", "id", "idcounter" ), -1 )[1]["id"] )
				dbExec ( handler, "UPDATE ?? SET ?? = ?", "idcounter", "id", id+1 )
				
				local result = dbExec ( handler, "INSERT INTO players ( UID, Name, Serial, IP, Last_login, Geburtsdatum_Tag, Geburtsdatum_Monat, Geburtsdatum_Jahr, Passwort, Geschlecht, RegisterDatum, LastLogin) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", id, pname, getPlayerSerial(player), getPlayerIP ( player ), lastlogin, tonumber ( bday), tonumber ( bmon), tonumber ( byear), passwort, geschlecht, registerdatum, lastLoginInt )
				if not result then
					outputDebugString ( "[register_func 1] Error executing the query" )
				else
					triggerClientEvent ( player, "infobox_start", player, "Du hast dich\nerfolgreich registriert!\n\nDeine Daten werden\nnun gespeichert!", 7500, 0, 255, 0 )
					playerUID[pname] = id
					playerUIDName[id] = pname
				end
				
				local result = dbExec ( handler, "INSERT INTO achievments (UID) VALUES (?)", id )
				if not result then
					outputDebugString ( "[register_func 2] Error executing the query" )
				end
				
				local result = dbExec ( handler, "INSERT INTO inventar (UID) VALUES (?)", id )
				if not result then
					outputDebugString ( "[register_func 3] Error executing the query" )
				end
				
				local result = dbExec ( handler, "INSERT INTO packages (UID, Paket1, Paket2, Paket3, Paket4, Paket5, Paket6, Paket7, Paket8, Paket9, Paket10, Paket11, Paket12, Paket13, Paket14, Paket15, Paket16, Paket17, Paket18, Paket19, Paket20, Paket21, Paket22, Paket23, Paket24, Paket25) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", id,'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )
				if not result then
					outputDebugString ( "[register_func 4] Error executing the query" )
				end
				
				local result = dbExec ( handler, "INSERT INTO bonustable (UID, Lungenvolumen, Muskeln, Kondition, Boxen, KungFu, Streetfighting, CurStyle, PistolenSkill, DeagleSkill, ShotgunSkill, AssaultSkill) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", id, 'none', 'none', 'none', 'none', 'none', 'none', '4', 'none', 'none', 'none', 'none' )
				if not result then
					outputDebugString ( "[register_func 5] Error executing the query" )
				end
				
				local result = dbExec ( handler, "INSERT INTO statistics ( UID ) VALUES (?)", id )
				if not result then
					outputDebugString ( "[register_func 6] Error executing the query" )
				end
				
				local result = dbExec ( handler, "INSERT INTO skills ( UID ) VALUES (?)", id )
				if not result then
					outputDebugString ( "[register_func 7] Error executing the query" )
				end
				
				vioSetElementData ( player, "money", 15000 )
				vioSetElementData ( player, "points", 0 )
				vioSetElementData ( player, "packages", "90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" )
				local Spawnpos_X = -1969.730
				vioSetElementData ( player, "spawnpos_x", Spawnpos_X )
				local Spawnpos_Y = 116.0128
				vioSetElementData ( player, "spawnpos_y", Spawnpos_Y )
				local Spawnpos_Z = 28
				vioSetElementData ( player, "spawnpos_z", Spawnpos_Z )
				local Spawnrot_X = 0
				vioSetElementData ( player, "spawnrot_x", Spawnrot_X )
				local SpawnInterior = 0
				vioSetElementData ( player, "spawnint", SpawnInterior )
				local SpawnDimension = 0
				vioSetElementData ( player, "spawndim", SpawnDimension )
				vioSetElementData ( player, "fraktion", 0 )
				vioSetElementData ( player, "rang", 0 )
				vioSetElementData ( player, "adminlvl", 0 )
				vioSetElementData ( player, "playingtime", 0 )
				vioSetElementData ( player, "curcars", 0 )
				vioSetElementData ( player, "maxcars", 5 )
				for i=1, 20 do
					vioSetElementData ( player, "carslot"..i, 0 )
				end
				vioSetElementData ( player, "deaths", 0 )
				vioSetElementData ( player, "kills", 0 )
				vioSetElementData ( player, "gangwarwins", 0 )
				vioSetElementData ( player, "gangwarlosses", 0 )
				vioSetElementData ( player, "jailtime", 0 )
				vioSetElementData ( player, "prison", 0 )
				vioSetElementData ( player, "bail", 0 )
				vioSetElementData ( player, "heaventime", 0 )
				vioSetElementData ( player, "housekey", 0 )
				vioSetElementData ( player, "bizkey", 0 )
				vioSetElementData ( player, "bankmoney", 35000 )
				vioSetElementData ( player, "drugs", 0 )
				local Skinid = getRandomRegisterSkin ( player, geschlecht )
				vioSetElementData ( player, "skinid", Skinid )
				vioSetElementData ( player, "carlicense", 0 )
				vioSetElementData ( player, "bikelicense", 0 )
				vioSetElementData ( player, "lkwlicense", 0 )
				vioSetElementData ( player, "helilicense", 0 )
				vioSetElementData ( player, "planelicensea", 0 )
				vioSetElementData ( player, "planelicenseb", 0 )
				vioSetElementData ( player, "motorbootlicense", 0 )
				vioSetElementData ( player, "segellicense", 0)
				vioSetElementData ( player, "fishinglicense", 0)
				vioSetElementData ( player, "wanteds", 0 )
				vioSetElementData ( player, "stvo_punkte", 0 )
				vioSetElementData ( player, "gunlicense", 0 )
				vioSetElementData ( player, "perso", 0 )
				vioSetElementData ( player, "boni", 1000 )
				vioSetElementData ( player, "pdayincome", 0 )
				vioSetElementData ( player, "hitglocke", 0 )
				vioSetElementData ( player, "medikits", 0 )
				vioSetElementData ( player, "repairkits", 0 )
				local run = 1
				while true do
					if run >= 20 then
						break
					else
						run = run + 1
					end
					local tnr = math.random ( 1000, 9999999 )
					local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "Telefonnr", "userdata", "Telefonnr", tnr ), -1 )
					if not result or not result[1] then
						if tonumber ( tnr ) ~= 911 and tonumber ( tnr ) ~= 333 and tonumber ( tnr ) ~= 400 and tonumber (tnr ) ~= 666666 then
							Telefonnr = tnr
							break
						end
					end
				end
				if Telefonnr == nil then
					Telefonnr = math.random ( 1000, 9999999 )
				end
				vioSetElementData ( player, "telenr", Telefonnr )
				vioSetElementData ( player, "warns", 0 )
				vioSetElementData ( player, "gunboxa", "0|0" )
				vioSetElementData ( player, "gunboxb", "0|0" )
				vioSetElementData ( player, "gunboxc", "0|0" )
				vioSetElementData ( player, "job", "none" )
				vioSetElementData ( player, "jobtime", 0 )
				vioSetElementData ( player, "club", "none" )
				vioSetElementData ( player, "favchannel", 0 )
				vioSetElementData ( player, "bonuspoints", 0 )
				vioSetElementData ( player, "truckerlvl", 1 )
				vioSetElementData ( player, "airportlvl", 1 )
				vioSetElementData ( player, "bauarbeiterLVL", 0 )
				vioSetElementData ( player, "farmerLVL", 0 )
				vioSetElementData ( player, "contract", 0 )
				vioSetElementData ( player, "socialState", "Flüchtling" )
				vioSetElementData ( player, "streetCleanPoints", 0 )
				vioSetElementData ( player, "handyType", 1 )
				vioSetElementData ( player, "handyCosts", 0 )
				
				_G[pname.."paydaytime"] = setTimer ( playingtime, 60000, 0, player )
				
				vioSetElementData ( player, "loggedin", 1 )
				vioSetElementData ( player, "muted", 0 )
				vioSetElementData ( player, "curplayingtime", 0 )
				vioSetElementData ( player, "housex", 0 )
				vioSetElementData ( player, "housey", 0 )
				vioSetElementData ( player, "housez", 0 )
				vioSetElementData ( player, "house", "none" )
				vioSetElementData ( player, "handystate", "on" )
				vioSetElementData ( player, "ammoTyp", 0 )
				vioSetElementData ( player, "curAmmoTyp", 0 )
				vioSetElementData ( player, "nodmzone", 0 )
				vioSetElementData ( player, "coins", 0 )

				bindKey ( source, "r", "down", reload )											
				setPlayerWantedLevel ( player, 0 )
				vioSetElementData ( player, "call", false )
				
				packageLoad ( player )
				achievload ( player )
				inventoryload ( player )
				elementDataSettings ( player )
				bonusLoad ( player )
				skillDataLoad ( player )
				createPlayerAFK ( player )
				loadPlayerStatisticsMySQL ( player )
				if not allPrivateCars[pname] then
					allPrivateCars[pname] = {}
				end

				local result = dbExec ( handler, "INSERT INTO userdata ( UID,Name,Skinid,Telefonnr) VALUES(?,?,?,?)", id, pname, Skinid, Telefonnr)
				if not result then
					outputDebugString ( "[register_func 8] Error executing the query" )
				else
					outputDebugString ("Daten für Spieler "..pname.." wurden angelegt!")
				end
				outputChatBox ( "Drücke F1, um das Hilfemenü zu öffnen!", player, 200, 200, 0 )
				
				vioSetElementData ( player, "gameboy", 0 )
				loadAddictionsForPlayer ( player )
				spawnchange_func ( player, "", "noobspawn", "" )
				triggerJoinedPlayerTheTrams ( player )
				syncInvulnerablePedsWithPlayer ( player )
				playerLoginGangMembers ( player )
				spawnPlayer ( player, Spawnpos_X, Spawnpos_Y, Spawnpos_Z+5000, Spawnrot_X, Skinid, SpawnInterior, 0 )
				setElementFrozen ( player, true )
				toggleAllControls ( player, false )
				triggerClientEvent ( player, "starttutorial", player, Skinid )
				setPlayerHudComponentVisible ( player, "all", false )

			end
	end
end
addEvent ( "register", true )
addEventHandler ( "register", getRootElement(), register_func)


addEvent ( "tutorialended", true )
addEventHandler ( "tutorialended", root, function ( )
	setElementPosition ( client, -2000.2779541016, 196.17945861816, 27.577531051636 )
	setCameraTarget ( client, client )
	setElementFrozen ( client, false )
	toggleAllControls ( client, true )
end )


addEvent ( "setPlayerTutorialMoney", true )
addEventHandler ( "setPlayerTutorialMoney", root, function ( )
	vioSetElementData ( client, "money", vioGetElementData ( client, "money" ) + 10000 )
end )


local maleSkins = {1, 2, 7, 14, 15, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 32, 33, 34, 35, 36, 37, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 57, 58, 59, 60, 61, 62, 66, 67, 68, 71, 72, 73, 78, 79, 80, 81, 82, 83, 84, 94, 95, 96, 97, 98, 99, 100, 101, 108, 109, 110, 122, 128, 132, 133, 134, 135, 136, 137, 142, 143, 144, 146, 147, 153, 154, 155, 156, 158, 159, 160, 161, 162, 167, 168, 170, 171, 176, 177, 179, 180, 182, 183, 184, 185, 187, 189, 200, 202, 203, 204, 206, 209, 210, 212, 213, 217, 220, 221, 222, 223, 227, 228, 229, 230, 234, 235, 236, 239, 240, 241, 242, 249, 250, 252, 253, 255, 258, 259, 261, 262, 264, 269, 270, 271, 291, 302, 303, 306, 307, 310}
local femaleSkins = {9, 10, 11, 12, 13, 31, 38, 39, 40, 41, 53, 54, 55, 56, 63, 64, 69, 75, 76, 77, 85, 87, 88, 89, 90, 91, 92, 93, 129, 130, 131, 138, 139, 140, 141, 145, 148, 150, 151, 152, 157, 169, 172, 178, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 201, 205, 207, 211, 214, 215, 216, 218, 219, 225, 226, 231, 232, 233, 238, 243, 244, 245, 246, 251, 256, 257, 263 }


function getRandomRegisterSkin ( player, sex )
	local testped = createPed ( 0, 9999, 9999, 9999 )
	if sex == 1 then
		local rnd = math.random ( 1, #femaleSkins )
		if setElementModel ( testped, femaleSkins[rnd] ) then
			destroyElement ( testped )
			return femaleSkins[rnd]
		else
			destroyElement ( testped )
			return getRandomRegisterSkin ( player, sex )
		end	
	else
		local rnd = math.random ( 1, #maleSkins )
		if setElementModel ( testped, maleSkins[rnd] ) then
			destroyElement ( testped )
			return maleSkins[rnd]
		else
			destroyElement ( testped )
			return getRandomRegisterSkin ( player, sex )
		end
	end
end


function login_func ( player, passwort )
	
	if player == client then
		if vioGetElementData ( player, "loggedin" ) == 0 then
			local pname = getPlayerName ( player )
			local passwort = passwort
			
			local pwresult = dbPoll ( dbQuery ( handler, "SELECT Passwort FROM players WHERE UID=?", playerUID[pname] ), -1 )
			if pwresult and pwresult[1] then
				pwresult = pwresult[1]["Passwort"]
				if pwresult == hash ( "sha512", passwort ) then	
									
					setPlayerLoggedIn ( pname )
				
					toggleAllControls ( player, true )

					vioSetElementData ( player, "loggedin", 1 )
					vioSetElementData ( player, "nodmzone", 0 )
					
					local logtime = getRealTime()
					local year = logtime.year + 1900
					local month = logtime.month + 1
					local day = logtime.monthday
					local hour = logtime.hour
					local minute = logtime.minute
					
					local lastLoginInt = getSecTime ( 0 )
					local lastlogin = tostring(day.."."..month.."."..year..", "..hour..":"..minute)
					
					local result = dbPoll ( dbQuery ( handler, "SELECT * from userdata WHERE UID = ?", playerUID[pname] ), -1 )
					if result then
						if result[1] then
							local dsatz = result[1]
							local money = tonumber ( dsatz["Geld"] )
							vioSetElementData ( player, "money", money )
							local fraktion = tonumber ( dsatz["Fraktion"] )
							vioSetElementData ( player, "fraktion", fraktion )
							if fraktion > 0 then
								fraktionMembers[fraktion][player] = fraktion
								bindKey ( player, "y", "down", "chatbox", "t" )
								if fraktion ~= 10 and fraktion ~= 11 then
									triggerClientEvent ( player, "syncPlayerList", player, fraktionMemberList[fraktion], fraktionMemberListInvite[fraktion] )
								else
									triggerClientEvent ( player, "syncPlayerList", player, fraktionMemberList[10], fraktionMemberListInvite[10] )
								end
							end
							local rang = tonumber ( dsatz["FraktionsRang"] )
							vioSetElementData ( player, "rang", rang )
							
							local admnlvl = tonumber ( dsatz["Adminlevel"] )
							vioSetElementData ( player, "adminlvl", admnlvl )
							if admnlvl >= 1 then
								adminsIngame[player] = admnlvl
							end
							if admnlvl == 1 then
								donatorMute[player] = {}
							end
							
							vioSetElementData ( player, "spawnpos_x", tonumber ( dsatz["Spawnpos_X"] ) )
							vioSetElementData ( player, "spawnpos_y", tonumber ( dsatz["Spawnpos_Y"] ) )
							vioSetElementData ( player, "spawnpos_z", tonumber ( dsatz["Spawnpos_Z"] ) )
							vioSetElementData ( player, "spawnrot_x", tonumber ( dsatz["Spawnrot_X"] ) )
							vioSetElementData ( player, "spawnint", tonumber ( dsatz["SpawnInterior"] ) )
							vioSetElementData ( player, "spawndim", tonumber ( dsatz["SpawnDimension"] ) )
							vioSetElementData ( player, "playingtime", tonumber ( dsatz["Spielzeit"] ) )
							vioSetElementData ( player, "curcars", tonumber ( dsatz["CurrentCars"] ) )
							local maximumcars = tonumber ( dsatz["MaximumCars"] )
							vioSetElementData ( player, "maxcars",maximumcars  )
							local curcars = 0
							local offerOnCar = false
							local vehresult = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "Special", "Slot", "vehicles", "UID", playerUID[pname] ), -1 )
							for i=1, maximumcars do
								vioSetElementData ( player, "carslot"..i, 0 )
							end
							if vehresult and vehresult[1] then
								for i = 1, #vehresult do
									local id = tonumber ( vehresult[i]["Slot"] )
									local carvalue = tonumber ( vehresult[i]["Special"] )
									if carvalue == 2 then
										vioSetElementData ( player, "yachtImBesitz", true )
									end
									if not carvalue then
										--if MySQL_DatasetExist("buyit", "Hoechstbietender LIKE '"..pname.."' AND Typ LIKE 'Veh'") then
										--	carvalue = 3
										--	offerOnCar = true
										--else
											carvalue = 0
										--end
									else
										if carvalue == 2 then
											carvalue = 2
										else
											carvalue = 1
										end
										curcars = curcars + 1
									end
									vioSetElementData ( player, "carslot"..id, carvalue )
								end
							end
							vioSetElementData ( player, "curcars", curcars )
							
							vioSetElementData ( player, "deaths", tonumber ( dsatz["Tode"] ) )
							vioSetElementData ( player, "kills", tonumber ( dsatz["Kills"] ) )
							vioSetElementData ( player, "gangwarlosses", tonumber ( dsatz["GangwarVerloren"] ) )
							vioSetElementData ( player, "gangwarwins", tonumber ( dsatz["GangwarGewonnen"] ) )
							vioSetElementData ( player, "jailtime", tonumber ( dsatz["Knastzeit"] ) )
							vioSetElementData ( player, "prison", tonumber ( dsatz["Prison"] ) )
							vioSetElementData ( player, "bail", tonumber ( dsatz["Kaution"] )  )
							vioSetElementData ( player, "heaventime", tonumber ( dsatz["Himmelszeit"] ) )
							
							local resulthouse = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "ID", "houses", "UID", playerUID[pname] ), -1 )
							local Hausschluessel = resulthouse[1] and resulthouse[1]["ID"] or false
							local key = tonumber ( dsatz["Hausschluessel"] )
							if Hausschluessel then
								vioSetElementData ( player, "housekey", tonumber ( Hausschluessel ) )
							elseif key <= 0 then
								vioSetElementData ( player, "housekey", key )
							else
								vioSetElementData ( player, "housekey", 0 )
							end
							
							vioSetElementData ( player, "hitglocke", tonumber ( dsatz["Hitglocke"] ) )
							vioSetElementData ( player, "bizkey", tonumber ( dsatz["Bizschluessel"] ) )
							vioSetElementData ( player, "bankmoney", tonumber ( dsatz["Bankgeld"] ) )
							vioSetElementData ( player, "drugs", tonumber ( dsatz["Drogen"] ) )
							vioSetElementData ( player, "skinid", tonumber ( dsatz["Skinid"] ) )
							vioSetElementData ( player, "carlicense", tonumber ( dsatz["Autofuehrerschein"] ) )
							vioSetElementData ( player, "bikelicense", tonumber ( dsatz["Motorradtfuehrerschein"] ) )
							vioSetElementData ( player, "lkwlicense", tonumber ( dsatz["LKWfuehrerschein"] ) )
							vioSetElementData ( player, "helilicense", tonumber ( dsatz["Helikopterfuehrerschein"] ) )
							vioSetElementData ( player, "planelicensea", tonumber ( dsatz["FlugscheinKlasseA"] ) )
							vioSetElementData ( player, "planelicenseb", tonumber ( dsatz["FlugscheinKlasseB"] ) )
							vioSetElementData ( player, "motorbootlicense", tonumber ( dsatz["Motorbootschein"] ) )
							vioSetElementData ( player, "segellicense", tonumber ( dsatz["Segelschein"] ) )
							vioSetElementData ( player, "fishinglicense", tonumber ( dsatz["Angelschein"] ) )
							vioSetElementData ( player, "wanteds", tonumber ( dsatz["Wanteds"] ) )
							vioSetElementData ( player, "stvo_punkte", tonumber ( dsatz["StvoPunkte"] ) )
							vioSetElementData ( player, "gunlicense", tonumber ( dsatz["Waffenschein"] ) )
							vioSetElementData ( player, "perso", tonumber ( dsatz["Perso"] ) )
							vioSetElementData ( player, "boni", tonumber ( dsatz["Boni"] ) )
							vioSetElementData ( player, "pdayincome", tonumber ( dsatz["PdayIncome"] ) )
							vioSetElementData ( player, "telenr", tonumber ( dsatz["Telefonnr"] ) )
							vioSetElementData ( player, "warns", getPlayerWarnCount ( pname ) )
							vioSetElementData ( player, "gunboxa", dsatz["Gunbox1"] )
							vioSetElementData ( player, "gunboxb", dsatz["Gunbox2"] )
							vioSetElementData ( player, "gunboxc", dsatz["Gunbox3"] )
							vioSetElementData ( player, "job", dsatz["Job"] )
							vioSetElementData ( player, "jobtime", dsatz["Jobtime"] )
							vioSetElementData ( player, "club", dsatz["Club"] )
							vioSetElementData ( player, "favchannel", tonumber ( dsatz["FavRadio"] ) )
							vioSetElementData ( player, "bonuspoints", tonumber ( dsatz["Bonuspunkte"] ) )
							local skill = tonumber ( dsatz["Truckerskill"] )
							if not skill then
								skill = 0
							end
							local ArmyPermissions = dsatz["ArmyPermissions"]
							for i = 1, 10 do
								vioSetElementData ( player, "armyperm"..i, tonumber ( gettok ( ArmyPermissions, i, string.byte( '|' ) ) ) )
							end
							vioSetElementData ( player, "truckerlvl", skill )
							vioSetElementData ( player, "coins", tonumber ( dsatz["Coins"] ) )
							vioSetElementData ( player, "airportlvl", tonumber ( dsatz["AirportLevel"] ) )
							vioSetElementData ( player, "farmerLVL", tonumber ( dsatz["farmerLVL"] ) )
							vioSetElementData ( player, "bauarbeiterLVL", tonumber ( dsatz["bauarbeiterLVL"] ) )
							vioSetElementData ( player, "contract", tonumber ( dsatz["Contract"] ) )
							vioSetElementData ( player, "socialState", dsatz["SocialState"] )
							if tonumber ( dsatz["SocialState"] ) then
								if tonumber ( dsatz["SocialState"] ) == 0 then
									vioSetElementData ( player, "socialState", "Flüchtling" )
								end
							end
							vioSetElementData ( player, "streetCleanPoints", tonumber ( dsatz["StreetCleanPoints"] ) )
							
							local handyString = dsatz["Handy"] 
							local v1, v2
							v1 = tonumber ( gettok ( handyString, 1, string.byte ( '|' ) ) )
							v2 = tonumber ( gettok ( handyString, 2, string.byte ( '|' ) ) )
							vioSetElementData ( player, "handyType", v1 )
							vioSetElementData ( player, "handyCosts", v2 )
							
							loadAddictionsForPlayer ( player )
							
							--isPremium ( player )
							
							vioSetElementData ( player, "housex", 0 )
							vioSetElementData ( player, "housey", 0 )
							vioSetElementData ( player, "housez", 0 )
							vioSetElementData ( player, "house", "none" )
							vioSetElementData ( player, "curplayingtime", 0 )
							vioSetElementData ( player, "handystate", "on" )
							vioSetElementData ( player, "call", false )
							
							packageLoad ( player )
							achievload ( player )
							inventoryload ( player )
							elementDataSettings ( player )
							bonusLoad ( player )
							setPremiumData ( player )
							skillDataLoad ( player )
							createPlayerAFK ( player )
							loadPlayerStatisticsMySQL ( player )
							setMaximumCarsForPlayer ( player )

							if not allPrivateCars[pname] then
								allPrivateCars[pname] = {}
							end
							
							_G[pname.."paydaytime"] = setTimer ( playingtime, 60000, 0, player )
				
							RemoteSpawnPlayer ( player )
							setElementFrozen ( player, true )
							setTimer ( setElementFrozen, 3000, 1, player, false )
							vioSetElementData ( player, "muted", 0 )
							triggerClientEvent ( player, "DisableLoginWindow", getRootElement() )					
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast dich\nerfolgreich eingeloggt!\nDrücke F1, um das\nHilfemenü zu\nöffnen!", 5000, 0, 255, 0 )
							outputDebugString ("Spieler "..pname.." wurde eingeloggt, IP: "..getPlayerIP(player))
							vioSetElementData ( player, "loggedin", 1 )
							triggerJoinedPlayerTheTrams ( player )

							if vioGetElementData ( player, "stvo_punkte" ) >= 15 then			-- SearchSTVO
								vioSetElementData ( player, "carlicense", 0 )
								vioSetElementData ( player, "stvo_punkte", 0 )
								dbExec ( handler, "UPDATE ?? SET ??=?, ??=?, ??=? WHERE ??=?", "userdata", "Autofuehrerschein", 0, "UID", playerUID[pname] )
								outputChatBox ( "Wegen deines schlechten Fahrverhaltens wurde dir dein Führerschein abgenommen!", player, 125, 0, 0 )
							end
							
							checkmsgs ( player )
							
							blacklistLogin ( pname )
							
							if isElement ( houses["pickup"][getPlayerName(player)] ) then
								local x, y, z = getElementPosition (houses["pickup"][getPlayerName(player)])
								createBlip ( x, y, z, 31, 2, 255, 0, 0, 255, 0, 99999, player )
							end
							
							local serial = getPlayerSerial ( player )
							
							dbExec ( handler, "UPDATE ?? SET ??=?, ??=?, ??=? WHERE ??=?", "players", "Last_login", lastlogin, "LastLogin", lastLoginInt, "Serial", serial, "UID", playerUID[pname] )
							
							outputChatBox ( "#383838═══════ #FFD700Ultimate-RL Info #383838═══════", player, 56, 56, 56, true )
							outputChatBox ( "╔ Willkommen auf Ultimate-RL.", player, 255, 215, 0 )
							outputChatBox ( "╠ Bei Fragen und Problemen kannst du /report benutzen.", player, 255, 215, 0 )
							outputChatBox ( "╠ Um einer Fraktion beizutreten, melde dich im Teamspeak³.", player, 255, 215, 0 )
							outputChatBox ( "╠ Teamspeak: 151.80.196.135:1578", player, 255, 215, 0 )
							outputChatBox ( "╚ Forum: Ultimate-RL.de", player, 255, 215, 0 )
							outputChatBox ( "═════════════════════════", player, 56, 56, 56 )
							
							local resultlogout = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "Position", "Waffen", "logout", "UID", playerUID[pname] ), -1 )
							if resultlogout and resultlogout[1] then
								local position = resultlogout[1]["Position"]
								if position then
									weapons = resultlogout[1]["Waffen"]
									dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "logout", "UID", playerUID[pname] )
									for i = 1, 12 do
										local wstring = gettok ( weapons, i, string.byte( '|' ) )
										if wstring then
											if wstring then
												if #wstring >= 3 then
													local weapon = tonumber ( gettok ( wstring, 1, string.byte( ',' ) ) )
													local ammo = tonumber ( gettok ( wstring, 2, string.byte( ',' ) ) )
													giveWeapon ( player, weapon, ammo, true )
												end
											end
										end
									end
									if position ~= "false" then
										local x = tonumber ( gettok ( position, 1, string.byte( '|' ) ) )
										local y = tonumber ( gettok ( position, 2, string.byte( '|' ) ) )
										local z = tonumber ( gettok ( position, 3, string.byte( '|' ) ) )
										local int = tonumber ( gettok ( position, 4, string.byte( '|' ) ) )
										local dim = tonumber ( gettok ( position, 5, string.byte( '|' ) ) )
										setTimer ( setElementInterior, 1000, 1, player, int )
										setTimer ( setElementDimension, 1000, 1, player, dim )
										setTimer ( setElementPosition, 1000, 1, player, x, y, z )
									end
								end
							end
							getMailsForClient_func ( pname )
							playerLoginGangMembers ( player )
							syncInvulnerablePedsWithPlayer ( player )
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler\nexistiert nicht!", 5000, 255, 0, 0 )	
						end
					else
						outputDebugString ( "Einloggen klappt nicht!" )
					end		
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Ungueltiges Passwort -\nüberpruefe\ndeine Eingabe\noder melde dich\nim Forum.", 5000, 255, 0, 0 )	
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler\nexistiert nicht!", 5000, 255, 0, 0 )	
			end
			if player and isElement ( player ) then
				bindKey ( player, "r", "down", reload )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Spieler\nist einloggt!", 5000, 255, 0, 0 )	
		end
	end
end
addEvent ( "einloggen", true )
addEventHandler ( "einloggen", getRootElement(), login_func )


function gameBeginGuiShow_func ( player )

	if player == client then
		vioSetElementData ( player, "isInTut", false )
		triggerClientEvent ( player, "showBeginGui", getRootElement() )
		showCursor ( player, true )
		setElementClicked ( player, true )
		toggleAllControls ( player, true )
		setElementPosition ( player, -1421.3, -287.2, 13.8 )
		setElementInterior ( player, 0 )
	end
end
addEvent ( "gameBeginGuiShow", true )
addEventHandler ( "gameBeginGuiShow", getRootElement(), gameBeginGuiShow_func)
	

function achievload ( player )

	local pname = getPlayerName ( player )
	local result = dbPoll ( dbQuery ( handler, "SELECT * from achievments WHERE UID = ?", playerUID[pname] ), -1 )
	local dsatz = nil
	if result then
		if result[1] then
			dsatz = result[1]
		else
			outputDebugString ( "Spieler in Achievment-Datenbank nicht gefunden!" )
			return false
		end
	end
	vioSetElementData ( player, "schlaflosinsa", dsatz["SchlaflosInSA"] )
	vioSetElementData ( player, "gunloads", dsatz["Waffenschieber"] )
	vioSetElementData ( player, "angler_achiev", dsatz["Angler"] )
	vioSetElementData ( player, "licenses_achiev", dsatz["Lizensen"] )
	vioSetElementData ( player, "carwahn_achiev", dsatz["Fahrzeugwahn"] )
	vioSetElementData ( player, "collectr_achiev", dsatz["DerSammler"] )
	vioSetElementData ( player, "rl_achiev", dsatz["ReallifeWTF"] )
	vioSetElementData ( player, "own_foots", dsatz["EigeneFuesse"] )
	vioSetElementData ( player, "kingofthehill_achiev", dsatz["KingOfTheHill"] )
	vioSetElementData ( player, "thetruthisoutthere_achiev", dsatz["TheTruthIsOutThere"] )
	vioSetElementData ( player, "silentassasin_achiev", dsatz["SilentAssasin"] )
	vioSetElementData ( player, "highwaytohell_achiev", dsatz["HighwayToHell"] )
	
	vioSetElementData ( player, "revolverheld_achiev", tonumber ( dsatz["Revolverheld"] ) )
	vioSetElementData ( player, "chickendinner_achiev", tonumber ( dsatz["ChickenDinner"] ) )
	vioSetElementData ( player, "nichtsgehtmehr_achiev", tonumber ( dsatz["NichtGehtMehr"] ) )
	vioSetElementData ( player, "highscore_achiev", tonumber ( dsatz["highscore"] ) == 1 )
	
	local dstring = dsatz["LookoutsA"]
	triggerClientEvent ( player, "hideLookoutMarkers", player, dstring )
	local count = 0
	for i = 1, 10 do
		if tonumber ( gettok ( dstring, i, string.byte ( '|' ) ) ) == 1 then
			count = count + 1
		end
	end
	vioSetElementData ( player, "viewpoints", count )
	loadHorseShoesFound ( player, pname )
	loadPlayingTimeForSleeplessAchiev ( player, pname )
end


function inventoryload ( player )

	local pname = getPlayerName ( player )
	vioSetElementData ( player, "playerid", playerUID[pname] )
	
	local dsatz
	local result = dbPoll ( dbQuery ( handler, "SELECT * from inventar WHERE UID = ?", playerUID[pname] ), -1 )
	if not result or not result[1] then
		dbExec ( handler, "INSERT INTO inventar (UID) VALUES (?)", playerUID[pname] )
		result = dbPoll ( dbQuery ( handler, "SELECT * from inventar WHERE UID = ?", playerUID[pname] ), -1 )
	end
	dsatz = result[1]
	if dsatz["Wuerfel"] then
		vioSetElementData ( player, "dice", tonumber ( dsatz["Wuerfel"] ) )
	else
		vioSetElementData ( player, "dice", 0 )
	end
	vioSetElementData ( player, "flowerseeds", tonumber ( dsatz["Blumensamen"] ) )
	vioSetElementData ( player, "food1", tonumber ( dsatz["Essensslot1"] ) )
	vioSetElementData ( player, "food2", tonumber ( dsatz["Essensslot2"] ) )
	vioSetElementData ( player, "food3", tonumber ( dsatz["Essensslot3"] ) )
	vioSetElementData ( player, "zigaretten", tonumber ( dsatz["Zigaretten"] ) )
	vioSetElementData ( player, "mats", tonumber ( dsatz["Materials"] ) )
	vioSetElementData ( player, "benzinkannister", tonumber ( dsatz["Benzinkanister"] ) )
	vioSetElementData ( player, "fruitNotebook", tonumber ( dsatz["FruitNotebook"] ) )
	vioSetElementData ( player, "casinoChips", tonumber ( dsatz["Chips"] ) )
	vioSetElementData ( player, "gameboy", tonumber ( dsatz["Gameboy"] ) )
	vioSetElementData ( player, "medikits", tonumber ( dsatz["Medikit"] ) )
	vioSetElementData ( player, "repairkits", tonumber ( dsatz["Repairkit"] ) )
	vioSetElementData ( player, "object", tonumber ( dsatz["Objekt"] ) )
	-- X-MAS --
	-- vioSetElementData ( player, "presents", tonumber ( dsatz["Geschenke"] ) )
	-- X-MAS --
end


	
function datasave ( quitReason, reason )

	if clanMembers[source] then
		clanMembers[source] = nil
	end
	if ticketPermitted[source] then
		ticketPermitted[source] = nil
	end
	local pname = getPlayerName ( source )
	removePlayerFromLoggedIn ( pname )
	if vioGetElementData ( source, "loggedin" ) == 1 then
		playerDisconnectGangMembers ( source )
		pname = getPlayerName ( source )
		local frak = vioGetElementData(source,"fraktion")
		if fraktionMembers[frak] then
			fraktionMembers[frak][source] = nil
		end
		adminsIngame[source] = nil
		if vioGetElementData ( source, "shootingRanchGun" ) then
		elseif quitReason and reason ~= "Ausgeloggt." then
			if vioGetElementData ( source, "wanteds" ) >= 1 --[[and ( quitReason == "Quit" or quitReason == "Unknown" )]] and vioGetElementData ( source, "jailtime" ) == 0 and vioGetElementData ( source, "prison" ) == 0 then
				local x, y, z = getElementPosition ( source )
				local copShape = createColSphere ( x, y, z, 20 )
				local elementsInCopSphere = getElementsWithinColShape ( copShape, "player" )
				destroyElement ( copShape )
				for i=1, #elementsInCopSphere do
					local cPlayer = elementsInCopSphere[i]
					if ( isOnDuty ( cPlayer ) or isArmy ( cPlayer ) ) and cPlayer ~= source then
						local wanteds = vioGetElementData ( source, "wanteds" )
						vioSetElementData ( source, "wanteds", 0 )
						vioSetElementData ( source, "jailtime", wanteds * math.ceil(jailtimeperwanted*1.4) + vioGetElementData ( source, "jailtime" ) )
						wantedCost = 100*wanteds*(wanteds*.5)
						vioSetElementData ( source, "money", vioGetElementData ( source, "money" ) - wantedCost )
						if vioGetElementData ( source, "money" ) < 0 then
							vioSetElementData ( source, "money", 0 )
						end
						outputChatBox ( "Der Gesuchte "..getPlayerName ( source ).." ist offline gegangen - er wird beim nächsten Einloggen im Knast sein.", cPlayer, 0, 125, 0 )
						vioSetElementData ( cPlayer, "AnzahlEingeknastet", vioGetElementData ( cPlayer, "AnzahlEingeknastet" ) + 1 )
						vioSetElementData ( source, "AnzahlImKnast", vioGetElementData ( source, "AnzahlImKnast" ) + 1 )
						offlinemsg ( "Du bist für "..(wanteds * math.ceil(jailtimeperwanted*1.2)).." Minuten im Gefängnis (Offlineflucht?)", "Server", getPlayerName(source) )
						break
					end
				end
			end
			if shootingRanchGun[source] then
				takeWeapon ( source, shootingRanchGun[source] )
			end
			shootingRanchGun[source] = {}
			local curWeaponsForSave = "|"
			for i = 1, 12 do
				if i ~= 10 and i ~= 12 then
					local weapon = getPedWeapon ( source, i )
					local ammo = getPedTotalAmmo ( source, i )
					if weapon and ammo then
						if weapon > 0 and ammo > 0 then
							if #curWeaponsForSave <= 40 then
								curWeaponsForSave = curWeaponsForSave..weapon..","..ammo.."|"
							end
						end
					end
				end
			end
			if #curWeaponsForSave > 1 then
				dbExec ( handler, "DELETE FROM logout WHERE UID = ?", playerUID[pname] )
				dbExec ( handler, "INSERT INTO logout (Position, Waffen, UID) VALUES (?,?,?)", 'false', curWeaponsForSave, playerUID[pname]) 
			end
		end
		hangup ( source )
		datasave_remote ( source )
		if vioGetElementData ( source, "isInArea51Mission" ) then
			removeArea51Bots ( pname )
		end
		local veh = getPedOccupiedVehicle ( source )
		if veh then
			if isElement ( veh ) then
				if getElementModel(veh) == 502 then
					destroyElement ( veh )
				end
			end
		end
		killTimer ( _G[pname.."paydaytime"] )
		clearInv ( source )
		clearUserdata ( source )
		clearBonus ( source )
		clearAchiev ( source )
		clearPackage ( source )
		clearDataSettings ( source )
	end
end
addEventHandler ("onPlayerQuit", getRootElement(), datasave )

function elementDataSettings ( player )

	local pname = getPlayerName ( player )
	vioSetElementData ( player, "objectToPlace", false )
	vioSetElementData ( player, "growing", false )
	vioSetElementData ( player, "isInRace", false )
	vioSetElementData ( player, "callswithpolice", false )
	vioSetElementData ( player, "callswithmedic", false )
	vioSetElementData ( player, "callswithmechaniker", false )
	vioSetElementData ( player, "isLive", false )
	vioSetElementData ( player, "isInArea51Mission", false )
	vioSetElementData ( player, "armingBomb", false )
	vioSetElementData ( player, "tied", true )
	vioSetElementData ( player, "hasBomb", false )
	vioSetElementData ( player, "wanzen", false )
	------------------
	
	local Weapon_Settings = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "Spezial", "inventar", "UID", playerUID[pname] ), -1 )
	local shads = {}
	
	if not Weapon_Settings or not Weapon_Settings[1] then
		for i = 1, 6 do
			shads[i] = 0
		end
	else
		for i = 1, 6 do
			shads[i] = tonumber ( gettok ( Weapon_Settings[1]["Spezial"], i, string.byte( '|' ) ) )
		end
	end
	
		
	----------------	
	local ArmyPermissions = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "ArmyPermissions", "userdata", "UID", playerUID[pname] ), -1 )
	if ArmyPermissions and ArmyPermissions[1] then
		ArmyPermissions = ArmyPermissions[1]["ArmyPermissions"]
		for i = 1, 10 do
			local int = tonumber ( gettok ( ArmyPermissions, i, string.byte( '|' ) ) )
			if int then
				vioSetElementData ( player, "armyperm"..i, int )
			else
				vioSetElementData ( player, "armyperm"..i, 0 )
			end
		end
	else
		for i = 1, 10 do
			vioSetElementData ( player, "armyperm"..i, 0 )
		end
	end
end

function saveArmyPermissions ( player )

	local pname = getPlayerName ( player )
	local empty = ""
	for i = 1, 10 do
		empty = empty.."|"..vioGetElementData ( player, "armyperm"..i )
	end
	empty = empty.."|"
	dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "ArmyPermissions", empty, "UID", playerUID[pname] )
end


function SaveCarData ( player )

	local pname = getPlayerName ( player )
	dbExec ( handler, "UPDATE ?? SET ??=?, ??=?, ??=? WHERE ??=?", "userdata", "Geld", vioGetElementData ( player, "money" ), "CurrentCars", vioGetElementData ( player, "curcars" ), "MaximumCars", vioGetElementData ( player, "maxcars" ), "UID", playerUID[pname] )
end

function datasave_remote ( player )
	
	local source = player
	if tonumber ( vioGetElementData ( source, "loggedin" )) == 1 then
		local pname = getPlayerName ( source )	
		local fields = "SET"
		fields = fields.." Geld = '"..math.abs ( math.floor ( vioGetElementData ( source, "money" ) ) ).."'"
		fields = fields..", Fraktion = '"..math.abs ( math.floor ( vioGetElementData ( source, "fraktion") ) ).."'"
		fields = fields..", FraktionsRang = '"..math.floor ( vioGetElementData ( source, "rang" ) ).."'"
		fields = fields..", Spielzeit = '"..math.floor ( vioGetElementData ( source, "playingtime" ) ).."'"
		fields = fields..", Adminlevel = '"..math.floor ( vioGetElementData ( source, "adminlvl" ) ).."'"
		fields = fields..", Hitglocke = '"..math.floor ( vioGetElementData ( source, "hitglocke" ) ).."'"
		fields = fields..", CurrentCars = '"..math.floor ( vioGetElementData ( source, "curcars" ) ).."'"
		fields = fields..", MaximumCars = '"..math.floor ( vioGetElementData ( source, "maxcars" ) ).."'"
		fields = fields..", Knastzeit = '"..math.floor ( vioGetElementData ( source, "jailtime" ) ).."'"
		fields = fields..", Prison = '"..math.floor ( vioGetElementData ( source, "prison" ) ).."'"
		fields = fields..", Kaution = '"..math.floor ( vioGetElementData ( source, "bail" ) ).."'"
		fields = fields..", Himmelszeit = '"..math.floor ( vioGetElementData ( source, "heaventime" ) ).."'"
		fields = fields..", Hausschluessel = '"..math.floor ( vioGetElementData ( source, "housekey" ) ).."'"
		fields = fields..", Bankgeld = '"..math.floor ( vioGetElementData ( source, "bankmoney" ) ).."'"
		fields = fields..", Drogen = '"..math.floor ( vioGetElementData ( source, "drugs" ) ).."'"
		fields = fields..", Skinid = '"..math.floor ( vioGetElementData ( source, "skinid" ) ).."'"
		fields = fields..", Wanteds = '"..math.floor ( vioGetElementData ( source, "wanteds" ) ).."'"
		fields = fields..", StvoPunkte = '"..math.floor ( vioGetElementData ( source, "stvo_punkte" ) ).."'"
		fields = fields..", Boni = '"..math.floor ( vioGetElementData ( source, "boni" ) ).."'"
		fields = fields..", PdayIncome = '"..math.floor ( vioGetElementData ( source, "pdayincome" ) ).."'"
		fields = fields..", Warns = '"..math.floor ( vioGetElementData ( source, "warns" ) ).."'"
		fields = fields..", Gunbox1 = '"..vioGetElementData ( source, "gunboxa" ).."'"
		fields = fields..", Gunbox2 = '"..vioGetElementData ( source, "gunboxb" ).."'"
		fields = fields..", Gunbox3 = '"..vioGetElementData ( source, "gunboxc" ).."'"
		fields = fields..", Job = '"..vioGetElementData ( source, "job" ).."'"
		fields = fields..", Jobtime = '"..math.floor ( vioGetElementData ( source, "jobtime" ) ).."'"
		fields = fields..", Club = '"..vioGetElementData ( source, "club" ).."'"
		fields = fields..", FavRadio = '"..math.floor ( vioGetElementData ( source, "favchannel" ) ).."'"
		fields = fields..", Bonuspunkte = '"..math.floor ( vioGetElementData ( source, "bonuspoints" ) ).."'"
		local skill = tonumber ( vioGetElementData ( source, "truckerlvl" ) ) or 0
		fields = fields.." ,Coins = '"..vioGetElementData ( source, "coins" ).."'"
		fields = fields..", Truckerskill = '"..skill.."'"
		fields = fields..", farmerLVL = '"..vioGetElementData ( source, "farmerLVL" ).."'"
		fields = fields..", bauarbeiterLVL = '"..vioGetElementData ( source, "bauarbeiterLVL" ).."'"
		fields = fields..", AirportLevel = '"..math.floor ( vioGetElementData ( source, "airportlvl" ) ).."'"
		fields = fields..", Contract = '"..math.floor ( vioGetElementData ( source, "contract" ) ).."'"
		fields = fields..", SocialState = '".. vioGetElementData ( source, "socialState") .."'"
		fields = fields..", StreetCleanPoints = '"..math.floor ( vioGetElementData ( source, "streetCleanPoints" ) ).."'"
		local v1 = "|"..vioGetElementData ( source, "handyType" ).."|"
		local v2 = vioGetElementData ( source, "handyCosts" ).."|"
		local v3 = v1..v2
		fields = fields..", Handy = '"..v3.."'"
		dbExec ( handler, "UPDATE userdata "..fields.." WHERE UID=?", playerUID[pname] )
		
		saveAddictionsForPlayer ( source )
		achievsave(source)
		inventorysave(source)
		skillDataSave ( player )
		saveArmyPermissions ( player )
		saveStatisticsMySQL ( player )
		outputDebugString ("Daten für Spieler "..pname.." wurden gesichert!")
	end
end

function achievsave ( player )

	local pname = getPlayerName ( player )
	saveHorseShoesFound ( player, pname )
	dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "achievments", "Waffenschieber", vioGetElementData ( player, "gunloads"), "UID", playerUID[pname] )
	savePlayingTimeForSleeplessAchiev ( player, pname )
end



function inventorysave ( player )
	local pname = getPlayerName ( player )	
	dbExec ( handler, "UPDATE ?? SET ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=? WHERE ??=?", "inventar", "Blumensamen", vioGetElementData ( player, "flowerseeds" ), "Essensslot1", vioGetElementData ( player, "food1" ), "Essensslot2", vioGetElementData ( player, "food2" ), "Essensslot3", vioGetElementData ( player, "food3" ), "Zigaretten", vioGetElementData ( player, "zigaretten" ), "Materials", vioGetElementData ( player, "mats" ), "Benzinkanister", vioGetElementData ( player, "benzinkannister" ), "Objekt", vioGetElementData ( player, "object" ), "Chips", vioGetElementData ( player, "casinoChips" ), "Medikit", vioGetElementData ( player, "medikits" ), "Repairkit", vioGetElementData ( player, "repairkits" ), "UID", playerUID[pname] )
end

function casinoMoneySave ( player )

	if vioGetElementData ( player, "loggedin" ) == 1 then
		local name = getPlayerName ( player )
		local chips = math.abs ( math.floor ( vioGetElementData ( player, "casinoChips" ) ) )
		local money = math.floor ( vioGetElementData ( player, "money" ) )
		local bankMoney = math.floor ( vioGetElementData ( player, "bankmoney" ) )
		dbExec ( handler,"UPDATE userdata SET ??=?, ??=? WHERE UID=?", "Geld", money, "Bankgeld", bankMoney, playerUID[name] )
		dbExec ( handler, "UPDATE inventar SET Chips=? WHERE UID=?", chips, playerUID[name] )
	end
end



-- Info: Angabe von Last_Login in Tagen seit Jahresanfang, Angabe von Geschlecht in 1 u. 0 - 1 = Weiblich, 0 = männlich
-- Anreise in 1 u. 0, 0 = Schiff, 1 = Flugzeug
-- Scheine: 0 = nicht vorhanden, 1 = vorhanden

function logoutPlayer_func ( player, x, y, z, int, dim )

	local client = player
	if vioGetElementData ( client, "shootingRanchGun" ) then
		
	else
		local pname = getPlayerName ( client )
		local int = tonumber ( int )
		local dim = tonumber ( dim )
		local curWeaponsForSave = "|"
		if shootingRanchGun[client] then
			takeWeapon ( client, shootingRanchGun[client] )
		end
		for i = 1, 11 do
			if i ~= 10 then
				local weapon = getPedWeapon ( client, i )
				local ammo = getPedTotalAmmo ( client, i )
				if weapon and ammo then
					if weapon > 0 and ammo > 0 then
						if #curWeaponsForSave <= 40 then
							curWeaponsForSave = curWeaponsForSave..weapon..","..ammo.."|"
						end
					end
				end
			end
		end
		pos = "|"..(math.floor(x*100)/100).."|"..(math.floor(y*100)/100).."|"..(math.floor(z*100)/100).."|"..int.."|"..dim.."|"
		if #curWeaponsForSave < 5 then
			curWeaponsForSave = ""
		end
		local result = dbExec ( handler,"INSERT INTO logout (Position, Waffen, UID) VALUES (?,?,?)", pos, curWeaponsForSave, playerUID[pname] )
		kickPlayer ( client, "Ausgeloggt." )
	end
end
addEvent ( "logoutPlayer", true )
addEventHandler ( "logoutPlayer", getRootElement(), logoutPlayer_func )