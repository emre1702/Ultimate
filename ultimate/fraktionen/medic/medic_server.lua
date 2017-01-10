-- VARIABLEN --

-- saniShowTimeLeftStart
-- saniShowTimeLeftEnd
-- newDeadGuyToRescue   |  local playerdeatharray = { m_pick[pname], r, g, b, 60*1000 }


-- INTERIOR OBJECT --

local radio = createObject(2103, 409.51727294922, 262.29370117188, 997.16198730469, 0, 0, 130)
setElementInterior(radio, 3)

local innenraum = createObject(14594, 242.4009552002, 995.79626464844, 0, 0, 179.99450683594)
setElementInterior(innenraum, 3)

-- INT MARKER --

local marker1 = createMarker(437.60995483398, 230.7248840332, 996.91188964844, "corona", 1.5, 0, 255, 0, 150)
setElementInterior(marker1, 3)

local marker2 = createMarker(-2655.1066894531, 640.07641601563, 14.554549789429, "corona", 1.5, 0, 255, 0, 150)

addEventHandler("onMarkerHit", marker1, function(hitElement, dim)
	if getElementType(hitElement) == "player" and (dim) then
		if isPedInVehicle ( hitElement ) == false then
			setElementPosition(hitElement, -2655.2829589844, 638.32342529297, 14.453125)
			setElementInterior(hitElement, 0)
			infobox ( hitElement, "\nPass besser\nauf dich auf!", 5000, 0, 125, 0 )
		end
	end
end)

addEventHandler("onMarkerHit", marker2, function(hitElement, dim)
	if getElementType(hitElement) == "player" and (dim) then
		if isPedInVehicle ( hitElement ) == false then
			setElementPosition(hitElement, 435.42782592773, 230.65969848633, 996.81188964844)
			setElementInterior(hitElement, 3)
			infobox ( hitElement, "\nWillkommen im\nKrankenhaus!", 5000, 0, 125, 0 )
		end
	end
end)

local m_pick = {}
local m_mark = {}
local m_blip = {}

-- MEDIPACK AUFLADEN --

local marker_medipack = createMarker(398.35266113281, 258.39260864258, 996.01188964844, "cylinder", 2.0, 255, 0, 0, 150)
setElementInterior(marker_medipack, 3)

addEventHandler("onMarkerHit", marker_medipack, function(hitElement, dim)
	if getElementType(hitElement) == "player" and (dim) then
		if(isMedic(hitElement)) then
			outputChatBox("[INFO]: Nutze /loadmedikits um deine Medipacks wieder aufzuladen!", hitElement, 150, 150, 0)
		else
			outputChatBox("[INFO]: Nur für Mitarbeiter der Los Angeles Emergency!", hitElement, 175, 0, 0)
		end
	end
end)

addCommandHandler("loadmedikits", function(thePlayer)
	if(isMedic(thePlayer)) then
		if (isEmergencyOnDuty(thePlayer)) then
			if (isElementWithinMarker(thePlayer, marker_medipack)) then
				vioSetElementData(thePlayer, "medikits", 10)
				outputChatBox("Du hast deine Medikits erfolgreich aufgeladen! Du hast nun 10 Stück. Nutze /usekit um jemanden zu heilen!", thePlayer, 0, 150, 0)
			else
				triggerClientEvent ( thePlayer, "infobox_start", getRootElement(), "\Du bist nicht\nim dafür vorgesehenen\nMarker!", 5000, 255, 0, 0 )			
			end
		else
			triggerClientEvent ( thePlayer, "infobox_start", getRootElement(), "\nDu bist\nOffduty!", 5000, 255, 0, 0 )			
		end
	else
		triggerClientEvent ( thePlayer, "infobox_start", getRootElement(), "\nDu bist\nkein Sanitäter!", 5000, 255, 0, 0 )			
	end
end)

