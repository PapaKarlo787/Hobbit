//=============================================================================
// Controller, the base class of players or AI.
//
// Controllers are non-physical actors that can be attached to a pawn to control 
// its actions.  PlayerControllers are used by human players to control pawns, while 
// AIControllers implement the artificial intelligence for the pawns they control.  
// Controllers take control of a pawn using their Possess() method, and relinquish 
// control of the pawn by calling UnPossess().
//
// Controllers receive notifications for many of the events occuring for the Pawn they 
// are controlling.  This gives the controller the opportunity to implement the behavior 
// in response to this event, intercepting the event and superceding the Pawn's default 
// behavior.  
//
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class Controller extends Actor
	native
	nativereplication
	abstract
	editorinvisible;

var Pawn Pawn;

var		float      FovAngle;      // X field of view angle in degrees, usually 90.
var		bool        bIsPlayer;      // Pawn is a player or a player-bot.

var const	Controller		nextController; // chained Controller list

var class<Pawn> PawnClass;	// class of pawn to spawn (for players)
var string FaceName, SkinName; //fixme - don't dynamic load every respawn

var float GroundPitchTime;
var vector ViewX, ViewY, ViewZ;	// Viewrotation encoding for PHYS_Spider

var deusexprop vector CameraBob; // Used for first person camera offsets when a pawn is moving.

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     FovAngle=90.000000
     bHidden=True
     bHiddenEd=True
}
