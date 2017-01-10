testmode = false
winterzeit = 0
maxplayers = 100
wctime = 20
speznr = { [110]=true, [112]=true, [300]=true, [400]=true } -- 110=Polize, 112=Sanitäter, 300=Mechaniker, 400=Taxi
tramSpeed = 0.35
aktionpuffer = 3*60*1000
healafterdmgtime = 3*60*1000

-- Cars
destcardim = 1
noobbikerespawn = 5
FCarIdleRespawn = 10
FCarDestroyRespawn = 0.1
noobrollerrespawntime = 5
noobrolleridlerespawntime = 600

-- Preise
nitroprice = 50
tuningpartprice = 75

paynsprayprice = 25
wantedprice = 200
wantedkillmoney = 100
wantedarrestmoney = 300
jailtimeperwanted = 5
hospitalcosts = 30
autosteuerprice = 30
autosteuererh = 1.5
drugprice = 30
smsprice = 1
callprice = 2
adcosts = 3
adbasiscosts = 10
pm_price = 250
waffenscheinprice = 8000
weaponsTruckCost = 5000


zinssatz = 0.15

-- Essen
salatprice = 15
smallpizzaprice = 15
normalpizzaprice = 40
bigpizzaprice = 50
salatheal = 25
smallpizzaheal = 15
normalpizzaheal = 35
bigpizzaheal = 50

-- SFPD

copcars = { [598]=true, [596]=true, [597]=true }
copbikes = { [523]=true }
copjeeps = { [599]=true }
cophelis = { [497]=true }
copvehs = { [598]=true, [596]=true, [597]=true, [523]=true, [599]=true, [497]=true }

validResources = { ["realdriveby"]=true, ["parachute"]=true, ["vio"]=true }
stopBadScripts = false

timeTillWeaponTruckDisappears = 20 * 60 * 1000
timeTillDrogentruckDisappears = 20 * 60 * 1000

--[[function resourceStart ( resource )

	if not validResources [ getResourceName ( resource ) ] then
		if stopBadScripts then
			cancelEvent()
		end
	end
end
addEventHandler ( "onResourcePreStart", getRootElement(), resourceStart )]]