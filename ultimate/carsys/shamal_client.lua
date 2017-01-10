function shamal_client_int ( button, press )

    if ( button == "g" ) and ( press ) then
	
        triggerServerEvent ( "onEnterAnShamal", localPlayer, localPlayer )
		
    end
	
end

addEventHandler( "onClientKey", root, shamal_client_int )