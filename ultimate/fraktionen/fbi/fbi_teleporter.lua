FederalToHeli = createMarker ( -2446.7297363281, 528.22644042969, 29.273189544678, "cylinder", 1.2, 125, 0, 0, 255 )
FederalFromHeli = createMarker ( -2454.3820800781, 515.05053710938, 44.502365112305, "cylinder", 1.2, 125, 0, 0, 255 )
FederalToBunker = createMarker ( -2470.2028808594, 485.21612548828, 29.036027908325, "cylinder", 1.2, 125, 0, 0, 255 )
FederalFromBunkerO = createMarker ( 985.66186523438, -4.663423538208, 247.5625, "cylinder", 1.2, 125, 0, 0, 255 )
FederalFromBunker = createMarker ( 985.66186523438, -4.663423538208, 247.5625, "corona", 2, 125, 0, 0, 0 )
setElementInterior ( FederalFromBunker, 10 )
setElementInterior ( FederalFromBunkerO, 10 )

function FederalToHeli_func ( player, dim )
   
	if getElementType ( player ) == "player" and dim and getPedOccupiedVehicle ( player ) == false then
		fadeElementInterior ( player, 0, -2454.2243652344, 512.92053222656, 45.211734771729, 0, 0 )
	end
end
addEventHandler ( "onMarkerHit", FederalToHeli, FederalToHeli_func )
function FederalFromHeli_func ( player, dim )
   
	if getElementType ( player ) == "player" and dim and getPedOccupiedVehicle ( player ) == false then
		fadeElementInterior ( player, 0, -2443.9675292969, 527.796875, 29.565580368042, 0, 0 )
	end
end
addEventHandler ( "onMarkerHit", FederalFromHeli, FederalFromHeli_func )

function FederalToBunker_func ( player, dim )

	if getElementType ( player ) == "player" and dim and getPedOccupiedVehicle ( player ) == false then
		fadeElementInterior ( player, 10, 988.9, -4.5, 248.6, 0, 0 )
	end
end
addEventHandler ( "onMarkerHit", FederalToBunker, FederalToBunker_func )
function FederalFromBunker_func ( player, dim )
   
	if getElementType ( player ) == "player" and dim and getPedOccupiedVehicle ( player ) == false then
		fadeElementInterior ( player, 0, -2469.3479003906, 482.94918823242, 29.585912704468, 0, 0 )
	end
end
addEventHandler ( "onMarkerHit", FederalFromBunker, FederalFromBunker_func )