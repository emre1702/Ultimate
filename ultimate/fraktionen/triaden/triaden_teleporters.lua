--[[createObject ( 7245, -2213.9482421875, 774.56787109375, 5.2562294006348 )

    <marker id="IntEnter" color="#FF000599" dimension="0" interior="0, -2172.6772460938, 679.87579345703, 54.16397857666" size="1" type="cylinder" />
	<object id="InnerportPos" dimension="0" interior="1" model="1337, -2170.2390136719, 637.73980712891, 1052.0241699219" rotX="0" rotY="0" rotZ="0" />
	
    <marker id="Triadbase Exit" color="#FE000699" dimension="0" interior="1, -2170.3583984375, 635.75671386719, 1051.3493652344" size="1" type="cylinder" />
	<object id="TriadExitPos" dimension="0" interior="0" model="1337, -2173.5454101563, 682.26794433594, 54.813526153564" rotX="0" rotY="0" rotZ="0" />
	
	<marker id="Dach->Inner" color="#FF000099" dimension="0" interior="0, -2163.9565429688, 676.29083251953, 82.131492614746" size="1" type="cylinder" />
	<marker id="Inner->Dach" color="#FF000099" dimension="0" interior="1, -2171.1403808594, 645.33117675781, 1056.5302734375" size="1" type="cylinder" />

    <object id="EntranceRootPos" dimension="0" interior="1" model="1337, -2169.7309570313, 645.28344726563, 1057.2429199219" rotX="0" rotY="0" rotZ="0" />
    <object id="PosRoof" dimension="0" interior="0" model="1337, -2163.9748535156, 674.06390380859, 82.821098327637" rotX="0" rotY="0" rotZ="0" />
]]

local extraheight = 1.2
TriadDownEntrance = createMarker ( -2172.6772460938, 679.87579345703, 54.16397857666+extraheight, "corona", 1, getColorFromString ( "#FF000099" ) )
TriadDownExit = createMarker ( -2170.3583984375, 635.75671386719, 1051.3493652344+extraheight, "corona", 1, getColorFromString ( "#FF000099" ) )
setElementInterior ( TriadDownExit, 1 )
TriadRoofEntrance = createMarker ( -2163.9565429688, 676.29083251953, 82.131492614746+extraheight, "corona", 1, getColorFromString ( "#FF000099" ) )
TriadToRoof = createMarker ( -2171.1403808594, 645.33117675781, 1056.5302734375+extraheight, "corona", 1, getColorFromString ( "#FF000099" ) )
setElementInterior ( TriadToRoof, 1 )

function TriadDownEntrance_func ( player, dim )
   
	if dim == true and getPedOccupiedVehicle ( player ) == false and ( isTriad(player) or isOnDuty(player) or isArmy(player) ) then
		fadeElementInterior ( player, 1, -2170.2390136719, 637.73980712891, 1052.0241699219 )
		if isTriad (player) then
			outputChatBox ( "Wilkommen, Triade!", player, 0, 125, 0 )
		end
	else
		outputChatBox ( "Du bist kein Triade/sitzt in einem Fahrzeug!", player, 125, 0, 0 )
	end
end
addEventHandler ( "onMarkerHit", TriadDownEntrance, TriadDownEntrance_func )

function TriadDownExit_func ( player, dim )
   
	if dim == true then
		fadeElementInterior ( player, 0, -2173.5454101563, 682.26794433594, 54.813526153564 )
	end
end
addEventHandler ( "onMarkerHit", TriadDownExit, TriadDownExit_func )

function TriadRoofEntrance_func ( player, dim )
   
	if dim == true and getPedOccupiedVehicle ( player ) == false and ( isTriad(player) or isOnDuty(player) or isArmy(player)) then
		setElementInterior ( player, 1, -2169.7309570313, 645.28344726563, 1057.2429199219 )
		if isTriad(player) then
			outputChatBox ( "Wilkommen, Triade!", player, 0, 125, 0 )
		end
	else
		outputChatBox ( "Du bist kein Triade/sitzt in einem Fahrzeug!", player, 125, 0, 0 )
	end
end
addEventHandler ( "onMarkerHit", TriadRoofEntrance, TriadRoofEntrance_func )

function TriadToRoof_func ( player, dim )
   
	if dim == true then
		setElementInterior ( player, 0, -2163.9748535156, 674.06390380859, 82.821098327637 )
	end
end
addEventHandler ( "onMarkerHit", TriadToRoof, TriadToRoof_func )

