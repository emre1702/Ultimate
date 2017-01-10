local loehne_payday = {}

for i = 1, 13, 1 do
	loehne_payday[i] = {}
end
	
loehne_payday[1][0] = 0
loehne_payday[1][1] = 300
loehne_payday[1][2] = 600
loehne_payday[1][3] = 900
loehne_payday[1][4] = 1200
loehne_payday[1][5] = 1500

loehne_payday[6][0] = 0
loehne_payday[6][1] = 350
loehne_payday[6][2] = 700
loehne_payday[6][3] = 1000
loehne_payday[6][4] = 1300
loehne_payday[6][5] = 1600

loehne_payday[8][0] = 500
loehne_payday[8][1] = 1000
loehne_payday[8][2] = 1500
loehne_payday[8][3] = 2000
loehne_payday[8][4] = 2500
loehne_payday[8][5] = 3000

loehne_payday[4][0] = 600
loehne_payday[4][1] = 1000
loehne_payday[4][2] = 1400
loehne_payday[4][3] = 1800
loehne_payday[4][4] = 2200
loehne_payday[4][5] = 2600

loehne_payday[5][0] = 600
loehne_payday[5][1] = 1000
loehne_payday[5][2] = 1400
loehne_payday[5][3] = 1800
loehne_payday[5][4] = 2200
loehne_payday[5][5] = 2600

loehne_payday[10][0] = 600
loehne_payday[10][1] = 1000
loehne_payday[10][2] = 1400
loehne_payday[10][3] = 1800
loehne_payday[10][4] = 2200
loehne_payday[10][5] = 2600

loehne_payday[11][0] = 600
loehne_payday[11][1] = 1000
loehne_payday[11][2] = 1400
loehne_payday[11][3] = 1800
loehne_payday[11][4] = 2200
loehne_payday[11][5] = 2600

loehne_payday[2][0] = 500
loehne_payday[2][1] = 800
loehne_payday[2][2] = 1100
loehne_payday[2][3] = 1400
loehne_payday[2][4] = 1700
loehne_payday[2][5] = 2000

loehne_payday[3][0] = 500
loehne_payday[3][1] = 800
loehne_payday[3][2] = 1100
loehne_payday[3][3] = 1400
loehne_payday[3][4] = 1700
loehne_payday[3][5] = 2000

loehne_payday[7][0] = 500
loehne_payday[7][1] = 800
loehne_payday[7][2] = 1100
loehne_payday[7][3] = 1400
loehne_payday[7][4] = 1700
loehne_payday[7][5] = 2000

loehne_payday[9][0] = 500
loehne_payday[9][1] = 800
loehne_payday[9][2] = 1100
loehne_payday[9][3] = 1400
loehne_payday[9][4] = 1700
loehne_payday[9][5] = 2000

loehne_payday[12][0] = 500
loehne_payday[12][1] = 800
loehne_payday[12][2] = 1100
loehne_payday[12][3] = 1400
loehne_payday[12][4] = 1700
loehne_payday[12][5] = 2000

loehne_payday[13][0] = 500
loehne_payday[13][1] = 800
loehne_payday[13][2] = 1100
loehne_payday[13][3] = 1400
loehne_payday[13][4] = 1700
loehne_payday[13][5] = 2000