addCommandHandler("usekit", function(thePlayer, cmd, target)
	if(target) and (getPlayerFromName(target)) and (getPlayerName(thePlayer) ~= target) then
		if(isMedic(thePlayer)) and (isEmergencyOnDuty(thePlayer)) then
			target = getPlayerFromName(target)
			local carheal = false
			if isPedInVehicle(thePlayer) and isPedInVehicle(target) and getElementModel(getPedOccupiedVehicle(thePlayer)) == 416 and getElementModel(getPedOccupiedVehicle(target)) == 416 then
				carheal = true
			end
			local x, y, z = getElementPosition(thePlayer)
			local x2, y2, z2 = getElementPosition(target)
			if(getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) > 20) then
				triggerClientEvent ( thePlayer, "infobox_start", getRootElement(), "\nDu bist\nnicht nahe genug\nam Spieler!", 5000, 255, 0, 0 )	
				return
			end
			local kits = tonumber(vioGetElementData(thePlayer, "medikits"))
			if not(kits) or (kits < 1) and (carheal == false) then
				triggerClientEvent ( thePlayer, "infobox_start", getRootElement(), "\nDu hast\nkeine Medikits mehr!", 5000, 255, 0, 0 )
				return
			end
			if(carheal == false) then
				vioSetElementData(thePlayer, "medikits", kits-1)
				local x1, y1, z1 = getElementPosition(target)
				local x2, y2, z2 = getElementPosition(thePlayer)
				local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
				rot = rot-90
				setPedRotation(target, rot)
				
				x1, y1, z1 = getElementPosition(thePlayer)
				x2, y2, z2 = getElementPosition(target)
				rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
				rot = rot-90
				setPedRotation(thePlayer, rot)
			end
			toggleAllControls(target, false)
			toggleAllControls(thePlayer, false)
			setPedAnimation(thePlayer, "INT_SHOP", "shop_self", -1, true, false, false)
			triggerClientEvent ( thePlayer, "infobox_start", getRootElement(), "\nHeile Spieler ..", 5000, 255, 0, 0 )	
			setTimer(function()
				toggleAllControls(target, true)
				toggleAllControls(thePlayer, true)
				setPedAnimation(thePlayer)
				outputChatBox("[INFO]: Du wurdest von Sanitäter "..getPlayerName(thePlayer).." geheilt!", target, 200, 200, 0)
				if(carheal == false) then
					outputChatBox("[INFO]: Du hast "..getPlayerName(target).." geheilt! Verbleibene Kits: "..(kits-1), thePlayer, 0, 150, 0)
					setElementData(thePlayer, "medickits", kits-1)
				else
					outputChatBox("[INFO]: Du hast "..getPlayerName(target).." geheilt! Da du in einem Krankenwagen sitzt, hast du kein Kit verbraucht.", thePlayer, 0, 150, 0)
				end
				setElementHealth(target, 100)
				if(getPedArmor(target) < 50) then
					setPedArmor(target, 50)
				end
			end, 2000, 1)
		else
			triggerClientEvent ( thePlayer, "infobox_start", getRootElement(), "\nDu bist\nkein Sanitäter\nim Dienst!", 5000, 255, 0, 0 )	
		end
	else
		triggerClientEvent ( thePlayer, "infobox_start", getRootElement(), "Spieler ist\nnicht online\noder ungültig!", 5000, 255, 0, 0 )	
	end
end)

-- DUTY FUNC --

local duty_marker = createMarker(413.16009521484, 257.68475341797, 995.51188964844, "cylinder", 1.5, 255, 0, 0, 150)
setElementInterior(duty_marker, 3)

addEventHandler("onMarkerHit", duty_marker, function(hitElement, dim)
	if getElementType(hitElement) == "player" and (dim) then
		if(isMedic(hitElement)) or (isMechaniker(hitElement)) then
			outputChatBox("[INFO]: Nutze /medic um in Dienst zu gehen/den Dienst zu verlassen!", hitElement, 200, 200, 0)
		else
			outputChatBox("Nur für Mitarbeiter der San Fierro Emergency!", hitElement, 175, 0, 0)
		end
	end
end)

