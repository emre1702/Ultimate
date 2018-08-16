cigarChokeTime = 3000
local smokingPlayers = {}

function removeAddicts_func ()

	local player = client
	local total = getTotalAddictLevel ( player )
	local totalCost = getTotalAddictLevel ( player ) * addictRemoveCost
	local money = vioGetElementData ( player, "money" )
	if money >= totalCost then
		takePlayerSaveMoney ( player, totalCost )
		
		vioSetElementData ( player, "cigarettAddictPoints", 0 )
		vioSetElementData ( player, "alcoholAddictPoints", 0 )
		vioSetElementData ( player, "drugAddictPoints", 0 )
		
		vioSetElementData ( player, "cigarettFlushPoints", 0 )
		vioSetElementData ( player, "alcoholFlushPoints", 0 )
		vioSetElementData ( player, "drugFlushPoints", 0 )
		
		triggerClientEvent ( player, "showAddictInfo", player, true )
	else
		infobox ( player, "\n\n\nDu hast nicht\ngenug Geld!", 7500, 125, 0, 0 )
	end
end
addEvent ( "removeAddicts", true )
addEventHandler ( "removeAddicts", getRootElement(), removeAddicts_func )

function takeDrugs ( player )

	local curPoints = vioGetElementData ( player, "drugAddictPoints" )
	local curFlush = vioGetElementData ( player, "drugFlushPoints" )
	meCMD_func ( player, "cmd", "raucht Grass." )
	
	vioSetElementData ( player, "drugAddictPoints", curPoints + 1 )
	vioSetElementData ( player, "drugFlushPoints", curFlush + 5 )
	
	setElementHealth ( player, 100 )
	if getElementHunger(player) then
		setElementHunger ( player, getElementHunger(player) + 25 )
	end
	outputLog ( getPlayerName(player).." hat Drogen genommen", "Heilung" )
	
	toggleAllControls ( player, false, true, true )
	
	setPedAnimation ( player, "crack", "crckdeth2", 1, true, true, false )
	setTimer ( setPedAnimation, 5000, 1, player )
	triggerClientEvent ( player, "showAddictInfo", player, true )
	setTimer ( toggleAllControls, 5000, 1, player, true, true, true )
	triggerClientEvent ( player, "startDrugEffect", player, 30000 * 5, getDrugStrength ( player ), false, true )
end

function checkForSymptoms ( player )

	local smokeFlush = vioGetElementData ( player, "cigarettFlushPoints" )
	local drinkFlush = vioGetElementData ( player, "alcoholFlushPoints" )
	local drugFlush = vioGetElementData ( player, "drugFlushPoints" )
	
	local smokeAddict = vioGetElementData ( player, "cigarettAddictPoints" )
	local drinkAddict = vioGetElementData ( player, "alcoholAddictPoints" )
	local drugAddict = vioGetElementData ( player, "drugAddictPoints" )
	
	if math.floor ( smokeAddict/addictLevelDivisors[1] ) < smokeFlush then
		infobox ( player, "Du hast zu lange\nnicht geraucht und\nhast Entzugs-\nerscheinungen.\nBesorg dir ein\npaar Zigaretten!", 7500, 125, 0, 0 )
		detoxSympton ( player )
	elseif math.floor ( drinkAddict/addictLevelDivisors[2] ) < drinkFlush then
		infobox ( player, "Du hast zu lange\nnicht getrunken und\nhast Entzugs-\nerscheinungen.\nBesorg dir einen\nDrink!", 7500, 125, 0, 0 )
		detoxSympton ( player )
	elseif math.floor ( drugAddict/addictLevelDivisors[3] ) < drugFlush then
		infobox ( player, "Du hast zu lange\nnichts genommen und\nhast Entzugs-\nerscheinungen.\nBesorg dir etwas\nStoff!", 7500, 125, 0, 0 )
		detoxSympton ( player )
	end
end

