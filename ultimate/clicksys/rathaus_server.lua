function LizenzKaufen_func ( player, lizens )

	if player == client then
		local pname = getPlayerName ( player )
		if lizens == "planeb" then
			if tonumber(vioGetElementData ( player, "planelicenseb" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 34950 then
					if vioGetElementData ( player, "planelicensea" ) == 1 then
						vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 34950 )
						vioSetElementData ( player, "planelicenseb", 1 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nFluglizens\nTyp B erhalten!", 5000, 0, 255, 0 )
						playSoundFrontEnd ( player, 40 )
						dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "FlugscheinKlasseB", 1, "UID", playerUID[pname] )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du benoetigst\nzuerst einen\nFlugschein Typ A!", 5000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen Flugschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "wschein" then
			if tonumber(vioGetElementData ( player, "gunlicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= waffenscheinprice then
					if tonumber(vioGetElementData ( player, "playingtime" )) >= noobtime then
						vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - waffenscheinprice )
						prompt ( player, "Du hast soeben deinen Waffenschein erhalten,\nder dich zum Besitz einer Waffe berechtigt.\nTraegst du deine Waffen offen, so wird die\nPolizei sie dir abnehmen.\nFalls du zu oft negativ auffaellst ( z.b.\ndurch Schiesserein ), koennen sie dir ihn\nauch wieder abnehmen.\n\nAusserdem: GRUNDLOSES Toeten von Spielern ist verboten.\nGruende sind nicht: Geldgier, \"Hat mich angeguggt\"\nusw., sondern z.b. Selbstverteidigung oder Gangkriege.", 30 )
						playSoundFrontEnd ( player, 40 )
						vioSetElementData ( player, "gunlicense", 1 )
						dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Waffenschein", 1, "UID", playerUID[pname] )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nErst ab 3\nStunden verfuegbar!", 5000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast bereits\neinen Waffenschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "bike" then
			if tonumber(vioGetElementData ( player, "bikelicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 450 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 450 )
					vioSetElementData ( player, "bikelicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nMotorradfuehrerschein\nerhalten!", 5000, 0, 255, 0 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Motorradtfuehrerschein", 1, "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen\nMotorradfuehrerschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "planea" then
			if tonumber(vioGetElementData ( player, "planelicensea" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 15000 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 15000 )
					vioSetElementData ( player, "planelicensea", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nFlugschein\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "FlugscheinKlasseA", 1, "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen\nFlugschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "fishing" then
			if tonumber(vioGetElementData ( player, "fishinglicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 79 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 79 )
					vioSetElementData ( player, "fishinglicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nAngelschein\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Angelschein", 1, "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen Angelschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "car" then
			local price
			if vioGetElementData ( player, "playingtime" ) >= 60 * 50 then
				price = 4750
			elseif vioGetElementData ( player, "playingtime" ) >= 60 * 25 then
				price = 1750
			else
				price = 750
			end
			vioSetElementData ( player, "drivingLicensePrice", price )
			if tonumber(vioGetElementData ( player, "carlicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= price then
					startDrivingSchoolTheory_func ()
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen Fuehrerschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "perso" then
			if tonumber(vioGetElementData ( player, "perso" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 40 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 40 )
					vioSetElementData ( player, "perso", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nPersonalausweiss\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Perso", 1, "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen\nPersonalausweiss!", 5000, 255, 0, 0 )
			end
		elseif lizens == "lkw" then
			if tonumber(vioGetElementData ( player, "lkwlicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 450 then
					if vioGetElementData ( player, "carlicense" ) == 1 then
						vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 450 )
						vioSetElementData ( player, "lkwlicense", 1 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nLKW-Fuehrerschein\nerhalten!", 5000, 0, 255, 0 )
						playSoundFrontEnd ( player, 40 )
						dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "LKWfuehrerschein", 1, "UID", playerUID[pname] )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du benoetigst\nzuerst einen\nFuehrerschein!", 5000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen\nLKW-Fuehrerschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "heli" then
			if tonumber(vioGetElementData ( player, "helilicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 20000 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 20000 )
					vioSetElementData ( player, "helilicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nHelikopter-\nflugschein\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Helikopterfuehrerschein", 1, "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits\neinen Helikopter-\nflugschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "raft" then
			if tonumber(vioGetElementData ( player, "segellicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 350 then
					if vioGetElementData ( player, "motorbootlicense" ) == 1 then
						vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 350 )
						vioSetElementData ( player, "segellicense", 1 )
						triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nSegellizens\nerhalten!", 5000, 0, 255, 0 )
						playSoundFrontEnd ( player, 40 )
						dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Segelschein", 1, "UID", playerUID[pname] )
					else
						triggerClientEvent ( player, "infobox_start", getRootElement(), "Du benoetigst\nzuerst einen\nMotorboot-\nfuehrerschein!", 5000, 255, 0, 0 )
					end
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast bereits\neinen Segelschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "motorboot" then
			if tonumber(vioGetElementData ( player, "motorbootlicense" )) == 0 then
				if tonumber(vioGetElementData ( player, "money" )) >= 400 then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - 400 )
					vioSetElementData ( player, "motorbootlicense", 1 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nMotorboot-\nfuehrerschein\nerhalten!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Motorbootschein", 1, "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits\neinen Motorboot-\nfuehrerschein!", 5000, 255, 0, 0 )
			end
		elseif lizens == "maxveh" then
			if vioGetElementData ( player, "carslotupgrade" ) ~= "buyed" then
				if tonumber(vioGetElementData ( player, "money" )) >= fahrzeugslotprice[5] then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - fahrzeugslotprice[5] )
					vioSetElementData ( player, "carslotupgrade", "buyed" )
					vioSetElementData ( player, "maxcars", 7 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nMax. Fahrzeuganzahl\nauf 7\nerhöht!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "bonustable", "CarslotUpgrades", "buyed", "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			elseif tonumber(vioGetElementData ( player, "carslotupgrade2" )) ~= 1 then
				if tonumber(vioGetElementData ( player, "money" )) >= fahrzeugslotprice[7] then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - fahrzeugslotprice[7] )
					vioSetElementData ( player, "carslotupgrade2", 1 )
					vioSetElementData ( player, "maxcars", 9 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nMax. Fahrzeuganzahl\nauf 9\nerhöht!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "bonustable", "CarslotUpdate2", 1, "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			elseif tonumber(vioGetElementData ( player, "carslotupgrade3" )) ~= 1 then
				if tonumber(vioGetElementData ( player, "money" )) >= fahrzeugslotprice[9] then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - fahrzeugslotprice[9] )
					vioSetElementData ( player, "carslotupgrade3", 1 )
					vioSetElementData ( player, "maxcars", 11 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nMax. Fahrzeuganzahl\nauf 11\nerhöht!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "bonustable", "CarslotUpdate3", 1, "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			elseif tonumber(vioGetElementData ( player, "carslotupgrade4" )) ~= 1 then
				if tonumber(vioGetElementData ( player, "money" )) >= fahrzeugslotprice[11] then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - fahrzeugslotprice[11] )
					vioSetElementData ( player, "carslotupgrade4", 1 )
					vioSetElementData ( player, "maxcars", 13 )
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nMax. Fahrzeuganzahl\nauf 13\nerhöht!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "bonustable", "CarslotUpdate4", 1, "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			elseif tonumber(vioGetElementData ( player, "carslotupgrade5" )) ~= 1 then
				if tonumber(vioGetElementData ( player, "money" )) >= fahrzeugslotprice[13] then
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - fahrzeugslotprice[13] )
					vioSetElementData ( player, "carslotupgrade5", 1 )
					if vioGetElementData ( player, "adminlvl" ) >= 1 then
						vioSetElementData ( player, "maxcars", 20 )
					else
						vioSetElementData ( player, "maxcars", 15 )
					end
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nMax. Fahrzeuganzahl\nmaximiert!", 5000, 0, 255, 0 )
					playSoundFrontEnd ( player, 40 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "bonustable", "CarslotUpdate5", 1, "UID", playerUID[pname] )
				else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu hast nicht\ngenug Geld!", 5000, 255, 0, 0 )
				end
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "Du hast bereits\ndie maximale\nFahrzeuganzahl\ngekauft!", 5000, 255, 0, 0 )
			end
		end
		checkAchievLicense ( player )
	end
end
addEvent ( "LizenzKaufen", true )
addEventHandler ( "LizenzKaufen", getRootElement(), LizenzKaufen_func )

function checkAchievLicense ( player )

	if tonumber ( vioGetElementData ( player, "motorbootlicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "segellicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "helilicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "lkwlicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "lkwlicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "perso" ) )  == 1 and tonumber ( vioGetElementData ( player, "carlicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "fishinglicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "planelicensea" ) ) == 1 and tonumber ( vioGetElementData ( player, "planelicenseb" ) ) == 1 and tonumber ( vioGetElementData ( player, "bikelicense" ) ) == 1 and tonumber ( vioGetElementData ( player, "gunlicense" ) ) == 1 and vioGetElementData ( player, "licenses_achiev" ) ~= "done" then
		if vioGetElementData ( player, "licenses_achiev" ) ~= "done" then																						-- Achiev: Mr. License
			vioSetElementData ( player, "licenses_achiev", "done" )																								-- Achiev: Mr. License
			triggerClientEvent ( player, "showAchievmentBox", player, " Mr. License", 40, 10000 )																-- Achiev: Mr. License
			vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 40 )												-- Achiev: Mr. License
			dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "achievments", "Lizensen", "done", "UID", playerUID[getPlayerName(player)] )						-- Achiev: Mr. License
		end	
	end
end