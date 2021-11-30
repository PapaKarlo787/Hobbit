//=============================================================================
// Emitter: An Unreal Emitter Actor.
//=============================================================================

class Emitter extends FX
	native
	placeable;

#exec Texture Import File=Textures\S_Emitter.pcx  Name=S_Emitter Mips=Off Flags=2


enum EEmitterState
{
	ES_OnWhenRendered,
	ES_CompletelyOff,
	ES_AlwaysOn
};

struct ParticleStim
{
	var() StimulusAmount	Amount		"The stimulus and amount we are applying per ping";
};

struct ParticleTransfer
{
	var bool					Inactive	"Is this particle stim active";
	var() array<ParticleStim>	Stim		"The stimulus info";
};

var float	TimeSinceRendered;

var rotator PreviousRotation; //so relative emitters can do better updates
var vector PreviousLocation;

var (Global) runtimeinstantiated(735)		EEmitterState EmitterState		"How much does emitter update when not being rendered?";
var (Stimulus) inherited(929)	ParticleTransfer ParticleStimXfr	"The stimulus you want this particle system to xfr";

enum EEmitterSpawnState
{
	EDS_NormalSpawning,
	EDS_NoNewParticles,
	EDS_NoParticles
};

var (Global) inherited(906) EEmitterSpawnState EmitterSpawnState "By default, sub emitters handle spawning.  Turning this on can get them to stop spawning or kill their particles altogether.";

var ()	export	editinline	array<ParticleEmitter>	Emitters;

var		(Global)	bool	AutoDestroy;
var		(Global)	bool	AutoReset;
var		(Global)	bool	DisableFogging;
var		(Global)	bool	bDisableZBuffer;
var					bool    bRenderedLastFrame;
var		transient	bool	ActorForcesEnabled;
var		(Global)	bool	AutoHide;
var		(Global)	rangevector	GlobalOffsetRange;
var		(Global)	range		TimeTillResetRange;

var		transient	box		BoundingBox;
var		transient	float	EmitterRadius;
var		transient	float	EmitterHeight;
var		transient	vector			GlobalOffset;
var		transient	float			TimeTillReset;

var		transient	bool	InOverlay;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     bRenderedLastFrame=True
     RenderType=(DrawType=DT_Particle,Style=STY_Particle)
     Texture=Texture'Engine.S_Emitter'
     RelevantChangeTypes=(CHANGE_Burning,CHANGE_Smoke,CHANGE_Gas)
     bDirectional=True
}
