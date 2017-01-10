local screenWidth, screenHeight = guiGetScreenSize()
local anima = nil

function Animshow(anim)
	removeEventHandler ( "onClientRender", getRootElement(), Animrender)
	anima = anim
	addEventHandler( "onClientRender", getRootElement(), Animrender)
end
addEvent("Animshow",true)
addEventHandler("Animshow", getLocalPlayer(), Animshow)

function Animrender()
	local posx = 192/800
	local posxn = posx*screenWidth
	local posyline = 515.0/600
	local posynline = posyline*screenHeight
	local posytxt1 = 476/600
	local posytxt1n = posytxt1*screenHeight
	local posytxt2 = 528/600
	local posytxt2n = posytxt2*screenHeight
	dxDrawLine(posxn,posynline,793.0,posynline,tocolor(255,255,255,255),1.0,false)
	dxDrawText("Animation : "..anima.."",posxn,posytxt1n,737.0,502.0,tocolor(255,0,0,180),1.1,"pricedown","left","top",false,false,false)
	dxDrawText("Leertaste benutzen um die Animation zu beenden!",posxn,posytxt2n,737.0,554.0,tocolor(255,0,0,180),1.1,"pricedown","left","top",false,false,false)
end

function removeAnimDraw()
	removeEventHandler ( "onClientRender", getRootElement(), Animrender)
end
addEvent("Animhide",true)
addEventHandler("Animhide", root, removeAnimDraw)