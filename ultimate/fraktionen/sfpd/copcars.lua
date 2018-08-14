local color = { 6, 51, 10, 255, 255, 255 }

createFactionVehicle ( 430, -1476.9272460938, 688.00726318359, 0, 0, 0, 0, 1, color )
createFactionVehicle ( 430, -1477.2888183594, 700.31298828125, 0, 0, 0, 0, 1, color )
createFactionVehicle ( 523, -1595.988, 693.09, -5.5818099975586, 0, 0, 0, 1, color )
createFactionVehicle ( 523, -1600.29, 693.09, -5.5818099975586, 0, 0, 0, 1, color )
createFactionVehicle ( 523, -1604.406, 693.09, -5.5818099975586, 0, 0, 0, 1, color )
createFactionVehicle ( 523, -1608.327, 693.09, -5.5818099975586, 0, 0, 0, 1, color )
createFactionVehicle ( 523, -1612.507, 693.09, -5.5818099975586, 0, 0, 0, 1, color )
createFactionVehicle ( 497, -1680.3172607422, 705.72058105469, 30.866561889648, 0, 0, 0, 1, color )

local othersirenscar = createFactionVehicle ( 411, -1596.6436, 676.12, -5.5818099975586, 0, 0, 0, 1, color )
removeVehicleSirens(othersirenscar)
setVehicleSirens( othersirenscar, 1, 0.3, 1, 0.3, 200, 0, 0 )
setVehicleSirens( othersirenscar, 2, -0.3, 1, 0.3, 0, 0, 200 )

createFactionVehicle ( 411, -1600.3172607422, 676.12, -5.5818099975586, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2285.8088378906, 2432.4931640625, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2290.05859375, 2432.6218261719, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2294.80859375, 2432.7648925781, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2303.5493164063, 2433.1047363281, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2307.7990722656, 2433.0205078125, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2263.8806152344, 2432.5795898438, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2255.841796875, 2431.947265625, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 523, 2276.5373535156, 2431.9802246094, 2.9338150024414, 0, 0, 0, 1, color )
createFactionVehicle ( 523, 2272.1821289063, 2432.3117675781, 2.9338150024414, 0, 0, 0, 1, color )
createFactionVehicle ( 523, 2268.681640625, 2432.2944335938, 2.9338150024414, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2281.37109375, 2476.1291503906, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2272.87109375, 2476.2202148438, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2277.12109375, 2476.1740722656, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 598, 2263.87109375, 2476.3161621094, 3.1434371471405, 0, 0, 0, 1, color )
createFactionVehicle ( 497, 2275.23, 2471.57, 38.94, 90, 0, 0, 1, color )

local police_vehs_y = {
	706.06042480469,
	710.11444091797,
	714.16558837891,
	718.31237792969,
	722.46551513672,
	726.62103271484,
	730.66967773438,
	734.66009521484,
	738.64855957031,
	742.80816650391
}

for i=1, #police_vehs_y do
	createFactionVehicle ( 597, -1573.38, police_vehs_y[i], -5.3721876144409, 0, 0, 90, 1, color )
end

createFactionVehicle ( 599, -1580.0047607422, 749.4423828125, -4.8570609092712, 0, 0, 180, 1, color )
createFactionVehicle ( 599, -1588.1330566406, 749.4423828125, -4.8570609092712, 0, 0, 180, 1, color )
createFactionVehicle ( 599, -1596.2564697266, 749.4423828125, -4.8570609092712, 0, 0, 180, 1, color )
createFactionVehicle ( 599, -1604.3792724609, 749.4423828125, -4.8570609092712, 0, 0, 180, 1, color )

createFactionVehicle ( 601, -1639.1837158203, 653.63220214844, -5.3119788169861, 0, 0, 270, 1, color )
createFactionVehicle ( 427, -1638.599609375, 661.8994140625, -5, 0, 0, 270, 1, color )

createFactionVehicle ( 596, 1595.0999755859, -1710.5, 5.6999998092651, 0, 0, 0, 1, color )
createFactionVehicle ( 596, 1591.3000488281, -1710.5, 5.6999998092651, 0, 0, 0, 1, color )
createFactionVehicle ( 596, 1587.6999511719, -1710.6999511719, 5.6999998092651, 0, 0, 0, 1, color )
createFactionVehicle ( 596, 1583.6999511719, -1710.6999511719, 5.6999998092651, 0, 0, 0, 1, color )
createFactionVehicle ( 599, 1600.5999755859, -1696.1999511719, 6, 0, 0, 270, 1, color )
createFactionVehicle ( 599, 1600.8000488281, -1700.0999755859, 6, 0, 0, 270, 1, color )
createFactionVehicle ( 599, 1600.5, -1692, 6, 0, 0, 270, 1, color )
createFactionVehicle ( 523, 1545.0999755859, -1676.1999511719, 5.5999999046326, 0, 0, 270, 1, color )
createFactionVehicle ( 523, 1544.8000488281, -1683.9000244141, 5.5999999046326, 0, 0, 270, 1, color )
createFactionVehicle ( 523, 1545.0999755859, -1680.5, 5.5999999046326, 0, 0, 270, 1, color )
createFactionVehicle ( 523, 1545.3000488281, -1671.9000244141, 5.5999999046326, 0, 0, 270, 1, color )
createFactionVehicle ( 497, 1565, -1698.0999755859, 28.700000762939, 0, 0, 270, 1, color )
createFactionVehicle ( 497, 1567, -1653.5999755859, 28.700000762939, 0, 0, 270, 1, color )
createFactionVehicle ( 490, -1613.1, 732.79,  -5.0534, 0, 0, 0, 1, color )
createFactionVehicle ( 426, -1616.636, 732.55, -5.602, 0, 0, 0, 1, color )
createFactionVehicle ( 427, -1637.5126953125, 666.24731445313, -4.8579044342041, 0, 0, 270, 1, color )
createFactionVehicle ( 523, -1616.8988, 693.09, -5.5818099975586, 0, 0, 0, 1, color )
createFactionVehicle ( 523, -1620.9189453125, 693.09, -5.5818099975586, 0, 0, 0, 1, color )