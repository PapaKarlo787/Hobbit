//=============================================================================
// SubActionGameSpeed:
//
// Changes the game speed.
//=============================================================================
class SubActionGameSpeed extends MatSubAction
	native;

var(GameSpeed)	range	GameSpeed;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     Icon=Texture'Engine.SubActionGameSpeed'
     Desc="Game Speed"
}
