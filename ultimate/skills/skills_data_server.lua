function skillDataLoad ( player )

	local pname = getPlayerName ( player )
	setFishingValues ( player )
	local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "fishing", "gamble", "skills", "UID", playerUID[pname] ), -1 )
	if result and result[1] then
		vioSetElementData ( player, "fishingSkill", tonumber ( result[1]["fishing"] ) )
		vioSetElementData ( player, "fishingSkillOld", vioGetElementData ( player, "fishingSkill" ) )
		vioSetElementData ( player, "gambleSkill", tonumber ( result[1]["gamble"] ) )
	end
end

function skillDataSave ( player )

	local pname = getPlayerName ( player )
	if vioGetElementData ( player, "fishingSkill" ) > vioGetElementData ( player, "fishingSkillOld" ) then
		dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "skills", "fishing", vioGetElementData ( player, "fishingSkill" ), "UID", playerUID[pname] )
	end
	saveFishingValues ( player )
	dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "skills", "gamble", vioGetElementData ( player, "gambleSkill" ), "UID", playerUID[pname] )
end