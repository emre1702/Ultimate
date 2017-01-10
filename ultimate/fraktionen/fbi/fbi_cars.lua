fbiCars = {}

-- createFactionVehicle ( model, x, y, z, rx, ry, rz, 6, 0, 0, 0, 0 )

fbiCars[1] = createFactionVehicle ( 497, -2462.4187011719, 522.23236083984, 51.328762054443, 0, 0, 0, 6, 0, 0, 0, 0 ) -- Maverick 1
fbiCars[2] = createFactionVehicle ( 497, -2480.1748046875, 522.08630371094, 51.328762054443, 0, 0, 0, 6, 0, 0, 0, 0 ) -- Maverick 2
fbiCars[3] = createFactionVehicle ( 411, -2440.7897949219, 500.4065246582, 29.801193237305, 0, 0, 25.805053710938, 6, 0, 0, 0, 0 ) -- Infernus
fbiCars[4] = createFactionVehicle ( 415, -2430.1098632813, 515.35406494141, 29.779209136963, 0, 0, 220, 6, 0, 0, 0, 0 ) -- Cheetah 1
fbiCars[5] = createFactionVehicle ( 415, -2426.1662597656, 518.52447509766, 29.779209136963, 0, 0, 223.96569824219, 6, 0, 0, 0, 0 ) -- Cheetah 2
fbiCars[6] = createFactionVehicle ( 415, -2445.1672363281, 523.02789306641, 29.769685745239, 0, 0, 0, 6, 0, 0, 0, 0 ) -- Cheetah 3
fbiCars[7] = createFactionVehicle ( 427, -2418.8041992188, 524.45080566406, 30.249813079834, 0, 0, 230.97143554688, 6, 0, 0, 0, 0 ) -- Enforcer
fbiCars[8] = createFactionVehicle ( 490, -2416.2280273438, 528.17468261719, 30.249813079834, 0, 0, 240.89605712891, 6, 0, 0, 0, 0 ) -- Rancher 1
fbiCars[9] = createFactionVehicle ( 490, -2414.5490722656, 531.81390380859, 30.249813079834, 0, 0, 248.83172607422, 6, 0, 0, 0, 0 ) -- Rancher 2
fbiCars[10] = createFactionVehicle ( 490, -2413.3103027344, 535.69073486328, 30.249813079834, 0, 356.03002929688, 260.73931884766, 6, 0, 0, 0, 0 ) -- Rancher 3
fbiCars[11] = createFactionVehicle ( 490, -2412.6123046875, 540.1435546875, 30.249813079834, 0, 356.02844238281, 272.6484375, 6, 0, 0, 0, 0 ) -- Rancher 4
fbiCars[12] = createFactionVehicle ( 601, -2421.8315429688, 520.83325195313, 30.191606, 0, 0, 225.01995849609, 6, 0, 0, 0, 0 ) -- S.W.A.T.
FederalBoxville = createFactionVehicle ( 609, -2439.05, 522.28, 30.11, 0, 0, 0, 6, 0, 0, 0, 0 ) -- Boxville

-- LVPD FBI Cars:

fbiCars[13] = createFactionVehicle ( 490, 2242.2202148438, 2447.2504882813, 3.5935640335083, 0, 0, 90, 6, 0, 0, 0, 0 ) -- Rancher 1
fbiCars[14] = createFactionVehicle ( 490, 2241.55078125, 2456.7524414063, 3.5935640335083, 0, 0, 90, 6, 0, 0, 0, 0 ) -- Rancher 2
fbiCars[15] = createFactionVehicle ( 490, 2241.6481933594, 2465.7797851563, 3.5935640335083, 0, 0, 90, 6, 0, 0, 0, 0 ) -- Rancher 3
fbiCars[16] = createFactionVehicle ( 490, 2241.2680664063, 2471.0139160156, 3.5935640335083, 0, 0, 90, 6, 0, 0, 0, 0 ) -- Rancher 4

fbiCars[17] = createFactionVehicle ( 415, 2314.0190429688, 2460.5991210938, 3.1229588985443, 0, 0, 90, 6, 0, 0, 0, 0 ) -- Cheetah 1
fbiCars[18] = createFactionVehicle ( 415, 2314.2822265625, 2465.08984375, 3.1229588985443, 0, 0, 90, 6, 0, 0, 0, 0 ) -- Cheetah 2
fbiCars[19] = createFactionVehicle ( 415, 2314.58984375, 2470.3295898438, 3.1229588985443, 0, 0, 90, 6, 0, 0, 0, 0 ) -- Cheetah 3

for k, v in pairs ( fbiCars ) do
	setElementFrozen ( v, true )
	addEventHandler ( "onVehicleStartEnter", v, function (player, seat, jacked)
		if seat == 0 and not isOnDuty ( player ) then
			if not jacked then
				cancelEvent ()
			end
		else
			setElementFrozen ( v, false )
		end
	end )
	addEventHandler ( "onVehicleEnter", v, function (player, seat, jacked)
		if seat == 0 and not isOnDuty ( player ) and jacked then
			opticExitVehicle ( player )
			infobox ( player, "Du bist kein\nStaatsfraktionist\nimDienst!", 4000, 255, 0, 0 )
		end
	end )
end