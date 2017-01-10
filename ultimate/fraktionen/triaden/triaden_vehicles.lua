triadCars = {}
local rbb, gbb, bbb = 255, 4, 4
triadCars[1] = createFactionVehicle ( 487, -2164.2846679688, 667.72784423828, 83.436874389648, 0, 0, 90, 3, rbb, gbb, bbb, 255 ) -- Maverick
triadCars[2] = createFactionVehicle ( 560, -2178.4130859375, 606.05322265625, 49.25048828125, 0, 0, 0, 3, rbb, gbb, bbb, 255 ) -- Sultan 1
triadCars[3] = createFactionVehicle ( 560, -2183.6630859375, 606.052734375, 49.25048828125, 0, 0, 0, 3, rbb, gbb, bbb, 255 ) -- Sultan 2
triadCars[4] = createFactionVehicle ( 560, -2188.6630859375, 606.052734375, 49.25048828125, 0, 0, 0, 3, rbb, gbb, bbb, 255 ) -- Sultan 3
triadCars[5] = createFactionVehicle ( 409, -2207.5991210938, 660.40356445313, 49.362499237061, 0, 0, 180, 3, rbb, gbb, bbb, 255 ) -- Stretch
triadCars[6] = createFactionVehicle ( 522, -2211.6977539063, 622.326, 49.118579864502, 0, 0, 180, 3, rbb, gbb, bbb, 255 ) -- PCJ 1
triadCars[7] = createFactionVehicle ( 522, -2214.78, 622.326, 49.118579864502, 0, 0, 180, 3, rbb, gbb, bbb, 255 ) -- PCJ 2
triadCars[8] = createFactionVehicle ( 522, -2217.857, 622.326, 49.118579864502, 0, 0, 180, 3, rbb, gbb, bbb, 255 ) -- PCJ 3
triadCars[9] = createFactionVehicle ( 418, -2184.2397460938, 713.95666503906, 54.021366119385, 0, 0, 180, 3, rbb, gbb, bbb, 255 ) -- Moonbeam 1
triadCars[10] = createFactionVehicle ( 418, -2178.7392578125, 713.9560546875, 54.021366119385, 0, 0, 180, 3, rbb, gbb, bbb, 255 ) -- Moonbeam 1
triadCars[11] = createFactionVehicle ( 480, -2194.15258, 606.052734375, 49.25048828125, 0, 0, 0, 3, rbb, gbb, bbb, 255 )
triadCars[12] = createFactionVehicle ( 405, -2177.95654, 620.2122, 49.25048828125, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[13] = createFactionVehicle ( 405, -2183.0459, 620.2122, 49.25048828125, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[14] = createFactionVehicle ( 402, -2188.211, 620.2122, 49.25048828125, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[15] = createFactionVehicle ( 402, -2193.3777, 620.2122, 49.25048828125, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[16] = createFactionVehicle ( 487, -2226.593, 588.42, 51.6258, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[17] = createFactionVehicle ( 522, -2223.824, 615.802, 49.118579864502, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[18] = createFactionVehicle ( 522, -2223.824, 612.6358, 49.118579864502, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[19] = createFactionVehicle ( 522, -2223.824, 609.17, 49.118579864502, 0, 0, 180, 3, rbb, gbb, bbb, 255 )

-- Casino Autos:

triadCars[20] = createFactionVehicle ( 409, 1899.4958496094, 1003.9580078125, 10.737696647644, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[21] = createFactionVehicle ( 522, 1919.6287841797, 970.36273193359, 10.480690002441, 0, 0, 0, 3, rbb, gbb, bbb, 255 )
triadCars[22] = createFactionVehicle ( 522, 1919.6938476563, 973.36157226563, 10.480690002441, 0, 0, 0, 3, rbb, gbb, bbb, 255 )
triadCars[23] = createFactionVehicle ( 522, 1919.5997314453, 976.60974121094, 10.480690002441, 0, 0, 0, 3, rbb, gbb, bbb, 255 )
triadCars[24] = createFactionVehicle ( 522, 1919.5059814453, 979.85778808594, 10.480690002441, 0, 0, 0, 3, rbb, gbb, bbb, 255 )
triadCars[25] = createFactionVehicle ( 560, 1917.8037109375, 1006.8927612305, 10.625288009644, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[26] = createFactionVehicle ( 560, 1917.6541748047, 1000.879699707, 10.617671966553, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[27] = createFactionVehicle ( 560, 1903.4294433594, 1007.0963745117, 10.617671966553, 0, 0, 180, 3, rbb, gbb, bbb, 255 )
triadCars[28] = createFactionVehicle ( 487, 2004.6790771484, 1007.2655029297, 39.356094360352, 0, 0, 90, 3, rbb, gbb, bbb, 255 )

for k, v in pairs ( triadCars ) do
	setVehicleColor ( v, 255, 4, 4 )
end