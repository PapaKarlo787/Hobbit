//=============================================================================
// ParticleEmitter: Base class for sub- emitters.
//
// make sure to keep structs in sync in UnParticleSystem.h
//=============================================================================

class ParticleEmitter extends Object
	abstract
	native;


enum EBlendFunction
{
    BF_ZERO,
    BF_ONE,
    BF_SRCCOLOR,
    BF_INVSRCCOLOR,
    BF_SRCALPHA,
    BF_INVSRCALPHA,
    BF_DESTALPHA,
    BF_INVDESTALPHA,
    BF_DESTCOLOR,
    BF_INVDESTCOLOR,
	BF_SRCALPHASAT,
	BF_HACK
};

enum EBlendMode
{
	BM_MODULATE,
	BM_MODULATE2X,
	BM_MODULATE4X,
	BM_ADD,
	BM_ADDSIGNED,
	BM_ADDSIGNED2X,
	BM_SUBTRACT,
	BM_ADDSMOOTH,
	BM_BLENDDIFFUSEALPHA,
	BM_BLENDTEXTUREALPHA,
	BM_BLENDFACTORALPHA,
	BM_BLENDTEXTUREALPHAPM,
	BM_BLENDCURRENTALPHA,
	BM_PREMODULATE,
	BM_MODULATEALPHA_ADDCOLOR,
	BM_MODULATEINVALPHA_ADDCOLOR,
	BM_MODULATEINVCOLOR_ADDALPHA,
	BM_HACK	
};

enum EParticleDrawStyle
{
	PTDS_Regular,
	PTDS_AlphaBlend,
	PTDS_Modulated,
	PTDS_Translucent,
	PTDS_AlphaModulate,
	PTDS_Darken,
	PTDS_Brighten,
    PTDS_TextureAndVertexAlphaBlend,
    PTDS_MultiplyColorByAlphaThenAddToFrameBuffer
};

enum EParticleCoordinateSystem
{
	PTCS_Independent,
	PTCS_Relative,
	PTCS_Absolute
};

enum EParticleRotationSource
{
	PTRS_None,
	PTRS_Actor,
	PTRS_Offset,
	PTRS_Normal,
	PTRS_Bone,	
};

enum EParticleVelocityDirection
{
	PTVD_None,
	PTVD_StartPositionAndOwner,
	PTVD_OwnerAndStartPosition
};

enum EParticleStartLocationShape
{
	PTLS_Box,
	PTLS_Sphere
};

enum EParticleEffectAxis
{
	PTEA_NegativeX,
	PTEA_PositiveZ
};

struct ParticleTimeScale
{
	var () float	RelativeTime;		// always in range [0..1]
	var () float	RelativeSize;
};

struct ParticleColorScale
{
	var () float	RelativeTime;		// always in range [0..1]
	var () color	Color;
};


struct Particle
{
	var vector	Location;
	var vector	Velocity;
	var byte	Mass; //fraction of way through mass range
	var	byte	StartSize; //fraction of way through startsize range
	var byte	SpinsPerSecond; //fraction of way through spin range, but < 128 is opposite dir (so pos is 128-255)
	var byte	StartSpin; //fraction of way through startspin range
	var byte	HitCount;
	var byte	HitUpdateTime;
	var byte	Flags;
	var byte	Subdivision;
	var float	Time;
	var float	MaxLifetime;
};


var (Acceleration)	vector				Acceleration;

var (Collision)		bool				UseCollision;
var (Collision)		vector				ExtentMultiplier;
var (Collision)		rangevector			DampingFactorRange;
var (Collision)		bool				UseCollisionPlanes;
var (Collision)		bool				UseGridCollisionPlanes;
var (Collision)		array<plane>		CollisionPlanes;
var	(Collision)		bool				UseMaxCollisions;
var (Collision)		range				MaxCollisions;
var (Collision)		int					SpawnFromOtherEmitter;
var (Collision)		int					SpawnAmount;
var (Collision)		rangevector			SpawnedVelocityScaleRange;
var (Collision)		bool				UseSpawnedVelocityScale;


var (Color)			bool				UseColorScale;
var (Color)			array<ParticleColorScale> ColorScale;
var (Color)			float				ColorScaleRepeats;

var (Fading)		plane				FadeOutFactor;
var (Fading)		float				FadeOutStartTime;
var (Fading)		bool				FadeOut;
var (Fading)		plane				FadeInFactor;
var (Fading)		float				FadeInEndTime;
var (Fading)		bool				FadeIn;

var (Force)			bool				UseActorForces;

var (General)		EParticleCoordinateSystem CoordinateSystem;
var (General)		int					MaxParticles;
var (General)		bool				ResetAfterChange;
var (General)		EParticleEffectAxis EffectAxis;

var (Local)			bool				RespawnDeadParticles;
var (Local)			bool				AutoDestroy;
var (Local)			bool				AutoReset;
var (Local)			bool				disabled;
var (Local)			bool				DisableFogging;
var (Local)			range				AutoResetTimeRange;
var (Local)			string				Name;

