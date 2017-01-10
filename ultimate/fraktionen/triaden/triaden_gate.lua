local gateMoved = false
triadGate = createObject ( 986, -2241.7890625, 643.9013671875, 50.107360839844, 0, 0, 90 )

triadCasinoGate = createObject ( 7657, 1903.6638183594, 967.37475585938, 11.5371551, 0, 0, 0 )
triadCasinoGateA = createObject ( 7657, 1903.6638183594, 967.37475585938, 11.5371551, 0, 0, 180 )
attachElementsInCorrectWay ( triadCasinoGateA, triadCasinoGate )

triadCasinoGateState = false
fourDragonGateSwitches = {}
local switchA = createObject ( 2886, 1896.2963867188, 967.83520507813, 11.806823730469, 0, 0, 180 )
local switchB = createObject ( 2886, 1910.2141113281, 966.93408203125, 11.806823730469, 0, 0, 0 )
fourDragonGateSwitches[switchA] = true
fourDragonGateSwitches[switchB] = true

function gate_func ( player )
	if isTriad(player) or isOnDuty(player) then	
		if getDistanceBetweenPoints3D ( -2241.7890625, 643.9013671875, 50.107360839844, getElementPosition ( player ) ) < 10 then
			if gateMoved == false then
				moveObject ( triadGate, 3000, -2241.7890625, 643.9013671875, 41.357360839844, 0, 0, 0 )
				gateMoved = true
			else
				moveObject ( triadGate, 3000, -2241.7890625, 643.9013671875, 50.107360839844, 0, 0, 0 )
				gateMoved = false
			end
		end
	end
end
addCommandHandler ( "mv", gate_func )


function moveTriadCasinoGate_func ( player )
	
	if isTriad ( player ) or isOnDuty(player) then
		if getDistanceBetweenPoints3D ( 1903.6638183594, 967.37475585938, 11.5371551, getElementPosition ( player ) ) < 10 then
			if triadCasinoGateState then
				moveObject ( triadCasinoGate, 5000, 1903.6638183594, 967.37475585938, 11.5371551, 0, 0, 0 )
			else
				moveObject ( triadCasinoGate, 5000, 1903.6638183594 + 20, 967.37475585938, 11.5371551, 0, 0, 0 )
			end
			triadCasinoGateState = not triadCasinoGateState
		end
	end
end
addCommandHandler ( "mv", moveTriadCasinoGate_func )