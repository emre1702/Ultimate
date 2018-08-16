spawnBoats = { [454]=true, [484]=true }

function RemoteSpawnPlayer ( player )

	if isElement ( player ) then
		local pname = getPlayerName ( player )
		toggleAllControls ( player, true )
		setPlayerHudComponentVisible ( player, "radar", true )
		if vioGetElementData ( player, "spawnpos_x" ) == "wohnmobil" then
			local spawned = false
			for i = 1, vioGetElementData ( player, "maxcars" ) do
				local veh = allPrivateCars[pname][i]
				if veh then
					local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=? AND ??=?", "Typ", "vehicles", "UID", playerUID[pname], "Slot", i ), -1 )
					if result and result[1] then
						local model = tonumber ( result[1]["Typ"] )
						if model == 508 then
							sx, sy, sz = getElementPosition ( veh )
							savespawn ( player, sx+4, sy+4, sz, 0, 0, 0 )
							spawned = true
							break
						end
					end
				end
			end
			if not spawned then
				savespawn ( player, -2458.288085, 774.354492, 35.171875, 0, 0, 0 )
			end
		elseif tonumber ( vioGetElementData ( player, "spawnpos_x" ) ) then
			vioSetElementData ( player, "spawnpos_x", tonumber(vioGetElementData ( player, "spawnpos_x" )) )
			vioSetElementData ( player, "spawnpos_y", tonumber(vioGetElementData ( player, "spawnpos_y" )) )
			savespawn ( player, 0, 0, 0, 0, 0, 0 )
			local sx, sy, sz = vioGetElementData ( player, "spawnpos_x" ), vioGetElementData ( player, "spawnpos_y" ),vioGetElementData ( player, "spawnpos_z" )
			setElementPosition ( player, sx, sy, sz )
			setElementInterior ( player, vioGetElementData ( player, "spawnint" ) )
			setElementDimension ( player, vioGetElementData ( player, "spawndim" ) )
			if not isKeyBound ( player, "F2", "down", house_func ) then
				bindKey ( player, "F2", "down", house_func )
			end
		else
			local spawned = false
			if vioGetElementData ( player, "maxcars" ) then
				for i = 1, vioGetElementData ( player, "maxcars" ) do
					local veh = allPrivateCars[pname][i]
					if veh then
						local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=? AND ??=?", "Typ", "vehicles", "UID", playerUID[pname], "Slot", i ), -1 )
						if result and result[1] then
							local model = tonumber ( result[1]["Typ"] )
							if model then
								if spawnBoats[model] then
									sx, sy, sz = getElementPosition ( veh )
									savespawn ( player, sx, sy, sz+3.8, 0, 0, 0 )
									spawned = true
									break
								end
							end
						end
					end
				end
				if not spawned then
					savespawn ( player, -2458.288085, 774.354492, 35.171875, 0, 0, 0 )
				end
			end
		end
		setElementModel ( player, vioGetElementData ( player, "skinid") )
		if isArmy ( player ) then
			armyClassSpawn ( player )
		end
		fadeCamera ( player, true )
		setCameraTarget( player, player )
		setPlayerWantedLevel ( player, tonumber(vioGetElementData ( player, "wanteds")) )
		if tonumber(vioGetElementData ( player, "jailtime" )) >= 1 or vioGetElementData ( player, "prison" ) >= 1 then
			putPlayerInJail ( player )
		end
		if tonumber ( vioGetElementData ( player, "heaventime" ) ) >= 1 then
			endfade ( player, tonumber ( vioGetElementData ( player, "heaventime" ) ) )
			setElementInterior ( player, 0 )
			setElementDimension ( player, 1 )
		end
	end
	triggerClientEvent ( player, "camfix", player )
	--triggerClientEvent ( player, "showInfoText", getRootElement() )
end

function savespawn ( player, x, y, z, rx, ry, rz, highNoon )

	if highNoon then
		setElementDimension ( player, 0 )
	end
	spawnPlayer ( player, x, y, z, rz )
	setElementHealth ( player, 100 )
	setElementModel ( player, vioGetElementData ( player, "skinid") )
	fadeCamera ( player, true )
	setCameraTarget( player, player )
	if tonumber ( vioGetElementData ( player, "fraktion" ) ) == 5 then
		local gun1 = 43
		local ammo1 = 20000
		giveWeapon ( player, gun1, ammo1, true )
		giveWeapon ( player, gun1, ammo1, true )
		giveWeapon ( player, gun1, ammo1, true )
	end
	if isEvil ( player ) then
		setPedArmor ( player, 100 )
	end
	setPlayerWantedLevel ( player, vioGetElementData ( player, "wanteds" ) )
end