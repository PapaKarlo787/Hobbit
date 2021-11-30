//=============================================================================
// DefaultPhysicsVolume:  the default physics volume for areas of the level with 
// no physics volume specified
//=============================================================================
class DefaultPhysicsVolume extends PhysicsVolume
	native;

// Used to have bStatic=false, not sure which of the new elements it wanted, set them all.

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     bNoDelete=False
     bNotTickable=False
     bNotMoveableRender=False
     bNotSpawnable=False
     bNotMoveablePhysics=False
}
