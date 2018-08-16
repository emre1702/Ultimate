function onPlayerSpawn_func ()

	setPedSkin ( source, vioGetElementData ( source, "skinid") )
	setPlayerHudComponentVisible ( source, "radar", true )
	setTimer ( ShowWanteds_func, 250, 1, source )
	
    if isKeyBound ( source, "r", "down", reload ) then
        unbindKey ( source, "r", "down", reload )
    end
    
    bindKey ( source, "r", "down", reload )
	
end
addEventHandler("onPlayerSpawn", getRootElement(), onPlayerSpawn_func )

function ShowWanteds_func ( player )
	
	setPlayerWantedLevel ( player, tonumber(vioGetElementData ( player, "wanteds" )) )
end