-- Exit Position: -2181.65, 639.31, 51
-- -2234.4174804688, 777.53778076172, 3.25" size="5" type="cylinder"

-- -2227.34765625, 798.13751220703, 2.7640419006348
-- 

--[[TriadenUpMarker = createMarker ( -2234.4174804688, 777.53778076172, 3.25, "cylinder", 5, getColorFromString ( "#FF000099" ) )
TriadenDownMarker = createMarker ( -2175.20703125, 639.1060180664, 48.288452148438, "cylinder", 5, getColorFromString ( "#FF000099" ) )

function TriadenUp_func ( player, dim )

	if getElementType ( player ) == "player" then
		local veh = getPedOccupiedVehicle ( player )
		if veh then
			if getPedOccupiedVehicleSeat ( player ) == 0 then
				setElementPosition ( veh, -2181.65, 639.31, 51 )
				setVehicleRotation ( veh, 0, 0, 90 )
				setElementVelocity ( veh, 0, 0, 0 )
				setVehicleFrozen ( veh, true )
				setTimer ( setVehicleFrozen, 500, 1, veh, false )
			end
		else
			setElementPosition ( player, -2181.65, 639.31, 49.5 )
		end
	end
end
addEventHandler ( "onMarkerHit", TriadenUpMarker, TriadenUp_func )

function TriadenDown_func ( player, dim )

	if getElementType ( player ) == "player" then
		local veh = getPedOccupiedVehicle ( player )
		if veh then
			if getPedOccupiedVehicleSeat ( player ) == 0 then
				setElementPosition ( veh, -2227.34765625, 798.13751220703, 3.5 )
				setVehicleRotation ( veh, 0, 0, 270 )
				setElementVelocity ( veh, 0, 0, 0 )
				setVehicleFrozen ( veh, true )
				setTimer ( setVehicleFrozen, 500, 1, veh, false )
			end
		else
			setElementPosition ( player, -2227.34765625, 798.13751220703, 2.7640419006348 )
		end
	end
end
addEventHandler ( "onMarkerHit", TriadenDownMarker, TriadenDown_func )]]

