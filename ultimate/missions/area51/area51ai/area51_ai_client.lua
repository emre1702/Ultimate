function createPatrolBot_func(bot, cxS, cyS, czS, gun, botName, px1S, py1S, pz1S, px2S, py2S, pz2S, px3S, py3S, pz3S)
  setPedWeaponSlot(bot, 5)
  setElementDimension(bot, tonumber(vioClientGetElementData("playerid")) + 1)
  setElementPosition(bot, cxS, cyS, czS)
  _G["Bot" .. botName .. "Waypoint"] = 0
  setElementData(bot, "gun", tonumber(gun), false)
  setElementData(bot, "a51bot", true, false)
  setElementData(bot, "bothealth", 60, false)
  setElementData(bot, "isAlarmed", false, false)
  setElementData(bot, "isAiming", false, false)
  setElementData(bot, "isReEquiped", false, false)
  setElementData(bot, "name", botName, false)
  if px1S then
    setBotPatrol(bot, cxS, cyS, czS, px1S, py1S, pz1S, px2S, py2S, pz2S, px3S, py3S, pz3S, botName)
  end
end
addEvent("createPatrolBot", true)
addEventHandler("createPatrolBot", getRootElement(), createPatrolBot_func)
function createStayingBot_func(bot, cxS, cyS, czS, gun, botName, rot)
  setPedWeaponSlot(bot, 5)
  setElementDimension(bot, tonumber(vioClientGetElementData("playerid")) + 1)
  setElementPosition(bot, cxS, cyS, czS)
  setPedRotation(bot, rot)
  _G["Bot" .. botName .. "Waypoint"] = 0
  setElementData(bot, "gun", tonumber(gun), false)
  setElementData(bot, "a51bot", true, false)
  setElementData(bot, "bothealth", 60, false)
  setElementData(bot, "isAlarmed", false, false)
  setElementData(bot, "isAiming", false, false)
  setElementData(bot, "isReEquiped", false, false)
  setElementData(bot, "name", botName, false)
  setBotGuard(bot, botName)
end
addEvent("createStayingBot", true)
addEventHandler("createStayingBot", getRootElement(), createStayingBot_func)
function setBotGuard(botGuard, botGuardName)
  setTimer(checkGuardProgress, 200, 1, botGuard, botGuardName)
end
function checkGuardProgress(botGuard, botGuardName)
  if isElement ( botGuard ) then
    if isPedDead(botGuard) then
    elseif not getElementData(botGuard, "isAlarmed") and not isPlayerInBotSight(botGuard) then
      setTimer(checkGuardProgress, 200, 1, botGuard, botGuardName)
    else
      outputChatBox("Die Wache hat dich bemerkt! Schnell ausschalten!", 125, 0, 0)
      setElementData(botGuard, "isAlarmed", true, false)
      Area51BotAttackPlayer(botGuard)
    end
  end
end
function setBotPatrol(botPatrol, cxP, cyP, czP, px1P, py1P, pz1P, px2P, py2P, pz2P, px3P, py3P, pz3P, botPName)
  setBotPerfectSlowAnimation(botPatrol)
  local x1, y1, z1 = getElementPosition(botPatrol)
  setPedRotation(botPatrol, findRotation(x1, y1, px1P, py1P))
  setTimer(checkPatrolProgress, 150, 1, botPatrol, cxP, cyP, czP, px1P, py1P, pz1P, px2P, py2P, pz2P, px3P, py3P, pz3P, botPName)
