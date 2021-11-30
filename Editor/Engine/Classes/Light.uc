//=============================================================================
// The light class.
//=============================================================================
class Light extends Actor
	placeable
	native;

#exec Texture Import File=Textures\S_Light.pcx  Name=S_Light Mips=Off Flags=2
#exec Texture Import File=Textures\At_Light.pcx  Name=At_Light Mips=Off Flags=2

var (Lighting) vector		CoronaSize;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     LightColor=(LightBrightness=255)
     VolumeProperties=(VolumeBrightness=64)
     LightShape=(LightRadius=64,LightPeriod=32,LightCone=64)
     DirectionalLightShape=()
     ProjectedLightShape=()
     FLLightTexture=()
     Texture=Texture'Engine.S_Light'
     CollisionRadius=24.000000
     CollisionHeight=24.000000
     bHidden=False
     bNoDelete=True
     bNotTickable=True
     bNotMoveableRender=True
     bNotSpawnable=True
     bNotMoveablePhysics=True
     FleshLightType=FL_Omni
}
