//=============================================================================
// If, when loading an object from a package, we are unable to find its
// class, MissingArch becomes its class and it shows up as a sprite of three
// exclamation points.  If the package is saved out again, the object
// will not be saved with it (as MissingArch is transient) so be very careful!
//=============================================================================
class MissingArch extends Actor
	placeable
	transient
	native;

#exec Texture Import File=Textures\S_Exclamation.pcx  Name=S_Exclamation Mips=Off Flags=2

// Used to have bStatic=false, not sure which of the new elements it wanted, set them all
// except bNotMoveableRender & bNotMoveablePhysics, since that used to be explicitly set

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Texture=Texture'Engine.S_Exclamation'
     CollisionRadius=24.000000
     CollisionHeight=24.000000
     bHidden=True
     bNoDelete=True
     bNotTickable=False
     bNotMoveableRender=True
     bNotSpawnable=False
     bNotMoveablePhysics=True
}
