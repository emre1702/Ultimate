----------------
-- Army-Tore Area51

local hGate1 = createObject( 2909, 131.10000610352, 1941.3000488281, 22, 0, 0, 89.895629882813 )
local hGate2 = createObject( 2909, 131.10000610352, 1941.3000488281, 19.60000038147, 180, 0, 89.895629882813 )
local hGate3 = createObject( 2909, 139, 1941.3000488281, 22, 0, 0, 89.895629882813 )
local hGate4 = createObject( 2909, 139, 1941.3000488281, 19.60000038147, 180, 0, 89.895629882813 )
local hGateState = false
setObjectScale ( hGate1, 0.95 )
setObjectScale ( hGate2, 0.95 )
setObjectScale ( hGate3, 0.95 )
setObjectScale ( hGate4, 0.95 )

local bGate1 = createObject( 2929, 215.9, 1875.5, 13.9, 0, 0, 0)
local bGate2 = createObject( 2927, 211.8, 1875.5, 13.9, 0, 0, 0)
local bGateState = false

local nGate = createObject( 988, 75.300003051758, 1918.5999755859, 17.60000038147, 0, 0, 274 )
setElementDoubleSided ( nGate, true )
setObjectScale ( nGate, 1.1 )
local nGateState = false

----------------------------------------------------

local area51_hangar11 = createObject( 16775, 286.5498046875, 1953.8681640625, 19.04842376709, 0, 0, 270 )
local area51_hangar12 = createObject( 16775, 286.5322265625, 1958.802734375, 19.04842376709, 0, 0, 270 )
local area51_hangar1_state = "zu"

local area51_hangar21 = createObject( 16775, 286.5498046875, 1987.6591796875, 19.04842376709, 0, 0, 270 )
local area51_hangar22 = createObject( 16775, 286.5322265625, 1992.5458984375, 19.04842376709, 0, 0, 270 )
local area51_hangar2_state = "zu"

local area51_hangar31 = createObject( 16775, 286.5498046875, 2021.87109375, 19.04842376709, 0, 0, 270 )
local area51_hangar32 = createObject( 16775, 286.5322265625, 2026.6669921875, 19.04842376709, 0, 0, 270 )
local area51_hangar3_state = "zu"

local hangarGate1 = createObject( 16773, 128.2, 1815.5999755859, 18.4, 0, 0, 0)
local hangarGate2 = createObject( 16773, 118.6, 1815.5999755859, 18.4, 0, 0, 0)
local hangarState = false
local hangarMoving = false

----------------
-- Army Tore SF
sfarmyzaun = createObject(986, -1522.8876953125,482.0810546875,6.8689527511597,0,0,352.05688476)
sfarmygate = createObject(986, -1530.7382,482.61816,6.87969017,359.7473144,0,0)
sfarmygatestate = true
----------------

-----------------------

function mv_func ( player )

	local x, y, z = getElementPosition ( player )
	
	if isArmy ( player ) or ( isOnDuty ( player ) and getPlayerRank ( player ) >= 4 ) then
	
		if getDistanceBetweenPoints3D ( x, y, z, 286.5498046875, 1953.8681640625, 19.04842376709 ) <= 15 then -- Halle1
		
			if ( area51_hangar1_state == "zu" ) then 
		
				moveObject( area51_hangar11, 2500, 286.5498046875, 1953.8681640625, 10.04842376709 )
				moveObject( area51_hangar12, 2500, 286.5322265625, 1958.802734375, 10.04842376709 )
				area51_hangar1_state = "auf"
				return
			
			else
			
				moveObject( area51_hangar11, 2500, 286.5498046875, 1953.8681640625, 19.04842376709 )
				moveObject( area51_hangar12, 2500, 286.5322265625, 1958.802734375, 19.04842376709 )
				area51_hangar1_state = "zu"
				return
			
			end
			
		elseif getDistanceBetweenPoints3D ( x, y, z, 286.5498046875, 1987.6591796875, 19.04842376709 ) <= 15 then -- Halle2
		
			if ( area51_hangar2_state == "zu" ) then 
		
				moveObject( area51_hangar21, 2500, 286.5498046875, 1987.6591796875, 10.04842376709 )
				moveObject( area51_hangar22, 2500, 286.5322265625, 1992.5458984375, 10.04842376709 )
				area51_hangar2_state = "auf"
				return
			
			else
			
				moveObject( area51_hangar21, 2500, 286.5498046875, 1987.6591796875, 19.04842376709 )
				moveObject( area51_hangar22, 2500, 286.5322265625, 1992.5458984375, 19.04842376709 )
				area51_hangar2_state = "zu"
				return
			end
				
		elseif getDistanceBetweenPoints3D ( x, y, z, 286.5498046875, 2021.87109375, 19.04842376709 ) <= 15 then -- Halle3
		
			if ( area51_hangar3_state == "zu" ) then 
		
				moveObject( area51_hangar31, 2500, 286.5498046875, 2021.87109375, 10.04842376709 )
				moveObject( area51_hangar32, 2500, 286.5322265625, 2026.6669921875, 10.04842376709 )
				area51_hangar3_state = "auf"
				return
			
			else
			
				moveObject( area51_hangar31, 2500, 286.5498046875, 2021.87109375, 19.04842376709 )
				moveObject( area51_hangar32, 2500, 286.5322265625, 2026.6669921875, 19.04842376709 )
				area51_hangar3_state = "zu"
				return
			
			end
			
		end
		
	end
	
