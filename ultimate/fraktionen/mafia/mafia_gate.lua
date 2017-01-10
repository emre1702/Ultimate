MAFIAgate1Moved = false
MAFIAgate2Moved = false
MAFIAgate3Moved = false
MAFIAgate4Moved = true
MAFIAGate11 = createObject ( 969, -735.5, 770.900390625, 17.60000038147, 0, 0, 152.99560546875 )
MAFIAGate12 = createObject ( 969, -735.40002441406, 770.90002441406, 17.60000038147, 0, 0, 23 )
MAFIAGate2 = createObject ( 969, -679.89282226563, 1050.6893310547, 11.1328125, 0, 0, 348.08532714844 )
MAFIAGate3 = createObject ( 971, -800.20989990234, 1004.3591308594, 20.387649536133, 0, 0, 76.10498046875 )

MAFIAGate4 = createObject ( 2634, 2147.8286132813, 1604.787109375, 1006.6293334961, 0, 0, 0 )
setElementInterior ( MAFIAGate4, 1 )

createObject ( 969, -671.22625732422, 1048.8637695313, 11.1328125, 0, 0, 348.08532714844 )
createObject ( 971, -684.10284423828, 1052.4639892578, 11.452730178833, 0, 0, 336.18005371094 )

MafiaDoorKeypadA = createObject ( 2886, 2149.0217285156, 1604.5771484375, 1006.5141601563, 0, 0, 0 )
setElementInterior ( MafiaDoorKeypadA, 1 )
MafiaDoorKeypadB = createObject ( 3052, 2149.0476074219, 1604.8155517578, 1006.5411987305, 0, 90, 90 )

MafiaCasinoKeypads = {
 [MafiaDoorKeypadA]=true,
 [MafiaDoorKeypadB]=true
}

function mv_func ( player )

	if isMafia(player) or isOnDuty(player) then
		if getDistanceBetweenPoints3D ( -735.01953125, 774.21478271484, 17.2798690795, getElementPosition ( player ) ) < 17 then
			if MAFIAgate1Moved == false then
				moveObject ( MAFIAGate11, 3000, -741.59997558594, 774.09997558594, 17.60000038147 )
				moveObject ( MAFIAGate12, 3000, -729, 773.5, 17.60000038147 )
				MAFIAgate1Moved = true
			else
				moveObject ( MAFIAGate11, 3000, -735.5, 770.900390625, 17.60000038147 )
				moveObject ( MAFIAGate12, 3000, -735.40002441406, 770.90002441406, 17.60000038147 )
				MAFIAgate1Moved = false
			end
		elseif getDistanceBetweenPoints3D ( -679.89282226563, 1050.6893310547, 11.1328125, getElementPosition ( player ) ) < 17 then
			if MAFIAgate2Moved == false then
				moveObject ( MAFIAGate2, 3000, -671.24029541016, 1048.9068603516, 11.1328125, 0, 0, 0 )
				MAFIAgate2Moved = true
			else
				moveObject ( MAFIAGate2, 3000, -679.89282226563, 1050.6893310547, 11.1328125, 0, 0, 0 )
				MAFIAgate2Moved = false
			end
		elseif getDistanceBetweenPoints3D ( -800.20989990234, 1004.3591308594, 20.387649536133, getElementPosition ( player ) ) < 17 then
			if not MAFIAgate3Moved then
				moveObject ( MAFIAGate3, 3000, -798.14, 1012.92, 20.37, 0, 0, 0 )
				MAFIAgate3Moved = true
			else
				moveObject ( MAFIAGate3, 3000, -800.20989990234, 1004.3591308594, 20.387649536133, 0, 0, 0 )
				MAFIAgate3Moved = false
			end
		end
	end
end
addCommandHandler ( "mv", mv_func )


function moveCasinoDoor ( player )

	if isMafia ( player ) then
		MAFIAgate4Moved = not MAFIAgate4Moved
		if MAFIAgate4Moved then
			moveObject ( MAFIAGate4, 2500, 2147.8286132813, 1604.787109375, 1006.6293334961, 0, 0, -70 )
		else
			moveObject ( MAFIAGate4, 2500, 2147.2602539063, 1605.478515625, 1006.6293334961, 0, 0, 70 )
		end
	end
end