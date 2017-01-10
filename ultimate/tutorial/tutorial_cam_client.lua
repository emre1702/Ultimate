tutorialCamSettings = {}

function followElement ( x, y, z, element )

	local ex, ey, ez = getElementPosition ( element )
	setCameraMatrix ( x, y, z, ex, ey, ez )
	tutorialCamSettings.x = x
	tutorialCamSettings.y = y
	tutorialCamSettings.z = z
	tutorialCamSettings.element = element
	addEventHandler ( "onClientRender", getRootElement(), followElement_render )
end

function followElementWithElement ( element1, element2 )

	tutorialCamSettings.elementone = element1
	tutorialCamSettings.elementtwo = element2
	local x1, y1, z1 = getElementPosition ( element1 )
	local x2, y2, z2 = getElementPosition ( element2 )
	setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
	addEventHandler ( "onClientRender", getRootElement(), followElementWithElement_render )
end


function followElement_render ()

	if not getCameraTarget ( lp ) then
		local x1, y1, z1 = tutorialCamSettings.x, tutorialCamSettings.y, tutorialCamSettings.z
		local x2, y2, z2 = getElementPosition ( tutorialCamSettings.element )
		setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
	else
		removeEventHandler ( "onClientRender", getRootElement(), followElement_render )
	end
end


function followElementWithElement_render ()

	if not getCameraTarget ( lp ) then
		local x1, y1, z1 = getElementPosition ( tutorialCamSettings.elementone )
		local x2, y2, z2 = getElementPosition ( tutorialCamSettings.elementtwo )
		setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
	else
		removeEventHandler ( "onClientRender", getRootElement(), followElementWithElement_render )
	end
end


function cameraAttachFollow ( x, y, z, element )

	local x1, y1, z1 = x, y, z
	local x2, y2, z2 = getElementPosition ( element )
	local xd, yd, zd = x1 - x2, y1 - y2, z1 - z2
	tutorialCamSettings.x = xd
	tutorialCamSettings.y = yd
	tutorialCamSettings.z = zd
	tutorialCamSettings.element = element
	addEventHandler ( "onClientRender", getRootElement(), followElement_render )
end
function cameraAttachFollow_render ()

	if not getCameraTarget ( lp ) then
		local x1, y1, z1 = tutorialCamSettings.x, tutorialCamSettings.y, tutorialCamSettings.z
		local x2, y2, z2 = getElementPosition ( tutorialCamSettings.element )
		setCameraMatrix ( x1 + x2, y1 + y2, z1 + z2, x2, y2, z2 )
	else
		removeEventHandler ( "onClientRender", getRootElement(), cameraAttachFollow_render )
	end
end

function fadeScreen ( bool )

	if bool then
		fadeScreenToNormal ()
	else
		fadeScreenToBlack ()
	end
end
function fadeScreenToNormal ()

	fadeCamera ( true )
end
function fadeScreenToBlack ()

	fadeCamera ( false, 1, 0, 0, 0 )
end