var (Location)		vector				StartLocationOffset;
var (Location)		rangevector			StartLocationRange;
var (Location)		int					AddLocationFromOtherEmitter;
var (Location)		EParticleStartLocationShape StartLocationShape;
var (Location)		range				SphereRadiusRange;

var (Mass)			range				StartMassRange;

var (Rotation)		EParticleRotationSource	UseRotationFrom;
var (Rotation)		bool				DampRotation;
var (Rotation)		bool				SpinParticles;
var (Rotation)		rotator				RotationOffset;
var (Rotation)		float				SpinCCWorCWChance;
var (Rotation)		rangevector			SpinsPerSecondRange;
var (Rotation)		rangevector			StartSpinRange;
var (Rotation)		range				SpinDampingFactorRange;
var (Rotation)		vector				RotationNormal;

var (Size)			bool				UseSizeScale;
var (Size)			bool				UseRegularSizeScale;
var (Size)			array<ParticleTimeScale> SizeScale;
var (Size)			float				SizeScaleRepeats;
var (Size)			rangevector			StartSizeRange;
var (Size)			bool				UniformSize;

var (Spawning)		float				ParticlesPerSecond;
var (Spawning)		float				InitialParticlesPerSecond;
var (Spawning)		bool				AutomaticInitialSpawning;

var (Texture)		EParticleDrawStyle	DrawStyle;
var (Texture)		texture				Texture;
var (Texture)		int					TextureUSubdivisions;
var (Texture)		int					TextureVSubdivisions;
var (Texture)		bool				BlendBetweenSubdivisions;
var	(Texture)		bool				UseSubdivisionScale;
var (Texture)		array<float>		SubdivisionScale;
var (Texture)		int					SubdivisionStart;
var (Texture)		int					SubdivisionEnd;
var (Texture)		int					SubdivisionLoops;
var (Texture)		bool				UseRandomSubdivision;

var (Tick)			float				SecondsBeforeInactive;
var (Tick)			float				MinSquaredVelocity;

var	(Time)			range				InitialTimeRange;
var (Time)			range				LifetimeRange;
var (Time)			range				InitialDelayRange;

var (Velocity)		rangevector			StartVelocityRange;
var (Velocity)		vector				MaxAbsVelocity;
var (Velocity)		rangevector			VelocityLossRange;
var private transient bool				bUseVelocityClamping; //for this tick
var private transient bool				bUseVelocityLoss; //for this tick
var private transient vector			CurrentVelocityLoss; //for this tick

var (Velocity)		int					AddVelocityFromOtherEmitter;
var (Velocity)		EParticleVelocityDirection GetVelocityDirectionFrom;

var (Warmup)		float				WarmupTicksPerSecond;
var (Warmup)		float				RelativeWarmupTime;

var	 		transient emitter				Owner;
var					object				OuterObject; //Generally an emitter, sometimes an emitter class
var	 		bool				Initialized;
var  		bool				Inactive;
var  		float				InactiveTime;
var  		array<Particle>		Particles;
var  		int					ParticleIndex;			// index into circular list of particles
var  		int					ActiveParticles;		// currently active particles
var  		float				PPSFraction;			// used to keep track of fractional PPTick
var  		box					BoundingBox;
var  		box					LocalBoundingBox;		// bounding box in local space (for non-relative emitters, this is the same as the normal bounding box)
var (BoundingBox)   bool				bUsePrecomputedBoundingBox;     // use the precomputed bounding box instead of calculating perframe?
var (BoundingBox)   box					PrecomputedBoundingBox;

var  		vector				RealExtentMultiplier;
var	 		bool				RealDisableFogging;
var  		bool				AllParticlesDead;
var  		bool				WarmedUp;
var			bool				TickedInGame;
var	 		int					OtherIndex;
var  		float				InitialDelay;
var  		vector				GlobalOffset;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     ExtentMultiplier=(X=1.000000,Y=1.000000,Z=1.000000)
     DampingFactorRange=(X=(Min=1.000000,Max=1.000000),Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
     SpawnFromOtherEmitter=-1
     FadeOutFactor=(W=1.000000,X=1.000000,Y=1.000000,Z=1.000000)
     FadeInFactor=(W=1.000000,X=1.000000,Y=1.000000,Z=1.000000)
     MaxParticles=10
     RespawnDeadParticles=True
     AddLocationFromOtherEmitter=-1
     StartMassRange=(Min=1.000000,Max=1.000000)
     SpinCCWorCWChance=0.500000
     UseRegularSizeScale=True
     StartSizeRange=(X=(Min=100.000000,Max=100.000000),Y=(Min=100.000000,Max=100.000000),Z=(Min=100.000000,Max=100.000000))
     AutomaticInitialSpawning=True
     DrawStyle=PTDS_MultiplyColorByAlphaThenAddToFrameBuffer
     Texture=Texture'Engine.S_Emitter'
     SecondsBeforeInactive=1.000000
     LifetimeRange=(Min=4.000000,Max=4.000000)
     AddVelocityFromOtherEmitter=-1
}
