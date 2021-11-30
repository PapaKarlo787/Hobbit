//=============================================================================
// LookTarget
//
// A convenience actor that you can point a matinee camera at.
//
//
// Isn't static(notmoveable/tickable/spawnable) so that you can attach it to movers, etc.
// 
//=============================================================================
class LookTarget extends KeyPoint
	placeable
	native;

// Sprite.
#exec Texture Import File=Textures\LookTarget.pcx Name=S_LookTarget Mips=Off MASKED=1

// Used to have bStatic=false, not sure which of the new elements it wanted, set them all.

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Texture=Texture'Engine.S_LookTarget'
     bHidden=True
     bNotTickable=False
     bNotMoveableRender=False
     bNotSpawnable=False
     bNotMoveablePhysics=False
}
