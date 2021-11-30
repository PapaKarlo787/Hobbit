//=============================================================================
// SubActionFOV:
//
// Changes the viewers FOV
//=============================================================================
class SubActionFOV extends MatSubAction
	native;

var(FOV)	range		FOV;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     Icon=Texture'Engine.SubActionFOV'
     Desc="FOV"
}