function detoxSympton ( player )

	if getPedOccupiedVehicle ( player ) then
		toggleControl ( player, "accelerate", false )
		setPedControlState ( player, "accelerate", true )
		setTimer ( toggleControl, 5000, 1, player, "accelerate", true )
		setTimer ( setPedControlState, 5000, 1, player, "accelerate", false )
	else
		crackAnimation_func ( player )
	end
end

function lowerFlush ( player )

	local smokeFlush = vioGetElementData ( player, "cigarettFlushPoints" )
	local drinkFlush = vioGetElementData ( player, "alcoholFlushPoints" )
	local drugFlush = vioGetElementData ( player, "drugFlushPoints" )
	
	local change = false
	
	if smokeFlush and smokeFlush > 0 then
		change = true
		vioSetElementData ( player, "cigarettFlushPoints", smokeFlush - 1 )
	end
	if drinkFlush and drinkFlush > 0 then
		change = true
		vioSetElementData ( player, "alcoholFlushPoints", drinkFlush - 1 )
	end
	if drugFlush and drugFlush > 0 then
		change = true
		vioSetElementData ( player, "drugFlushPoints", drugFlush - 1 )
	end
	
	if change then
		triggerClientEvent ( player, "showAddictInfo", player, true )
	end
end

function lowerAddict ( player )

	local smokeAddict = vioGetElementData ( player, "cigarettAddictPoints" )
	local drinkAddict = vioGetElementData ( player, "alcoholAddictPoints" )
	local drugAddict = vioGetElementData ( player, "drugAddictPoints" )
	
	local change = false
	
	if smokeAddict > 0 then
		vioSetElementData ( player, "cigarettAddictPoints", smokeAddict - 1 )
		if math.floor ( smokeAddict / addictLevelDivisors[1] ) > math.floor ( vioGetElementData ( player, "cigarettAddictPoints" ) / addictLevelDivisors[1] ) then
			change = true
		end
	end
	if drinkAddict > 0 then
		vioSetElementData ( player, "alcoholAddictPoints", drinkAddict - 1 )
		if math.floor ( drinkAddict / addictLevelDivisors[2] ) > math.floor ( vioGetElementData ( player, "alcoholAddictPoints" ) / addictLevelDivisors[2] ) then
			change = true
		end
	end
	if drugAddict > 0 then
		vioSetElementData ( player, "drugAddictPoints", drugAddict - 1 )
		if math.floor ( drugAddict / addictLevelDivisors[3] ) > math.floor ( vioGetElementData ( player, "drugAddictPoints" ) / addictLevelDivisors[3] ) then
			change = true
		end
	end
	
	if change then
		triggerClientEvent ( player, "showAddictInfo", player, true )
	end
end

function smokeCigarett ( player )

	if not smokingPlayers[player] then
		smokingPlayers[player ]= true
		
		local curPoints = vioGetElementData ( player, "cigarettAddictPoints" )
		local curFlush = vioGetElementData ( player, "cigarettFlushPoints" )
		meCMD_func ( player, "cmd", "raucht eine Zigarette." )
		
		vioSetElementData ( player, "cigarettAddictPoints", curPoints + 1 )
		vioSetElementData ( player, "cigarettFlushPoints", curFlush + 1 )
		
		if not isPedInVehicle ( player ) then
			setPedAnimation ( player, "smoking", "M_smkstnd_loop", 1, true, true, false )
			setTimer ( setPedAnimation, 2000, 1, player )
		end
		
		addPlayerHealth ( player, 10 )
		setElementHunger ( player, getElementHunger(player)+20 )
		outputLog ( getPlayerName(player).." hat Zigarette geraucht", "Heilung" )
		
		local drinkFlush = vioGetElementData ( player, "alcoholFlushPoints" )
		local drugFlush = vioGetElementData ( player, "drugFlushPoints" )
		
		if drinkFlush > 0 then
			vioSetElementData ( player, "alcoholFlushPoints", drinkFlush - 1 )
		end
		if drugFlush > 0 then
			vioSetElementData ( player, "drugFlushPoints", drugFlush - 1 )
		end
		
		triggerClientEvent ( player, "showAddictInfo", player, true )
		
		--toggleAllControls ( player, false, true, true )
		
		if vioGetElementData ( player, "cigarettFlushPoints" ) >= 2 * vioGetElementData ( player, "cigarettAddictPoints" )  / addictLevelDivisors[1] + 1 then
			setTimer ( setPedChoking, 2750, 1, player, true )
			setTimer ( setPedChoking, 2750 + cigarChokeTime, 1, player, false )
			
			totalSmokeTime = 2750 + cigarChokeTime
			
			infobox ( player, "Offenbar hast du\nzu viele Zigaretten\nin kurzer Zeit\ngeraucht - gewöhne\ndeine Lungen an\nZigaretten!", 7500, 125, 0, 0 )
		else
			totalSmokeTime = 2000
		end
		
		setTimer ( 
			function ( player )
				smokingPlayers[player] = false
			end,
		totalSmokeTime, 1, player )
	end
