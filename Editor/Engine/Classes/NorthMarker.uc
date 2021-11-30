//=============================================================================
// NorthMarker.
//
// This is a marker that indicates north on the map.  There can be only one.
//
//=============================================================================
class NorthMarker extends NavigationPoint
	placeable
	native;

#exec Texture Import File=Textures\CompassNorth.pcx Name=CompassNorth Mips=Off Flags=2

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Texture=Texture'Engine.CompassNorth'
     bDirectional=True
}
