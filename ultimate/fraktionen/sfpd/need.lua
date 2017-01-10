local playerblip = {}
local playerbliptimer = {}
local antispam = {}

addCommandHandler ( "needhelp", function ( player )
	if ( antispam[player] or 0 ) + 2000 <= getTickCount() then
		if isOnDuty ( player ) then
			if isElement ( playerblip[player] ) then
				destroyElement ( playerblip[player] )
				killTimer ( playerbliptimer[player] )
			end
			playerblip[player] = createBlipAttachedTo ( player, 0, 2, 255, 0, 0, 255, 0, 65535, player )
			playerbliptimer[player] = setTimer ( destroyElement, 2*60000, 1, playerblip[player] )
			local playername = getPlayerName ( player )
			for thePlayer, _ in pairs ( fraktionMembers[1] ) do
				setElementVisibleTo ( playerblip[player], thePlayer, true )
				outputChatBox ( playername.." fordert Unterstützung. Der Standort wird für 2 Minuten markiert.", thePlayer, 0, 141, 235 )
			end
			for thePlayer, _ in pairs ( fraktionMembers[6] ) do
				setElementVisibleTo ( playerblip[player], thePlayer, true )
				outputChatBox ( playername.." fordert Unterstützung. Der Standort wird für 2 Minuten markiert.", thePlayer, 0, 141, 235 )
			end
			for thePlayer, _ in pairs ( fraktionMembers[8] ) do
				setElementVisibleTo ( playerblip[player], thePlayer, true )
				outputChatBox ( playername.." fordert Unterstützung. Der Standort wird für 2 Minuten markiert.", thePlayer, 0, 141, 235 )
			end
		end
	end
end )