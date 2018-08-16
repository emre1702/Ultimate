-- createFactionVehicle ( model, x, y, z, rx, ry, rz, 6, 0, 0, 0, 0 )
local color = {}
createFactionVehicle ( 497, -2462.4187011719, 522.23236083984, 51.328762054443, 0, 0, 0, 6, color ) -- Maverick 1
createFactionVehicle ( 497, -2480.1748046875, 522.08630371094, 51.328762054443, 0, 0, 0, 6, color ) -- Maverick 2
createFactionVehicle ( 411, -2440.7897949219, 500.4065246582, 29.801193237305, 0, 0, 25.805053710938, 6, color ) -- Infernus
createFactionVehicle ( 415, -2430.1098632813, 515.35406494141, 29.779209136963, 0, 0, 220, 6, color ) -- Cheetah 1
createFactionVehicle ( 415, -2426.1662597656, 518.52447509766, 29.779209136963, 0, 0, 223.96569824219, 6, color ) -- Cheetah 2
createFactionVehicle ( 415, -2445.1672363281, 523.02789306641, 29.769685745239, 0, 0, 0, 6, color ) -- Cheetah 3
createFactionVehicle ( 427, -2418.8041992188, 524.45080566406, 30.249813079834, 0, 0, 230.97143554688, 6, color ) -- Enforcer
createFactionVehicle ( 490, -2416.2280273438, 528.17468261719, 30.249813079834, 0, 0, 240.89605712891, 6, color ) -- Rancher 1
createFactionVehicle ( 490, -2414.5490722656, 531.81390380859, 30.249813079834, 0, 0, 248.83172607422, 6, color ) -- Rancher 2
createFactionVehicle ( 490, -2413.3103027344, 535.69073486328, 30.249813079834, 0, 356.03002929688, 260.73931884766, 6, color ) -- Rancher 3
createFactionVehicle ( 490, -2412.6123046875, 540.1435546875, 30.249813079834, 0, 356.02844238281, 272.6484375, 6, color ) -- Rancher 4
createFactionVehicle ( 601, -2421.8315429688, 520.83325195313, 30.191606, 0, 0, 225.01995849609, 6, color ) -- S.W.A.T.

FederalBoxville = createFactionVehicle ( 609, -2439.05, 522.28, 30.11, 0, 0, 0, 6, color ) -- Boxville
removeEventHandler ( "onVehicleStartEnter", FederalBoxville, onVehicleStartEnterFactionVehicleState)
removeEventHandler ( "onVehicleEnter", FederalBoxville, onVehicleEnterFactionVehicleState)

-- LVPD FBI Cars:

createFactionVehicle ( 490, 2242.2202148438, 2447.2504882813, 3.5935640335083, 0, 0, 90, 6, color ) -- Rancher 1
createFactionVehicle ( 490, 2241.55078125, 2456.7524414063, 3.5935640335083, 0, 0, 90, 6, color ) -- Rancher 2
createFactionVehicle ( 490, 2241.6481933594, 2465.7797851563, 3.5935640335083, 0, 0, 90, 6, color ) -- Rancher 3
createFactionVehicle ( 490, 2241.2680664063, 2471.0139160156, 3.5935640335083, 0, 0, 90, 6, color ) -- Rancher 4

createFactionVehicle ( 415, 2314.0190429688, 2460.5991210938, 3.1229588985443, 0, 0, 90, 6, color ) -- Cheetah 1
createFactionVehicle ( 415, 2314.2822265625, 2465.08984375, 3.1229588985443, 0, 0, 90, 6, color ) -- Cheetah 2
createFactionVehicle ( 415, 2314.58984375, 2470.3295898438, 3.1229588985443, 0, 0, 90, 6, color ) -- Cheetah 3