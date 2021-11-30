//=============================================================================
// Waypoint.
// Used in automatic interpolator
//=============================================================================
class Waypoint extends Keypoint
	native;

#exec Texture Import File=Textures\IntrpPnt.pcx Name=S_Interp Mips=Off MASKED=1

var() float PauseTime;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Texture=Texture'Engine.S_Interp'
}
