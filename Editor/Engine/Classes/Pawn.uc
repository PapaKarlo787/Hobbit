//=============================================================================
// Pawn, the base class of all actors that can be controlled by players or AI.
//
// Pawns are the physical representations of players and creatures in a level.  
// Pawns have a mesh, collision, and physics.  Pawns can take damage, make sounds, 
// and hold weapons and other inventory.  In short, they are responsible for all 
// physical interaction between the player or AI and the world.
//
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class Pawn extends Actor
	abstract
	native
	placeable
	nativereplication;

#exec Texture Import File=Textures\Pawn.pcx Name=S_Pawn Mips=Off Flags=2

//-----------------------------------------------------------------------------
// Pawn variables.

var Controller Controller;

var(Physics) inherited (1336) float CharacterHeightOffset "Cylinder height positioning is offset along the z-axis by this value.";
var(Physics) runtimeinstantiated(2096) float ImpulseMultiplier "The impulse this object takes from collisions is multiplied by this amount if the object is colliding agains anything other than a ragdoll. A value of 1 does nothing.";
var(Physics) runtimeinstantiated(2153) float ImpulseMultiplierRagdoll "The impulse this object takes from collisions is multiplied by this amount if the object is colliding against a ragdoll. A value of 1 does nothing.";

struct CharacterPushingStruct
{
	var   transient Actor	  Actor;
	var   float   TotalTime;
	var   float   LastFrameTime;
	var   vector  StartPosition;
	var   bool	  IsPushing;
		
	var() float StartTime "Number of seconds the character must be in contact with an object before increasing the impulse (pushing the object).";
	var() float ClearTime "Number of seconds the character must not be in contact with an object before clearing out the pushing.";
	var() float MinDistance "If the object has travelled more than Push_MinDistance since the character began contacting the object, then don't push (it's moving just fine)";
	var() float Multiplier "Amount to multipy the impulse by if the object is pushed (if 0 then no pushing occurs)";
	var() float MaxUnitsOfMultiplier "Max units of multiplier to apply to the object during pushing (For every unit of Push_StartTime, the impulse is increased by Push_Multiplier).";
};

var(Physics) Travel runtimeinstantiated(2155) CharacterPushingStruct CharacterPushingInfo "Parameters for character pushing (pushing an object for a long time will give it a bigger impulse)";

// Physics related flags.
var Travel bool		bJustLanded;	// used by eyeheight adjustment
var Travel bool		bUpAndOut;		// used by swimming 
var Travel bool		bIsWalking;			// currently walking (can't jump, affects animations)
var Travel bool		bWarping;		// Set when travelling through warpzone (so shouldn't telefrag)
var Travel bool		bWantsToCrouch;		// if true crouched (physics will automatically reduce collision height to CrouchHeight)
var Travel const bool	bTryToUncrouch;		// when auto-crouch during movement, continually try to uncrouch
var Travel const bool	bIsCrouched;		// set by physics to specify that pawn is currently crouched
var Travel bool		bCrawler;		// crawling - pitch and roll based on surface pawn is on
var Travel const bool		bReducedSpeed;		//used by movement natives

//AMSD-Add new things to the end.  Might want to add fly later, for instance.
var(MovementMode) inherited(1223) bitfield eMovementAbility
{
	MovementAbility_CanCrouch,
	MovementAbility_CanStrafe,
	MovementAbility_CanWalk,
	MovementAbility_CanJump,
	MovementAbility_CanPlant,
	MovementAbility_CanClimbLadders,
	MovementAbility_CanFly,
	
} MovementAbilities "What kinds of movement can this pawn perform when controlled by a player?";


var		bool		bCanSwim;
var		bool		bCanFly;
var		bool		bAvoidLedges;		// don't get too close to ledges
var		bool		bStopAtLedges;		// if bAvoidLedges and bStopAtLedges, Pawn doesn't try to walk along the edge at all
var	bool		bNoJumpAdjust;		// set to tell controller not to modify velocity of a jump/fall	
var		bool		bCountJumps;
var const bool	bSimulateGravity;	// simulate gravity for this pawn on network clients when predicting position (true if pawn is walking or falling)
var		bool		bUpdateEyeheight;	// if true, UpdateEyeheight will get called every tick
var		bool		bIgnoreForces;		// if true, not affected by external forces
var const bool		bNoVelocityUpdate;	// used by C++ physics
var	bool		bCanWalkOffLedges;	// Can still fall off ledges, even when walking (for Player Controlled pawns)
var	bool		bIsTurning;			// updated when turning in place (for animation)
var	bool		bTurningLeft;		// updated when turning in place (for animation)

// used by dead pawns (for bodies landing and changing collision box)
var		bool		bThumped;		
var		bool		bInvulnerableBody;

