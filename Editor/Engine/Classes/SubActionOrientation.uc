//=============================================================================
// SubActionOrientation:
//
// Changes the camera orientation.
//=============================================================================
class SubActionOrientation extends MatSubAction
	native;

var(Orientation)	Orientation		CamOrientation;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     Icon=Texture'Engine.SubActionOrientation'
     Desc="Orientation"
}