--[[ Four Dragons Casino --
    <object id="object (helipad01) (1)" doublesided="false" model="3934" interior="0" dimension="0, 2003.8626708984, 1007.2116699219, 38.091094970703" rotX="0" rotY="0" rotZ="0" />
    <object id="object (OG_Door) (1)" doublesided="false" model="14819" interior="0" dimension="0, 2018.7520751953, 1008.4146728516, 39.241008758545" rotX="0" rotY="0" rotZ="90" />
    <object id="object (bollardlight) (1)" doublesided="false" model="1215" interior="0" dimension="0, 2007.6083984375, 1010.5441894531, 38.655418395996" rotX="0" rotY="0" rotZ="0" />
    <object id="object (bollardlight) (2)" doublesided="false" model="1215" interior="0" dimension="0, 2007.5772705078, 1003.6942749023, 38.655418395996" rotX="0" rotY="0" rotZ="0" />
    <object id="object (bollardlight) (3)" doublesided="false" model="1215" interior="0" dimension="0, 1999.9272460938, 1003.6906738281, 38.655418395996" rotX="0" rotY="0" rotZ="2" />
    <object id="object (bollardlight) (4)" doublesided="false" model="1215" interior="0" dimension="0, 1999.9315185547, 1010.5415649414, 38.655418395996" rotX="0" rotY="2" rotZ="1.99951171875" />
    <object id="object (lift_dr) (1)" doublesided="false" model="3051" interior="0" dimension="0, 1920.6171875, 992.70147705078, 11.174900054932" rotX="0" rotY="0" rotZ="45" />
    <object id="object (lift_dr) (2)" doublesided="false" model="3051" interior="0" dimension="0, 1920.6049804688, 991.51696777344, 11.174900054932" rotX="0" rotY="0" rotZ="225" />
    <object id="object (crates01) (1)" doublesided="false" model="18260" interior="0" dimension="0, 1916.2370605469, 1016.9378051758, 11.393505096436" rotX="0" rotY="0" rotZ="180" />
    <object id="object (ammotrn_obj) (1)" doublesided="false" model="3066" interior="0" dimension="0, 1902.6480712891, 1016.5786743164, 10.87458896637" rotX="0" rotY="0" rotZ="90" />
    <object id="object (AMMO_BOX_c5) (1)" doublesided="false" model="2359" interior="0" dimension="0, 1911.3658447266, 1016.0397338867, 12.025768280029" rotX="0" rotY="0" rotZ="0" />
    <marker id="gunshop" type="cylinder" color="#0000ff99" size="1.5" interior="0" dimension="0, 1914.2331542969, 1014.4857788086, 9.8027935028076" rotX="0" rotY="0" rotZ="0" />
    <object id="object (tar_gun2) (1)" doublesided="false" model="1583" interior="0" dimension="0, 1913.2199707031, 1018.1460571289, 9.8126964569092" rotX="340" rotY="0" rotZ="0" />

	<object id="triadGate" doublesided="true" model="7657" interior="0" dimension="7657, 1903.6638183594, 967.37475585938, 11.537155151367" rotX="0" rotY="0" rotZ="0" />
    <object id="keypad1" doublesided="false" model="2886" interior="0" dimension="0, 1896.2963867188, 967.83520507813, 11.806823730469" rotX="0" rotY="0" rotZ="180" />
    <object id="keypad2" doublesided="false" model="2886" interior="0" dimension="0, 1910.2141113281, 966.93408203125, 11.806823730469" rotX="0" rotY="0" rotZ="0" />

    <vehicle id="vehicle (Stretch) (1)" paintjob="3" model="409" plate="AQ57 Y6G" interior="0" dimension="0, 1899.4958496094, 1003.9580078125, 10.737696647644" rotX="0" rotY="0" rotZ="180" />
    <vehicle id="vehicle (NRG-500) (1)" paintjob="3" model="522" plate="1ZV5 6MW" interior="0" dimension="0, 1919.6287841797, 970.36273193359, 10.480690002441" rotX="0" rotY="0" rotZ="0" />
    <vehicle id="vehicle (NRG-500) (2)" paintjob="3" model="522" plate="5NGP O3S" interior="0" dimension="0, 1919.6938476563, 973.36157226563, 10.480690002441" rotX="0" rotY="0" rotZ="0" />
    <vehicle id="vehicle (NRG-500) (3)" paintjob="3" model="522" plate="B6EO 4AE" interior="0" dimension="0, 1919.5997314453, 976.60974121094, 10.480690002441" rotX="0" rotY="0" rotZ="0" />
    <vehicle id="vehicle (NRG-500) (4)" paintjob="3" model="522" plate="39BL 5NC" interior="0" dimension="0, 1919.5059814453, 979.85778808594, 10.480690002441" rotX="0" rotY="0" rotZ="0" />
    <vehicle id="vehicle (Sultan) (1)" paintjob="3" model="560" plate="BBGF 82S" interior="0" dimension="0, 1917.8037109375, 1006.8927612305, 10.625288009644" rotX="0" rotY="0" rotZ="180" />
    <vehicle id="vehicle (Sultan) (2)" paintjob="3" model="560" plate="Y8PJ 71L" interior="0" dimension="0, 1917.6541748047, 1000.879699707, 10.617671966553" rotX="0" rotY="0" rotZ="180" />
    <vehicle id="vehicle (Sultan) (3)" paintjob="3" model="560" plate="5K36 2OJ" interior="0" dimension="0, 1903.4294433594, 1007.0963745117, 10.617671966553" rotX="0" rotY="0" rotZ="180" />









    <marker id="roofInner" type="cylinder" color="#0000ff99" size="1" interior="0" dimension="0, 2018.0836181641, 1007.6577758789, 38.091094970703" rotX="0" rotY="0" rotZ="0" />
    <marker id="garageExit" type="cylinder" color="#0000ff99" size="1" interior="10" dimension="0, 1963.8889160156, 972.15161132813, 993.41467285156" rotX="0" rotY="0" rotZ="0" />
    <marker id="roofEcess" type="cylinder" color="#0000ff99" size="1" interior="10" dimension="0, 1963.8132324219, 1063.4484863281, 993.42401123047" rotX="0" rotY="0" rotZ="0" />
    <marker id="liftMarker" type="cylinder" color="#0000ff99" size="1" interior="0" dimension="0, 1919.9337158203, 992.11108398438, 9.8066940307617" rotX="0" rotY="0" rotZ="0" />

    <object id="garageSoawn270" doublesided="false" model="1337" interior="0" dimension="0, 1918.3533935547, 992.06750488281, 10.461921691895" rotX="0" rotY="0" rotZ="0" />
    <object id="roofSpawn270" doublesided="false" model="1337" interior="0" dimension="0, 2016.6575927734, 1007.6748046875, 38.740322113037" rotX="0" rotY="0" rotZ="0" />
    <object id="InnerSpawnFromGarage330" doublesided="false" model="1337" interior="10" dimension="0, 1963.1610107422, 973.486328125, 994.11798095703" rotX="0" rotY="0" rotZ="0" />
    <object id="FromRoof" doublesided="false" model="1337" interior="10" dimension="0, 1963.1157226563, 1062.2529296875, 994.11798095703" rotX="0" rotY="0" rotZ="0" />
]]

