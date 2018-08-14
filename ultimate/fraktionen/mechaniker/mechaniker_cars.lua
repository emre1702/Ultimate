------------------------------
-------- Urheberrecht --------
------- by [LA]Leyynen -------
------------ 2012 ------------
------------------------------
---- Script by Noneatme ------

local color = {255, 255, 255, 0, 255}

createFactionVehicle (525, -2392.79, -153.79, 35.29, 0, 0, 269.49, 11, color ) -- Towtruck
createFactionVehicle (525, -2392.79, -148.09, 35.29, 0, 0, 269.49, 11, color ) -- Towtruck
createFactionVehicle (525, -2392.70, -142.40, 35.29, 0, 0, 269.49, 11, color ) -- Towtruck
createFactionVehicle (440, -2393.39, -136.79, 35.5, 0, 0, 269.49, 11, color ) -- Rumpo
createFactionVehicle (440, -2393.29, -131.29, 35.5, 0, 0, 269.49, 11, color ) -- Rumpo
createFactionVehicle (586, -2378.89, -180.5, 35, 0, 0, 0, 11, color ) -- Wayfarer
createFactionVehicle (586, -2380.39, -181.29, 35, 0, 0, 0, 11, color ) -- Wayfarer
createFactionVehicle (586, -2381.79, -182.20, 35, 0, 0, 0, 11, color ) -- Wayfarer
createFactionVehicle (422, -2399.5, -199.90, 35.40, 0, 0, 14.99, 11, color ) -- Bobcat
createFactionVehicle (422, -2402.89, -200.70, 35.40, 0, 0, 14.99, 11, color ) -- Bobcat
createFactionVehicle (422, -2406.39, -201.59, 35.40, 0, 0, 14.99, 11, color ) -- Bobcat
local heli = createFactionVehicle (417, -2404.20, -148.09, 41.5, 0, 0, 0, 11, color ) -- Leviathan

setVehicleAsMagnetHelicopter(heli)
addEventHandler("onVehicleExplode", heli, function() 
	vioSetElementData(heli, "magnet", false)
end)