end

addCommandHandler ( "mv", mv_func )

-----------------

-- SF Army Base /mv

function sfarmybase_func(player)

	tx,ty,tz = getElementPosition(sfarmygate)
	px, py, pz = getElementPosition(player)
	
	local dis = getDistanceBetweenPoints3D ( tx, ty, tz, px, py, pz )
	if isArmy ( player ) or ( isOnDuty ( player ) and getPlayerRank ( player ) >= 4 ) then
		if (dis <= 30) then
			if (sfarmygatestate == true) then
				moveObject( sfarmygate, 2500, -1538.997436, 482.7531127, 6.293198)
				sfarmygatestate = false
			else
				moveObject( sfarmygate, 2500, -1530.7382,482.618164,6.879690)
				sfarmygatestate = true
			end
		end
	end
	
end

addCommandHandler("mv", sfarmybase_func)

--------------------------------------------------------------

function moveArmyGate( player )
local x, y, z = getElementPosition( player )
	if isArmy ( player ) or ( isOnDuty ( player ) and getPlayerRank ( player ) >= 4 ) then
		if getDistanceBetweenPoints3D ( x, y, z, 139, 1941.3000488281, 20.700000762939 ) <= 10 or getDistanceBetweenPoints3D ( x, y, z, 131.10000610352, 1941.3000488281, 20.700000762939 ) <= 10 then
			if hGateState == false then
				moveObject( hGate1, 4000, 124.19999694824, 1941.3000488281, 22 )
				moveObject( hGate2, 4000, 124.19999694824, 1941.3000488281, 19.60000038147 )
				moveObject( hGate3, 4000, 146.39999389648, 1941.3000488281, 22 )
				moveObject( hGate4, 4000, 146.39999389648, 1941.3000488281, 19.60000038147 )
				hGateState = true
			elseif hGateState == true then
				moveObject( hGate1, 4000, 131.10000610352, 1941.3000488281, 22 )
				moveObject( hGate2, 4000, 131.10000610352, 1941.3000488281, 19.60000038147 )
				moveObject( hGate3, 4000, 139, 1941.3000488281, 22 )
				moveObject( hGate4, 4000, 139, 1941.3000488281, 19.60000038147 )
				hGateState = false
			end
		elseif getDistanceBetweenPoints3D( x, y, z, 75.300003051758, 1918.5999755859, 17.60000038147 ) <= 10 then
			if nGateState == false then
				moveObject( nGate, 1500, 75.7, 1912.8000488281, 17.60000038147 )	
				nGateState = true
			elseif nGateState == true then
				moveObject( nGate, 1500, 75.300003051758, 1918.5999755859, 17.60000038147 )
				nGateState = false
			end
		elseif getDistanceBetweenPoints3D( x, y, z, 212.9, 1875.5, 13.9 ) <= 15 then
			if bGateState == false then
				moveObject( bGate1, 4000, 219.8, 1875.5, 13.9 )
				moveObject( bGate2, 4000, 208, 1875.5, 13.9 )	
				bGateState = true
			elseif bGateState == true then
				moveObject( bGate1, 4000, 215.9, 1875.5, 13.9 )
				moveObject( bGate2, 4000, 211.8, 1875.5, 13.9 )
				bGateState = false
			end
		end
	end
end
addCommandHandler("mv", moveArmyGate)


function moveHangarGate( player )
	local x, y, z = getElementPosition( player )
	if isArmy ( player ) and getPlayerRank ( player ) >= 4 then
		if getDistanceBetweenPoints3D( x, y, z, 123.4, 1815.5999755859, 18.4) <= 15 then
			if hangarState == false then
				moveObject( hangarGate1, 5000, 128.2, 1815.5999755859, 10 )
				moveObject( hangarGate2, 5000, 118.6, 1815.5999755859, 10 )
				hangarState = true
			elseif hangarState == true then
				moveObject( hangarGate1, 5000, 128.2, 1815.5999755859, 18.4 )
				moveObject( hangarGate2, 5000, 118.6, 1815.5999755859, 18.4 )
				hangarState = false
			end
		end
	end
end
addCommandHandler("mv", moveHangarGate)