// AI related flags
var		bool	bIsFemale;
var		bool	bAutoActivate;			// if true, automatically activate Powerups which have their bAutoActivate==true
var		bool	bCanPickupInventory;	// if true, will pickup inventory when touching pickup actors
var		bool	bUpdatingDisplay;		// to avoid infinite recursion through inventory setdisplay
var		bool	bAmbientCreature;		// AIs will ignore me
var(AIBark)  inherited(2118)   bool    bIsTelepathic;          // Barks from this AI will have volume based on distance, but no 3D position

// AI basics.
var 	byte	Visibility;			//How visible is the pawn? 0=invisible, 128=normal, 255=highly visible 
var		float	DesiredSpeed;
var		float	MaxDesiredSpeed;
var const float	AvgPhysicsTime;		// Physics updating time monitoring (for AI monitoring reaching destinations)
var float	MeleeRange; // Max range for melee attack (not including collision radii)
var NavigationPoint Anchor;			// current nearest path;

// Movement.
var float   GroundSpeed;    // The maximum ground speed.
var float   WaterSpeed;     // The maximum swimming speed.
var float   AirSpeed;		// The maximum flying speed.
var float	LadderSpeed;	// Ladder climbing speed
var float	AccelRate;		// max acceleration rate
var(MovementMode) float	JumpZ;      	// vertical acceleration w/ jump
var float   AirControl;		// amount of AirControl available to the pawn
var float	WalkingPct;		// pct. of running speed that walking speed is
var bool    bOnSlope;				// true if the Pawn is on a slope
var float   SlopeStartAltitude;		// if bOnSlope is true, this stores the beginning altitude of the slope.
var float   InterpolatedZ;  // this is a shock absorber to smooth out jerky up/down movements - esp. on stairs. 


// Player info.
var	string	OwnerName;				// Name of owning player (for save games, coop)
var() float      		BaseEyeHeight "Base eye height above collision center.  Archetype version will forcefully override that set on instances.  So only set this for archetypes.";
var float        	EyeHeight;     	// Current eye height, adjusted for bobbing and stairs.
var	const vector	Floor;			// Normal of floor pawn is standing on (only used by PHYS_Spider and PHYS_Walking)
var float			SplashTime;		// time of last splash
var() float			CrouchHeight;	// CollisionHeight when crouching
var float			CrouchRadius;	// CollisionRadius when crouching
var float			OldZ;			// Old Z Location - used for eyeheight smoothing
var notextexport PhysicsVolume	HeadVolume;		// physics volume of head
var travel int      Health;          // Health: 100 = normal maximum
var	float			BreathTime;		 //used for getting BreathTimer() messages (for no air, etc.)
var float			UnderWaterTime; // how much time pawn can go without air (in seconds)
var	float			LastPainTime;	// last time pawn played a takehit animation (updated in PlayHit())

// Sound and noise management
// remember location and position of last noises propagated
var const 	vector 		noise1spot;
var const 	float 		noise1time;
var const	pawn		noise1other;
var const	float		noise1loudness;
var const 	vector 		noise2spot;
var const 	float 		noise2time;
var const	pawn		noise2other;
var const	float		noise2loudness;
var			float		LastPainSound;

var float SoundDampening;
var float DamageScaling;

var localized  string MenuName; //Name used for this pawn type in menus (e.g. player selection) 


// blood effect
var class<Effects> BloodEffect;
var class<Effects> LowDetailBlood;
var class<Effects> LowGoreBlood;

var class<AIController> ControllerClass;	// default class to use when pawn is controlled by AI (can be modified by an AIScript)

// Demo recording view rotation
var int DemoViewPitch;
var int DemoViewYaw;

var float CarcassCollisionHeight;	// collision height of dead body lying on the ground

var name LandMovementState;	// PlayerControllerState to use when moving on land or air
var name WaterMovementState;	// PlayerControllerState to use when moving in water

// Animation status
var name AnimStatus;
var name AnimAction;			// use for replicating anims (FIXME)

// Animation updating by physics
var float OldRotYaw;		// used for determining if pawn is turning
var vector OldAcceleration;

var(Health) inherited(1334) bool InjuredByPlayer;
var(Health) inherited(1335) bool KilledByPlayer;
var(Health) inherited(1342) bool TrackHealthFlags;
var(Health) inherited(1343) bool StoreHealthFlags;

var(Body) inherited(1385) bool CanPickup	"Can this Pawn be picked up after it is dead?";

