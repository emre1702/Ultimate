function putFoodInSlot ( player, item )

	for i = 1, 3 do
		if vioGetElementData ( player, "food"..i ) == 0 then
			if item == 5 then
				outputChatBox ( "Happy Halloween wuenscht dir Ultimate! Schau in deinem Inventar nach!", player, 125, 0, 0 )
				vioSetElementData ( player, "food"..i, item )
				break
			else
				vioSetElementData ( player, "food"..i, item )
				outputChatBox ( "Dein "..foodName[item].." wurde in Slot NR. "..i.." abgelegt, nutze es mit /eat "..i.." !", player, 0, 125, 0 )
				break
			end
		elseif i == 3 then
			if item == 5 then
				outputChatBox ( "Frohe Ostern wuenscht dir Ultimate! Schau in deinem Inventar nach!", player, 125, 0, 0 )
				vioSetElementData ( player, "food"..i, item )
			else
				outputChatBox ( "Du hast leider keinen freien Slot mehr!", player, 125, 0, 0 )
			end
		end
	end
end

-- X-MAS --
function unwrapPeresent ( player )

	if vioGetElementData ( player, "presents" ) > 0 then
		vioSetElementData ( player, "presents", vioGetElementData ( player, "presents" ) - 1 )
		local amount, content
		local rnd = math.random ( 1, 10000 )
		-- Geld / Chips
		if rnd <= 3500 then
			amount = math.random ( 250, 1000 )
			if math.random ( 1, 2 ) then
				content = amount.." $"
				vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + amount )
			else
				content = amount.." Casino Chips"
				vioSetElementData ( player, "casinoChips", vioGetElementData ( player, "casinoChips" ) + amount )
			end
		-- Items
		elseif rnd <= 7000 then
			rnd = math.random ( 1, 4 )
			if rnd == 1 then
				amount = math.random ( 15, 100 )
				vioSetElementData ( player, "drugs", vioGetElementData ( player, "drugs" ) + amount )
				content = amount.." Gramm Drogen"
			elseif rnd == 2 then
				amount = math.random ( 15, 100 )
				vioSetElementData ( player, "mats", vioGetElementData ( player, "mats" ) + amount )
				content = amount.." Materials"
			elseif rnd == 3 then
				amount = math.random ( 5, 25 )
				vioSetElementData ( player, "flowerseeds", vioGetElementData ( player, "flowerseeds" ) + amount )
				content = amount.." Hanfsamen"
			else
				amount = math.random ( 3, 15 )
				vioSetElementData ( player, "benzinkannister", vioGetElementData ( player, "benzinkannister" ) + amount )
				content = amount.." Benzinkanister"
			end
		-- Platzierbares
		elseif rnd <= 8500 then
			rnd = math.random ( 1, 3 )
			if rnd == 1 then
				vioSetElementData ( player, "object", 1828 )
				content = "Tiegerfell ( Zum platzieren )"
			elseif rnd == 2 then
				vioSetElementData ( player, "object", 13593 )
				content = "Rampe ( Zum platzieren )"
			elseif rnd == 3 then
				vioSetElementData ( player, "object", 2984 )
				content = "Toilettenhaeuschen ( Zum platzieren )"
			end
		-- Soziale Staten
		elseif rnd <= 9990 then
			local rank = ""
			local rnd = math.random ( 1, 5 )
			if rnd == 1 then
				rank = "Schneemann"
			elseif rnd == 2 then
				rank = "Grinch"
			elseif rnd == 3 then
				rank = "Santa Claus"
			elseif rnd == 4 then
				rank = "Rentier"
			elseif rnd == 5 then
				rank = "Tannenbaum"
			end
			vioSetElementData ( player, "socialState", rank )
			content = "Sozialer Status: "..rank
		else
			rnd = math.random ( 1, 3 )
			word = ""
			if rnd == 1 then
				word = "Tourismo"
			elseif rnd == 2 then
				word = "ZR-350"
			elseif rnd == 3 then
				word = "Alpha"
			end
			outputServerLog ( getPlayerName ( player ).." hat einen "..word.." gewonnen!" )
			outputChatBox ( "Melde dich bei Zipper, um deinen Gewinn einzuloesen!", player, 0, 125, 0 )
			outputChatBox ( "Bonuscode: "..string.sub ( md5 ( getPlayerName ( player ).."x-mas"..word ), 1, 8 ), player, 125, 0, 0 )
			content = "Fahrzeug: "..word
		end
		outputChatBox ( "Dein Geschenk hat folgendes enthalten: "..content..".", player, 0, 125, 0 )
	end
