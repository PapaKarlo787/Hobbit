//=============================================================================
// Texture: An Unreal texture map.
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class Texture extends Bitmap
	safereplace
	native
	noexport;

// Subtextures.
var(Texture) texture BumpMap;		// Bump map to illuminate this texture with.
var(Texture) texture DetailTexture;	// Detail texture to apply.
var(Texture) texture MacroTexture;	// Macrotexture to apply, not currently used.
var(Texture) texture EnvironmentMap;// Environment map for this texture

// Surface properties.
var(Texture) enum EEnvMapTransformType 
{
	EMTT_ViewSpace,
	EMTT_WorldSpace,
	EMTT_LightSpace,
} EnvMapTransformType;
var(Texture) enum ETexClampMode
{
	TC_Wrap,
	TC_Clamp,
} UClampMode, VClampMode;

var(Texture) float Diffuse;			// Diffuse lighting coefficient.
var(Texture) float Specular;		// Specular lighting coefficient.
var(Texture) float Alpha;			// Alpha.
var(Texture) float DrawScale;       // Scaling relative to parent.
var(Texture) float Friction;		// Surface friction coefficient, 1.0=none, 0.95=some.
var(Texture) float MipMult;         // Mipmap multiplier.

// Surface flags. !!out of date
var          bool bInvisible;
var(Surface) editconst bool bMasked;
var(Surface) bool bTransparent;
var          bool bNotSolid;
var(Surface) bool bEnvironment;
var          bool bSemisolid;
var(Surface) bool bModulate;
var(Surface) bool bFakeBackdrop;
var(Surface) bool bTwoSided;
var(Surface) bool bAutoUPan;
var(Surface) bool bAutoVPan;
var(Surface) bool bNoSmooth;
var(Surface) bool bAlphaTexture;
var(Surface) bool bSmallWavy;
var(Surface) bool bWaterWavy;
var			 bool bUseDiffuseAlpha;
var          bool bNoMerge;
var(Surface) bool bCloudWavy;
var          bool bDirtyShadows;
var          bool bHighLedge;
var          bool bSpecialLit;
var          bool bGouraud;
var(Surface) bool bUnlit;
var          bool bHighShadowDetail;
var          bool bPortal;
var          const bool bMirrored, bX2, bX3;
var          const bool bX4, bX5, bX6, bX7;

// Texture flags.
var(Quality) private  bool bHighColorQuality;   // High color quality hint.
var(Quality) private  bool bHighTextureQuality; // High color quality hint.
var(T3Temp)			  bool bCanClimb;			// if this surface is climbable 
var(T3Temp)			  bool bArrowStick;			// if an arrow should stick, or bounce off this surface
var private           bool bRealtime;           // Texture changes in realtime.
var private           bool bParametric;         // Texture data need not be stored.
var private transient bool bRealtimeChanged;    // Changed since last render.
var const editconst private  bool bHasComp;		//!!OLDVER Whether a compressed version exists.

// Level of detail set.
var(Quality) enum ELODSet
{
	LODSET_None,   // No level of detail mipmap tossing.
	LODSET_World,  // World level-of-detail set.
	LODSET_Skin,   // Skin level-of-detail set.
} LODSet;

// Animation.
var(Animation) texture AnimNext;
var transient  texture AnimCurrent;
var(Animation) byte    PrimeCount;
var transient  byte    PrimeCurrent;
var(Animation) float   MinFrameRate, MaxFrameRate;
var transient  float   Accumulator;

// Mipmaps.
var private native const array<int> Mips;
var const editconst ETextureFormat CompFormat; //!!OLDVER

var transient int	RenderInterface[5];

var transient float	DiffuseColor[4];

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     Diffuse=1.000000
     Specular=1.000000
     DrawScale=1.000000
     Friction=1.000000
     MipMult=1.000000
     LODSet=LODSET_World
}
