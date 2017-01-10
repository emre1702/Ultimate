function setPlayerOutOfArea51 ( player )

	if player then
		setCameraTarget ( player, player )
		fadeCamera ( player, true, 1 )
		setElementDimension ( player, 0 )
		local pname = getPlayerName ( player )
		vioSetElementData ( player, "isInArea51Mission", false )
		takeAllWeapons ( player )
		removeArea51Bots ( pname )
		local curw, nextw = getWeather()
		local curh, curmin = getTime ()
		triggerClientEvent ( player, "setClientSettingsBackToNormal", player, curw, nextw, curh, curmin )
	end
end
function removeArea51Bots ( pname )

	destroyElement ( _G[pname.."greenGoo"] )
	destroyElement ( _G[pname.."area51JetPlate"] )
	destroyElement ( _G[pname.."'sarmyBotA"] )
	destroyElement ( _G[pname.."'sarmyBotB"] )
	destroyElement ( _G[pname.."'sarmyBotC"] )
	destroyElement ( _G[pname.."'sarmyBotD"] )
	destroyElement ( _G[pname.."'sarmyBotE"] )
	destroyElement ( _G[pname.."'sarmyBotF"] )
	destroyElement ( _G[pname.."'sarmyBotG"] )
	destroyElement ( _G[pname.."'sarmyBotH"] )
	destroyElement ( _G[pname.."'sarmyBotI"] )
	destroyElement ( _G[pname.."'sarmyBotJ"] )
	destroyElement ( _G[pname.."'sarmyBotK"] )
	destroyElement ( _G[pname.."'sarmyBotL"] )
end

function greenGooHit ( player )

	local pname = getPlayerName ( player )
	if source == _G[pname.."greenGoo"] then
		fadeCamera ( player, false, 1, 0, 0, 0 )
		setTimer ( greenGooFadeIn, 1000, 1, player )
	end
end
function greenGooFadeIn ( player )
	if player then
		fadeCamera ( player, true, 1 )
		setElementDimension ( player, 1 )
		setCameraMatrix ( player, 48.466278076172, 2233.8425292969, 202.50161743164, 43.62, 2231.54, 228.6 )
		setTimer ( greenGooFadeOut, 7000, 1, player )
		if vioGetElementData ( player, "thetruthisoutthere_achiev" ) ~= "done" then
			vioSetElementData ( player, "thetruthisoutthere_achiev", "done" )
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 10000 )
			playSoundFrontEnd ( player, 40 )
			triggerClientEvent ( player, "showAchievmentBox", player, " The Truth is\n out there!", 15, 10000 )
			
			dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "achievments", "TheTruthIsOutThere", "done", "UID", playerUID[getPlayerName(player)] )
			
			vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 15 )
			outputChatBox ( "Da du diese Mission geschafft hast, erhälst du 10.000$!", player, 0, 125, 0 )
		elseif vioGetElementData ( player, "silentassasin_achiev" ) ~= "done" and tonumber ( vioGetElementData ( player, "alerts" ) ) == 0 then
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 20000 )
			vioSetElementData ( player, "silentassasin_achiev", "done" )
			triggerClientEvent ( player, "showAchievmentBox", player, " Silent\n Assasin", 25, 30000 )
			
			dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "achievments", "SilentAssasin", "done", "UID", playerUID[getPlayerName(player)] )
			
			vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 25 )
			outputChatBox ( "Da du diese Mission perfekt geschafft hast, erhälst du 20.000$!", player, 0, 125, 0 )
		else
			triggerClientEvent ( player, "achievsound", player )
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 500 )
			outputChatBox ( "Da du diese Mission bereits geschafft hast, erhälst du 500$ Belohnung!", player, 0, 125, 0 )
		end
		triggerClientEvent ( player, "createMissionSolvedText", getRootElement() )
	end
end
function greenGooFadeOut ( player )
	if player then
		fadeCamera ( player, false, 1, 0, 0, 0 )
		setTimer ( setPlayerOutOfArea51, 1000, 1, player )
		setElementPosition ( player, -1986.0279541016, 138.32154846191, 27.33 )
	end
end

function dimensionFixArea51_func ( player )
	
	if player == client then
		setElementDimension ( player, tonumber ( vioGetElementData ( player, "playerid" ) ) + 1 )
		startArea51Mission ( player )
	end
end
addEvent ( "dimensionFixArea51", true )
addEventHandler ( "dimensionFixArea51", getRootElement(), dimensionFixArea51_func )