end
function checkPatrolProgress(checkPatrolBot, cx, cy, cz, px1, py1, pz1, px2, py2, pz2, px3, py3, pz3, checkPatrolBotName)
  if isPedDead(checkPatrolBot) then
  elseif not getElementData(checkPatrolBot, "isAlarmed") and not isPlayerInBotSight(checkPatrolBot) then
    do
      local x, y, z = getElementPosition(checkPatrolBot)
      if _G["Bot" .. checkPatrolBotName .. "Waypoint"] == 0 then
        cx1, cy1, cz1 = px1, py1, pz1
        setPedRotation(checkPatrolBot, findRotation(x, y, cx1, cy1))
        setBotPerfectSlowAnimation(checkPatrolBot)
      elseif _G["Bot" .. checkPatrolBotName .. "Waypoint"] == 1 then
        cx1, cy1, cz1 = px2, py2, pz2
        setPedRotation(checkPatrolBot, findRotation(x, y, cx1, cy1))
        setBotPerfectSlowAnimation(checkPatrolBot)
      elseif _G["Bot" .. checkPatrolBotName .. "Waypoint"] == 2 then
        cx1, cy1, cz1 = px3, py3, pz3
        setPedRotation(checkPatrolBot, findRotation(x, y, cx1, cy1))
        setBotPerfectSlowAnimation(checkPatrolBot)
      elseif _G["Bot" .. checkPatrolBotName .. "Waypoint"] == 3 then
        cx1, cy1, cz1 = cx, cy, cz
        setPedRotation(checkPatrolBot, findRotation(x, y, cx1, cy1))
        setBotPerfectSlowAnimation(checkPatrolBot)
      end
      local distance = getDistanceBetweenPoints3D(x, y, 0, cx1, cy1, 0)
      if distance < 1 then
        if _G["Bot" .. checkPatrolBotName .. "Waypoint"] == 0 then
          _G["Bot" .. checkPatrolBotName .. "Waypoint"] = 1
          setPedRotation(checkPatrolBot, findRotation(x, y, cx1, cy1))
        elseif _G["Bot" .. checkPatrolBotName .. "Waypoint"] == 1 then
          _G["Bot" .. checkPatrolBotName .. "Waypoint"] = 2
          setPedRotation(checkPatrolBot, findRotation(x, y, cx1, cy1))
        elseif _G["Bot" .. checkPatrolBotName .. "Waypoint"] == 2 then
          _G["Bot" .. checkPatrolBotName .. "Waypoint"] = 3
          setPedRotation(checkPatrolBot, findRotation(x, y, cx1, cy1))
        elseif _G["Bot" .. checkPatrolBotName .. "Waypoint"] == 3 then
          _G["Bot" .. checkPatrolBotName .. "Waypoint"] = 0
          setPedRotation(checkPatrolBot, findRotation(x, y, cx1, cy1))
        end
      end
      setTimer(checkPatrolProgress, 150, 1, checkPatrolBot, cx, cy, cz, px1, py1, pz1, px2, py2, pz2, px3, py3, pz3, checkPatrolBotName)
    end
  else
    outputChatBox("Die Wache hat dich bemerkt! Schnell, schalte ihn aus!", 125, 0, 0)
    setElementData(checkPatrolBot, "isAlarmed", true, false)
    Area51BotAttackPlayer(checkPatrolBot)
  end
end
function Area51BotAttackPlayer(AttackBot)
  setPedWeaponSlot(AttackBot, 0)
  setPedWeaponSlot(AttackBot, 5)
  letBotAim(getLocalPlayer(), AttackBot)
end
function letBotAim(attackVictim, AimBot)
  triggerServerEvent("equipBotAgain", getRootElement(), AimBot, getLocalPlayer())
  setPedControlState(AimBot, "aim_weapon", true)
  setPedControlState(AimBot, "fire", true)
  setElementData(AimBot, "isAiming", true, false)
  setPedAimTarget(AimBot, getElementPosition(attackVictim))
  setPedAnimation(AimBot, "ped", "RIFLE_fire")
  setTimer(refreshA51AimPoint, 100, 1, AimBot, attackVictim)
end
function refreshA51AimPoint(RefreshBot, target)
  if getElementData(RefreshBot, "isAiming") and not isPedDead(RefreshBot) then
    do
      local x1, y1, z1 = getElementPosition(RefreshBot)
      local x2, y2, z2 = getElementPosition(target)
      local hit, x, y, z, element = processLineOfSight(x1, y1, z1, x2, y2, z2, true, false, false, true, false)
      if not hit then
        setPedControlState(RefreshBot, "fire", true)
        setPedAimTarget(RefreshBot, x2, y2, z2)
        setPedRotation(RefreshBot, math.abs(findRotation(x2, y2, x1, y1) - 180))
        if getElementData(RefreshBot, "isReEquiped") == false then
          triggerServerEvent("equipBotAgain", getRootElement(), RefreshBot, getLocalPlayer())
          setElementData(RefreshBot, "isReEquiped", true, false)
        end
      else
        setPedControlState(RefreshBot, "fire", false)
      end
      setTimer(refreshA51AimPoint, 100, 1, RefreshBot, target)
    end
  else
    setPedControlState(RefreshBot, "aim_weapon", false)
    setPedControlState(RefreshBot, "fire", false)
  end
end