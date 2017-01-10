------------------------------
-------- Urheberrecht --------
------- by [LA]Leyynen -------
------------ 2012 ------------
------------------------------

-- TO DO | KOORDINATEN --
local greenzones = { 
	[1] = { x = -2016.5999755859, y = 78.300003051758, width = 102.5, height = 160.1 }
}
local colCuboids = {}

addEventHandler ("onClientResourceStart", resourceRoot, function()
	for i=1, #greenzones do
		createRadarArea ( greenzones[i].x, greenzones[i].y, greenzones[i].width, greenzones[i].height, 0, 255, 0, 127, localPlayer )
		colCuboids[i] = createColCuboid ( greenzones[i].x, greenzones[i].y, -50, greenzones[i].width, greenzones[i].height, 7500)
		setElementID (colCuboids[i], "greenzoneColshape")
		addEventHandler ( "onClientColShapeHit", colCuboids[i], startGreenZone )
		addEventHandler ( "onClientColShapeLeave", colCuboids[i], stopGreenZone )
	end
end )


function startGreenZone (hitElement, matchingDimension)
	if hitElement == localPlayer and matchingDimension then
		infobox ( "Du hast\neine Schutzzone\nbetreten!", 5000, 0, 150, 0 )
		vioClientSetElementData ( "nodmzone", 1 )
		toggleControl ("fire", false)
		toggleControl ("next_weapon", false)
		toggleControl ("previous_weapon", false)
		toggleControl ("aim_weapon", false)
		toggleControl ("vehicle_fire", false)
		setPedDoingGangDriveby ( hitElement, false )
		setPedWeaponSlot( hitElement, 0 )
	end
end

function stopGreenZone (leaveElement, matchingDimension)
	if leaveElement == localPlayer and matchingDimension then
		infobox ( "Du hast\ndie Schutzzone\nverlassen!", 5000, 150, 0, 0 )
		vioClientSetElementData ( "nodmzone", 0 )
		toggleControl ("fire", true)
		toggleControl ("next_weapon", true)
		toggleControl ("previous_weapon", true)
		toggleControl ("aim_weapon", true)
		toggleControl ("vehicle_fire", true)
	end
end

addEventHandler ( "onClientPlayerSpawn", localPlayer, function ( )
	for i=1, #colCuboids do
		if isElementWithinColShape ( source, colCuboids[i] ) then
			startGreenZone ( source, true )
		end
	end
end )


addEventHandler ( "onClientPlayerVehicleExit", localPlayer, function ( )
	setPedWeaponSlot ( localPlayer, 0 )
end )