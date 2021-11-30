//=============================================================================
// PlayerController
//
// PlayerControllers are used by human players to control pawns.
//
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class PlayerController extends Controller
	config(user)
	native
	nativereplication
	editorinvisible;

// Player info.
var const player Player;

// player input control
var globalconfig	bool 	bLookUpStairs;	// look up/down stairs (player)
var globalconfig	bool	bSnapToLevel;	// Snap to level eyeheight when not mouselooking
var globalconfig	bool	bAlwaysMouseLook;
var globalconfig	bool	bKeyboardLook;	// no snapping when true
var bool		bCenterView;

// Player control flags
var bool		bBehindView;    // Outside-the-player view.
var bool		bFrozen;		// set when game ends or player dies to temporarily prevent player from restarting (until cleared by timer)
var bool		bPressedJump;
var bool		bUpdatePosition;
var bool		bJustFired;
var bool		bJustAltFired;
var bool		bIsTyping;
var bool		bFixedCamera;	// used to fix camera in position (to view animations)
var bool		bJumpStatus;	// used in net games
var	bool		bUpdating;
var config bool	bInvertYLookAxis;	// Should the player's Y look be inverted?

var bool		bDesiresToBePlanted; // Pawn wants to be in the 'planted' state. DX2 prop only, really.

var globalconfig bool	bNeverSwitchOnPickup;	// if true, don't automatically switch to picked up weapon

var bool		bZooming;
var	bool		bOnlySpectator;	// This controller is not allowed to possess pawns

var globalconfig bool bAlwaysLevel;
var bool		bSetTurnRot;
var bool		bCheatFlying;	// instantly stop in flying mode
var bool		bFreeCamera;	// free camera when in behindview mode (for checking out player models and animations)

var float AimingHelp;
var float WaitDelay;			// Delay time until can restart

var input float
	aBaseX, aBaseY, aBaseZ,	aMouseX, aMouseY,
	aForward, aTurn, aStrafe, aUp, aLookUp;

var input byte
	bStrafe, bSnapLevel, bLook, bFreeLook, bTurn180, bTurnToNearest;

var EDoubleClickDir DoubleClickDir;		// direction of movement key double click (for special moves)

// Camera info.
var int Misc1,Misc2;
var int RendMap;
var float        OrthoZoom;     // Orthogonal/map view zoom factor.
var const actor ViewTarget;
var float CameraDist;		// multiplier for behindview camera dist

var globalconfig float DesiredFOV;
var globalconfig float DefaultFOV;
var float		ZoomLevel;

// Screen flashes
var vector FlashScale, FlashFog;
var float DesiredFlashScale, ConstantGlowScale, InstantFlash;
var vector DesiredFlashFog, ConstantGlowFog, InstantFog;

// Remote Pawn ViewTargets
var rotator TargetViewRotation; 
var float TargetEyeHeight;
var vector TargetWeaponViewOffset;

var float LastPlaySound;
var globalconfig int AnnouncerVolume;

// Move buffering for network games.  Clients save their un-acknowledged moves in order to replay them
// when they get position updates from the server.
var float CurrentTimeStamp,LastUpdateTime,ServerTimeStamp,TimeMargin, ClientUpdateTime;
var globalconfig float MaxTimeMargin;
var int WeaponUpdate;

// Progess Indicator - used by the engine to provide status messages (HUD is responsible for displaying these).
var string ProgressMessage[4];
var color ProgressColor[4];
var float ProgressTimeOut;

// Localized strings
var localized string QuickSaveString;
var localized string NoPauseMessage;
var localized string ViewingFrom;
var localized string OwnCamera;

// ngWorldStats Logging
var globalconfig private string ngWorldSecret;
var globalconfig bool ngSecretSet;
var bool ReceivedSecretChecksum;

var				globalconfig float Bob;
var				float				LandBob, AppliedBob;
var				float bobtime;

var Pawn TurnTarget;
var config int EnemyTurnSpeed;
var int GroundPitch;
var rotator TurnRot180;

var vector OldFloor;		// used by PlayerSpider mode - floor for which old rotation was based;
			
var noexport int ShowFlags[2];

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     bAlwaysMouseLook=True
     OrthoZoom=40000.000000
     CameraDist=9.000000
     DesiredFOV=85.000000
     DefaultFOV=85.000000
     FlashScale=(X=1.000000,Y=1.000000,Z=1.000000)
     AnnouncerVolume=4
     MaxTimeMargin=1.000000
     QuickSaveString="Quick Saving"
     NoPauseMessage="Game is not pauseable"
     ViewingFrom="Now viewing from"
     OwnCamera="Now viewing from own camera"
     Bob=0.016000
     EnemyTurnSpeed=45000
     FovAngle=85.000000
     bIsPlayer=True
     Physics=PHYS_None
     NetPriority=3.000000
     InitialState="'"
     bTravel=True
}
