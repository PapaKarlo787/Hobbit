//=============================================================================
// PhysicsVolume:  a bounding volume which affects actor physics
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class PhysicsVolume extends Volume
	native
	nativereplication;

var() vector ViewFlash, ViewFog;

var()		vector		Gravity;

// Distance Fog
var(VolumeFog) bool   bDistanceFog;	// There is distance fog in this physicsvolume.
var(VolumeFog) color DistanceFogColor;
var(VolumeFog) float DistanceFogStart;
var(VolumeFog) float DistanceFogEnd;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     RenderColor=(Z=1.000000)
     RenderName="PHYSICS VOLUME"
     VolumeType=VOLUME_PHYSICS
}
