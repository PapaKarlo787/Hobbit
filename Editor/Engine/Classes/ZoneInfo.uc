//=============================================================================
// ZoneInfo, the built-in Unreal class for defining properties
// of zones.  If you place one ZoneInfo actor in a
// zone you have partioned, the ZoneInfo defines the 
// properties of the zone.
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class ZoneInfo extends Info
	native
	placeable
	nativereplication;

#exec Texture Import File=Textures\ZoneInfo.pcx Name=S_ZoneInfo Mips=Off Flags=2

//-----------------------------------------------------------------------------
// Zone properties.

var skyzoneinfo SkyZone; // Optional sky zone containing this zone's sky.
var() name   ZoneTag;

//-----------------------------------------------------------------------------
// Zone flags.

var() const bool   bFogZone;		// Zone is fog-filled.
var()		bool   bTerrainZone;	// There is terrain in this zone.
var()		bool   bDistanceFog;	// There is distance fog in this zone.

var const array<TerrainInfo> Terrains;

//-----------------------------------------------------------------------------
// Zone light.

var(ZoneLight) color AmbientColor; // not yet ready for prime time
var(ZoneLight) byte AmbientBrightness "deprecating - please use AmbientColor";
var(ZoneLight) byte AmbientHue "deprecating - please use AmbientColor";
var(ZoneLight) byte AmbientSaturation "deprecating - please use AmbientColor";

var(ZoneLight) color DistanceFogColor;
var(ZoneLight) float DistanceFogStart;
var(ZoneLight) float DistanceFogEnd;

var(ZoneLight) const texture EnvironmentMap;
var(ZoneLight) float TexUPanSpeed, TexVPanSpeed;

//-----------------------------------------------------------------------------
// Reverb.

// Settings.
var(Reverb) bool bReverbZone;
var(Reverb) bool bRaytraceReverb;
var(Reverb) float SpeedOfSound;
var(Reverb) byte MasterGain;
var(Reverb) int  CutoffHz;
var(Reverb) byte Delay[6];
var(Reverb) byte Gain[6];

//LEGEND:begin
//-----------------------------------------------------------------------------
// Lens flare.

var(LensFlare) texture LensFlare[12];
var(LensFlare) float LensFlareOffset[12];
var(LensFlare) float LensFlareScale[12];

//-----------------------------------------------------------------------------
// per-Zone mesh LOD lighting control
 
// the number of lights applied to the actor mesh is interpolated between the following
// properties, as a function of the MeshPolyCount for the previous frame.
var() byte MinLightCount; // minimum number of lights to use (when MaxLightingPolyCount is exceeded)
var() byte MaxLightCount; // maximum number of lights to use (when MeshPolyCount drops below MinLightingPolyCount)
var() int MinLightingPolyCount;
var() int MaxLightingPolyCount;
// (NOTE: the default LOD properties (below) have no effect on the mesh lighting behavior)
//LEGEND:end

//=============================================================================
// Iterator functions.

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     AmbientSaturation=255
     DistanceFogColor=(B=128,G=128,R=128)
     DistanceFogStart=3000.000000
     DistanceFogEnd=8000.000000
     TexUPanSpeed=1.000000
     TexVPanSpeed=1.000000
     SpeedOfSound=8000.000000
     MasterGain=100
     CutoffHz=6000
     Delay(0)=20
     Delay(1)=34
     Gain(0)=150
     Gain(1)=70
     MinLightCount=6
     MaxLightCount=6
     MinLightingPolyCount=1000
     MaxLightingPolyCount=5000
     Texture=Texture'Engine.S_ZoneInfo'
     bNoDelete=True
     bNotTickable=True
     bNotMoveableRender=True
     bNotSpawnable=True
     bNotMoveablePhysics=True
}
