//=============================================================================
// A generic marker denoting a place in the world.  
// Use this when you want to spawn a plain actor that does not render. - alc
//=============================================================================
class InvisibleMarker extends Keypoint;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     bNotTickable=True
     bNotMoveableRender=True
     bNotSpawnable=False
     bNotMoveablePhysics=True
}