addCommandHandler("medic", function(thePlayer)
	if(isMedic(thePlayer) or isMechaniker(thePlayer)) then
		local x, y, z = getElementPosition ( thePlayer )
		if getDistanceBetweenPoints3D ( x, y, z, 413.16009521484, 257.68475341797, 995.51188964844 ) <= 5 then
			local duty = isEmergencyOnDuty ( thePlayer )
			if(duty == true) then
				outputChatBox("[INFO]: Du bist nun nicht mehr als Sanitäter im Dienst!", thePlayer, 200, 200, 0)
				takeWeapon(thePlayer, 41)
				setElementModel ( thePlayer, vioGetElementData ( thePlayer, "skinid" ) )
				triggerClientEvent ( thePlayer, "saniShowTimeLeftStart", thePlayer )
			elseif isMedic(thePlayer) or isMechaniker(thePlayer) then
				if isMechaniker(thePlayer) then
					vioSetElementData (thePlayer, "fraktion", 10)
				end
				outputChatBox("[INFO]: Du bist nun als Sanitäter im Dienst!", thePlayer, 200, 200, 0)
				outputChatBox("[INFO]: Ausserdem hast du 5 Medikits erhalten, /usekit!", thePlayer, 200, 200, 0)
				local thezahl = math.random (1, #factionSkins[10])
				setElementModel ( thePlayer, factionSkins[10][thezahl] )
				giveWeapon(thePlayer, 41, 1000, true)
				vioSetElementData(thePlayer, "medikits", 5)
				triggerClientEvent ( thePlayer, "saniShowTimeLeftStart", thePlayer )	
			end
		else
			triggerClientEvent ( thePlayer, "infobox_start", getRootElement(), "Du bist nicht\nim Marker!", 5000, 255, 0, 0 )	
		end
	else
		triggerClientEvent ( thePlayer, "infobox_start", getRootElement(), "Du bist kein\Sanitäter oder\nMechaniker!", 5000, 255, 0, 0 )	
	end
end)


local function wiederbelebe_player(sanitaeter, thePlayer)
	if(isPedDead(thePlayer)) then
		--fadeCamera(thePlayer, false, -1, 255, 255, 255)
		local x, y, z = getElementPosition(thePlayer)
		setTimer(function(sanitaeter, thePlayer)

			-- KRANKENHAUS ABBRECHEN --
			vioSetElementData ( thePlayer, "heaventime", 0 )
			showChat ( thePlayer, true )
			--fadeCamera(thePlayer, true)
			setCameraTarget ( thePlayer )
			
			RemoteSpawnPlayer ( thePlayer )
			
			setElementHealth(thePlayer, 100)
			if vioGetElementData ( thePlayer, "fraktion" ) > 0 then
				setPedArmor ( thePlayer, 100 )
			end
			setElementFrozen(thePlayer, false)
			toggleAllControls ( thePlayer, true )
			setPedAnimation(thePlayer,false)
			playSoundFrontEnd ( thePlayer, 17 )
			triggerClientEvent ( thePlayer, "hideDeathBar", thePlayer )
			if isTimer ( thedeathtimer[thePlayer] ) then
				killTimer ( thedeathtimer[thePlayer] )
			end
					
			outputChatBox("Du wurdest von Sanitäter "..getPlayerName(sanitaeter).." wieder ins Leben gerufen!", thePlayer, 0, 255, 0)
			
			if vioGetElementData(thePlayer, "money") >= hospitalcosts then
				vioSetElementData(thePlayer, "money", vioGetElementData(thePlayer, "money") - hospitalcosts) 
			end
			
			local boni = 150
			vioSetElementData ( sanitaeter, "boni", vioGetElementData ( sanitaeter, "boni" ) + boni )
			outputChatBox("Du hast "..getPlayerName(thePlayer).." wiederbelebt und erhälst bei", sanitaeter, 0, 255, 0)
			outputChatBox(" deiner nächsten Abrechnung "..boni.."$ Boni.", sanitaeter, 0, 255, 0)
		end, 2000, 1, sanitaeter, thePlayer)
	end
end

local m_pick = {}
local m_mark = {}
local m_blip = {}

function checkIfMedicRespawn ( client )
	local pname = getPlayerName ( client )
	
	if isElement ( m_pick[pname] ) then
		destroyElement ( m_pick[pname] )
	end
	if isElement ( m_mark[pname] ) then 
		destroyElement ( m_mark[pname] )
	end
	if isElement ( m_blip[pname] ) then 
		destroyElement ( m_blip[pname] )
	end
	
	if getElementInterior ( client ) == 0 then
		if vioGetElementData ( client, "jailtime") == 0 and vioGetElementData ( client, "prison") == 0 then	
			local r, g, b = math.random ( 0, 255 ), math.random ( 0, 255 ), math.random ( 0, 255 )
			local x, y, z = getElementPosition ( client )
			m_pick[pname] = createPickup ( x, y, z, 3, 1240, 1000 )
			m_mark[pname] = createMarker ( x, y, z, "corona", 1.0, 0, 0, 0, 0 )
			m_blip[pname] = createBlip ( x, y, z, 0, 2, r, g, b, 255, 0, 99999, root )
			local zonename1 = getZoneName(x, y, z, false)
			local zonename2 = getZoneName(x, y, z, true)
			setElementVisibleTo ( m_blip[pname], root, false )
			local playerdeatharray = { m_pick[pname], r, g, b, 68*1000 }
			
			for playeritem, key in pairs ( fraktionMembers[10] ) do
				if isElement ( playeritem ) and playeritem ~= player then
					if isEmergencyOnDuty ( playeritem ) then
						outputChatBox ( "[INFO]: Toter in "..zonename1..", "..zonename2.." gemeldet.", playeritem, 255, 155, 0 )
						setElementVisibleTo ( m_blip[pname], playeritem, true )
						triggerClientEvent ( playeritem, "newDeadGuyToRescue", playeritem, playerdeatharray )
					end
				else
					fraktionMembers[10][playeritem] = nil
				end
			end
			addEventHandler("onMarkerHit", m_mark[pname], medicOnMarkerHitRevive )
		end
	end
end


function medicOnMarkerHitRevive ( hitElement )
	if getElementType ( hitElement ) == "player" then
		if isMedic ( hitElement ) and isEmergencyOnDuty ( hitElement ) then
			if getElementHealth ( hitElement ) > 0 then
				local pname = nil
				for name, marker in pairs ( m_mark ) do
					if marker == source then
						pname = name
						local thePlayer = getPlayerFromName ( name )
						if isElement ( thePlayer ) then
							toggleAllControls ( hitElement, false )
							setPedAnimation( hitElement, "MEDIC", "CPR", -1, true, false, false )
							setTimer ( function ( player, thePlayer )
								if isElement ( player ) then
									setPedAnimation ( player )
									toggleAllControls ( player, true )
								end
								wiederbelebe_player ( player, thePlayer )
							end, 5000, 1, hitElement, thePlayer )
						end
						break
					end
				end
				destroyElement ( m_mark[pname] )
				destroyElement ( m_pick[pname] )
				destroyElement ( m_blip[pname] )
			end
		end
	end
end


addEventHandler("onPlayerSpawn", root, function()
	local pname = getPlayerName(source)
	if isElement ( m_mark[pname] ) then
		destroyElement ( m_mark[pname] )
	end
	if isElement ( m_pick[pname] ) then
		destroyElement ( m_pick[pname] )
	end
	if isElement ( m_blip[pname] ) then
		destroyElement ( m_blip[pname] )
	end
end )


addEventHandler("onPlayerQuit", root, function()
	local pname = getPlayerName(source)
	if isElement ( m_mark[pname] ) then
		destroyElement ( m_mark[pname] )
	end
	if isElement ( m_pick[pname] ) then
		destroyElement ( m_pick[pname] )
	end
	if isElement ( m_blip[pname] ) then
		destroyElement ( m_blip[pname] )
	end
end )