end

function drinkAlcohol ( player, sort )

	local points = alcoholSorts[sort]
	local curPoints = vioGetElementData ( player, "alcoholAddictPoints" )
	local curFlush = vioGetElementData ( player, "alcoholFlushPoints" )
	meCMD_func ( player, "cmd", "trinkt ein"..alcoholGramma[sort].."." )
	
	vioSetElementData ( player, "alcoholAddictPoints", curPoints + points )
	vioSetElementData ( player, "alcoholFlushPoints", curFlush + points * 3 )
	
	addPlayerHealth ( player, 10 * points )
	setElementHunger ( player, getElementHunger(player) + 20 * points )
	outputLog ( getPlayerName(player).." hat Alkohol getrunken", "Heilung" )
	
	if hasDrunkToMuch ( player ) then
		setTimer ( killPed, 5000, 1, player )
		setPedAnimation ( player, "food", "EAT_Vomit_P", 5000, true, true, false )
		
		infobox ( player, "\n\nDu hast zu viel\ngetrunken und dir\neine Alkoholvergiftung\nzugezogen.", 7500, 125, 0, 0 )
	else
		setTimer ( setPedAnimation, 5000, 1, player )
		setPedAnimation ( player, "VENDING", "VEND_Drink2_P", 5000, true, true, false )
		
		triggerClientEvent ( player, "showAddictInfo", player, true )
		triggerClientEvent ( player, "startDrugEffect", player, 30000 * points, getAlcoholStrength ( player ), true, false )
	end
end

function getAlcoholStrength ( player )

	local curFlush = vioGetElementData ( player, "alcoholAddictPoints" )
	curFlush = curFlush / 5 + 1
	local curAddict = vioGetElementData ( player, "alcoholFlushPoints" )
	curAddict = curAddict / addictLevelDivisors[2] + 1
	
	local strength = ( curFlush * curAddict ) / 500 * 1.1
	if strength > 1 then
		strength = 1
	elseif strength < 0.1 then
		strength = 0.1
	end
	
	return strength
end

function getDrugStrength ( player )

	local curFlush = vioGetElementData ( player, "alcoholAddictPoints" )
	curFlush = curFlush / 5 + 1
	local curAddict = vioGetElementData ( player, "alcoholFlushPoints" )
	curAddict = curAddict / addictLevelDivisors[3] + 1
	
	local strength = ( curFlush * curAddict ) / 10 ^ ( curAddict ) + 0.1
	if strength > 1 then
		strength = 1
	elseif strength < 0.1 then
		strength = 0.1
	end
	
	return strength
end
--[[
Old
function hasDrunkToMuch ( player )

	local curAddict = vioGetElementData ( player, "alcoholFlushPoints" ) / addictLevelDivisors[2] + 1
	local curFlush = vioGetElementData ( player, "alcoholAddictPoints" )
	if curFlush > curAddict * 0.75 then
		return true
	end
	return false
end
]]
function hasDrunkToMuch ( player )

	local curAddict = vioGetElementData ( player, "alcoholFlushPoints" ) / addictLevelDivisors[2] + 1
	local curFlush = vioGetElementData ( player, "alcoholAddictPoints" )
	if math.floor ( curFlush / 10 - curAddict ) >= 1 then
		return true
	end
	return false
end