end
-- X-MAS --

function executeCommand_func ( player, cmd, arg1 )

	if player == client then
		if arg1 then
			eat ( player, "eat", arg1 )
		elseif cmd == "grow" then
			grow_func ( player, "grow", "weed" )
		elseif cmd == "presents" then
			unwrapPeresent ( player )
		else
			local proceed = true
			for i = 1, 6 do
				if cmd == "useAmmo"..i then
					proceed = false
					if vioGetElementData ( player, "curAmmoTyp" ) == i then
						vioSetElementData ( player, "curAmmoTyp", 0 )
						infobox ( player, "Spezialmunnition\nwird nicht mehr\nverwendet!", 5000, 0, 200, 0 )
					else
						vioSetElementData ( player, "curAmmoTyp", i )
						infobox ( player, "Munnitionstyp aus-\ngewählt!", 5000, 0, 200, 0 )
					end
					break
				end
			end
			if proceed then
				executeCommandHandler ( cmd, player )
			end
		end
		triggerClientEvent ( player, "refreshItems", getRootElement() )
	end
end
addEvent ( "executeCommand", true )
addEventHandler ( "executeCommand", getRootElement(), executeCommand_func )

function internet_func ( player )

	if vioGetElementData ( player, "fruitNotebook" ) >= 1 then
		triggerClientEvent ( player, "showFruitDesktop", getRootElement() )
	end
end
addCommandHandler ( "internet", internet_func )

