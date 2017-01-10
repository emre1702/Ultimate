function CriarJanela() -- Create all windows necessary to suspension
	-- Create the window for the CTRL HOLD suspension controller
	janela_ctrl = guiCreateWindow(639, 448, 151, 120, "Ultimate-Rl", false)
	guiWindowSetSizable(janela_ctrl, false)
	guiSetAlpha(janela_ctrl, 0.50)
	SuspensionUp = guiCreateButton(12, 44, 122, 26, "˄", false, janela_ctrl)
	SuspensionDown = guiCreateButton(12, 76, 122, 23, "˅", false, janela_ctrl)
	TxtHoldCtrl = guiCreateLabel(12, 19, 127, 15, "", false, janela_ctrl)    
	guiSetVisible ( janela_ctrl, false ) -- Set hold ctrl visible
 end


function EscondeMostra()
	 
	if (guiGetVisible(janela_ctrl) == false) then -- Check if the GUI are visible	
		guiSetVisible(janela_ctrl, true)				  
		bindKey("mouse_wheel_up", "down", Levanta) 
		bindKey("mouse_wheel_down", "down", Desce)
		bindKey("num_add", "down", Levanta) 
		bindKey("num_sub", "down", Desce)
		-- Falls es während der Fahrt nicht gehen soll -- 
		--[[if(movewith == "false") then
			bindKey("w", "down", EscondeJanela)
			bindKey("s", "down", EscondeJanela)
		end]]
	else
		EscondeJanela()
	end
end
			
function EscondeJanela() -- This function hide the GUI and unbind all the keys that i've pass before		
    guiSetVisible(janela_ctrl, false)		
    unbindKey("mouse_wheel_up", "down", Levanta) 
	unbindKey("mouse_wheel_down", "down", Desce)
	unbindKey("num_add", "down", Levanta) 
	unbindKey("num_sub", "down", Desce)
			
	-- Falls es während der Fahrt nicht gehen soll --
	--[[if(movewith == "true") then
		unbindKey("w", "down", EscondeJanela)
		unbindKey("s", "down", EscondeJanela)
	end]]
end
addEventHandler( "onClientPlayerVehicleExit", getLocalPlayer(), EscondeJanela  )

			
function onGuiClick ()
    if (source == SuspensionUp) then
        triggerServerEvent("subir", getLocalPlayer())
    elseif (source == SuspensionDown) then
        triggerServerEvent("descer", getLocalPlayer())
    end
end
addEventHandler("onClientGUIClick",root,onGuiClick)	  
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource( ) ), CriarJanela )
