class ShallowWaterVolume extends Volume
	native
	nativereplication;

var(Water) runtimeinstantiated(2030)	float	SurfaceHeight	"This the height of the water's surface relative to the volume (surface Z - volume location Z).";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     SurfaceHeight=0.000000
     LocationName="in shallow water"
     RenderColor=(X=2.000000,Y=0.200000,Z=0.700000)
     RenderName="SHALLOW WATER VOLUME"
     VolumeType=VOLUME_SHALLOW_WATER
     CollisionFlags=()
}