function payday ( player )

	if math.floor ( vioGetElementData ( player, "playingtime" ) / 60 ) == ( vioGetElementData ( player, "playingtime" ) / 60 ) then
	
		local player_payday = {}
		
		local faction = getPlayerFaction ( player )
		local rank = getPlayerRank ( player )
		player_payday["Boni"] = tonumber(vioGetElementData( player, "boni" )) 
		
		if isEvil ( player ) then
		
			player_payday["Zuschuesse"] = loehne_payday[faction][rank]
			
		else
		
			player_payday["Zuschuesse"] = 200
			
		end
		
		if isStateFaction ( player ) then
		
			local incoming = tonumber(vioGetElementData( player, "pdayincome" ))
			local multiplikator
			
			if incoming > 50 then
				multiplikator = 1
			elseif incoming > 40 then
				multiplikator = 5/6
			elseif incoming > 30 then
				multiplikator = 4/6
			elseif incoming > 20 then
				multiplikator = 3/6
			elseif incoming > 10 then
				multiplikator = 2/6
			else
				multiplikator = 1/6
			end
			
			local var = math.floor(loehne_payday[faction][rank] * multiplikator)
		
			player_payday["Lohn"] = var
			
		elseif faction >= 1 then
		
			player_payday["Lohn"] = loehne_payday[faction][rank]
			
		else
		
			player_payday["Lohn"] = 0
		
		end
		
		local grund 
		local costs
		
		if vioGetElementData ( player, "handyType" ) == 1 then
			grund = 10
			costs = tonumber(vioGetElementData( player, "handyCosts" ))
		elseif vioGetElementData ( player, "handyType" ) == 2 then
			grund = 0
			costs = 0
		else
			grund = 50
			costs = 0
		end
		
		player_payday["Handykosten"] = grund + costs
		
		local club = vioGetElementData ( player, "club" )
		
		if club == "gartenverein" then
			player_payday["Clubkosten"] = 30
			outputChatBox ( "Um deine Clubmitgliedschaft zu kündigen, tippe /leaveclub", player, 125, 0, 0 )
		elseif club == "biker" then
			player_payday["Clubkosten"] = 50
			bizArray["MistysBar"]["kasse"] = bizArray["MistysBar"]["kasse"] + 50
			outputChatBox ( "Um deine Clubmitgliedschaft zu kündigen, tippe /leaveclub", player, 125, 0, 0 )
		elseif club == "rc" then
			player_payday["Clubkosten"] = 50
			outputChatBox ( "Um deine Clubmitgliedschaft zu kündigen, tippe /leaveclub", player, 125, 0, 0 )
		else
			player_payday["Clubkosten"] = 0
		end
		local var_zinsen = vioGetElementData( player, "bankmoney" ) * 0.003
		local Zinsen = math.floor(var_zinsen)
		
		if Zinsen > 1500 then
			player_payday["Zinsen"] = 1500
		else
			player_payday["Zinsen"] = Zinsen
		end
		
		player_payday["Fahrzeugsteuer"] = math.floor( vioGetElementData(player, "curcars") * 75 )
		
		rent = 0
		
		if vioGetElementData ( player, "housekey" ) < 0 then
			local ID = math.abs(vioGetElementData ( player, "housekey" ))
			local haus = houses["pickup"][ID]
			rent = vioGetElementData ( haus, "miete" )
			local Kasse = tonumber ( dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "Kasse", "houses", "ID", ID ), -1 )[1]["Kasse"] )
			dbExec ( handler, "UPDATE ?? SET ?? = ? WHERE ID = ?", "houses", "Kasse", Kasse + rent, ID )
		end
		
		player_payday["Miete"] = rent
		
		if vioGetElementData ( player, "socialState" ) == "Rentner" then
			player_payday["Zuschuesse"] = player_payday["Zuschuesse"] + 1000
		end
		
		local amount = factionGangAreas[faction] or 0
						
		if vioGetElementData ( player, "stvo_punkte" ) >= 1 then
			vioSetElementData ( player, "stvo_punkte", vioGetElementData ( player, "stvo_punkte" ) - 1 )
			outputChatBox ( "Dir wurde soeben 1 STVO Punkt erlassen!", player, 125, 0, 0 )
		end
		
		if math.floor ( tonumber ( vioGetElementData ( player, "playingtime" ) ) / 120 ) == ( tonumber ( vioGetElementData ( player, "playingtime" ) ) / 120 ) and tonumber ( vioGetElementData ( player, "wanteds" ) ) >= 1 then
			vioSetElementData ( player, "wanteds", vioGetElementData ( player, "wanteds" ) - 1 )
			setPlayerWantedLevel ( player, vioGetElementData ( player, "wanteds" ) )
			outputChatBox ( "Dir wurde soeben 1 Wantedpunkt erlassen!", player, 125, 0, 0 )
		end
						
		outputChatBox ( "|___Zahltag___|", player, 0, 200, 0 )
		outputChatBox ( "Einkommen:", player, 200, 200, 0 )
		outputChatBox ( "Job: "..player_payday["Lohn"].."$; Boni: "..player_payday["Boni"].."$; Zuschüsse: "..player_payday["Zuschuesse"].."$;", player, 200, 200, 0 )
		outputChatBox ( "Kosten:", player, 200, 200, 0 )
		outputChatBox ( "Handykosten: "..player_payday["Handykosten"].."$;", player, 200, 200, 0 )
		outputChatBox ( "Club: "..player_payday["Clubkosten"].."$; Fahrzeugsteuer: "..player_payday["Fahrzeugsteuer"].."$; Miete: "..player_payday["Miete"].."$;", player, 200, 200, 0 )
		outputChatBox ( "Zinsen: "..player_payday["Zinsen"].." $", player, 200, 200, 0 )
		
		if amount > 0 then
			player_payday["Gangarea"] = amount * 100
			outputChatBox ( "Einnahmen durch Ganggebiete: "..player_payday["Gangarea"].."$", player, 0, 200, 0 )
		else
			player_payday["Gangarea"] = 0
		end
		
		player_payday["Gesamt"] = player_payday["Lohn"] + player_payday["Boni"] + player_payday["Zuschuesse"] - player_payday["Handykosten"] - player_payday["Clubkosten"] - player_payday["Fahrzeugsteuer"] - player_payday["Miete"] + player_payday["Zinsen"] + player_payday["Gangarea"]
		
		outputChatBox ( "_______________", player, 125, 0, 0 )
		outputChatBox ( "Einnahmen: "..player_payday["Gesamt"].."$ ", player, 0, 200, 0 )
		outputChatBox ( "Die Einnahmen wurden auf dein Konto überwiesen!", player, 125, 0, 125 )
		
		if isHalloween then
			local eggs = vioGetElementData ( player, "easterEggs" )
			vioSetElementData ( player, "easterEggs", eggs + 1 )
			outputChatBox ( "Außerdem hast du einen Kürbis bekommen. Loese ihn mit /halloween ein!", player, 0, 125, 0 )
		end
		
		triggerClientEvent ( player, "createNewStatementEntry", player, "Abrechnung\n", player_payday["Gesamt"], "\n" )

		vioSetElementData ( player, "pdayincome", 0 )
		vioSetElementData ( player, "boni", 0 )

		triggerClientEvent ( player, "achievsound", player )

		vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) + player_payday["Gesamt"] )
		datasave_remote ( player )
		
	end
	
