//=============================================================================
// SceneManager
//
// Manages a matinee scene.  Contains a list of action items that will
// be played out in order.
//=============================================================================
class SceneManager extends Info
	placeable
	native;

#exec Texture Import File=Textures\SceneManager.pcx  Name=S_SceneManager Mips=Off

// Graphics for UI
#exec Texture Import File=Textures\S_MatineeIP.pcx Name=S_MatineeIP Mips=Off MASKED=1
#exec Texture Import File=Textures\S_MatineeIPSel.pcx Name=S_MatineeIPSel Mips=Off MASKED=1
#exec Texture Import File=Textures\S_MatineeTimeMarker.pcx Name=S_MatineeTimeMarker Mips=Off MASKED=1
#exec Texture Import File=Textures\ActionCamMove.pcx  Name=S_ActionCamMove Mips=Off
#exec Texture Import File=Textures\ActionCamPause.pcx  Name=S_ActionCamPause Mips=Off
#exec Texture Import File=Textures\PathLinear.pcx  Name=S_PathLinear Mips=Off MASKED=1
#exec Texture Import File=Textures\PathBezier.pcx  Name=S_PathBezier Mips=Off MASKED=1
#exec Texture Import File=Textures\S_BezierHandle.pcx  Name=S_BezierHandle Mips=Off MASKED=1
#exec Texture Import File=Textures\SubActionIndicator.pcx  Name=SubActionIndicator Mips=Off MASKED=1

struct noexport Orientation
{
	var() ECamOrientation	CamOrientation;
	var() actor LookAt;
	var() float EaseIntime;
	var() int bReversePitch;
	var() int bReverseYaw;
	var() int bReverseRoll;

	var int MA;
	var float PctInStart, PctInEnd, PctInDuration;
	var rotator StartingRotation;
};

// Exposed vars
var()	export	editinline	array<MatAction>	Actions;
var()	config	enum EAffect
{
	AFFECT_ViewportCamera,
	AFFECT_Actor,
} Affect;
var()	Actor	AffectedActor;			// The name of the actor which will follow the matinee path (if Affect==AFFECT_Actor)
var()	bool	bLooping;				// If this is TRUE, the path will looping endlessly
var()	bool	bCinematicView;			// Should the screen go into letterbox mode when playing this scene?

// These vars are set by the SceneManager in it's Tick function.  Don't mess with them directly.
var		transient float PctSceneComplete;			// How much of the scene has finished running
var		transient mataction	CurrentAction;			// The currently executing action
var		transient float SceneSpeed;
var		transient float	TotalSceneTime;				// The total time the scene will take to run (in seconds)
var		transient Actor	Viewer;						// The actor viewing this scene (the one being affected by the actions)
var		transient Pawn OldPawn;						// The pawn we need to repossess when scene is over
var		transient bool bIsRunning;					// If TRUE, this scene is executing.
var		transient bool bIsSceneStarted;				// If TRUE, the scene has been initialized and is running
var		transient float CurrentTime;				// Keeps track of the current time using the DeltaTime passed to Tick
var		transient array<vector> SampleLocations;	// Sampled locations for camera movement
var		transient array<MatSubAction> SubActions;	// The list of sub actions which will execute during this scene
var		transient Orientation CamOrientation;		// The current camera orientation
var		transient Orientation PrevOrientation;		// The previous orientation that was set

// AMSD: Seeing as how this is just a Pawn*, I don't know why it is noexport.  But it is.
// Hunh.  I marked it native because generally noexport things should be native.  If you
// want it to get saved out, change it back, but preferably make it an exportable
// property again.
var native noexport int pad0;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     RenderType=(DrawType=DT_Sprite)
     Texture=Texture'Engine.S_SceneManager'
}
