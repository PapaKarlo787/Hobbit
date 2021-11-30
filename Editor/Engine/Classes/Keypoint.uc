//=============================================================================
// Keypoint, the base class of invisible actors which mark things.
//=============================================================================
class Keypoint extends Marker
	abstract
	placeable
	native;

// Sprite.
#exec Texture Import File=Textures\Keypoint.pcx Name=S_Keypoint Mips=Off Flags=2

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Texture=Texture'Engine.S_Keypoint'
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bHidden=True
     bNotTickable=True
     bNotMoveableRender=True
     bNotSpawnable=True
     bNotMoveablePhysics=True
}