var(AIAbility) inherited(1416) thiefprop float ArrowRefireRate "How quickly this AI can shoot arrows, or spells.";
var(AIAbility) inherited(1417) thiefprop float AddlMeleeAttackRange "In addition to the melee weapon the AI is using, how much larger is his attack range.";
var(AIAbility) inherited(1972) thiefprop float EatsCorpsesForSeconds "Used for zombies, specifies how many seconds the AI will chew on any given corpse for. Omit or -1 to disable ghoulish feeding.";
var(AIAbility) inherited(1976) float PlayingPossumInertSeconds "For zombies, how many seconds the AI should be truly inert before being ready to grab the player. Omit or set -1 to disable possum behavior.";
var(AIAbility) inherited(1977) float PlayingPossumReactivateRadius "Possumed zombies will leap up to attack an enemy when they draw within this distance.";
var(AIAbility) inherited(2149) bool bOnlyKnockedOutByUnbindingStim "Used for statues - they can only be knocked out by the unbinding stim";

// special-case zombie flag (hidden)
var bool bZombieIgnoreBody;

var runtimeinstantiated(1973) thiefprop bool bIgnoredByZombies "Should be set after a zombie has chewed on a body, will remove it from future consideration for eating.";

var(Advanced) runtimeinstantiated(1608) bool bLeaving "When a pawn is 'leaving' it will be deleted off the map when not in view.";
var(Advanced) runtimeinstantiated(1609) bool bDormant "When a pawn is 'dormant', it's basically asleep and will not react to anything.  Going from bDormant=true to false will effectively wake up the dormant AI.";

var(Conversations) inherited(1670) float DisallowCinematicsWithinRadius "This is used on the player pawn for determining whether a cinematic conversation can be played or not. If NPC's are hostile toward the player and within this radius (in feet), the cinematic will not play.";
var(Conversations) inherited(1847) deusexprop bool WillTalkIfFrobbed	"Whether or not this pawn is supposed to talk if frobbed (for help text purposes)";

var(AILOD) float LODDistanceOff "The distance (in feet) from the player an AI must be from the player in order to be LOD'd off.  NOTE: If the distance <= 0, then this LOD level will never be chosen.";
var(AILOD) float LODDistanceMinimal "The distance (in feet) from the player an AI must be from the player in order to be set the minimal LOD level.  NOTE: If the distance <= 0, then this LOD level will never be chosen.";
var(AILOD) float LODDistanceBasic "The distance (in feet) from the player an AI must be from the player in order to be set the basic LOD level.  NOTE: If the distance <= 0, then this LOD level will never be chosen.";

var(Inventory) inherited(1694) bool bInventoryFrobbable "Specifies if the pawn's inventory items can be frobbed while they're still attached to the pawn.";
var(Inventory) inherited(1717) bool bHiddenInventory "Specifies if the pawn's inventory/weapons are hidden until used.  DX2 is going to use this for armed civilians.";

var(Health) inherited(1753) string HeadBoneName "Specify this if you would like hits on this bone to be considered the head";

var		bool IsBlinded;
var		bool IsHacking;

var inherited(1431) bool bUsingAltFire "Just a flag to tell the AI to use the alt fire on a weapon.";

var(AIBark) inherited(1907) bool bNoticesVandalism "Whether this AI should notice and reprimand for objects broken BY PLAYER nearby.";
var(AIGreetings) inherited(2002) bool bDoesNotGreet "Bans this AI from greeting or one-linering nearby pawns.";

enum eAILODLevel
{
	AILOD_Running,
	AILOD_Basic,
	AILOD_Minimal,
	AILOD_Off
};

var(AILOD) runtimeinstantiated(1347) eAILODLevel MinAILODLevel "The minimum LOD level an AI can be put into. - MDB 2/17/03";

enum eCityGroupType 
{
	kCGT_Victim,	
	kCGT_Guard,		
	kCGT_Hammer,	
	kCGT_Pagan,
	kCGT_Extra	
};

var(AICitySectionSpawn) inherited(2123) eCityGroupType CityGroup "Which citygroup quota an AI counts against if it's added to the level. (Does not mean this AI will respawn. - EGR 2/27/04";

var(AI) inherited(1769) bool bAmbientBarksDisabled "A pawn with this set will not play any ambient barks.";
var(AI) inherited(1770) bool bAmbientAnimsDisabled "A pawn with this set will not play any ambient fidget animations.";

var(Damage) inherited(2053) array<BodyLocationInfo> BoneToBodyLocationMap "Specifies how bone names map onto eBodyLocation for FStimlusInfo creation.";

// puppet/zombie animation and noise effects
var(Puppet) runtimeinstantiated(2139) float	PuppetNoiseScale "The amount to amplify the noise. 0 indicates no puppet noise. >0 noise applied after bones are xformed <0 noise applied before.";
var(Puppet) inherited(2140) float	PuppetNoiseTimeScale	"Ignored if PuppetNoiseScale is 0. Amount to speed up slow down the noise.";
var(Puppet) inherited(2141) int		PuppetNoiseFrameSkip "Ignored if PuppetNoiseScale is 0. Number of frames to skip to make animations pop/jerky.";

