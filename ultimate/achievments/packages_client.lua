function hidePackages_func ( package )
	setElementDimension ( package, 95 )
end
addEvent ( "hidePackages", true )
addEventHandler ( "hidePackages", root, hidePackages_func )


function hidePackagesArray_func ( array )
	for i=1, #array do 
		setElementDimension ( array[i], 95 )
	end
end
addEvent ( "hidePackagesArray", true )
addEventHandler ( "hidePackagesArray", root, hidePackagesArray_func )
