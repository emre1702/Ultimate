-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

sichtweite = 20
hoerweite = 4

function Area51SettingsClient_func ()

	setWeather ( 9 )
	setTime ( 3, 0 )
	
	sichtweite = 20
	
	scientist1 = createPed ( 70, 212.75068664551, 1822.8577880859, 6.0632882118225 )
	setPedRotation ( scientist1, 180 )
	scientist2 = createPed ( 70, 280.1787109375, 1872.8679199219, 8.4070377349854 )
	setPedRotation ( scientist2, 270 )
	scientist3 = createPed ( 70, 276.31051635742, 1854.2509765625, 8.414119720459 )
	scientist4 = createPed ( 70, 272.05737304688, 1854.2252197266, 8.414119720459 )
	setElementData ( scientist1, "bothealth", 50 )
	setElementData ( scientist2, "bothealth", 50 )
	setElementData ( scientist3, "bothealth", 50 )
	setElementData ( scientist4, "bothealth", 50 )
	setPedAnimation ( scientist1, "ON_LOOKERS", "panic_loop" )
	setPedAnimation ( scientist2, "SHOP", "SHP_Rob_HandsUp" )
	setPedAnimation ( scientist3, "ON_LOOKERS", "panic_cower" )
	setPedAnimation ( scientist4, "ON_LOOKERS", "panic_loop" )
	setElementDimension ( scientist1, tonumber ( vioClientGetElementData("playerid" ) ) + 1 )
	setElementDimension ( scientist2, tonumber ( vioClientGetElementData("playerid" ) ) + 1 )
	setElementDimension ( scientist3, tonumber ( vioClientGetElementData("playerid" ) ) + 1 )
	setElementDimension ( scientist4, tonumber ( vioClientGetElementData("playerid" ) ) + 1 )
end
addEvent ( "Area51SettingsClient", true )
addEventHandler ( "Area51SettingsClient", getRootElement(), Area51SettingsClient_func )

function setClientSettingsBackToNormal_func ( curweather, nextweather, curtimehours, curtimeminutes )

	setTime ( curtimehours, curtimeminutes )
	setWeather ( nextweather )
	for i = 1, 4 do
		destroyElement ( _G["scientist"..i] )
	end
	setElementDimension ( mothership, 0 )
	destroyElement ( TheTruth )
	destroyElement ( greenGooBlip )
end
addEvent ( "setClientSettingsBackToNormal", true )
addEventHandler ( "setClientSettingsBackToNormal", getRootElement(), setClientSettingsBackToNormal_func )

function setBotPerfectFastAnimation ( bot )

	if getPedWeaponSlot ( bot ) == 0 then
		setPedAnimation ( bot, "ped", "run_civi" )
		return true
	else
		setPedAnimation ( bot, "ped", "run_armed" )
		return true
	end
end

function setBotPerfectSlowAnimation ( bot )

	if getPedWeaponSlot ( bot ) == 0 then
		setPedAnimation ( bot, "ped", "WALK_civi" )
		return true
	else
		setPedAnimation ( bot, "ped", "WALK_armed" )
		return true
	end
end

function isPedDead ( ped )

	if isElement ( ped ) then
		if getElementHealth ( ped ) then
			if getElementHealth ( ped ) <= 0 then
				setPedAnimation ( ped )
				return true
			else
				return false
			end
		else
			return false
		end
	end
end

function isPlayerInBotSight ( bot )

	local x1, y1, z1 = getElementPosition ( lp )
	if bot then
		local x2, y2, z2 = getElementPosition ( bot )
		local distance = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2+2 )
		if distance <= sichtweite then
			local rotation = math.abs ( findRotation(x1, y1, x2, y2) - getPedRotation ( bot ) )
			if rotation < 245 and rotation > 115 then
				local hit, x, y, z, element = processLineOfSight ( x1, y1, z1, x2, y2, z2+2, true, false, false, true, false )
				if hit then
					return false
				else
					return true
				end
			elseif distance <= hoerweite and not isPedDucked ( lp ) then
				return true
			else
				return false
			end
		else
			return false
		end
	end
end

function pedDamagedArea51 ( attacker, weapon, bodypart, loss )

	if vioClientGetElementData ( "isInArea51Mission" ) then
		if getElementType ( source ) == "ped" and not getElementData ( source, "zombie" ) then
			if attacker and weapon and bodypart and loss then
				if bodypart == 3 or bodypart == 4 then
					loss = loss *2
				elseif bodypart == 5 or bodypart == 6 then
					loss = loss *2
				elseif bodypart == 7 or bodypart == 8 then
					loss = loss *2
				elseif bodypart == 9 then
					loss = loss * 5
				end
				if weapon == 4 then
					loss = loss*999
				end
				setElementData ( source, "bothealth", getElementData ( source, "bothealth" ) - loss, false )
				if getElementData ( source, "bothealth" ) <= 0 then
					triggerServerEvent ( "killPed", getRootElement(), source )
				elseif getElementData ( source, "isAlarmed" ) == false then
					setTimer ( setBotAlert, 1000, 1, source )
					setPedAnimation ( source )
				end
			end
		end
	end
end
addEventHandler ( "onClientPedDamage", getRootElement (), pedDamagedArea51 )

function setBotAlert ( bot )

	if not isPedDead ( bot ) then
		setElementData ( bot, "isAlarmed", true, false )
	end
end