end

-- PING KICK PINGKICK PING --
--[[function pingCheck ( player )

	if not isElement(player) then
		return
	end

	local ping = getPlayerPing ( player )
	
	if ping >= 400 then
		local x, y, z = getElementPosition ( player )
		triggerEvent ( "logoutPlayer", player, player, x, y, z, getElementInterior ( player ), getElementDimension ( player ), player )
	end
	
	setTimer ( pingCheck, 5000, 1, player )

end]]


function playingtime ( player )

	if isElement ( player ) then
	
		if vioGetElementData ( player, "loggedin" ) == 1 then
		
			setPlayerWantedLevel ( player, tonumber( vioGetElementData ( player, "wanteds" ) ))
			local pname = getPlayerName ( player )
			vioSetElementData ( player, "lastcrime", "none" )
			
			if not vioGetElementData ( player, "isafk" ) then
				vioSetElementData ( player, "curplayingtime", vioGetElementData ( player, "curplayingtime" ) + 1 )						-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
				
				if math.random ( 1, 10 ) == 1 then
					checkForSymptoms ( player )
				end
					
				if math.floor ( vioGetElementData ( player, "curplayingtime" ) / 3 ) == vioGetElementData ( player, "curplayingtime" ) / 3 then
					lowerFlush ( player )
				elseif math.floor ( vioGetElementData ( player, "curplayingtime" ) / 20 ) == vioGetElementData ( player, "curplayingtime" ) / 20 then
					lowerAddict ( player )
				end
					
				vioSetElementData ( player, "playingtime", vioGetElementData ( player, "playingtime" ) + 1 )								-- Spielzeit
			
				local jailed = tonumber( vioGetElementData ( player, "jailtime" ) )
				
				if jailed > 1 then
				
					vioSetElementData ( player, "jailtime", jailed - 1 )
					
				elseif jailed == 1 then
				
					freePlayerFromJail ( player )
						
				end
				
				local prisonjailed = tonumber( vioGetElementData ( player, "prison" ) )
				
				if prisonjailed > 1 then
				
					vioSetElementData ( player, "prison", prisonjailed - 1 )
					
				elseif prisonjailed == 1 then
				
					freePlayerFromJail ( player )
						
				end 
					
				if tonumber ( vioGetElementData ( player, "jobtime" ) ) ~= 0 then
					vioSetElementData ( player, "jobtime", tonumber ( vioGetElementData ( player, "jobtime" ) ) - 1 )
				end
			
			
				if isOnDuty ( player ) or isArmy ( player ) then	
				
					if isFBI(player) then
						bonus = 1.2
					else
						bonus = 1
					end
					
					local income = tonumber(vioGetElementData( player, "pdayincome" ))
					vioSetElementData ( player, "pdayincome", income+1 )

				end
			
				payday ( player )
				dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "userdata", "Bankgeld", vioGetElementData ( player, "bankmoney"), "Geld", vioGetElementData ( player, "money" ), "UID", playerUID[pname] )
				ReallifeAchievCheck ( player )
				
				-- PING PINGCHECK CHECK --
				--[[if getPlayerPing ( player ) >= 350 then
					setTimer ( pingCheck, 5000, 1, player )
				end]]

				vioSetElementData ( player, "timePlayedToday", vioGetElementData ( player, "timePlayedToday" ) + 1 )
				
				if vioGetElementData ( player, "timePlayedToday" ) >= 720 and vioGetElementData ( player, "schlaflosinsa" ) ~= "done" then						-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
					triggerClientEvent ( player, "showAchievmentBox", player, "Schlaflos in SA", 50, 10000 )													-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
					vioSetElementData ( player, "bonuspoints", vioGetElementData ( player, "bonuspoints" ) + 50 )												-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
					vioSetElementData ( player, "schlaflosinsa", "done" )																						-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "achievments", "SchlaflosInSA", "done", "UID", playerUID[getPlayerName ( player )] )										-- Achiev: Schlaflos in SA, 12 Stunden am St??zocken, 30 Punkte
				end	
			end
			
			--_G[pname.."paydaytime"] = setTimer ( playingtime, 60000, 1, player )
				
		end
			
	end
	
end