function startArea51Mission ( player )

	setPedArmor ( player, 0 )
	setElementHealth ( player, 100 )
	setElementHunger ( player, 100 )
	vioSetElementData ( player, "isInArea51Mission", true )
	vioSetElementData ( player, "alerts", 0 )
	matchinDim = tonumber ( vioGetElementData ( player, "playerid" ) ) + 1
	createPatrolBot ( player, 109.70455169678, 1934.6207275391, 18.336933135986, 30, "armyBotA", 109.49381256104, 1915.2282714844, 18.078744888306, 109.49381256104, 1900.2282714844, 18.078744888306, 109.49381256104, 1896.2282714844, 18.078744888306 )
	createArea51PatrolBot2 ( player )
	createArea51PatrolBot3 ( player )
	createArea51PatrolBot4 ( player )
	createArea51PatrolBot5 ( player )
	createArea51PatrolBot6 ( player )
	createArea51PatrolBot7 ( player )
	createStayingBot ( player, 217.36338806152, 1876.5539550781, 12.7, 31, "armyBotG", 0 )
	createStayingBot ( player, 210.34010314941, 1876.4041748047, 12.7, 31, "armyBotH", 0 )
	createStayingBot ( player, 158.85374450684, 1929.640625, 20.016412734985, 31, "armyBotI", 180 )
	createStayingBot ( player, 263.70938110352, 1891.7360839844, 27.49, 31, "armyBotJ", 145 )
	createStayingBot ( player, 225.7463684082, 1859.2065429688, 12.796184539795, 31, "armyBotK", 90 )
	createStayingBot ( player, 267.30288696289, 1817.2218017578, 5.3523507118225, 31, "armyBotL", 180 ) -- 14 -> 17
	takeAllWeapons ( player )
	local weapon = 23
	local ammo = 85
	giveWeapon ( player, weapon, ammo, false )
	local weapon = 4
	local ammo = 1
	giveWeapon ( player, weapon, ammo, false )
	local weapon = 45
	local ammo = 1
	giveWeapon ( player, weapon, ammo, false )
	setElementDimension ( player, matchinDim )
	local pname = getPlayerName ( player )
	_G[pname.."greenGoo"] = createPickup ( 268.71075439453, 1883.5866699219, -30.48, 3, 2976, 9999999 )
	_G[pname.."area51JetPlate"] = createObject ( 3095, 268.97, 1883.9, 16.07 )
	addEventHandler ( "onPickupHit", _G[pname.."greenGoo"], greenGooHit )
	setElementDimension ( _G[pname.."greenGoo"], matchinDim )
	setElementDimension ( _G[pname.."area51JetPlate"], matchinDim )
	triggerClientEvent ( player, "Area51SettingsClient", getRootElement() )
end

function createArea51PatrolBot2 ( player )

	createPatrolBot ( player, 
	151.95083618164, 1861.3603515625, 17.316484451294, 30, "armyBotB", 
	152.22256469727, 1870.1881103516, 18.141916275024, 
	152.22256469727, 1880.1881103516, 18.141916275024, 
	152.22256469727, 1896.1881103516, 18.141916275024 )
end
function createArea51PatrolBot3 ( player )

	createPatrolBot ( player, 
	218.30274963379, 1870.5343017578, 17.289850234985, 30, "armyBotC", 
	209.28860473633, 1870.5324707031, 17.289850234985, 
	205.28732299805, 1902.353515625, 17.289850234985, 
	222.32057189941, 1902.0520019531, 17.289850234985 )
end
function createArea51PatrolBot4 ( player )

	createPatrolBot ( player, 
	299.4826965332, 1858.6744384766, 7.4144887924194, 30, "armyBotD", 
	299.56591796875, 1852.4049072266, 7.4144887924194, 
	299.56591796875, 1858.6749072266, 7.4144887924194, 
	299.56591796875, 1852.4049072266, 7.4144887924194 )
end
function createArea51PatrolBot5 ( player )

	createPatrolBot ( player, 
	298.42486572266, 1823.9669189453, 7.4773507118225, 30, "armyBotE", 
	277.49459838867, 1823.9656982422, 7.4773507118225, 
	277.49459838867, 1838.9656982422, 7.4773507118225, 
	298.42486572266, 1838.9656982422, 7.4773507118225 )
end
function createArea51PatrolBot6 ( player )

	createPatrolBot ( player, 
	262.9377746582, 1878.2269287109, -6.3507742881775, 30, "armyBotF", 
	262.9377746582, 1882.2269287109, -6.3507742881775,
	262.95974731445, 1887.6384277344, -11.046087265015,
	262.95974731445, 1889.6384277344, -11.046087265015 )
end
function createArea51PatrolBot7 ( player )

	createPatrolBot ( player, 
	257.5100402832, 1866.5538330078, 8.4070377349854, 30, "armyBotG", 
	248.56788635254, 1867.0233154297, 8.4070377349854,
	257.5100402832, 1867.0233154297, 8.4070377349854,
	248.56788635254, 1867.0233154297, 8.4070377349854 )
end

function equipBotAgain_func ( bot, player )

	if player == client then
		giveWeapon ( bot, 31, 9999, true )
		vioSetElementData ( player, "alerts", 1 )
	end
end
addEvent( "equipBotAgain", true )
addEventHandler( "equipBotAgain", getRootElement(), equipBotAgain_func )

function createPatrolBot ( player, sx, sy, sz, gun, botname, px1, py1, pz1, px2, py2, pz2, px3, py3, pz3 )

	local pname = getPlayerName ( player )
	_G[pname.."'s"..botname] = createPed ( 287, 0, 0, 0 )
	setElementDimension ( _G[pname.."'s"..botname], 1 )
	giveWeapon ( _G[pname.."'s"..botname], 31, 9000, false )
	setWeaponAmmo ( _G[pname.."'s"..botname], 31, 9999, 0 )
	triggerClientEvent ( player, "createPatrolBot", getRootElement(), _G[pname.."'s"..botname], sx, sy, sz, gun, botname, px1, py1, pz1, px2, py2, pz2, px3, py3, pz3 )
end

function createStayingBot ( player, cxS, cyS, czS, gun, botname, rot )

	local pname = getPlayerName ( player )
	_G[pname.."'s"..botname] = createPed ( 287, 0, 0, 0, rot )
	setElementDimension ( _G[pname.."'s"..botname], 1 )
	giveWeapon ( _G[pname.."'s"..botname], 31, 9000, false )
	setWeaponAmmo ( _G[pname.."'s"..botname], 31, 9999, 0 )
	triggerClientEvent ( player, "createStayingBot", getRootElement(), _G[pname.."'s"..botname], cxS, cyS, czS, gun, botname, rot )
end

function killPed_func ( bot )

	if vioGetElementData ( client, "isInArea51Mission" ) then
		killPed ( bot )
	end
end
addEvent( "killPed", true )
addEventHandler( "killPed", getRootElement(), killPed_func )