local triadCasinoCoordinates = {}
triadCasinoTeleporters = {}
	local i = 0
	
	i = i + 1
	-- Roof -> Inner
	local optic
	local x, y, z, int, tx, ty, tz, tint, trot = 2018.0836181641, 1007.6577758789, 38.091094970703, 0, 1963.1157226563, 1062.2529296875, 994.11798095703, 10, 210
	optic = createMarker ( x, y, z, "cylinder", 1, getColorFromString ( "#FF000099" ) )
	setElementInterior ( optic, int )
	triadCasinoTeleporters[i] = createMarker ( x, y, z + 1, "corona", 1, 0, 0, 0, 0 )
	setElementInterior ( triadCasinoTeleporters[i], int )
	triadCasinoCoordinates[triadCasinoTeleporters[i]] = { ["x"] = tx, ["y"] = ty, ["z"] = tz, ["int"] = tint, ["rot"] = rot }


	-- Inner -> Roof
	i = i + 1
	local x, y, z, int, tx, ty, tz, tint, trot = 1963.8132324219, 1063.4484863281, 993.42401123047, 10, 2016.6575927734, 1007.6748046875, 38.74, 0, 90
	optic = createMarker ( x, y, z, "cylinder", 1, getColorFromString ( "#FF000099" ) )
	setElementInterior ( optic, int )
	triadCasinoTeleporters[i] = createMarker ( x, y, z + 1, "corona", 1, 0, 0, 0, 0 )
	setElementInterior ( triadCasinoTeleporters[i], int )
	triadCasinoCoordinates[triadCasinoTeleporters[i]] = { ["x"] = tx, ["y"] = ty, ["z"] = tz, ["int"] = tint, ["rot"] = rot }
	
	-- Garage -> Inner
	i = i + 1
	local x, y, z, int, tx, ty, tz, tint, trot = 1919.9337158203, 992.11108398438, 9.8066940307617, 0, 1963.1610107422, 973.486328125, 994.11798095703, 10, 330
	optic = createMarker ( x, y, z, "cylinder", 1, getColorFromString ( "#FF000099" ) )
	setElementInterior ( optic, int )
	triadCasinoTeleporters[i] = createMarker ( x, y, z + 1, "corona", 1, 0, 0, 0, 0 )
	setElementInterior ( triadCasinoTeleporters[i], int )
	triadCasinoCoordinates[triadCasinoTeleporters[i]] = { ["x"] = tx, ["y"] = ty, ["z"] = tz, ["int"] = tint, ["rot"] = rot }
	
	-- Inner -> Garage
	i = i + 1
	local x, y, z, int, tx, ty, tz, tint, trot = 1963.8889160156, 972.15161132813, 993.41467285156, 10, 1918.3533935547, 992.06750488281, 10.461921691895, 0, 270 - 180
	optic = createMarker ( x, y, z, "cylinder", 1, getColorFromString ( "#FF000099" ) )
	setElementInterior ( optic, int )
	triadCasinoTeleporters[i] = createMarker ( x, y, z + 1, "corona", 1, 0, 0, 0, 0 )
	setElementInterior ( triadCasinoTeleporters[i], int )
	triadCasinoCoordinates[triadCasinoTeleporters[i]] = { ["x"] = tx, ["y"] = ty, ["z"] = tz, ["int"] = tint, ["rot"] = rot }


for i, index in pairs ( triadCasinoTeleporters ) do

	addEventHandler ( "onMarkerHit", triadCasinoTeleporters[i],
		function ( hit )
			if getElementType ( hit ) == "player" then
				if not getPedOccupiedVehicle ( hit ) then
					if isTriad ( hit ) then
						local x, y, z, int, rot = triadCasinoCoordinates[source]["x"], triadCasinoCoordinates[source]["y"], triadCasinoCoordinates[source]["z"], triadCasinoCoordinates[source]["int"], triadCasinoCoordinates[source]["rot"] 
						fadeElementInterior ( hit, int, x, y, z, rot )
					end
				end
			end
		end
	)
end