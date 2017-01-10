BallasGate1 = createObject ( 3050, -2177.5, 45.400001525879, 36.599998474121, 0, 0, 90)
BallasGate2 = createObject ( 3050, -2177.5, 40.799999237061, 36.599998474121, 0, 0, 90)

BallasGateMoving = false
BallasGateMoved = false

function mv_func ( player )

	if isBallas(player) or isOnDuty(player) then
		if getDistanceBetweenPoints3D ( -2177.5, 45.400001525879, 36.599998474121, getElementPosition ( player ) ) < 17 then
			if BallasGateMoving == false then
				BallasGateMoving = true
				if BallasGateMoved == false then
					moveObject ( BallasGate1, 3000, -2177.5, 45.400001525879, 32, 0, 0, 0 )
					moveObject ( BallasGate2, 3000, -2177.5, 40.799999237061, 32, 0, 0, 0 )
					setTimer ( triggerBallasGateVarb, 3000, 1 )
					BallasGateMoved = true
				else
					moveObject ( BallasGate1, 3000, -2177.5, 45.400001525879, 36.599998474121, 0, 0, 0 )
					moveObject ( BallasGate2, 3000, -2177.5, 40.799999237061, 36.599998474121, 0, 0, 0 )
					setTimer ( triggerBallasGateVarb, 3000, 1 )
					BallasGateMoved = false
				end
			end
		end
	end
end
addCommandHandler ( "mv", mv_func )

function triggerBallasGateVarb ()

	BallasGateMoving = false
end