function dice_func ( player )

	if vioGetElementData ( player, "dice" ) == 1 then
		local posX, posY, posZ = getElementPosition( player )
		local chatSphere = createColSphere ( posX, posY, posZ, 15 )
		local nearbyPlayers = getElementsWithinColShape ( chatSphere, "player" )
		destroyElement ( chatSphere )
		rnd = math.random(1,6)
		local pname = getPlayerName ( player )
		for i=1, #nearbyPlayers do	
			outputChatBox ( "*"..pname.." hat eine "..rnd.." gewurfelt!", nearbyPlayers[i], 100, 0, 200 )
		end
	else
		outputChatBox ( "Du hast keinen Wuerfel!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "dice", dice_func )

function throw_func ( player, cmd, item, count )

	if player == client then
		if item == "mats" then
			vioSetElementData ( player, "mats", 0 )
			outputChatBox ( "Du hast deine Materialien weggeworfen!", player, 125, 0, 0 )
			executeCommandHandler ( "meCMD", player, " wirft einige Metallteile weg..." )
		elseif item == "drugs" then
			vioSetElementData ( player, "drugs", 0 )
			outputChatBox ( "Du hast deine Drogen weggeworfen!", player, 125, 0, 0 )
			executeCommandHandler ( "meCMD", player, " wirft ein weisses Paeckchen weg..." )
		elseif item == "food" then
			vioSetElementData ( player, "food"..count, 0 )
			outputChatBox ( "Du hast dein Essen in Slot NR. "..count.." weggeworfen!", player, 125, 0, 0 )
		elseif item == "fuel" then
			vioSetElementData ( player, "benzinkannister", 0 )
			outputChatBox ( "Du hast deinen Benzinkannister weggeworfen!", player, 125, 0, 0 )
		elseif item == "dice" then
			vioSetElementData ( player, "dice", 0 )
			outputChatBox ( "Du hast deinen Wuerfel weggeworfen!", player, 125, 0, 0 )
		elseif item == "zigaretten" then
			vioSetElementData ( player, "zigaretten", 0 )
			outputChatBox ( "Du hast deine Zigaretten weggeworfen!", player, 125, 0, 0 )
		elseif item == "flowerseeds" then
			vioSetElementData ( player, "flowerseeds", 0 )
			outputChatBox ( "Du hast deine Hanfsamen weggeworfen!", player, 125, 0, 0 )
			executeCommandHandler ( "meCMD", player, " wirft einige Samen weg..." )
		elseif item == "object" then
			vioSetElementData ( player, "object", 0 )
			outputChatBox ( "Du hast dein Objekt weggeworfen!", player, 125, 0, 0 )
			executeCommandHandler ( "meCMD", player, " wirft ein Objekt weg." )
		elseif item == "chips" then
			vioSetElementData ( player, "casinoChips", 0 )
			outputChatBox ( "Du hast deine Casino-Chips weggeworfen!", player, 125, 0, 0 )
			executeCommandHandler ( "meCMD", player, " wirft einige Chips weg." )
		elseif item == "presents" then
			outputChatBox ( "Das solltest du nicht wegwerfen!", player, 125, 0, 0 )
		else
			outputChatBox ( "Dieses Item kannst du nicht wegwerfen!", player, 125, 0, 0 )
		end
		triggerClientEvent ( player, "refreshItems", getRootElement() )
	end
end
addEvent ( "throw", true )
addEventHandler ( "throw", getRootElement(), throw_func )

function giveitem_func ( target, item, food, amount )

	if source == client then
		local player = source
		local target = getPlayerFromName ( target )
		if isElement ( player ) and isElement ( target ) then
			if item == "object" then
				if vioGetElementData ( target, "object" ) == 0 then
					if vioGetElementData ( player, "object" ) > 0 then
						vioSetElementData ( target, "object", vioGetElementData ( player, "object" ) )
						vioSetElementData ( player, "object", 0 )
						executeCommandHandler ( "meCMD", player, " gibt "..getPlayerName(target).." ein Objekt." )
					else
						infobox ( "Du hast kein Objekt, das du vergeben kannst!", player, 5000, 200, 0, 0 )
					end
				else
					infobox ( "Der Spieler hat bereits ein Objekt!", player, 5000, 200, 0, 0 )
				end
			else
				amount = amount and math.abs ( math.floor ( amount ) ) or 1
				if food then
					if vioGetElementData ( target, "food1" ) or vioGetElementData ( target, "food2" ) or vioGetElementData ( target, "food3" ) then
						slot = vioGetElementData ( player, "food"..food )
						putFoodInSlot ( target, vioGetElementData ( player, "food"..food ) )
						vioSetElementData ( player, "food"..food, 0 )
						outputChatBox ( "Du hast "..getPlayerName ( target ).." folgendes Item gegeben: "..foodName[slot]".", player, 10, 125, 10 )
						outputChatBox ( "Du hast von "..getPlayerName ( player ).." folgendes Item erhalten: "..foodName[slot]".", target, 10, 125, 10 )
						executeCommandHandler ( "meCMD", player, " gibt "..getPlayerName(target).." etwas zu essen." )
					else
						outputChatBox ( "Der Spieler hat keinen freien Inventarslot mehr!", player, 125, 0, 0 )
					end
				else
					if not amount then amount = 1 end
					if item == "fill" then
						if vioGetElementData ( target, "benzinkannister" ) == 0 then
							vioSetElementData ( target, "benzinkannister", 1 )
							vioSetElementData ( player, "benzinkannister", vioGetElementData ( player, "benzinkannister" ) - 1 )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." einen Benzinkanister gegeben!", player, 10, 125, 10 )
							outputChatBox ( "Du hast von "..getPlayerName ( player ).." einen Benzinkanister erhalten!", target, 10, 125, 10 )
							executeCommandHandler ( "meCMD", player, " gibt "..getPlayerName(target).." einen Benzinkanister." )
						else
							outputChatBox ( "Der Spieler hat bereits einen Kannister!", player, 125, 0, 0 )
						end
					elseif item == "grow" then
						local weed = vioGetElementData ( player, "flowerseeds" )
						if weed >= amount then
							vioSetElementData ( player, "flowerseeds", vioGetElementData ( player, "flowerseeds" ) - amount )
							vioSetElementData ( target, "flowerseeds", vioGetElementData ( target, "flowerseeds" ) + amount )
							outputChatBox ( "Du hast von "..getPlayerName ( player ).." "..amount.." Hanfsamen erhalten!", target, 10, 125, 10 )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." "..amount.." Hanfsamen gegeben!", player, 10, 125, 10 )
							executeCommandHandler ( "meCMD", player, " gibt "..getPlayerName(target).." einige Koerner..." )
						else
							outputChatBox ( "Du hast nicht so viele Hanfsamen!", player, 125, 0, 0 )
						end
					elseif item == "usedrugs" then
						local drugs = vioGetElementData ( player, "drugs" )
						if drugs >= amount then
							vioSetElementData ( player, "drugs", drugs - amount )
							vioSetElementData ( target, "drugs", vioGetElementData ( target, "drugs" ) + amount )
							outputChatBox ( "Du hast von "..getPlayerName ( player ).." "..amount.." g Drogen erhalten!", target, 10, 125, 10 )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." "..amount.." g Drogen gegeben!", player, 10, 125, 10 )
							executeCommandHandler ( "meCMD", player, " gibt "..getPlayerName(target).." ein weisses Paeckchen." )
						else
							outputChatBox ( "Du hast nicht so viele Drogen!", player, 125, 0, 0 )
						end
					elseif item == "mats" then
						local mats = vioGetElementData ( player, "mats" )
						if mats >= amount then
							vioSetElementData ( player, "mats", mats - amount )
							vioSetElementData ( target, "mats", vioGetElementData ( target, "mats" ) + amount )
							outputChatBox ( "Du hast von "..getPlayerName ( player ).." "..amount.." Materialien erhalten!", target, 10, 125, 10 )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." "..amount.." Materialien gegeben!", player, 10, 125, 10 )
							executeCommandHandler ( "meCMD", player, " gibt "..getPlayerName(target).." einige Materialien..." )
						else
							outputChatBox ( "Du hast nicht so viele Materialien!", player, 125, 0, 0 )
						end
					elseif item == "dice" then
						outputChatBox ( "Dieses Item kannst du nicht abgeben.", player, 125, 0, 0 )
					elseif item == "smoke" then
						local cig = vioGetElementData ( player, "zigaretten" )
						if cig >= amount then
							vioSetElementData ( player, "zigaretten", cig - amount )
							vioSetElementData ( target, "zigaretten", vioGetElementData ( target, "zigaretten" ) + amount )
							outputChatBox ( "Du hast von "..getPlayerName ( player ).." "..amount.." Zigaretten erhalten!", target, 10, 125, 10 )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." "..amount.." Zigaretten gegeben!", player, 10, 125, 10 )
							executeCommandHandler ( "meCMD", player, " gibt "..getPlayerName(target).." eine Packung Zigaretten." )
						else
							outputChatBox ( "Du hast nicht so viele Zigaretten!", player, 125, 0, 0 )
						end
					elseif item == "chips" then
						local chips = vioGetElementData ( player, "casinoChips" )
						if chips >= amount then
							vioSetElementData ( player, "casinoChips", chips - amount )
							vioSetElementData ( target, "casinoChips", vioGetElementData ( target, "casinoChips" ) + amount )
							outputChatBox ( "Du hast von "..getPlayerName ( player ).." "..amount.." Chips erhalten!", target, 10, 125, 10 )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." "..amount.." Chips gegeben!", player, 10, 125, 10 )
							executeCommandHandler ( "meCMD", player, " gibt "..getPlayerName(target).." einige Chips." )
						end
					elseif item == "halloween" then
						local eggs = vioGetElementData ( player, "easterEggs" )
						if eggs >= amount then
							vioSetElementData ( player, "easterEggs", eggs - amount )
							vioSetElementData ( target, "easterEggs", vioGetElementData ( target, "easterEggs" ) + amount )
							outputChatBox ( "Du hast von "..getPlayerName ( player ).." "..amount.." Kuerbisse erhalten!", target, 10, 125, 10 )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." "..amount.." Kuerbisse gegeben!", player, 10, 125, 10 )
							executeCommandHandler ( "meCMD", player, " gibt "..getPlayerName(target).." einige Kuerbisse." )
						end
					elseif item == "presents" then
						local presents = vioGetElementData ( player, "presents" )
						if presents >= amount then
							vioSetElementData ( player, "presents", presents - amount )
							vioSetElementData ( target, "presents", vioGetElementData ( target, "presents" ) + amount )
							outputChatBox ( "Du hast von "..getPlayerName ( player ).." "..amount.." Geschenke erhalten!", target, 10, 125, 10 )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." "..amount.." Geschenke gegeben!", player, 10, 125, 10 )
							executeCommandHandler ( "meCMD", player, " gibt "..getPlayerName(target).." einige Geschenke." )
						end
					else
						outputChatBox ( "Dieses Item kannst du nicht abgeben.", player, 125, 0, 0 )
					end
				end
			end
		end
	end
end
addEvent ( "giveitem", true )
addEventHandler ( "giveitem", getRootElement(), giveitem_func )