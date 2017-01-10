promptPath = "vio_stored_files/prompt/prompt.vio"
local promptFile = fileOpen ( promptPath, false )
local filesize = fileGetSize ( promptFile )
promptMainText = fileRead( promptFile, filesize )
fileClose ( promptFile )

function prompt ( player, text, time )

	triggerClientEvent ( player, "prompt", player, text, time )
end

function changePrompt ( player, cmd, ... )

	if vioGetElementData ( player, "adminlvl" ) >= 3 then
		local msg = table.concat ( arg, " " )
		
		local file = fileCreate ( promptPath )
		fileWrite ( file, msg )
		fileClose ( file )
		
		promptMainText = msg
		
		dbExec ( handler, "UPDATE ?? SET ?? = ?", "userdata", "pred", "0" )
		
		outputChatBox ( "Erfolgreich geändert!", player, 0, 200, 0 )
	end
end
addCommandHandler ( "changeprompt", changePrompt )