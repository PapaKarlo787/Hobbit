class AmbientLightVolume extends Volume
	native
	nativereplication;

//TAJ: If you change these structs, must fix AAmbientLightVolume.h version
struct LightColorStructl
{
	var() int LightBrightness;
	var() int LightHue;
	var() int LightSaturation;
};

var(Lighting) inherited(739) LightColorStructl LightColorl;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     LightColorl=(LightBrightness=255)
     LocationName="in local ambient light zone"
     RenderColor=(Y=0.900000,Z=0.900000)
     RenderName="AMBIENT LIGHT VOLUME"
     VolumeType=VOLUME_AMBIENT_LIGHT
     LightColor=(LightBrightness=255)
     LightKind=(LightEffect=LE_Ambient,LightType=LT_Steady)
     CollisionFlags=()
}
