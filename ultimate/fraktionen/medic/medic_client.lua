addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	--local shader = dxCreateShader("images/textureshader.fx")
	--dxSetShaderValue(shader, "Tex", dxCreateTexture("images/texturen/ambulance.png"))
	--engineApplyShaderToWorldTexture(shader, "ambulan92decal128")
	
	-- RADIO --
	local sound = playSound3D("http://iloveradio.de/listen.m3u", 409.51727294922, 262.29370117188, 997.16198730469, true)
	setElementInterior(sound, 3)
end)


addEvent ( "saniShowTimeLeftStart", true )
addEvent ( "saniShowTimeLeftEnd", true )
addEvent ( "newDeadGuyToRescue", true )

local playerRespawnArray = {}
local sx,sy = guiGetScreenSize()
local px,py = 1600,900
local x,y =  (sx/px), (sy/py)
local timetorespawn = 68000


local function drawMedicRespawnTime ( )
	local xp, yp, zp = getElementPosition ( localPlayer )
	for i=1, #playerRespawnArray do
		if playerRespawnArray[i] then
			if isElement ( playerRespawnArray[i][1] ) then
				local timeleft = playerRespawnArray[i][5]-getTickCount()
				if timeleft > 0 then
					dxDrawRectangle ( x*1230, y*230+y*32*(i-1), x*360*(timeleft/timetorespawn), y*30, tocolor ( playerRespawnArray[i][2], playerRespawnArray[i][3], playerRespawnArray[i][4], 150 ) )
					local xpi, ypi, zpi = getElementPosition ( playerRespawnArray[i][1] )
					dxDrawText ( math.floor ( getDistanceBetweenPoints3D ( xp, yp, zp, xpi, ypi, zpi ) * 100 )/100, x*1230, y*230+y*32*(i-1), x*1590, y*260+y*32*(i-1), tocolor ( 255-playerRespawnArray[i][2], 255-playerRespawnArray[i][3], 255-playerRespawnArray[i][4], 255 ), 2, "default-bold", "center", "center" )
				else
					table.remove ( playerRespawnArray, i )
				end
			else
				table.remove ( playerRespawnArray, i )
			end
		end
	end
end


addEventHandler ( "saniShowTimeLeftStart", root, function ()
	addEventHandler ( "onClientRender", root, drawMedicRespawnTime )
end )


addEventHandler ( "saniShowTimeLeftEnd", root, function ()
	removeEventHandler ( "onClientRender", root, drawMedicRespawnTime )
end )


addEventHandler ( "newDeadGuyToRescue", root, function ( array )
	playerRespawnArray[#playerRespawnArray+1] = { array[1], array[2], array[3], array[4], getTickCount()+array[5] }
end )