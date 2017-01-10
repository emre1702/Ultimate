--[[GroveGate1 = createObject ( 980,997.8994140625,1684.3994140625,12.699999809265,0,0,90)

function mv_func (player)

	if isGrove or isFBI(player) or isTerror (player) then
		if getDistanceBetweenPoints3D ( 997.8994140625,1684.3994140625,12.699999809265, getElementPosition ( player ) ) < 17 then
					moveObject ( GroveGate1, 3000, 997.8994140625,1684.3994140625,7 )
					setTimer ( triggerGroveGate1Varb, 10000, 1 )
					outputChatBox("Das Tor schliest sich in 10 Sekunden wieder", player )
		end
	end
end
addCommandHandler( "mv", mv_func )

function triggerGroveGate1Varb ()

	moveObject ( GroveGate1, 3000, 997.8994140625,1684.3994140625,12.699999809265 )
end--]]


-- SF --
local lift = createObject(3095,-2446.6000976563,-85.800003051758,32.200000762939,0,0,0)

function lift_grove_func ( player, cmd, zahl )
	local x, y, z = getElementPosition(player)
	if isGrove(player) or isOnDuty(player) or isMedic(player) then
		if getDistanceBetweenPoints3D(x,y,z,-2446.6000976563,-85.800003051758,32.200000762939) <= 30 then
			if zahl == "0" then
				moveObject(lift, 5000,-2446.6000976563,-85.800003051758,32.200000762939)
				outputChatBox("Lift bewegt sich auf Deck 0", player, 0, 255, 0)
			elseif zahl == "1" then
				moveObject(lift, 5000,-2446.6000976563,-85.800003051758,40.700000762939)
				outputChatBox("Lift bewegt sich auf Deck 1", player, 0, 255, 0)
			elseif zahl == "2" then
				moveObject(lift, 5000,-2446.6000976563,-85.800003051758,47.400001525879)
				outputChatBox("Lift bewegt sich auf Deck 2", player, 0, 255, 0)
			else
				outputChatBox("Nutze '/lift [0-2]",player)
			end
		end
	end
end
addCommandHandler("lift", lift_grove_func)

local gate = createObject(987, -2441, -81.05, 33.400001525879, 0, 3.7957763671875, 177.98950195313)
local gate_Status = "zu"

function gate_grove_func ( player )
	local x, y, z = getElementPosition(player)
	if isGrove(player) or isOnDuty(player) or isMedic(player) then
		if getDistanceBetweenPoints3D(x,y,z,-2441, -81.05, 33.400001525879) <= 15 then
			if gate_Status == "zu" then
				moveObject(gate, 1500, -2441, -81.05, 26.60000038147)
				gate_Status = "offen"
			else
				moveObject(gate, 1500, -2441, -81.05, 33.400001525879)
				gate_Status = "zu"
			end
		end
	end
end
addCommandHandler("mv",gate_grove_func)

local hgate = createObject(988,-2491.1999511719,-129.19999694824,24.60000038147,0,0,270)
local hgate_Status = "zu"

function hgate_grove_func ( player )
	local x, y, z = getElementPosition(player)
	if isGrove(player) or isOnDuty(player) or isMedic(player) then
		if getDistanceBetweenPoints3D(x,y,z,-2491.1999511719,-129.19999694824,24.60000038147) <= 15 then
			if hgate_Status == "zu" then
				moveObject(hgate, 1500, -2491.1999511719,-129.19999694824,18.89999961853)
				hgate_Status = "offen"
			else
				moveObject(hgate, 1500, -2491.1999511719, -129.19999694824, 24.60000038147)
				hgate_Status = "zu"
			end
		end
	end
end
addCommandHandler("mv", hgate_grove_func)