// transparency / invisibility properties
var(Invisibility) float InvisibilityTargetAlpha "When a character gets hit with invisibility stim, its alpha will fade to this target over time.";
var(Invisibility) float InvisibilityInterpolationRate "This is the rate of interpolation (0.0001 = very slow, 1.0 = immediate) for blending into invisibility for a character.";
var float InvisibilityCurrentAlpha;
var float InvisibilityEndTime;

var native noexport int DArrayPad[3]; // 12 bytes for FArray<IMotionCallback>

// stub placeholders	
var native noexport int InventoryPtrStub;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     ImpulseMultiplier=1.000000
     ImpulseMultiplierRagdoll=1.000000
     bIsTelepathic=False
     Visibility=128
     DesiredSpeed=1.000000
     MaxDesiredSpeed=1.000000
     AvgPhysicsTime=0.100000
     GroundSpeed=600.000000
     WaterSpeed=300.000000
     AirSpeed=600.000000
     LadderSpeed=200.000000
     AccelRate=2048.000000
     JumpZ=420.000000
     AirControl=0.050000
     BaseEyeHeight=54.000000
     EyeHeight=54.000000
     CrouchHeight=40.000000
     CrouchRadius=34.000000
     Health=100
     noise1time=-10.000000
     noise2time=-10.000000
     SoundDampening=1.000000
     DamageScaling=1.000000
     ControllerClass=Class'Engine.AIController'
     CarcassCollisionHeight=23.000000
     LandMovementState="PlayerWalking"
     WaterMovementState="PlayerSwimming"
     CanPickup=True
     ArrowRefireRate=10.000000
     bOnlyKnockedOutByUnbindingStim=False
     DisallowCinematicsWithinRadius=40.000000
     LODDistanceOff=200.000000
     LODDistanceMinimal=100.000000
     LODDistanceBasic=40.000000
     bNoticesVandalism=True
     MinAILODLevel=AILOD_Off
     BoneToBodyLocationMap(0)=(BoneName="M1 Head",BodyLocation=BodyLocation_Head)
     BoneToBodyLocationMap(1)=(BoneName="M1 L Calf",BodyLocation=BodyLocation_LeftLeg)
     BoneToBodyLocationMap(2)=(BoneName="M1 L Forearm",BodyLocation=BodyLocation_LeftArm)
     BoneToBodyLocationMap(3)=(BoneName="M1 L Thigh",BodyLocation=BodyLocation_LeftLeg)
     BoneToBodyLocationMap(4)=(BoneName="M1 L UpperArm",BodyLocation=BodyLocation_LeftArm)
     BoneToBodyLocationMap(5)=(BoneName="M1 Pelvis",BodyLocation=BodyLocation_Torso)
     BoneToBodyLocationMap(6)=(BoneName="M1 R Calf",BodyLocation=BodyLocation_RightLeg)
     BoneToBodyLocationMap(7)=(BoneName="M1 R Forearm",BodyLocation=BodyLocation_RightArm)
     BoneToBodyLocationMap(8)=(BoneName="M1 R Thigh",BodyLocation=BodyLocation_RightLeg)
     BoneToBodyLocationMap(9)=(BoneName="M1 R UpperArm",BodyLocation=BodyLocation_RightArm)
     BoneToBodyLocationMap(10)=(BoneName="M1 Spine",BodyLocation=BodyLocation_Torso)
     BoneToBodyLocationMap(11)=(BoneName="M1 Spine1",BodyLocation=BodyLocation_Torso)
     PuppetNoiseScale=0.000000
     PuppetNoiseTimeScale=1.000000
     PuppetNoiseFrameSkip=0
     InvisibilityTargetAlpha=0.100000
     InvisibilityInterpolationRate=0.150000
     InvisibilityCurrentAlpha=1.000000
     bRotateToDesired=True
     bCanTeleport=True
     RenderType=(DrawType=DT_Mesh,Style=STY_Normal)
     Texture=Texture'Engine.S_Pawn'
     CollisionRadius=34.000000
     CollisionHeight=78.000000
     CollisionFlags=(bCollideActors=True,bCollideWorld=True,bBlockActors=True,bBlockPlayers=True,bProjTarget=True)
     bBlocksCamera=False
     NetPriority=2.000000
     MinFallDamage=96.000000
     MaxFallDamage=128.000000
     bIsConsideredForProx=True
     bDirectional=True
     bEdShouldSnap=True
     bOwnerNoSee=True
     bIsPawn=True
     RemoteRole=ROLE_SimulatedProxy
}
