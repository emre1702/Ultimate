		      -- SCRIPT BY HD|~BigWilly~ --
-- You can edit the Script it but dont remove this Lines --
 -- You have no right of this script issue than yours --
      -- You have no right to sell this script --
	       -- High Definition Race 2014 --
		-- IP mtasa://217.198.132.136:22003 --
		
local sx,sy = guiGetScreenSize()
local px,py = 1600,900
local x,y = (sx/px), (sy/py)
local customhudshown = 2
local hudRT

function renderHud()
	local datum, time = timestampOpticalZeitDatum ()
	local weaponslot = getPedWeaponSlot(localPlayer)
	local playerHunger = getElementHunger ( )	
	local playerHealth = getElementHealth ( localPlayer )
	local playerArmor = getPedArmor ( localPlayer )
	local playerMoney = mymoney
	local playerWanted = getElementData ( localPlayer, "wanteds" )
	local playerX, playerY, playerZ = getElementPosition ( localPlayer ) 
	local playerZoneName = getZoneName ( playerX, playerY, playerZ )
	if hudRT then
		dxSetBlendMode ( "add" )
		dxDrawImage ( x*1230, y*10, x*360, y*168, hudRT, 0, 0, 0, tocolor ( 255, 255, 255, 255 ), true )
		dxSetBlendMode ( "blend" )
	else
		dxDrawRectangle(x*1230, y*10, x*360, y*18, tocolor(7, 7, 7, 220), true)
		dxDrawRectangle(x*1230, y*28, x*360, y*150, tocolor(7, 7, 7, 110), true)
		dxDrawLine(x*1379, y*39, x*1379, y*72, tocolor(255, 255, 255, 255), 2, true)
        dxDrawLine(x*1379, y*71, x*1398, y*71, tocolor(255, 255, 255, 255), 2, true)
        dxDrawLine(x*1379, y*39, x*1398, y*39, tocolor(255, 255, 255, 255), 2, true)
        dxDrawLine(x*1554, y*71, x*1573, y*71, tocolor(255, 255, 255, 255), 2, true)
        dxDrawLine(x*1573, y*39, x*1573, y*72, tocolor(255, 255, 255, 255), 2, true)
        dxDrawLine(x*1554, y*39, x*1573, y*39, tocolor(255, 255, 255, 255), 2, true)
        dxDrawRectangle(x*1384, y*44, x*185, y*23, tocolor(66, 66, 66, 122), true) 
        dxDrawLine(x*1379, y*81, x*1379, y*115, tocolor(197, 0, 0, 255), 2, true)
        dxDrawLine(x*1379, y*114, x*1398, y*114, tocolor(197, 0, 0, 255), 2, true)
        dxDrawLine(x*1379, y*81, x*1398, y*81, tocolor(197, 0, 0, 255), 2, true)
        dxDrawLine(x*1554, y*114, x*1573, y*114, tocolor(197, 0, 0, 255), 2, true)
        dxDrawLine(x*1573, y*81, x*1573, y*115, tocolor(197, 0, 0, 255), 2, true)
        dxDrawLine(x*1554, y*81, x*1573, y*81, tocolor(197, 0, 0, 255), 2, true)
        dxDrawRectangle(x*1383, y*43, x*187, y*25, tocolor(22, 22, 22, 100), true) -- Armor Background]]
       
		dxDrawRectangle(x*1383, y*85, x*187, y*26, tocolor(22, 22, 22, 100), true) -- Health Background
        
        dxDrawRectangle(x*1383, y*131, x*187, y*24, tocolor(22, 22, 22, 100), true) 
        dxDrawRectangle(x*1384, y*85, x*185, y*24, tocolor(66, 66, 66, 122), true)
        dxDrawRectangle(x*1383, y*130, x*187, y*26, tocolor(22, 22, 22, 100), true) -- Hunger Background
       
        dxDrawLine(x*1379, y*126, x*1379, y*159, tocolor(67, 191, 0, 172), 2, true)
        dxDrawLine(x*1379, y*126, x*1398, y*126, tocolor(67, 191, 0, 172), 2, true)
        dxDrawLine(x*1379, y*159, x*1398, y*159, tocolor(67, 191, 0, 172), 2, true)
        dxDrawLine(x*1573, y*126, x*1573, y*159, tocolor(67, 191, 0, 172), 2, true)
        dxDrawLine(x*1554, y*159, x*1573, y*159, tocolor(67, 191, 0, 172), 2, true)
        dxDrawLine(x*1554, y*126, x*1573, y*126, tocolor(67, 191, 0, 172), 2, true)
	end
		dxDrawRectangle(x*1384, y*44, x*185/100*playerArmor, y*23, tocolor(255,255,255,255), true) -- Armor Rectangle
		dxDrawRectangle(x*1384, y*86, x*185/100*playerHealth, y*24, tocolor(197, 0, 0, 172), true) -- Health Rectangle
		dxDrawRectangle(x*1384, y*131, x*185/100*playerHunger, y*24, tocolor(67, 191, 0, 172), true) -- Hunger Rectangle
        dxDrawText(""..math.floor(tonumber(playerHealth)).."%", x*1435, y*92, x*1514, y*106, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerHealth)).."%", x*1435, y*90, x*1514, y*104, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerHealth)).."%", x*1433, y*92, x*1512, y*106, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerHealth)).."%", x*1433, y*90, x*1512, y*104, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerHealth)).."%", x*1434, y*91, x*1513, y*105, tocolor(255, 255, 255, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerArmor)).."%", x*1435, y*50, x*1514, y*64, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerArmor)).."%", x*1435, y*48, x*1514, y*62, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerArmor)).."%", x*1433, y*50, x*1512, y*64, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerArmor)).."%", x*1433, y*48, x*1512, y*62, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerArmor)).."%", x*1434, y*49, x*1513, y*63, tocolor(255, 255, 255, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerHunger)).."%", x*1435, y*139, x*1514, y*153, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerHunger)).."%", x*1435, y*137, x*1514, y*151, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerHunger)).."%", x*1433, y*139, x*1512, y*153, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerHunger)).."%", x*1433, y*137, x*1512, y*151, tocolor(0, 0, 0, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(""..math.floor(tonumber(playerHunger)).."%", x*1434, y*138, x*1513, y*152, tocolor(255, 255, 255, 255), 0.90, "default-bold", "center", "center", false, false, true, false, false)
		if weaponslot >= 2 and weaponslot <= 9 then
			local clip = getPedAmmoInClip (localPlayer, weaponslot )
			local clip1 = getPedTotalAmmo (localPlayer, weaponslot )
			dxDrawText(clip.."|"..clip1, x*1266, y*135, x*1345, y*149, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(clip.."|"..clip1, x*1266, y*133, x*1345, y*147, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(clip.."|"..clip1, x*1264, y*135, x*1343, y*149, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(clip.."|"..clip1, x*1264, y*133, x*1343, y*147, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
			dxDrawText(clip.."|"..clip1, x*1265, y*134, x*1344, y*148, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		end
        dxDrawText(playerMoney.."$", x*1263, y*162, x*1342, y*164, tocolor(0, 0, 0, 255), 2, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(playerMoney.."$", x*1263, y*160, x*1342, y*162, tocolor(0, 0, 0, 255), 2, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(playerMoney.."$", x*1261, y*162, x*1340, y*164, tocolor(0, 0, 0, 255), 2, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(playerMoney.."$", x*1261, y*160, x*1340, y*162, tocolor(0, 0, 0, 255), 2, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(playerMoney.."$", x*1262, y*161, x*1341, y*163, tocolor(255, 255, 255, 255), 2, "default-bold", "center", "center", false, false, true, false, false)
       
		dxDrawText(time.."", x*1314, y*12, x*1525, y*28, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(time.."", x*1314, y*10, x*1525, y*26, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(time.."", x*1312, y*12, x*1523, y*28, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(time.."", x*1312, y*10, x*1523, y*26, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(time.."", x*1313, y*11, x*1524, y*27, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		dxDrawText(datum.."", x*1569, y*12, x*1525, y*28, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(datum.."", x*1569, y*10, x*1525, y*26, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(datum.."", x*1567, y*12, x*1523, y*28, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(datum.."", x*1567, y*10, x*1523, y*26, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
        dxDrawText(datum.."", x*1568, y*11, x*1524, y*27, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
	
		if playerWanted >= 1 then
			dxDrawImage(x*1510, y*180, x*45, y*40, "images/hud/wanted_active.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) --1
			if playerWanted >= 2 then
				dxDrawImage(x*1460, y*180, x*45, y*40, "images/hud/wanted_active.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) --2
				if playerWanted >= 3 then
					dxDrawImage(x*1410, y*180, x*45, y*40, "images/hud/wanted_active.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) --3
					if playerWanted >= 4 then
						dxDrawImage(x*1360, y*180, x*45, y*40, "images/hud/wanted_active.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) --4
						if playerWanted >= 5 then
							dxDrawImage(x*1310, y*180, x*45, y*40, "images/hud/wanted_active.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) --5
							if playerWanted >= 6 then
								dxDrawImage(x*1260, y*180, x*45, y*40, "images/hud/wanted_active.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) --6
							end
						end
					end
				end
			end
		end
		local weaponID = getPedWeapon (localPlayer)
		dxDrawImage (x*1245, y*35, x*120, y*100,"images/hud/"..  weaponID .. ".png",0.0,0.0,0.0,tocolor(255,255,255,200),true)
		
	end
	
	
function showOtherHud ()
	if customhudshown == 1 then
		removeEventHandler ("onClientRender", root, renderHud)
		setPlayerHudComponentVisible("clock",true)
		setPlayerHudComponentVisible("money",true)
		setPlayerHudComponentVisible("health",true)
		setPlayerHudComponentVisible("armour",true)
		setPlayerHudComponentVisible("weapon",true) 
		setPlayerHudComponentVisible("ammo",true)
		setPlayerHudComponentVisible("wanted",true)
		setPlayerHudComponentVisible("breath",true)
		setPlayerHudComponentVisible("radar",true)
		setPlayerHudComponentVisible("crosshair", true)
		showHungerBar()
		customhudshown = 2
	elseif customhudshown == 2 then
		if not hudRT then
			drawRenderTargetNew ( true )
		end
		removeEventHandler ("onClientRender", root, renderHud)
		addEventHandler ("onClientRender", root, renderHud)
		setPlayerHudComponentVisible("clock",false)
		setPlayerHudComponentVisible("money",false)
		setPlayerHudComponentVisible("health",false)
		setPlayerHudComponentVisible("armour",false)
		setPlayerHudComponentVisible("weapon",false) 
		setPlayerHudComponentVisible("ammo",false)
		setPlayerHudComponentVisible("wanted",false)
		setPlayerHudComponentVisible("breath",false)
		setPlayerHudComponentVisible("radar",true)
		setPlayerHudComponentVisible("crosshair", true)
		hideHungerBar()
		customhudshown = 1
	end
end


function timestampOpticalDatum ()
	local regtime = getRealTime()
	local year = regtime.year + 1900
	local month = regtime.month+1
	local day = regtime.monthday
	return tostring(day.."."..month.."."..year)
end

function timestampOpticalZeit ()
	local regtime = getRealTime()
	local hour = regtime.hour
	local minute = regtime.minute
	if hour < 10 then
		hour = "0"..hour
	end
	if minute < 10 then
		minute = "0"..minute
	end
	return tostring(hour..":"..minute)
end


function timestampOpticalZeitDatum ()
	local regtime = getRealTime()
	local year = regtime.year + 1900
	local month = regtime.month+1
	local day = regtime.monthday
	local hour = regtime.hour
	local minute = regtime.minute
	if hour < 10 then
		hour = "0"..hour
	end
	if minute < 10 then
		minute = "0"..minute
	end
	return tostring(day.."."..month.."."..year), tostring(hour..":"..minute)
end

wegTable={}

local hudwason = false
addEventHandler ( "onClientPlayerWeaponFire", root, function ( weapon )
	if weapon == 43 then
		if customhudshown == 1 then
			removeEventHandler ("onClientRender", root, renderHud)
			customhudshown = 2
			showChat ( false )
			bindKey ( "b", "down", showChatAfterCameraAgain )
		else
			removeEventHandler ("onClientRender", root, renderHud)
			setPlayerHudComponentVisible("clock",false)
			setPlayerHudComponentVisible("money",false)
			setPlayerHudComponentVisible("health",false)
			setPlayerHudComponentVisible("armour",false)
			setPlayerHudComponentVisible("weapon",false) 
			setPlayerHudComponentVisible("ammo",false)
			setPlayerHudComponentVisible("wanted",false)
			setPlayerHudComponentVisible("breath",false)
			hideHungerBar()
			showChat ( false )
			customhudshown = 1
			bindKey ( "b", "down", showChatAfterCameraAgain )
		end
	end
end )


function showChatAfterCameraAgain ( number )
	showChat ( true )
	unbindKey ( "b", "down", showChatAfterCameraAgain )
end


function drawRenderTargetNew ( bool )
	if bool then
		hudRT = dxCreateRenderTarget ( x*360, y*168, true )
		local name = getPlayerName(localPlayer):gsub('#%x%x%x%x%x%x', '')
		dxSetRenderTarget ( hudRT )
		dxSetBlendMode ( "modulate_add" )
		-- x*1230, y*10, x*360, y*168 --
		dxDrawRectangle(0, 0, x*360, y*18, tocolor(7, 7, 7, 220))
		dxDrawRectangle(0, y*18, x*360, y*150, tocolor(7, 7, 7, 110))
		dxDrawLine(x*149, y*29, x*149, y*62, tocolor(255, 255, 255, 255), 2)
		dxDrawLine(x*149, y*61, x*168, y*61, tocolor(255, 255, 255, 255), 2)
		dxDrawLine(x*149, y*29, x*168, y*29, tocolor(255, 255, 255, 255), 2)
		dxDrawLine(x*324, y*61, x*343, y*61, tocolor(255, 255, 255, 255), 2)
		dxDrawLine(x*343, y*29, x*343, y*62, tocolor(255, 255, 255, 255), 2)
		dxDrawLine(x*324, y*29, x*343, y*29, tocolor(255, 255, 255, 255), 2)
		dxDrawRectangle(x*154, y*34, x*185, y*23, tocolor(66, 66, 66, 122)) 
		dxDrawLine(x*149, y*71, x*149, y*105, tocolor(197, 0, 0, 255), 2)
		dxDrawLine(x*149, y*104, x*168, y*104, tocolor(197, 0, 0, 255), 2)
		dxDrawLine(x*149, y*71, x*168, y*71, tocolor(197, 0, 0, 255), 2)
		dxDrawLine(x*324, y*104, x*343, y*104, tocolor(197, 0, 0, 255), 2)
		dxDrawLine(x*343, y*71, x*343, y*105, tocolor(197, 0, 0, 255), 2)
		dxDrawLine(x*324, y*71, x*343, y*71, tocolor(197, 0, 0, 255), 2)
		dxDrawRectangle(x*153, y*33, x*187, y*25, tocolor(22, 22, 22, 100)) -- Armor Background
		dxDrawRectangle(x*153, y*75, x*187, y*26, tocolor(22, 22, 22, 100)) -- Health Background

		dxDrawRectangle(x*153, y*121, x*187, y*24, tocolor(22, 22, 22, 100)) 
		dxDrawRectangle(x*154, y*75, x*185, y*24, tocolor(66, 66, 66, 122))
		dxDrawRectangle(x*153, y*120, x*187, y*26, tocolor(22, 22, 22, 100)) -- Hunger Background
		dxDrawLine(x*149, y*116, x*149, y*149, tocolor(67, 191, 0, 172), 2)
		dxDrawLine(x*149, y*116, x*168, y*116, tocolor(67, 191, 0, 172), 2)
		dxDrawLine(x*149, y*149, x*168, y*149, tocolor(67, 191, 0, 172), 2)
		dxDrawLine(x*343, y*116, x*343, y*149, tocolor(67, 191, 0, 172), 2)
		dxDrawLine(x*324, y*149, x*343, y*149, tocolor(67, 191, 0, 172), 2)
		dxDrawLine(x*324, y*116, x*343, y*116, tocolor(67, 191, 0, 172), 2)
		dxDrawText(name.."", x*20, y*2, x*112, y*18, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(name.."", x*20, 0, x*112, y*16, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(name.."", x*18, y*2, x*110, y*18, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(name.."", x*18, 0, x*110, y*16, tocolor(0, 0, 0, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText(name.."", x*19, y*1, x*111, y*17, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, false, false, false)
		dxSetBlendMode ( "blend" )
		dxSetRenderTarget ( )
	end
end
addEventHandler ( "onClientRestore", root, drawRenderTargetNew )
   
fileDelete("anzeigen/hud.lua")

