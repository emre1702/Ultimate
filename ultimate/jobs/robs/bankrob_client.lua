------------------------------
-------- Urheberrecht --------
------- by [LA]Leyynen -------
-------- 2012 - 2013 ---------
------------------------------
---- Script by Noneatme ------

addEvent("onBankraubKlingelStart", true)
addEvent("onClientBankrobAttackPed", true)

local sound
local bankdim = 4


addEventHandler("onBankraubKlingelStart", getRootElement(), function()
	if(isElement(sound)) then destroyElement(sound) end
	sound = playSound3D("sounds/klingel.mp3", 358.22827148438, 161.99220275879, 1027.7963867188, true)
	setSoundMaxDistance(sound, 200)
	setElementInterior(sound, 3)
	setElementDimension(sound, bankdim)
	setTimer(destroyElement, 15*60*1000, 1, sound)
end)


local col = createColSphere(357.23455810547, 161.79089355469, 1025.7963867188, 20)
setElementInterior(col, 3)
setElementDimension(col, bankdim)

local attacking = {}
local attackTimer = {}
local function setPedAttackPlayer(thePed)
	if(attacking[thePed] == true) then return end
	attacking[thePed] = true
	attackTimer[thePed] = setTimer(function()
		if(getElementHealth(thePed) < 1) then
			killTimer(attackTimer[thePed])
		else
			local x1, y1, z1 = getElementPosition(thePed)
			local x2, y2, z2 = getElementPosition(localPlayer)
			local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
			rot = rot-90
			if(isLineOfSightClear(x1, y1, z1, x2, y2, z2, true, false, false, false, false, false, false)) then
				setPedRotation(thePed, rot)
				setPedAimTarget(thePed, getElementPosition(localPlayer))
				setPedControlState(thePed, "aim_weapon", true)
				setPedControlState(thePed, "fire", true)
				setTimer(setPedControlState, 100, 1, thePed, "fire", false)
			else
				setPedControlState(thePed, "aim_weapon", false)
				setPedControlState(thePed, "fire", false)
			end
		end
	end, 500, -1)
end

addEventHandler("onClientPedDamage", getRootElement(), function()
	if(getElementData(source, "bankguard") == true) then
		setPedAttackPlayer(source)
	end
end)

addEventHandler("onClientBankrobAttackPed", getRootElement(), function(thePed)
	setPedAttackPlayer(thePed)
end)