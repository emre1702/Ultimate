--rathauspickup_1 = createPickup ( -2764.5270996094, 375.37478637695, 6.3415489196777, 3, 1239, 0)

jobchoosepickup = createPickup ( 362.39953613281, 180.4635925293, 1008.0034790039, 3, 1210, 50)
setElementInterior (jobchoosepickup, 3, 362.39953613281, 180.4635925293, 1008.0034790039)

createMarker ( -2766.1726074219, 375.55252075195, 5.2596783638, "cylinder", 1, getColorFromString ( "#FF000099" ) )
cityHallEnter = createMarker ( -2766.1726074219, 375.55252075195, 5.2596783638+.5, "corona", 1, 0, 0, 0, 0 )
cityHallExit = createMarker ( 389.89999389648, 173.82061767578, 1007.3699951172+.5, "corona", 1, 0, 0, 0, 0 )
cityHallExitOptic = createMarker ( 389.89999389648, 173.82061767578, 1007.3699951172, "cylinder", 1, getColorFromString ( "#FF000099" ) )
setElementInterior ( cityHallExit, 3 )
setElementInterior ( cityHallExitOptic, 3 )
--[[
cityHallEnter" type="cylinder" color="#FF000099" size="1" interior="0, , -2766.1726074219, 375.55252075195, 5.2596783638
cityhallExit" type="cylinder" color="#0000ff99" size="1" interior="3, , 389.89999389648, 173.82061767578, 1007.3699951172

cityHallOut90" doublesided="false" model="1337" interior="0, , -2765.0368652344, 375.58209228516, 5.99236536026
CityHallSpawn270" doublesided="false" model="1337" interior="3, , 388.5, 173.82061767578, 1008.032043457
]]

function jobchoosepickup_func (player)

	setElementFrozen ( player, true )
    setTimer ( setElementFrozen, 100, 1, player, false )
	triggerClientEvent ( player, "showJobGui", getRootElement() )
	showCursor ( player, true )
	setElementClicked ( player, true )
end
addEventHandler ( "onPickupHit", jobchoosepickup, jobchoosepickup_func )

function pickedUpRathaus (source, dim)

	if getPedOccupiedVehicle(source) == false and dim then
		fadeElementInterior ( source, 3, 388.5, 173.82061767578, 1008.032043457, 90 )
		toggleControl ( source, "fire", false )
		toggleControl ( source, "enter_exit", false )
		vioSetElementData(source,"nodmzone", 1)
	end
end
addEventHandler ( "onMarkerHit", cityHallEnter, pickedUpRathaus )

--rathauspickup_2 = createPickup ( 387.705, 174.3994, 1008.3828, 3, 1239, 0)
--setElementInterior (rathauspickup_2, 3)

function pickedUpRathaus2 (source)

   fadeElementInterior ( source, 0, -2765.0368652344, 375.58209228516, 5.99236536026, 270 )
   toggleControl ( source, "fire", true )
   toggleControl ( source, "enter_exit", true )
   vioSetElementData(source,"nodmzone", 0)
end
addEventHandler ( "onMarkerHit", cityHallExit, pickedUpRathaus2 )

rathausmarker = createMarker ( 362.45562744141, 173.81, 1007.5, "corona", 2, 125, 0, 0, 0 )
setElementInterior (rathausmarker, 3)
rathausmarker2 = createMarker ( 362.45562744141, 173.81, 1007, "cylinder", 1, 125, 0, 0 )
setElementInterior (rathausmarker2, 3)

function rathausmarker_func (player)
   
    setElementFrozen ( player, true )
    setTimer ( setElementFrozen, 100, 1, player, false )
	triggerClientEvent ( player, "ShowRathausMenue", getRootElement() )
	showCursor ( player, true )
	setElementClicked ( player, true )
end
addEventHandler ( "onMarkerHit", rathausmarker, rathausmarker_func )

rathausped = createPed(141, 359.7138671875, 173.625765625, 1008.38934)
setElementInterior (rathausped, 3)
setPedRotation(rathausped, 280)