bonusVehicles = {
 [460]=true, -- Wasserflugzeug
 [539]=true, -- Vortex
 [471]=true, -- Quad
 [442]=true, -- Leichenwagen
 [457]=true  -- Golfwagen
}

camper = {
 [483]=true,
 [508]=true
}

function hasPlayerLicense ( player, id )

	return true
end


function opticExitVehicle ( player )


	local veh = getPedOccupiedVehicle ( player )

	if isElement ( veh ) then

		if getPedOccupiedVehicleSeat ( player ) == 0 then

			setElementVelocity ( veh, 0, 0, 0 )

		end

		setPedControlState ( player, "enter_exit", false )

		setTimer ( removePedFromVehicle, 750, 1, player )

		setTimer ( setPedControlState, 150, 1, player, "enter_exit", false )

		setTimer ( setPedControlState, 200, 1, player, "enter_exit", true )

		setTimer ( setPedControlState, 700, 1, player, "enter_exit", false )

	end

end

addEvent ( "opticExitVehicle", true )

addEventHandler ( "opticExitVehicle", getRootElement(),

	function ()

		opticExitVehicle ( client )

	end

)



function hasPlayerPerso ( player )

	return ( vioGetElementData ( player, "perso" ) == 1 )
end