--[[
	/////// //////////////////
	/////// PROJECT: MTA iLife - German Fun Reallife Gamemode
	/////// VERSION: 1.7.2 
	/////// DEVELOPERS: See DEVELOPERS.md in the top folder
	/////// LICENSE: See LICENSE.md in the top folder 
	/////// /////////////////
]]

local dsdigi = dxCreateFont("fonts/DS-DIGI.ttf",8)
local sx,sy = guiGetScreenSize()
local multiply = 1.35
KMDistance = 0
maxDistanceKilometer = 999999
c_EnableScaling = false

c_XOffset = 0
c_YOffset = 0
c_ImageW = 221
c_ImageH = 211
c_BarW = 50
c_BarH = 10
c_BarYOffset = 70

c_FireTimeMs = 5000
c_BarAlpha = 120
c_BarFlashInterval = 300

g_tFireStart = nil

multiply = 1.35

KMDistance = 0
maxDistanceKilometer = 999999


function renderTacho()
	if isPedInVehicle(getLocalPlayer()) then
		local alpha = 255
		local theVehicle = getPedOccupiedVehicle(getLocalPlayer())

		-- Render
		dxDrawImage(sx-300, sy-300, 300, 300, "images/carsys/Background.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)
		local color
		if(theVehicle) and (getVehicleEngineState(theVehicle)) then
			color = tocolor(255, 255, 255, alpha)
		else
			color = tocolor(0, 0, 0, alpha/2)
		end

		-- Motor
		dxDrawImage(sx-200, sy-220, 40, 30, "images/carsys/Engine.png", 0, 0, 0, color, false)

		-- Licht

		if (theVehicle) and (getVehicleOverrideLights(theVehicle) == 2) then
			color = tocolor(255, 255, 255, alpha)
		else
			color = tocolor(0, 0, 0, alpha/2)
		end
		dxDrawImage(sx-150, sy-220, 30, 30, "images/carsys/Light.png", 0, 0, 0, color, false)


		-- Text
		local speed = getVehicleSpeed ( theVehicle )
		dxDrawText(round(speed), sx-155, sy-145, sx-100, sy-100,  tocolor(255, 255, 255, alpha), 3.6, dsdigi, "right", "top", false, false, true, false, false)

		-- Tanknadel

		local fuel = 100;
		local empty_degree = 224
		local full_degree = 136
		if(getElementData(theVehicle, "fuelstate")) then
			fuel = tonumber(getElementData(theVehicle, "fuelstate"));
		end
		if fuel > 100 then fuel = 100 end
		local fuel_degree = full_degree+(full_degree-empty_degree)*fuel/100
		dxDrawImage(sx-246, sy-148, 194, 11.5, "images/carsys/Tanknadel.png", fuel_degree, 0, 0, tocolor(255, 255, 255, alpha), false)
		
		-- Nadel & Punkt

		local npos = 0
		if (speed>364) then
			npos= 365+((getTickCount()%2)-1)
		else
			npos = speed - 3
		end

		dxDrawImage(sx-250, sy-160, 200, 6, "images/carsys/Nadel.png", npos/2, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(sx-300, sy-300, 300, 300, "images/carsys/Punkt.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		removeEventHandler ( "onClientRender", root, renderTacho )
	end
end


addEventHandler("onClientVehicleEnter", getRootElement(), function(enterer)
	if (enterer == getLocalPlayer()) then
		addEventHandler("onClientRender",getRootElement(), renderTacho)
	end
end
)

addEventHandler("onClientVehicleExit", getRootElement(), function(exiter)
	if (exiter == getLocalPlayer()) then
		removeEventHandler("onClientRender",getRootElement(), renderTacho)
	end
end
)


function getDistanceTraveled ( veh, x1, y1, z1 )

	local veh = getPedOccupiedVehicle ( lp )
	if veh then
		if getPedOccupiedVehicleSeat ( lp ) == 0 then
			local x2, y2, z2 = getElementPosition ( veh )
			local nd = getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) / 100
			KMDistance = KMDistance + nd
			setTimer ( getDistanceTraveled, 500, 1, veh, x2, y2, z2 )
		end
	end
end


function VehEject_func ()

	removePedFromVehicle ( lp )
end
addEvent ("VehEject", true )
addEventHandler ("VehEject", getRootElement(), VehEject_func )

function refreshVehDistance_client ()

	veh = getPedOccupiedVehicle ( lp )
	if veh then
		if getPedOccupiedVehicleSeat ( lp ) == 0 then
			if not getElementData ( veh, "distance" ) then
			else
				triggerServerEvent ( "refreshVehDistance", getRootElement(), veh, KMDistance + getElementData ( veh, "distance" ) )
				KMDistance = 0
				setTimer ( refreshVehDistance_client, 60000, 1 )
			end
		end
	end
end

addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		if isPedInVehicle(lp) then
			showSpeedometer()
		end
	end
)

function round(num)
    return math.floor(num + 0.5)
end


function getVehicleSpeed()
    if isPedInVehicle(lp) then
        local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(lp))
        return math.sqrt(vx^2 + vy^2 + vz^2) * 161 * multiply
    end
    return 0
end

function hideSpeedometer()
	removeEventHandler("onClientRender", root, renderTacho)
end

function getPedOccupiedVehicleSeat ( player )

	local veh = getPedOccupiedVehicle ( player )
	if veh then
		for i = 0, getVehicleMaxPassengers ( veh ) do
			if getVehicleOccupant ( veh, i ) == player then
				return i
			end
		end
	else
		return false
	end
end

function showSpeedometer()
	if getPedOccupiedVehicleSeat ( lp ) == 0 then
		local x1, y1, z1 = getElementPosition ( getPedOccupiedVehicle ( lp ) )
		refreshVehDistance_client ()
		getDistanceTraveled ( getPedOccupiedVehicle ( lp ), x1, y1, z1 )
		addEventHandler("onClientRender", root, renderTacho)
	end
end

function getKmhBySpeed ( speed )
	return speed/218.77
end



local function getVehicleSpeed ( vehicle )
	local vx, vy, vz = getElementVelocity ( vehicle )
	return ( math.sqrt(vx^2 + vy^2 + vz^2) * 161 * multiply ) / 218.77
end