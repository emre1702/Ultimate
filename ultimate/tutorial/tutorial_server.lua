function startintro_func ( player )

	setElementPosition ( player, -772.75, 504.88, 1395 )
	--setPedFrozen ( player, true )
	setElementInterior ( player, 1 )
	setElementAlpha ( player, 0 )
	
	local bot1 = createPed ( 0, 0, 0, 0, 0 )
	local bot2 = createPed ( 0, 0, 0, 0, 0 )
	setElementInterior ( bot1, 1 )
	setElementInterior ( bot2, 1 )
	setElementParent ( bot1, player )
	setElementParent ( bot2, player )
	
	giveWeapon ( bot1, 25, 100, true )
	
	triggerClientEvent ( player, "startIntro", player, bot1, bot2 )
end
-- addCommandHandler ( "startintro", startintro_func )

function intfix_func ()

	local player = client
	setElementInterior ( player, 14 )
	setElementAlpha ( player, 255 )
	setPlayerHudComponentVisible ( player, "radar", true )
end
addEvent ( "intfix", true )
addEventHandler ( "intfix", getRootElement(), intfix_func )