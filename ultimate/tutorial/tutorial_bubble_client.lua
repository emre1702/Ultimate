local tutBubbleData = {}

function vehicleHelpEnter ()
	if getElementData ( lp, "playingtime" ) <= 240 then
		infobox_start_func ( "Drücke \"X\" und\n\"L\", um den\nMotor bzw. das\nLicht ein/aus\nzu schalten.", 7500, 255, 255, 255 )
	else
		removeEventHandler ( "onClientPlayerVehicleEnter", localPlayer, vehicleHelpEnter ) 
	end
end
addEventHandler ( "onClientPlayerVehicleEnter", localPlayer, vehicleHelpEnter )

function createTutorialBubble ( x, y, z, text, maxTime, r, g, b, range )

	if not b then
		r, g, b = 255, 255, 255
	end
	if not text then
		text = ""
	end
	if not maxTime then
		maxTime = 3
	end
	if not range then
		range = 3
	end
	local tutColshape = createColSphere ( x, y, z, range )
	tutBubbleData[tutColshape] = { ["text"] = text, ["r"] = r, ["g"] = g, ["b"] = b, ["max"] = maxTime }
	addEventHandler ( "onClientColShapeHit", tutColshape,
		function ( element, dim )
			if dim and element == lp then
				local text = tutBubbleData[source]["text"]
				local r = tutBubbleData[source]["r"]
				local g = tutBubbleData[source]["g"]
				local b = tutBubbleData[source]["b"]
				local maxt = tutBubbleData[source]["max"] * 60
				if maxt >= getElementData ( lp, "playingtime" ) then
					infobox ( text, 10000, r, g, b )
				end
			end
		end
	)
end

createTutorialBubble ( -1980.5427246094, 145.16845703125, 27.32200050354, "An einem Automaten\nkannst du dein\nGeld von der Bank\nabheben. Druecke\ndazu ALT-GR ( neben\nder Leertaste )\nund klicke ihn an.", 5, 200, 200, 0 )
createTutorialBubble ( -2765.4018554688, 372.29138183594, 5.9826860427856, "An einem Automaten\nkannst du dein\nGeld von der Bank\nabheben. Druecke\ndazu ALT-GR ( neben\nder Leertaste )\nund klicke ihn an.", 5, 200, 200, 0 )
createTutorialBubble ( -2456.9841308594, 783.24542236328, 34.81477355957, "An einem Automaten\nkannst du dein\nGeld von der Bank\nabheben. Druecke\ndazu ALT-GR ( neben\nder Leertaste )\nund klicke ihn an.", 5, 200, 200, 0 )

createTutorialBubble ( -2633.6958007813, 211.23025512695, 3.4143309593201, "\nIn diesen Kisten\nkannst du Waffen\nLagern, klicke sie\ndazu mittels ALT-GR\n( neben der Leertaste ) an.", 5, 200, 200, 0 )
createTutorialBubble ( -2172.8569335938, 710.32220458984, 52.89062, "\nIn diesen Kisten\nkannst du Waffen\nLagern, klicke sie\ndazu mittels ALT-GR\n( neben der Leertaste ) an.", 5, 200, 200, 0 )
createTutorialBubble ( -700.05700683594, 943.8525390625, 11.3368101, "\nIn diesen Kisten\nkannst du Waffen\nLagern, klicke sie\ndazu mittels ALT-GR\n( neben der Leertaste ) an.", 5, 200, 200, 0 )
createTutorialBubble ( -1970.5015869141, -1585.2413330078, 86.7981414794, "\nIn diesen Kisten\nkannst du Waffen\nLagern, klicke sie\ndazu mittels ALT-GR\n( neben der Leertaste ) an.", 5, 200, 200, 0 )
createTutorialBubble ( -767.6689453125, 2419.4206542969, 156.05166625977, "\nIn diesen Kisten\nkannst du Waffen\nLagern, klicke sie\ndazu mittels ALT-GR\n( neben der Leertaste ) an.", 5, 200, 200, 0 )