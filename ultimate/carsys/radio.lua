-------------------------
------- (c) 2009 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function radioenter ( player )

	if player == getLocalPlayer() then
		if not vioClientGetElementData ( "favchannel" ) then
			setRadioChannel ( 0 )
		else
			setRadioChannel ( tonumber ( vioClientGetElementData ( "favchannel" ) ) )
		end
		setPlayerHudComponentVisible ( "radio", true )
	end
end
addEventHandler ( "onClientVehicleEnter", getRootElement(), radioenter )


function radioleave ( player )

	if player == getLocalPlayer() then
		setPlayerHudComponentVisible ( "radio", false )
	end
end
addEventHandler ( "onClientVehicleExit", getRootElement(), radioleave )