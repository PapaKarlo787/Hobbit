//=============================================================================
// Actor: The base class of all actors.
// Actor is the base class of all gameplay objects.  
// A large number of properties, behaviors and interfaces are implemented in Actor, including:
//
// -	Display 
// -	Animation
// -	Physics and world interaction
// -	Making sounds
// -	Networking properties
// -	Actor creation and destruction
// -	Triggering and timers
// -	Actor iterator functions
// -	Message broadcasting
//
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class Actor extends Object
	abstract
	native
	nativereplication;

// Imported data (during full rebuild). 
#exec Texture Import File=Textures\S_Actor.pcx Name=S_Actor Mips=Off Flags=2

#exec Texture Import File=Textures\script_marker.pcx Name=ScriptMarker Mips=Off Flags=2

#exec Texture Import File=Textures\Fleshlight_a.pcx Name=Fleshlight_a Mips=Off Flags=2
#exec Texture Import File=Textures\Fleshlight_a_v.pcx Name=Fleshlight_a_v Mips=Off Flags=2
#exec Texture Import File=Textures\Fleshlight_d_s.pcx Name=Fleshlight_d_s Mips=Off Flags=2
#exec Texture Import File=Textures\Fleshlight_d_ns.pcx Name=Fleshlight_d_ns Mips=Off Flags=2
#exec Texture Import File=Textures\Fleshlight_o_ns.pcx Name=Fleshlight_o_ns Mips=Off Flags=2
#exec Texture Import File=Textures\Fleshlight_o_s.pcx Name=Fleshlight_o_s Mips=Off Flags=2
#exec Texture Import File=Textures\Fleshlight_o_v.pcx Name=Fleshlight_o_v Mips=Off Flags=2
#exec Texture Import File=Textures\Fleshlight_s_ns.pcx Name=Fleshlight_s_ns Mips=Off Flags=2
#exec Texture Import File=Textures\Fleshlight_s_s.pcx Name=Fleshlight_s_s Mips=Off Flags=2

#exec Texture Import File=Textures\AlarmRelay.pcx Name=AlarmRelay Mips=Off Flags=2
#exec Texture Import File=Textures\LightRelay.pcx Name=LightRelay Mips=Off Flags=2
#exec Texture Import File=Textures\PowerRelay.pcx Name=PowerRelay Mips=Off Flags=2
#exec Texture Import File=Textures\s_soundicon.dds Name=SoundIcon Mips=Off Flags=2


// Beginning of new property system properties
// For some easy of use, I'm defining each category to use a 100 element block of property ids.
// This allows 655 categories (should be more than enough), and no category should have even that many
// elements.  Maybe we change it to subcategories later.  So we'll start with the Movement category.

var() inherited (733) string VoiceTag "Indicates the name to use with +Voice: tags for this NPC (uses classname if not specified)";
var() inherited (1912) string OneLinerTag "Indicates the tag which other NPCs will use when firing off +OneLiner barks (eg 'commoner' here -> '+OneLiner +OneLinerTarget:commoner')";


//----------------------------------------------------------------------------
// Movement properties, IDs 1-99
//----------------------------------------------------------------------------
// Since almost every actor cares about location and rotation, these are NOT under the new system.
var(Movement) const				vector	Location;		// Actor's location; use Move to set.
var(Movement) const	Travel		rotator	Rotation;		// Rotation.
var(Movement)					vector	Velocity;		// Velocity.
var(Movement)					vector	Acceleration;	// Acceleration.
// Priority Parameters

var const vector    ColLocation;		// Actor's old location one move ago. Only for debugging  <=This is a LIE! 
			                            // Projectile.uc uses it in a touch function, which means I can't make it
										// non-release only, which means no point in putting it in the new system.
struct CharacterControllerInfoStruct
{
	var() float DynamicFriction;
	var() float StaticFriction;
	var() float ExtraDownStaticFriction;
	var() float ExtraUpStaticFriction;
};

// Physics properties.
var(Movement) inherited(21) float       Mass;            // Mass of this actor.
var(Movement) inherited(22) float       Buoyancy;        // Water buoyancy.
var(Movement) inherited(23) rotator		RotationRate	"Change in rotation specified in Degrees Per Second.";
var(Movement) inherited(24) rotator     DesiredRotation; // Physics will smoothly rotate actor to this rotation if bRotateToDesired.
var(Movement) inherited(1542)	float	StepHeight "Height of objects that the character can step onto.";
var(Movement) inherited(2058)   float   MaxSlopeDegrees "Angle in degrees of the max slope the character can walk up. Must be between 0 and 90 degrees.";
var(Movement) inherited(1549)	float	PivotOffset "Offset of pivot point from the center of the object.";
var(Movement) inherited(2059)  CharacterControllerInfoStruct CharacterControllerInfo "Internal Havok variables for the character controller.";

var notextexport const PhysicsVolume PhysicsVolume;	 // physics volume this actor is currently in

struct BoneAimInfo
{
	var() Name BoneControlName;
	var() Name BoneToControl;
	var() Name BoneToConstrain;
	var() Name BoneToAim;
	var() float ConstraintClamp;
	var() float ConstraintGiveUp;
	var() float RateActive;
	var() float RateRestore;
	var() bool bUseWeaponBoneForAiming;
	var() bool bNoZAiming;
	var() int  AimMethod;
};

var(Movement) inherited(1763) Array<BoneAimInfo> BoneAimArray "Multi-bone info for bone aim controller";

enum eDoorType
{
	DoorType_Conventional,
	DoorType_TrapDoor,
};

enum eDoorState
{
	DoorState_Open,
	DoorState_Opening,
	DoorState_Closing,
	DoorState_Closed
};

struct DoorControllerStruct
{
	var() float		DoorSpeed;    // time in seconds for door to open or close
	var() float		MaximumForce; // the maximum force the door motor can exert
	var() bool		StartOpen;    // if this is true, the door will be open at the start of the level
	var() eDoorType DoorType "The type of door this is; trapdoors are not added to the navmesh";
};

struct DoorControllerSaveStruct
{
	var eDoorState m_doorState;
	var float      m_velocityTarget;
	var float      m_maxForce;
};

struct CharacterControllerSaveStruct
{
	// vector variables from CharacterController (in GamePhysCharacterController.h)
	var vector m_prevDisplacement;
	var vector m_previousVelocity;
	var float m_lineHeight;
	var int m_collisionInfo;
	
	// vector variables from ObjectController (in GamePhysObjectController.h)
	var vector m_displacement;
	var vector m_currentVelocity;
	var vector m_targetVelocity;
	
	// vector variables from hkCharacterController (in hkCharacterController.h)
	var vector m_gravity;
	var vector m_velocity;
	var vector m_surfaceVelocity;
	var vector m_characterHalfExtents;
	var vector m_position;
	var int	m_previousLocationIndex;
	var int	m_maxLocationsSaved;
	var float m_locationDistance;
	var array<vector> m_previousLocations;

	// byte variables from ObjectController (in GamePhysObjectController.h)
	var byte   m_state;
	
	// bool variables from CharacterController (in GamePhysCharacterController.h)
	var bool   m_isCrouching;
	var bool   m_wantsToStand;
	var bool   m_isActive;
	
	// bool variables from hkCharacterController (in hkCharacterController.h)
	var bool   m_onGround;
	var bool   m_isCrouching_hkCharacterController;
	var bool   m_atStep;
	var bool   m_isRagdolling;
};

struct ObjectControllerSaveStruct
{
	// all of the data we need to restore in ObjectController
	var int    m_state;
	var vector m_displacement;
	var vector m_currentVelocity;
	var vector m_targetVelocity;
	var vector m_gravity;
	var float  m_maxSpeed;	
};

struct CharacterControllerSaveStruct2
{
	// all of the data we need to restore in CharacterController
	var ObjectControllerSaveStruct m_objectController;
	
	// this is m_characterProxy's data (from its Cinfo)
	var vector m_position;
	var vector m_velocity;
	var float  m_dynamicFriction;
	var float  m_staticFriction;
	var float  m_extraUpStaticFriction;
	var float  m_extraDownStaticFriction;
	var float  m_keepDistance;
	var float  m_characterRadius;
	
	// this is m_characterContext's data
	var int    m_currentState;
	
	// the rest of the stuff we need to restore for CharacterController
	var int    m_collisionFilterInfo;
	var float  m_lineHeight;
	var bool   m_isCrouching;
	var bool   m_wantsToStand;
	var bool   m_jump;
	var bool   m_isRagdolling;
	var bool   m_isActive;
};

struct PhysicsObjectSaveStruct
{
	var vector  m_linearVelocity;
	var vector  m_angularVelocity;
	var bool    m_isActive;
	var bool    m_isInSimulation;
	var bool    m_isPinned;
	var int     m_defaultCollisionGroup;
	var int     m_currentCollisionFilterInfo;
};

// IMPORTANT: YOU MUST KEEP THESE NUMBERS IN SYNC WITH ... PhysicsObjectController.h -> ObjectController::ObjectState
enum EInitialHavokState
{
	Havok_None = 0,
	Havok_Walking = 1,
	Havok_Flying = 2,
	Havok_Falling = 3,
	Havok_Ghost = 4,
	Havok_DirectControlled = 5,
	Havok_DirectControlled_NoStaticCollisions = 6,
	Havok_HavokControlled = 7,
};

// Actor's current physics mode.
enum EPhysics
{
	PHYS_None = 0,
	PHYS_Havok = 14,	// this replaces Havok
	PHYS_Point = 22,	
};

var(Movement) inherited(1331)	const EPhysics				Physics		"The physics manager that controls this object";
var(Physics) inherited(1330)	const EInitialHavokState	InitialHavokState	"Only used when Physics=Havok. Initial state for the physics controller";
var(Physics) inherited(1564)    bool	StartActive	"Don't set this true unless you know what you are doing.  True if the object should start active when created. Used mostly for spawned objects.";
var(Physics) inherited(953) DoorControllerStruct DoorController; // add this property to constrained objects to make them doors
var(Physics) inherited(960) float DoorDeactivateThreshold "Lower if door is deactivating too soon.  Reasonable range [0,5]; default=1.0";
var inherited(1771) DoorControllerSaveStruct DoorControllerSave;
var inherited(1788) CharacterControllerSaveStruct CharacterControllerSave;
var inherited(1968) CharacterControllerSaveStruct2 CharacterControllerSave2;
var inherited(1796) PhysicsObjectSaveStruct PhysicsObjectSave;

struct ElevatorControllerStruct
{
	var() vector       ElevatorAxis  "Obsolete.  Do not use this field.";
	var() array<float> FloorOffsets  "Obsolete.  Do not use this field.";
	var() float        ElevatorSpeed "Elevator speed, in Unreal units.";
	var() float        ElevatorWait  "Time, in seconds, elevator waits before moving to next floor.";
	var() bool         Interruptable "If true, pressing a call button will immediately call the elevator, even if it's already in motion.";
};

struct ElevatorControllerSaveStruct
{
	var vector m_requestLocation;
	var vector m_previousLocation;
	var vector m_previousWaypoint;
	var float  m_speed;
	var float  m_waitTime;
	var float  m_timer;
	var float  m_blockedWaitTime;
	var float  m_blockedTimer;
};

var inherited(1798) ElevatorControllerSaveStruct ElevatorControllerSave;

var(Physics) inherited(1052) ElevatorControllerStruct ElevatorController; // this property makes objects into elevators

var(Physics) inherited(1565) vector       Gravity "Gravity for this actor.  Only works on objects with a character controller.  If not specified, will default to world gravity.";
var(Physics) inherited(682) float            MassPounds "Use this instead of Movement->Mass for physics; default=1.0";
var(Physics) inherited(683) float            Friction	 "Coefficient of friction, > 0; default=0.5";
var(Physics) inherited(684) float            Restitution "Coefficient of restitution (elastisity) ranges 0 to 1; default=0.4";
var(Physics) inherited(1540) float			 LinearDrag "Applies drag to the linear velocity of an object;default=0.0";
var(Physics) inherited(1541) float			 AngularDrag "Applies drag to the angular velocity of an object;default=0.05";

struct ControlledObjectImpulseStruct
{
	var() float MinImpulse;
	var() float MaxImpulse;
};

var(Physics) inherited(1126) ControlledObjectImpulseStruct ControlledObjectImpulse "Min and Max impulses for controlled physics objects (i.e. all characters use this when impulsing dynamic objects that they collide with.";
var(Physics) inherited(1268) Name			RagdollTag		"The name of the .RGD file containing the ragdoll constraint information for this object";
var(Physics) inherited(1719) bool			bNotRagdoll "Should be set to true for creatures that have a ragdoll file assigned but are not supposed to ragdoll when they die (i.e. bots).";
var(Physics) inherited(1791) bool			bNoMultisphere	"Set for ragdolls that don't respond well with multisphered hulls.";

struct DragActionStruct
{
	var() float LinearDrag;
	var() float AngularDrag;
};

var(PhysicsAction) inherited(1338) DragActionStruct DragAction "DEPRICATED PROPERTY - Use Physics->LinearDrag & Physics->AngularDrag instead";

struct MotorActionStruct
{
	var() vector    MotorAxis		"The axis along which the object spins.";
	var() float		SpinRate		"Desired angular velocity around axis.";
	var() float		MotorGain		"Rate at which the desired speed is attained.";
	var() float		MaxTorque		"Maximum torque applied to body.";
};

// This will likely have more members later.
struct SwingActionStruct
{
	var() vector    MaxForce		"The max force applied to make the object swing.";
};

var(PhysicsAction) inherited(1339) MotorActionStruct MotorAction "Applies a motor to an object if SpinRate > 0.";
var(PhysicsAction) inherited(1584) SwingActionStruct SwingAction "Applies a swing to an object if MaxForce > 0.";

var(PointPhysics) inherited(1327)	float EnergyLossOnCollision "A value between 0..1 that determines how much energy is lost on an impact";

// Options.
var(Movement) inherited(25) bool		bFixedRotationDir; // Fixed direction of rotation.
var(Movement) inherited(26) bool		bRotateToDesired;  // Rotate to DesiredRotation.
var(Movement) inherited(28) bool      bCanTeleport;  // This actor can be teleported.

//AMSD: These aren't necessary, so we're removing them.
//var const vector		RelativeLocation;	// location relative to base/bone (valid if base exists)
//var const rotator		RelativeRotation;	// rotation relative to base/bone (valid if base exists)

var			  inherited(31) Actor		  PendingTouch;		// Actor touched during move which wants to add an effect after the movement completes 

//----------------------------------------------------------------------------
// Lighting properties
//----------------------------------------------------------------------------

// Light modulation.
enum ELightType
{
	LT_None,
	LT_Steady,
	LT_Pulse,
	LT_Blink,
	LT_Flicker,
	LT_Strobe,
	LT_BackdropLight,
	LT_SubtlePulse,
	LT_TexturePaletteOnce,
	LT_TexturePaletteLoop
};

// Spatial light effect to use.
enum ELightEffect
{
	LE_None,
	LE_TorchWaver,
	LE_FireWaver,
	LE_WateryShimmer,
	LE_Searchlight,
	LE_SlowWave,
	LE_FastWave,
	LE_CloudCast,
	LE_StaticSpot,
	LE_Shock,
	LE_Disco,
	LE_Warp,
	LE_Spotlight,
	LE_Ambient,
	LE_OmniBumpMap,
	LE_Interference,
	LE_Rotor,
	LE_Unused,
	LE_Sunlight,
	LE_Pulse,
	LE_Flicker,
	LE_Panning
};

// Whether the light is a torch or one of them newfangled 'lectrics
// (used only for AI bark generation)
enum ELightBarkType
{
	LBT_Electric,
	LBT_Torch
};

struct LightColorStruct
{
    var() byte LightBrightness;
	var() byte LightHue;
	var() byte LightSaturation;
	var	  byte UselessPackingVariable;

};

struct LightVolumeStruct
{
	var() byte VolumeBrightness;
	var() byte VolumeRadius;
	var() byte VolumeFog;
	var	  byte UselessPackingVariable;
};

struct LightShapeStruct
{
	var() byte LightRadius "For specifying the outer radius of the light";
	var() byte LightPeriod;
	var() byte LightPhase;
	var() byte LightCone;
	var() byte LightInnerRadius "For specifying the inner radius of the light";
	var   byte UselessPack1;
	var   byte UselessPack2;
	var   byte UselessPack3;
	var() float DotBias		"Dot product bias";
};

struct LightCylinderStruct
{
	var() float Radius "For specifying the radius of the bounding cylinder for a directional light (such as sunlight)";
	var() float Length "For specifying the length of the bounding cylinder for a directional light (such as sunlight)";
};

struct LightProjectedStruct
{
	var() float Radius "Use the FLLightTexture now. (Obsolete)";
	var() float Length "Use the FLLightTexture now. (Obsolete)";
	var() string Name  "Use the FLLightTexture now. (Obsolete)";
};

struct FLTextureStruct
{
	var() string Name		  "For specifying the texture name";
	var() vector Dir		  "For specifying the texture scroll x,y,z direction units per second";
	var() vector Rotation	  "For specifying the texture rotation x,y,z axis degrees degrees per second";

};

struct LightTypeStruct
{
	var ELightEffect LightEffect;
	var ELightType   LightType;
	var() bool		   bSpecialLit;
	var() bool		   bActorShadows;
	var() bool		   bCorona;
	var() bool		   bLensFlare;
};

// @HACK:E32002 Helper Property A struct containing everything to give a light a pulsing effect
//struct LightPulseStruct
//{
//	var() float Amplitude1;
//	var() float Period1;
//	var() float Amplitude2;
//	var() float Period2;
//	var byte OriginalBrightness;
//	var byte bInit;
//	var byte Reserved1;
//	var byte Reserved2;
//};

// @HACK:E32002 Helper Property A struct containing everything to give a light a pulsing effect
//struct LightPanningStruct
//{	
//	var() float HorizontalScale;
//	var() float VerticalScale;
//	var() float Period;
//	var rotator OriginalRotation;
//	var byte bInit;
//	var byte Reserved1;
//	var byte Reserved2;
//	var byte Reserved3;
//	var() float VerticalBias;
//	var() float HorizontalBias;
//};

//var bool bHACKLIGHTPANNING; // @HACK: COMDEX REMOVE ASAP

var(Lighting) inherited(116)		LightColorStruct		LightColor;
var(Lighting) inherited(117)		LightVolumeStruct		VolumeProperties;
var(Lighting) inherited(118)		LightShapeStruct		LightShape;
var(Lighting) inherited(119)		LightTypeStruct			LightKind;
var(Lighting) inherited(956)		LightCylinderStruct		DirectionalLightShape "Cylinder volume for Directional Lights ( ignored for all others )";
var(Lighting) inherited(923)		LightProjectedStruct	ProjectedLightShape   "Use the FLLightTexture now. (This one will be removed)";
var(Lighting) inherited(1326)	FLTextureStruct			FLLightTexture		  "Lighting texture map data (Ignored for all others)";

var(Lighting) inherited(1546)	float					DirectionalClipHeight;
var(Lighting) inherited(1883)	float					ShadowExtrusionDistance "0.0 = Default = light radius";

//var(Lighting) inherited(725)  LightPulseStruct	LightPulse "E32002 - A light pulsing helper property for use with light effect LE_Pulse. - MDB 5/08/02";
//var(Lighting) inherited(728)  LightPanningStruct	LightPanning "E32002 - A light panning helper property for use with light effect LE_Panning (does a figure 8 on parent). - MDB 5/08/02";

var(Lighting) inherited(904) float LightDamping "Damps out the light by specified factor.  0 means original light value, 1 is completely dark."; 
var(Lighting) inherited(1487) Travel bool bLightOn "Whether a light is in the on state or not.";
var(Lighting) inherited(1807) vector LightHardpointOffset "Coordinate offset for the light hardpoint.";
var(Lighting) inherited(1980) rotator LightHardpointRotation "Rotation offset for the light hardpoint.";
var(Lighting) inherited(1916) ELightBarkType BarksReferAs "Whether AIs should call this light a 'torch' or a (electric) 'light'.";

///////////////////////////////////////////////////////////////////////////////
//created on 4/2/2003 as the beginnings of a property-oriented light effects system...

enum eLightingBehavior
{
	LB_None,
	LB_Flicker,
	LB_CandleWaver,
	LB_TorchWaver,
	LB_LargeFireWaver,
	LB_SlowPulse,
	LB_MediumPulse,
	LB_FastPulse,
	LB_ColorShift,
	LB_Strobe,
	LB_EMPFlicker,
};
var(Lighting) inherited(1455)	eLightingBehavior		LightingBehavior	"Choose from a list of possible behaviors that this light would take on";
var(Lighting) inherited(1472) vector LightOffset "This gets altered by Light Behavior Controllers during runtime";

//Helper Property: A struct containing everything to give a light a flickering effect
struct LightFlickerStruct
{
	var() float BrightnessMin;
	var() float BrightnessMax;
	var() float TimeOffMin;
	var() float TimeOffTransitionBias;
	var() float TimeOffMax;
	var() float TimeOnMin;
	var() float TimeOnTransitionBias;
	var() float TimeOnMax;
	var() float FlickerActivePeriodMin;
	var() float FlickerActivePeriodMax;
	var() float FlickerDormantPeriodMin;
	var() float FlickerDormantPeriodMax;
};
var(Lighting) inherited(704)  LightFlickerStruct	LB_FlickerParam			"Light flickering properties for use with LightingBehavior=LB_Flicker.";
var(Lighting) inherited(1492) CustomEditor string	LB_FlickerParamSound	"Plays when flicker goes to on state and shuts off when flicker goes to off state";

var(Lighting) deusexprop inherited(1490)  LightFlickerStruct LB_EMPFlickerParam "Light flickering properties for use with LightingBehavior=LB_EMPFlicker.";
var(Lighting) deusexprop inherited(1493) CustomEditor string	LB_EMPFlickerParamSound	"Plays when flicker goes to on state and shuts off when flicker goes to off state";

//Good for describing fires...
struct LightWaverStruct
{
	var() LightFlickerStruct LBWaver_FlickerParam;
	var() vector MaxWaverOffset;
	var() float TimeBetweenWavers;
	var() float TimeBetweenWaversDeviation;
};
var(Lighting) inherited(1473)  LightWaverStruct		LB_CandleWaverParam "Light wavering properties for use with LightingBehavior=LB_CandleWaver.  MaxWaverOffset is in feet.";
var(Lighting) inherited(1474)  LightWaverStruct		LB_TorchWaverParam "Light wavering properties for use with LightingBehavior=LB_TorchWaver.  MaxWaverOffset is in feet.";
var(Lighting) inherited(1475)  LightWaverStruct		LB_LargeFireWaverParam "Light wavering properties for use with LightingBehavior=LB_LargeFireWaver.  MaxWaverOffset is in feet.";

//Pulsating Lights... like a heartbeat... errr, if it was a light
struct PulseStruct
{
	var() float DurationOfBrightening;
	var() float DurationOfDarkening;
	var() float BrightnessMin;
	var() float BrightnessMax;
	var() float DurationOfDarkness;
	var() float DurationOfBright;
	var() float SoundDelayFromWhenBrighteningBegins;
};
var(Lighting) inherited(1476)  PulseStruct		LB_SlowPulseParam "Light pulsing properties for use with LightingBehavior=LB_SlowPulse.";
var(Lighting) inherited(1494) CustomEditor string	LB_SlowPulseParamSound	"Plays when 'SoundDelayFromWhenBrighteningBegins' seconds have elapsed since brightening begins";
var(Lighting) inherited(1477)  PulseStruct		LB_MediumPulseParam "Light pulsing properties for use with LightingBehavior=LB_MediumPulse.";
var(Lighting) inherited(1495) CustomEditor string	LB_MediumPulseParamSound	"Plays when 'SoundDelayFromWhenBrighteningBegins' seconds have elapsed since brightening begins";
var(Lighting) inherited(1478)  PulseStruct		LB_FastPulseParam "Light pulsing properties for use with LightingBehavior=LB_FastPulse.";
var(Lighting) inherited(1496) CustomEditor string	LB_FastPulseParamSound	"Plays when 'SoundDelayFromWhenBrighteningBegins' seconds have elapsed since brightening begins";

//Shifting Colors... from red to green to yellow and more, shift to new colors 'til your eyes get sore
struct ColorShiftStruct
{
	var() float DurationOfTransition;
	var() float DurationOfStability;
	var() array<color> ColorsToCycle;
	var() float SoundDelayFromWhenTransitionBegins;
};
var(Lighting) inherited(1479)  ColorShiftStruct	LB_ColorShiftParam "Light color-shift properties for use with LightingBehavior=LB_ColorShift.";
var(Lighting) inherited(1497) CustomEditor string	LB_ColorShiftParamSound	"Plays when 'SoundDelayFromWhenTransitionBegins' seconds have elapsed since transition begins";

//Strobe... not good for those players prone to epileptic seizures
struct StrobeStruct
{
	var() float DurationWhenOff;
	var() float DurationWhenOn;
};
var(Lighting) inherited(1480)  StrobeStruct	LB_StrobeParam "Strobe properties for use with LightingBehavior=LB_Strobe.";
var(Lighting) inherited(1498) CustomEditor string	LB_StrobeParamSound	"Plays when strobe is on, silent when strobe is off";

//...end property-oriented light effects system (created on 4/2/2003)
///////////////////////////////////////////////////////////////////////////////

var(LightLevel) inherited(1554) float		LightLevelWeight "The Light level weight for this light (only useful if lighting properties are set)";

// These properties are going away, but they must remain at the moment, because
// older maps use them.
var	editconst inherited(100)	byte			LightBrightness;
var	editconst inherited(101)	byte			LightHue;
var	editconst inherited(102)	byte			LightSaturation;

var	inherited(103)	ELightEffect	LightEffect;
var	inherited(104)	ELightType		LightType;
var	inherited(105)	byte			LightRadius;
var	inherited(106)	byte			LightPeriod;
var	inherited(107)	byte			LightPhase;
var	inherited(108)	byte			LightCone;
var	inherited(109)	byte			VolumeBrightness;
var	inherited(110)	byte			VolumeRadius;
var	inherited(111)	byte			VolumeFog;
var	inherited(112)	bool			bSpecialLit; // Light only affects special lit surfaces
var	inherited(113)	bool			bActorShadows; // Light casts actor shadows
var	inherited(114)	bool			bCorona; // Light uses skin as a corona
var	inherited(115)	bool			bLensFlare; // Light uses zone lens flare

//----------------------------------------------------------------------------
// Render properties
//----------------------------------------------------------------------------
// Drawing effect.
enum EDrawType
{
	DT_None,
	DT_Sprite,
	DT_Mesh,
	DT_Brush,
	DT_RopeSprite,
	DT_VerticalSprite,
	DT_Terraform,
	DT_SpriteAnimOnce,
	DT_StaticMesh,
	DT_DrawType,
	DT_Particle
};

// Style for rendering sprites, meshes.
enum ERenderStyle
{
	STY_None,
	STY_Normal,
	STY_Masked,
	STY_Translucent,
	STY_Modulated,
	STY_Alpha,
	STY_Particle
};

//AMSD: If you change these structs, must fix AActor.h version
struct RenderTypeStruct
{
	var() EDrawType DrawType;
	var() ERenderStyle Style;
	var byte UselessPackingVariable[2];
};

// RenderType ought to be split up; the DrawType doesn't want to be editor-visible,
// since manually changing it doesn't really make much sense (and messes stuff up.)
// But I suppose Style needs to be editor-visible... ugh.
var(Render) inherited(38) RenderTypeStruct		RenderType;

var(Render) inherited(39) texture				Texture;		 // Sprite texture.if DrawType=DT_Sprite
var(Render) transient		mesh				Mesh;            // Mesh if DrawType=DT_Mesh.
var(Render) inherited(41) Name					SkeletalTag;
var(Render) inherited(1320) vector				SkeletalScale "Scale the base bounding box flesh computes for a skeletal mesh by this amount.";
var(Render) inherited(2093) bool				bUsePivotForCenter "Use the pivot of the object, instead of the redering bounding box to calc the center of this object.";

// StaticMesh has no category, since we don't want it to show up in the editor.
// The editor-visible property for setting static meshes on objects is ObjectMesh.
var runtimeinstantiated(43) export StaticMesh	StaticMesh;		 // StaticMesh if DrawType=DT_StaticMesh

var(StaticMesh) inherited(1967) bool				LoadAllSkins "Load all the static mesh skins when loading resources for this object.";

var(Render) inherited(44) texture Skins[4];					// Multiple skin support.
var const inherited(45) export model			Brush;           // Brush if DrawType=DT_Brush.  Not seen by designers

struct RenderFlagsStruct
{
	var() bool bUnlit;						// Lights don't affect actor.
	var() bool bNoSmooth;					// Don't smooth actor's texture.
	var() bool bParticles;					// Mesh is a particle system.
	var() bool bRandomFrame;				// Particles use a random texture from among the default texture and the skins textures
	var() bool bMeshEnviroMap;				// Environment-map the mesh.
	var() bool bShadowCast;					// Casts static shadows.
	var() bool bStaticLighting;				// Uses raytraced lighting.
	
//  Moved to MaterialEffectsStruct.	
//	var() float transparency;				// If this value is anything but 0.0 it will draw the object with the specified percentage of transparency.
};

var(Render) inherited(46) RenderFlagsStruct	RenderFlags;

enum	eFXMaterialMode
{
	FXMaterialMode_None,
	FXMaterialMode_Replace,
	FXMaterialMode_Add
};

struct FXMaterialStruct
{
	var() string			Material;
	var() eFXMaterialMode	Mode;
};

struct TexturePanStruct
{
	var() float TexturePanX;
	var() float TexturePanY;
};

var(Render) inherited(1587) float HeatGlow "0.0 = doesn't glow in vision modes, 1.0 = glows brightly";
var(Render) inherited(1586) float EmissiveScale "0.0 = not emissive, 1.0 = fully emissive. This only applies to Flesh objects which don't have a light.";
var(Render) inherited(1452) float Transparency "0.0 = not transparent, 1.0 = invisible";
var(Render) inherited(1752) LightColorStruct Tint "Color modulated with the object's material";
var(Render) inherited(1453) FXMaterialStruct FXMaterial "Material = Material Name, Mode = application mode";
var(Render) inherited(1454) TexturePanStruct TexturePan "Pan texture UV across an entire object";
var(Render) inherited(1873) bool    UnderlayObject "Render this object in the underlay pass (between skybox and world).";
var(Render) inherited(1884) float ShadowExtrusionOffset "Added to a light's ShadowExtrusionDistance property (0.0 uses default = .5*object_radius)";

var		  runtimeinstantiated(47) vector				PrePivot;		 // Offset from box center for drawing.  Not seen by designers
var(Render) runtimeinstantiated(48) float				DrawScale;		 // Scaling factor, 1.0=normal size.
var(Render) inherited(49) float				ScaleGlow;		 // Multiplies lighting.
var(Render) inherited(50) float				SpriteProjForward;// Distance forward to draw sprite from actual location.
var(Render) inherited(51) float				LODBias;

var(Render) notextexport runtimeinstantiated(52) NoTravel MeshInstance MeshInstance; // Mesh instance.
var(Render) inherited(53) bool      bHighDetail;	 // Only show up on high-detail.

var(Render) inherited(54) byte				AmbientGlow;     // Ambient brightness, or 255=pulsing.
var(Render) inherited(55) byte				Fatness;         // Fatness (mesh distortion) unused?

struct RenderObjectMeshStruct
{
	var() string Name;
	var() string Skin;
};

var(Render) inherited(56) CustomEditor RenderObjectMeshStruct	ObjectMesh "Add this property to a concrete or archetype to give it a static mesh. -- BHS 2/15/02";

var(Render) inherited(1659) CustomEditor string					MaterialSkin "The name of the material skin to use for the skeletal mesh. -- TPERRY 05/28/03";

var(Render) inherited(1671) CustomEditor Array<RenderObjectMeshStruct> ObjectMeshArray "This property randomly selected a static mesh and skin from the list upon object spawn.  -cc 5-28-03";

//temp variable for previous versions
var editconst inherited(57) bool   bShadowCast;

//----------------------------------------------------------------------------
// Animation properties
//----------------------------------------------------------------------------
// Animation variables.
var(Animation) editconst inherited(58) name         AnimSequence;  // Animation sequence we're playing.
var(Animation) editconst inherited(59) float        AnimFrame;     // Current animation frame, 0.0 to 1.0.
var(Animation) editconst inherited(60) float        AnimRate;      // Animation rate in frames per second, 0=none, negative=velocity scaled.
var(Animation) editconst inherited(61) float        TweenRate;     // Tween-into rate.

//-----------------------------------------------------------------------------
// Animation replication.
// FIXME - rarely replicate animation (only if can't be predicted)
// @NOTE:AMSD Do we care anymore about animrep?
struct noexport AnimRep
{
	var name AnimSequence;
	var bool bAnimLoop;	//FIXME - pack bools into a byte
	var bool bTweening;
	var float AnimRate;	//FIXME - pack floats
	var float AnimFrame;
	var float TweenRate;
};

// Animation control.
var		inherited(62)		float		AnimLast;		// Last frame.
var		inherited(63)			float		AnimMinRate;	// Minimum rate for velocity-scaled animation.
var		inherited(64)		float		OldAnimRate;	// Animation rate of previous animation (= AnimRate until animation completes).
var 	inherited(65)			AnimRep		  SimAnim;		   // replicated to simulated proxies.

// for scaling animations applied to non-scaled meshes (make an animation library work on smaller/larger mesh)
struct AnimationScale
{
	var() float translationScale;
	var() float rotationScale;
	var() float timeScale;
};

var(Animation) inherited(1585) AnimationScale AnimationScaleFactor "Translation, rotation, and time scale for animations used my this actor.";

//----------------------------------------------------------------------------
// Collision properties
//----------------------------------------------------------------------------
// Collision size.
var(Collision) inherited(66) const float CollisionRadius; // Radius of collision cyllinder.
var(Collision) inherited(67) const float CollisionHeight; // Half-height cyllinder.

//AMSD: If you change these structs, must fix AActor.h version
struct CollisionFlagsStruct
{
	var() const bool bCollideActors;		// Collides with other actors.
	var() bool bCollideWorld;				// Collides with the world.
	var() bool bBlockActors;				// Blocks other nonplayer actors.
	var() bool bBlockPlayers;				// Blocks other player actors.
	var() bool bProjTarget;					// Projectiles should potentially target this actor.
};

var(Collision) inherited(68) Travel CollisionFlagsStruct CollisionFlags;
var(Collision) inherited(69) bool	bBounce; //Flags for what an object does upon collision
var(Collision) inherited(70) bool		bCollideWhenPlacing;          // This actor collides with the world when placing.

// Camera blocking properties
//    NOTE: bOverrideSMFlag_BlocksCamera MUST be true for bBlocksCamera to have any effect.....
var(Collision) inherited(839) bool		bBlocksCamera;	               // This actor blocks a camera's view
var(Collision) inherited(2014) bool     bOverrideSMFlag_BlocksCamera;  // This actor overrides the SM flag.

var inherited(71) const array<Actor>    Touching;		// List of touching actors.

//----------------------------------------------------------------------------
// Timing properties
//----------------------------------------------------------------------------

// Execution and timer variables.
//JWC:  The TimerRate and TimerCounter vars were only being used in one place in the code:  to update the timer rates.
//Don't think any scripts are using them.
//var inherited(72) float                 TimerRate;     // Timer event, 0=no timer.
//var inherited(73) const float           TimerCounter;	 // Counts up until it reaches TimerRate.
//AMSD:Nobody was using this, and it was getting queried a LOT.
//var(Timing) runtimeinstantiated(74) float		  LifeSpan;      // How old the object lives before dying, 0=forever.
var inherited(75) const float           LatentFloat;   // Internal latent function use.

//----------------------------------------------------------------------------
// Networking properties
//----------------------------------------------------------------------------
var inherited(76) const transient int NetTag;

// Network control.
var inherited(77) float NetPriority; // Higher priorities means update it more frequently.
var inherited(78) float NetUpdateFrequency; // How many seconds between net updates.

//----------------------------------------------------------------------------
// Event properties
//----------------------------------------------------------------------------
var(Events) inherited(79) name		  Tag;			 // Actor's tag name.
var(Events) inherited(80) name          Event;         // The event this actor causes.

//----------------------------------------------------------------------------
// Object(bad name) properties
//----------------------------------------------------------------------------
var(Object) inherited(81) name InitialState;
var(Object) inherited(82) string Group; 
var(Object) inherited(1235) localized string FriendlyName;

// 7/16/03-MDB : Changing this to old style because new style properties get nuked before we
// had a chance to clear out our deleted list!
var const actor DeletedActor;       // Next actor in just-deleted chain.

//----------------------------------------------------------------------------
// "Advanced"  properties
//----------------------------------------------------------------------------
var(Advanced) inherited(85) bool		bGameRelevant;		// Always relevant for game
var(Advanced) runtimeinstantiated(86) bool        bHidden;       // Is hidden during gameplay.
var(Advanced) inherited(87) const bool  bNoDelete;     // Cannot be deleted during play.
var(Advanced) inherited(89) bool  bAlwaysDraw;		//always draw this actor, no matter where in lvl, used mainly by garrett
var(Advanced) inherited(1588) bool bAIIgnoreActor					"The AI will collect no evidence on this actor.";
var(Advanced) inherited(1611) bool bOutOfWorld					"The actor is effectively out of the world (rendering and physics).";

//----------------------------------------------------------------------------
// Damage properties
//----------------------------------------------------------------------------
var inherited(91) Pawn                  Instigator;    // Pawn responsible for damage.

//----------------------------------------------------------------------------
// Trigger Script properties
//----------------------------------------------------------------------------
var(Scripts) inherited(92) NoTravel CustomEditor array<name> TriggerScripts "This property will add an array of trigger script definitions, which you can add one by one from the trigger manager. - MDB 9/9/02";
var(Scripts) inherited(913) const bool bScriptsDisabled "This will cause any trigger scripts on this object to not be instantiated, effectively disabling them. - MDB 9/9/02";
var(Scripts) inherited(1768) bool bEnableScriptInherit "If set to true, this actor will inherit any trigger scripts from any of its parents (i.e. without this property, only local scripts will instantiate).";

//----------------------------------------------------------------------------
// Conversation properties
//----------------------------------------------------------------------------
var(Conversations) inherited(870) array<name> ConvosToBind;

//----------------------------------------------------------------------------
// Sound properties
//----------------------------------------------------------------------------
var(Sound) inherited(676) CustomEditor string SoundSpawn "This SoundSchema will play when the object is spawned at the location it was spawned at -- BHS 12.16.2002";
var(Sound) inherited(677) CustomEditor string SoundDestroy "This SoundSchema will play when the object is destroyed at the location it was destroyed at -- BHS 12.16.2002";
var(Sound) inherited(678) CustomEditor string SoundAmbient "This SoundSchema will play on the object and track its location, it probably should be a looping Schema -- BHS 12.16.2002";
var(Sound) inherited(1258) float DoorSoundDamp "This property is for doors and windows and stuff.  At 0 the door doesn't change the sound; at 1 it silences it; at 0.5 it cuts it to half volume, etc. -- BHS 12.16.2002";
var(Sound) inherited(1521) bool bIsOccluder "This property is for non-doors that you want to be occluders and bind to portals and stuff (doors automatically behave as though they had this property set to true.) -- BHS 04.17.2003"; 
var(Sound) inherited(1406) string CharacterType "This will be filled in as the character type for footstep notetrack sounds. -- AC 3.13.03";
var(Sound) inherited(1582) CustomEditor string DoorOpenSound "This is the name of the schema played when this door object opens.  It must have the right trigger scripts on it, though.  -- BHS 04.30.2003";
var(Sound) inherited(1583) CustomEditor string DoorCloseSound "This is the name of the schema played when this door object closes.  It must have the right trigger scripts on it, though.  -- BHS 04.30.2003";

//----------------------------------------------------------------------------
// Physics-sound properties
//----------------------------------------------------------------------------

enum eObjectWeight
{
	Weight_Light,
	Weight_Medium,
	Weight_Heavy,
};


var(PhysicsSound) inherited(1175) eObjectWeight ObjWeight "This is the weight of an archetype or concrete as it pertains to which physics sounds get played. -- BHS 11/26/02";
var(PhysicsSound) inherited(1380) string PhysSoundTag "This can be a single tag (no value) that is added to all physics-sound lookups for this object, used to special case sounds. -- BHS 2/25/03";


//----------------------------------------------------------------------------
// Material properties
//----------------------------------------------------------------------------
var(MaterialArch) inherited(1127) CustomEditor int MaterialCategory "This property is for Material Archetypes only and determines which material category an archetype corresponds to. - BHS 11/22/02";
var(MaterialArch) inherited(1315) bool bObjectsStickIn "If set to true objects set with the eCR_Stick_Based_On_Material contact type will stick in this material. An arrow sticking in wood for example - ALC.";
var(MaterialArch) inherited(1579) thiefprop bool bIsClimbable "Can the player climb on this material. -ALC";

var(Material) inherited(1144) CustomEditor int MaterialOverride "This property determines the material category of an object, overriding the category of its static mesh. - BHS 11/22/02";

//----------------------------------------------------------------------------
// DX2/T3 Shared Gameplay Properties
//----------------------------------------------------------------------------

enum eSex
{
	Sex_None,
	Sex_Male,
	Sex_Female,
};

enum eBodyLocation
{
	BodyLocation_None,
	BodyLocation_Head,
	BodyLocation_Torso,
	BodyLocation_LeftArm,
	BodyLocation_RightArm,
	BodyLocation_LeftLeg,
	BodyLocation_RightLeg,
};

enum eStimulusType
{
	StimulusType_None,
	StimulusType_Blunt,
	StimulusType_DX2Bullet,
	StimulusType_Cold,
	StimulusType_Edge,
	StimulusType_Electric,
	StimulusType_DX2EMP,
	StimulusType_Heat,
	StimulusType_Poison,
	StimulusType_DX2Radiation,
	StimulusType_Smoke,		
	StimulusType_Stun,
	StimulusType_Fire,
	StimulusType_Flash,
	StimulusType_T3Gas,
	StimulusType_Water,
	StimulusType_Impulse,
	StimulusType_Collision,
	StimulusType_DX2BotDomination,
	StimulusType_DX2Knockout,
	StimulusType_Fall,
	StimulusType_DX2Scramble,
	StimulusType_Extinguish,
	StimulusType_Blind,
	StimulusType_Backstab,
	StimulusType_UnbindingBlackjack,
	StimulusType_HolyWater,
	StimulusType_T3Explosive,
	StimulusType_AlternateBlunt,
 	StimulusType_T3BlessSpell,
 	StimulusType_T3SpeedSpell,
 	StimulusType_T3MakeInvisibleSpell,
 	StimulusType_Moss,
 	StimulusType_Blood,
 	StimulusType_DeathWater,
 	StimulusType_Trigger,
 	StimulusType_Crushed
};

enum eDeathResponse
{
	DeathResponse_None,
	DeathResponse_Destroy,
};

enum eHealthState
{
	HealthState_Alive,
	HealthState_Dead,
	HealthState_Disabled,
	HealthState_None,
};

enum eDropoffModel
{
	DropoffModel_Linear,
	DropoffModel_RadiusSquared,	
	DropoffModel_Max,
	DropoffModel_RadiusRoot,
	DropoffModel_ApplyToHeadOnly
};

// enums which specify a class of animations to be used for
// any AIs wielding this weapon
enum eAIWeaponType
{
    AIWeaponType_Melee,		// swords and other one-handed melee weapons
    AIWeaponType_Thrown,	// grenades, LAMs, and other thrown weapons
    AIWeaponType_Ranged,	// grenades, LAMs, and other thrown weapons    
};

enum eBodyType
{
	BodyType_Human,
	BodyType_Monster,
	BodyType_Animal,
	BodyType_Bot
};

struct BodyLocationInfo
{
	var() name				BoneName			"The name of the bone that maps onto a body location.";
	var() eBodyLocation		BodyLocation		"The general location on the body where this bone lives.";
};

struct BurstInfo
{
	var() float				NumProjectiles		"How many shots are fired in the burst";
	var() float				AnimRateMultiplier	"How much to we speed attack up for the burst (anim playback speed)";
	var() float				TracerFrequency		"What percent of the time is the projectile a tracer (as a percent 0-1)";
	var() bool				UseInAltFire		"Is this burst mode used in alt fire mode or regular fire?";
};	

enum EStaticAddSurfacesFlag
{
	AddSurfaces_Default,
	AddSurfaces_Always,
	AddSurfaces_Never
};

var(NavMesh) inherited(886) EStaticAddSurfacesFlag AddSurfacesToNavMesh; 

enum EStaticMeshSubdivideFlag
{
	Subdivide_Default,
	Subdivide_Always,
	Subdivide_Never
};

var	inherited(1764) bool StuckInObject "Used by contact system to say that the item is stuck in an object (so systems like AIs wont try to use weapons that are stuck in them)";

var(NavMesh) inherited(887) EStaticMeshSubdivideFlag CanSubdivideNavMesh; 
var(NavMesh) inherited(1741) bool SubtractAsOne "Use a convex hull wrapping all of this actor's physics hulls to subtract from the navmesh."; 

var(AIWeapon) inherited(1433) float WeaponLockoutTime	"Amount of time that must pass before the primary firing function of this weapon can be used again.";
var(AIWeapon) inherited(1434) float AltWeaponLockoutTime "Amount of time that must pass before the alt firing function of this weapon can be used again.";
enum eAIWeaponSpecialFiringModes
{
	AIWeaponFiring_Normal,
	AIWeaponFiring_Spew,
	AIWeaponFiring_MultiFire,
};
var(AIWeapon) inherited(1441) eAIWeaponSpecialFiringModes AISpecialFiringMode "A special firing mode used by the AI's to fire things like the flamethrower.  This goes on a weapon that needs a special AI firing mode.";
var(AIWeapon) inherited(1442) eAIWeaponSpecialFiringModes AIAltSpecialFiringMode "A special firing mode used by the AI's to fire things like the flamethrower.  This goes on a weapon that needs a special AI firing mode.";
var(AIWeapon) inherited(1538) bool bAIAltFireDisabled "A flag that tells the AI to never use the alt fire of this weapon (useful for bots).";
var(AIWeapon) inherited(1539) bool bAIFireDisabled "A flag that tells the AI to never use the normal fire of this weapon (useful for bots).";
var(AIWeapon) inherited(1443) float MinSpewTime "Minimum time that a weapon should spew when used by an AI (i.e. flamethrower)";
var(AIWeapon) inherited(1444) float MaxSpewTime "Maximum time that a weapon should spew when used by an AI (i.e. flamethrower)";
var(AIWeapon) inherited(1566) float MeleeAttackAngleSweep "The sweeping angle that a melee attack will be performed from left to right (in degrees).";
var(AIWeapon) inherited(1581) int MeleeAttackNumberRays "The number of incremental raycasts that are done within the MeleeAttackAngleSweep.";
var(AIWeapon) inherited(1969) bool bUsesSpawnProjectile "This weapon requires a projectile loading sequence.";
var(AIWeapon) runtimeinstantiated(1993) bool bPerfectlyAccurateWeapon "This *weapon* will always aim dead on target. (use for magic wands.)";
var(AIWeapon) inherited(2027) float MinAttackRange "This overrides any weapon range considerations and forces a ranged combatant to get within this distance (feet) to attack.";

var(Weapon) inherited(832)	BurstInfo	GunBurst "(Optional)Existance of this property means that the weapon's firing uses a burst (not DX2 specific although the name doesn't seem that way)";
var(Weapon) inherited(1783) float StickTargetToWallDistance "(Optional) for weapons that stick into targets, this property specifies how close the target needs to be to a wall inorder to pin the target to the wall if it dies on that attack";
struct WeaponCameraInfo
{
	var() bool  bIsContinuous;
	var() float ImpulseStrength;
};

var(UserArm) inherited(644) deusexprop string UserArmAnimPrefix		"The prefix name of the animation (specified by the user arm artist)";

var(Weapon) inherited(1649) deusexprop WeaponCameraInfo WeaponCameraEffect "Specifies how the camera gets impulsed when using this weapon";

enum eContactResponse
{
	eCR_Bounce,
	eCR_Destroy,
	eCR_Stick,
	eCR_Stick_Based_On_Material,
	eCR_Stick_On_Material_Or_Destroy
};

var(Weapon) inherited(1739) float EffectiveRadius "This property lets you set the effective radius of a weapon (in feet) so that AI's respond appropriately to it. This is currently only used for grenades.";

struct StimulusAmount
{
	var() float			Amount		"How much stimulus of this type are we applying";
	var() eStimulusType	Stimulus	"What type of stimulus are we applying";
};

struct ContactStim
{
	var() float				TotalTime		"The length of time in seconds we want to ping. 0 == do not ping";
	var() StimulusAmount	Amount			"The stimulus and amount we are applying per ping";
	var	  eBodyLocation		BodyLocation	"The location the stim is applied to ( is None - designers don't need access to this)";
	var   int 				BoneNumber      "The actual bone number of the stim target";
};

struct ContactTransfer
{
	var() bool					Inactive	"Is this pinger inactive";
	var() bool					DeleteOnXfr	"Will delete itself on transfer";
	var() array<ContactStim>	Stim		"The stimulus info";
};

struct RadialRaycast
{
	var() bool				bRaycast		"Should there be a raycast before assigning the stimulus to another actor, to make sure it is in the same room.";	
	var() vector			RaycastOrigin  "Where the origin of the raycast should be from the center of this stimulus.";
};

struct RadialStimPing
{
	var() StimulusAmount	Amount		"The stimulus and amount we are applying per ping";
	var() float				Radius		"The radius we are pinging (in feet)";
	var() eDropoffModel		Model		"How the stimulus drops off with distance";
};

struct RadialPinger
{
	var() bool					Inactive	"Is this pinger inactive";
	var() bool					IsExplosion	"This will cause the ping to happen just 1x (example: explosions)";	
	var() array<RadialStimPing>	Stim		"The stimulus info";
	var() RadialRaycast			Raycast		"Set these props if the explision should do a raycast before assigning damage.";
};

struct HitPoint
{
	var()			float			Current				"The current Hit Points";
	var()			float			Max					"The max Hit Points";
	var()			eBodyLocation	Location			"The location on the body of the HitPoint";
};

struct StimulusInfo
{
	var() float			StimulusAmount					"The amount of stim being applied";
	var() vector		HitNormal						"The hit normal of stimuls";
	var() vector		WorldLocation					"The world location of where the stim is being applied on dest";
	var() eStimulusType	StimulusType					"The Stimulus Type being applied";
	var() eBodyLocation	BodyLocation					"The Body location of where the impulse is beign applied (arm, head, etc..)";
	var   int 	        BoneNumber                      "The actual bone number of the stim target";
};

struct ProximityTriggerInfo
{
	var() float DistanceToTrigger		"the max dist away a moving object can be for this to destroy itself (in feet)";
	var() float ProximitySafeTime		"time for any people to get away before this arms itself";
	var() bool bNeedMovement			"if true the nearby actor needs to be moving for this to detonate";
};

var(Collision) inherited(1311) bitfield eCollisionFilterFlags
{
	CollisionFilterFlags_Breakable,
	CollisionFilterFlags_Transparent, 
} CollisionFilterFlags "These flags are used for special filter and describe additional infor about an object (ie breakable & tranparent mean its glass)";


var inherited(1411) float LastLightLevel "The last computed light level on this actor.";
var inherited(1412) float LastLightLevelTime "The time at which the light level was last calculated for this actor.";

//////////////////////////////
// Shared Hidden Properties //
//////////////////////////////

var runtimeinstantiated(420)			 int		Inventory_CurrentItemIndex;			//index to current inventory item

//////////////////////////////
// Shared Editor Properties //
//////////////////////////////

var(Actor)	inherited(999)				bool			bNotTickable	"The object does not need to receive tick messages (note, this cannot be changed when game is running)";
var(Actor)	inherited(1000)	bool			bNotMoveableRender "The graphical representation of this object never translates or rotates (note, this cannot be changed when game is running)";
var(Actor)	inherited(1001)				bool			bNotSpawnable	"The object cannot be spawned during game runtime (only from within the editor)";
var(Actor)	inherited(1318)	bool			bNotMoveablePhysics	"The physics representation of this object never translates or rotates (note, this cannot be changed when game is running)";


var inherited(1147) Actor Culprit "The culprit of the attack";	

// Changed HealthState to runtimeinstantiated since the AI does many lookups on HealthState in the evidence container. This sped these queries up quite a bit. - MDB 7/23/03
var(Health) runtimeinstantiated(495) Travel eHealthState			HealthState			"state this actor is in (health wise)";
var(Health) inherited(818) Travel HitPoint				MainHealth			"The main health property for this object";
var(Health) inherited(1029) eDeathResponse				DeathResponse	"Specifies what the automated response of the code should be when the objects healthstate goes to Dead";
var(Health) inherited(1049) float						MinimalDamage   "Is the percentage of maximum health at which the DamageLevel condition is fired for Minimal Damage.";
var(Health) inherited(1050) float						ModerateDamage  "Is the percentage of maximum health at which the DamageLevel condition is fired for Moderate Damage.";
var(Health) inherited(1051) float						ExtremeDamage   "Is the percentage of maximum health at which the DamageLevel condition is fired for Extreme Damage.";
 
var(Pawn) inherited(464) OptionTravel eSex Sex				"what sex is the character";
var(Pawn)   inherited(1056) float MinFallDamage "The least this pawn has to fall to deal damage to him. Unreal units. Use prop under FallDamage for the player.";
var(Pawn)   inherited(1057) float MaxFallDamage "If this pawn falls this many unreals or more, he will die. Use prop under FallDamage for the player.";

var(Stimulus) inherited(885) ContactTransfer	ContactXfrInfo		"Upon collisions this stimulus pinger is transfered to the other object";
var(Stimulus) inherited(888) RadialPinger		RadialPingInfo		"Every second a radial pulse of the stim specefied is emitted";

var(Inventory) inherited(98)	int	    MaxInventoryStack		"how many of these can we stack";
var(Inventory) inherited(1030)  bool    bRepeatUseOnHold		"does holding the useitem key down (or useweapon) cause this to keep getting used?";

var(Spawn) inherited(1011) bool bDelaySpawnActive	"Is the delay spawner active";
var(Spawn) inherited(1012) float DelaySpawnTime				"How long until the delay spawns occures (in seconds)";

var(Lifetime) inherited(625) bool bHasLifetime	"Does this actor have a lifetime";
var(Lifetime) inherited(626) float Lifetime		"How long is this actors lifetime, in seconds";
var(Lifetime) inherited(1795) bool bHideDontDestroy "(Optional) for effects, such as lights / flahses, we secretly hide not destroy the objects";

var(Flammable) inherited(650) bool bIsFlammable    "If this actor can catch on fire.";
var(Flammable) inherited(651) Travel bool bIsOnFire		"If the actor is currently on fire.";
var(Flammable) inherited(668) int FireStimAmntNeeded  "Amount of fire stimulus needed to set this object on fire.";
var(Flammable) inherited(669) int WaterStimAmntNeeded "Amount of water(or extinguisher) stimulus needed to extinguish this object when on fire.";

var(Proximity) inherited(631) bool					bIsProximity			"if true this will destroy itself when an an bIsConsideredForProx object is nearby";
var(Proximity) inherited(634)			bool					bIsConsideredForProx	"if this item should be considered for proximity item searches";
var(Proximity) inherited(869)			ProximityTriggerInfo	ProxTriggerInfo			"Information needed to setup the trigger mechanism for prxomimity";

var(Frob) inherited(94) float FrobBias			"how much do we cheat to make this easier to frob";

var(Puddle) inherited(1944) int NumMarks "The number of puddle marks that appear around the outter radius of the puddle.";
var(Puddle) inherited(1961) int NumInnerMarks "The number of puddle marks that appear around the inner radius of the puddle.";
var(Puddle) inherited(1946) float PuddleRadius "The radius of the entire puddle in unreal units.";
var(Puddle) inherited(1947) float MarkRadius "The radius of each puddle mark in unreal units.";
var(Puddle) inherited(1948) int PuddlePriority "How important is this puddle to keep around, the higher number the more important it is.";
var(Puddle) inherited(1949) float RadiusVariance "How much the radius for each mark of the puddle should vary, 0 to 1 value";
var(Puddle) inherited(1950) float AngleVariance "How much the angle for each mark of the puddle should vary, 0 to 1 value";
var(Puddle) inherited(1951) float GrowTime "How long in seconds it takes this puddle to grow.";
var(Puddle) inherited(1952) float ShrinkTime "How long in seconds it takes this puddle to shrink.";
var(Puddle) inherited(1966) float StartTime "How long in seconds it takes all the puddle marks to start.";

enum eShadowCastingType
{
	ShadowCasting_True,
	ShadowCasting_False,
};

var(Render) inherited(737) eShadowCastingType CastShadows;  // When to cast shadows

enum EFleshLightType
{
	FL_Unknown,
	FL_Omni,
	FL_OmniNoShadow,
	FL_Unsupported,
	FL_Ambient,
	FL_AmbientVertex,
	FL_Spot,
	FL_SpotNoShadow,
	FL_Directional,
	FL_DirectionalNoShadow,
	FL_Project
};

var(Lighting) inherited(881) EFleshLightType FleshLightType;

var(Render) const inherited(872) texture Texture_a;		// ambient
var(Render) const inherited(873) texture Texture_a_v;		// ambient vertex
var(Render) const inherited(874) texture Texture_d_s;		// directional shadow
var(Render) const inherited(880) texture Texture_d_ns;	// directional no shadow
var(Render) const inherited(875) texture Texture_o_ns;	// omni no shadow
var(Render) const inherited(876) texture Texture_o_s;		// omni shadow
var(Render) const inherited(877) texture Texture_o_v;		// omni vertex
var(Render) const inherited(878) texture Texture_s_ns;	// spot no shadow
var(Render) const inherited(879) texture Texture_s_s;		// spot shadow

var(Contact) const inherited(921) eContactResponse ContactResponse "What should this object do when it collides with something.";
var(Contact) inherited(2057) bool bIsTumbleRailing "If a sliding AI comes into contact with this, he will immediately ragdoll and try to impulse over it. USE ONLY FOR low railings near precipices -- otherwise it will look totally strange. YOU HAVE BEEN WARNED.";

var inherited(882) int ChildCount; // used for keeping track of my number of owners when I'm deleted
//I'm not putting in childactors yet because they'd be out of sync from the editor version
//but I've already grabbed the ID and we might want it in the future.
//AMSD:Note they won't cleanupdestroyed properly.
//var inherited(1687) Array<Actor> ChildActors; //used for keeping track of children/owner relations

var(BeamTrigger) inherited(1755) bool bIsBeamTrigger "Set on beam triggers so AI can easily identify the class.";

var(AITags) inherited(943) string AINearObjectTag "The tag that will be sent with the +NearObject:[...] tag when an AI is referring to something near this object.";
var(AITags) inherited(954) objectlist float AINearObjectDistanceInFeet "The distance (in feet) for an NPC to refer to this object using the +NearObject:[...] AI bark tag.";
var inherited(1962) float AINearObjectTimeStamp "Used so that a given object won't be used for near object barks within a minute or so.";

var(AIDoors) inherited(980) float AIDoorOpenDistanceInFeet "The distance (in feet) that an AI needs to stand from this door in order to open it.";

//var(SpecialOptions) inherited(1249) CustomEditor Travel Array<name> SpecialOptions "A list of special options to be used in something like the security computer or elevator control panel.  The master list of special options should be kept under MetaData->SpecialOptions. - MDB 12/12/02";
struct SpecialOptionsStruct
{
	var() CustomEditor name Name							"The name of the special option that is to match the one in MetaData";
	var bool bIsDisabled									"Whether this option is disabled - defaults to false as a natural GameSys behavior";
	var() bool bUseOnlyOnce									"Whether this option is to be used only once or not";
};
var(SpecialOptions) inherited(1679) Travel Array<SpecialOptionsStruct> SpecialOptions "A list of special options to be used in something like the security computer or elevator control panel.  The master list of special options should be kept under MetaData->SpecialOptions. - MDB 12/12/02";

// I really hate to add a property just for this, but there appears to be no other way
// to distinquish a live grenade from anything else. - Jerm 06/11/03
var	inherited(1737) bool IsLiveGrenade		"Is this actor a live grenade.";

var(Elevator) inherited(2145) StimulusAmount ElevatorCrushStim "How much damage an elevator does to an object when it is detected that it has crushed it.";

//----------------------------------------------------------------------------
// DX2 Gameplay Properties
//----------------------------------------------------------------------------

/////////////////////
// Misc. DX2 Enums //
/////////////////////

enum eIdIconType
{
	IdIconType_None,
	
	IdIconType_Bot,
	IdIconType_Break,
	IdIconType_Creature,
	IdIconType_Hack,
	IdIconType_Human,
	IdIconType_Lock,
	IdIconType_HotObject,
	IdIconType_Keypad,
	IdIconType_Industrial,
};

enum eAlarmState
{
	AlarmState_None,
	AlarmState_On,
	AlarmState_Off,
};

enum eObjectCategory
{
	Category_Object,
	Category_AI,
	Category_Player
};

enum eDamageLevel
{
	DamageLevel_Minimal,
	DamageLevel_Moderate,
	DamageLevel_Extreme
};

//AMSD:Make sure you only add to the END of this.  Don't change the order.
//Changing the order requires a rebuild of gamesys from .d2u files.
enum eInventoryType
{
	InventoryType_None,
	InventoryType_Medkit,
	InventoryType_Biocell,
	InventoryType_AugCannister,
	InventoryType_Multitool,
	InventoryType_MeleeWeapon,
	InventoryType_ProjectileWeapon,
	InventoryType_ThrownWeapon,
	InventoryType_ProximityMine,
	InventoryType_Junk,
	InventoryType_Food,
	InventoryType_Binoculars,
	InventoryType_FireExtinguisher,
	InventoryType_Trash,
	InventoryType_WeaponMod,
	InventoryType_Sin
};

var inherited(1254) Travel int TraveledInventorySlot;  // What position (if any) in your inventory is this object (to be replaced post-travel)
var inherited(1255) Travel bool SelectedInventory;  // Flag for whether or not this was the selected inventory item when we travelled
var inherited(1793) thiefprop Travel bool PlayerTraveledInventory;		//T3 needs to differentiate between player and normal inventory
var inherited(1794) thiefprop Travel int TraveledInventoryStackCount;	//how many of these are there in the inventory
var inherited(2099) thiefprop Travel bool PlayerSelectedInventory;			// is this what the player currently has selected.

///////////////////////////
// DX2 Hidden Properties //
///////////////////////////

var inherited(421) deusexprop Travel int		Augmentation_CurrentItemIndex;		//is this item selected (augmentation)

///////////////////////////
// DX2 Editor Properties //
///////////////////////////

var(Throw) inherited(1810) deusexprop float ThrowCapPercent		"This is the angle (as a percent that we max our throw at (.75 = 45 degrees up)";
var(Throw) inherited(1811) deusexprop float ThrowMultiplier		"This is the multiplier that is applied to your throw angle as percent";

var(Frob) inherited(93) objectlist bool  IsFrobbable			"is this frobbable";
var(Frob) inherited(95) deusexprop float FrobDistance		"how far can the person frobing be from something (this is on the player)";

var(BioEnergy) inherited(322) deusexprop Travel float BioEnergyCurrent;
var(BioEnergy) inherited(323) deusexprop float BioEnergyMax;

var(DX2Actor) inherited(1298) deusexprop bool	CanTakeEmpConverterDamage	"Used for EMP Mod to specify types of targets that are EMPable by it";
var(DX2Actor) inherited(456) deusexprop eIdIconType IdIconType	"Type of icon to display for this when targeted";
var(DX2Actor) inherited(698) deusexprop Travel bool bDisabled "Has the actor been disabled (e.g. emp'd)?";
var(DX2Actor) inherited(731) deusexprop float	BioEnergyCost	"for simple objects that take BE when you use them";
var(DX2Actor) inherited(1120) deusexprop Travel bool bLockedDown "Is this actor locked down, via security alert?";

var(DX2Actor) inherited(1878) deusexprop bool bIsAlarmPanel "Set to true on objects that are frobbed by AI's to sound alarms.";

var(Inventory) inherited(96)	deusexprop string	InventoryIconName		"name of the icon to use for inventory";
var(Inventory) inherited(318)	deusexprop int		DefaultInventorySlot	"which slot does this go into by default";
var(Inventory) inherited(496) bool DontDropOnDeath			"can this item be droped on death";
var(Inventory) inherited(1064) deusexprop eInventoryType InventoryType "How this object behaves in inventory (what kind of object is it?)";
var(Inventory) inherited(1213) deusexprop bool bDominatedBotInventoryItem "An inventory item that only exists in the inventory of dominated bots for the player to use (special bot weapons, etc)";
var(Inventory) inherited(1222) deusexprop bool bPlantWhenUsed "Does this inventory item require the equipper to be planted (motion thing, only for player)?";
var(Inventory) inherited(1523) deusexprop localized string ItemDescription "The localized description for this item";

var(AugCannister) inherited(99) deusexprop bool		IsBlackMarket	"is this a black market cannister (or aug)";

//var(Hacking) inherited(1317) deusexprop bool IsHackPanel			"Used to identify hack panels";
var(Hacking) inherited(1134) deusexprop float HackTimeMultiplier	"A multiplier to be used on the hack time for hacking into this object.";
var(Hacking) inherited(1136) deusexprop Travel int HackCreditPool "The pool of credits available to the hacker of this object.";

//Moved to HackAssociationLinkDataObject.uc
//enum eHackScreenType
//{
//	HackScreen_ATM,
//	HackScreen_SodaMachine,
//	HackScreen_SecurityPanel,
//	HackScreen_RecyclingMachine,
//	HackScreen_SnackMachine,
//	HackScreen_ArcadeMachine,
//	HackScreen_Jukebox,
//	HackScreen_MapTerminal
//};
//HackScreen is part of the HackAssociationLink, now... because there is only one hack panel linked to many different terminals
//var(Hacking) inherited(1137) deusexprop eHackScreenType HackScreen "Which user interface screen to use if this object is sucessfully hacked.";

var(Recycle)  inherited(1226) deusexprop bool  IsRecyclable		"Tells if this actor is recyclable or not.";

var(Terminal) inherited(1209) deusexprop enum eTerminalScreenType
{
	TerminalScreen_ATM,
	TerminalScreen_SecurityPanel,
	TerminalScreen_ElevatorControlPanel,
	TerminalScreen_HoloComm,
	TerminalScreen_MapTerminal,
	TerminalScreen_Jukebox,
} TerminalScreen "Which interface screen/manager to use when accessing this device.";

var(Strength) inherited(1217) deusexprop Travel float Strength			"specifies the maximum mass pounds that this actor can pick up";

var(Medkit) inherited(471) deusexprop bool	IsMedkit	"Is this a medkit";
var(Medkit) inherited(472) deusexprop float HealingCount	"amount of healing it can give";
var(Medkit) inherited(659) deusexprop float HealingRate	"amount that can be healed per second(ignored for inventory objects, only really used for medbots at the moment)";


var(BioEnergyCell) inherited(453) deusexprop float BioEnergyCount		"Amount of BE it can give";
var(BioEnergyCell) inherited(660) deusexprop float BioRechargeRate			"amount that can be regenerated per second";

var(Bot) inherited(661) deusexprop float BotRegenRate "The amount this bot regenerates repair points per second";

var(MedBot) inherited(662) deusexprop bool IsMedBot "Is this a medbot?";
var(MedBot) inherited(663) deusexprop float HealingCountMax "The total this bot can heal.";

var(RepairBot) inherited(664) deusexprop bool IsRepairBot "Is this a repair bot";
var(RepairBot) inherited(665) deusexprop float BioEnergyCountMax "The total this bot can recharge";

var(NanoformerBot) inherited(1437) deusexprop float NanoCountMax "The total number of nanites this bot can store";
var(NanoformerBot) inherited(1439) deusexprop float NanoCost "Number of nanites this bot uses to neutralize a hazard";
var(NanoformerBot) inherited(1440) deusexprop float NanoCount "Number of nanites this bot is currently storing";

enum eBotDominationFunction
{
	BotDomFunction_Attack,
	BotDomFunction_Heal,
	BotDomFunction_Recharge
};

var(BotDomination) inherited(1843)	deusexprop	eBotDominationFunction	BotDominationFunction		"What type of function this bot performs when dominated.";
var(BotDomination) inherited(1844)	deusexprop	float					BotDominateionRefireRate	"For weapon attacks, how often the bot can attack";

var(Text) inherited(1775) deusexprop array<localized string> MiscText "Text shown to the user when the designer says so";

enum eLockStrength
{
	kLS_Unlocked,
	kLS_OnePick,
	kLS_TwoPicks,
	kLS_ThreePicks,
	kLS_Infinite
};

var(Multipick) inherited(972) deusexprop eLockStrength LockStrength "How locked is this?  If not present, the object is unlocked.";
var(Multipick) inherited(1066) deusexprop float EnergyDrainPower "How much energy can a multipick drain from something?";

//AMSD:not used anymore
//var(Multipick) inherited(973) deusexprop int UnlockStrength "How much lockstrength can this remove?  Multitools should just put '1' here.";
//var(Multipick) inherited(1065) deusexprop int NumPicksToDisable "How many multipicks does this take to disable? (For robots, cameras, etc)";


var(Keys) inherited(1006) CustomEditor deusexprop Array<name> Keys "A list of keys, either to give or any needed to pass.  The keys should be in the list kept in MetaData->Keys. - MDB 10/24/02";
var(Logins) inherited(1063) CustomEditor deusexprop Array<name> Logins "A list of logins, either to give to the player or those that will successful complete a login.  Logins should be kept in single list under MetaData->Logins. - MDB 11/06/02";
var(Notes) inherited(1299) CustomEditor deusexprop Array<name> Notes "A list of notes to give to the player.  The notes should be in the list kept in MetaData->Notes. - Jerm 01/09/03";
var(DatavaultImages) inherited(1300) CustomEditor deusexprop Array<name> DatavaultImages "A list of datavault images to give to the player.  The datavault images should be in the list kept in MetaData->DatavaultImages. - Jerm 01/09/03";
var(DatavaultMaps) inherited(1301) CustomEditor deusexprop Array<name> DatavaultMaps "A list of datavault maps to give to the player.  The datavault maps should be in the list kept in MetaData->DatavaultMaps. - Jerm 01/09/03";
var(JukeboxSongs) inherited(1325) CustomEditor deusexprop Array<name> JukeboxSongs "A list of songs to give to the jukebox.  The songlist should be in the list kept in MetaData->SongList. - Kain 01/20/03";
//var(AssociatedCosts) inherited(1328) objectlist int  UsageFee	"How much does this machine charge per use?";

var(Health) deusexprop inherited(1026) float HealthLeechDrainAmount "How much can the health leech drone drain(at level 1) from this actor when it is dead?";

var(AutoAim) deusexprop inherited(1862) bool AutoAimAble "Can this be autoaimed at";

var(Conversations) inherited(955) deusexprop array<string> Datalinks "A list of datalinks to be evaluated, typically through a trigger action. - MDB 9/20/02";
var(Conversations) inherited(1548) deusexprop string DatalinkImage "Which texture to use for the face of the person you are speaking to during a datalink conversation. - Kain 4/23/03";

var(Power) inherited(1230) deusexprop Travel bool HasPower "Toggle state for whether power is supplied to this actor or not - true means it has power, false means it does not";
var(Power) runtimeinstantiated(1244) deusexprop Travel bool bOn "Whether something is in the on state or not.";

var(HoloComm) inherited(1312) deusexprop float LinkedActorScale "Scaler for drawing the linked actor.";

var(AquiredData)   inherited(1274) deusexprop string	AquiredDataFileName	"What file contains the text to this aquired data object.";
var(AquiredDataUI) inherited(1275) deusexprop int		PageLeftMargin		"Left margin for a page";
var(AquiredDataUI) inherited(1276) deusexprop int		PageRightMargin		"Right margin for a page";
var(AquiredDataUI) inherited(1277) deusexprop int		PageTopMargin		"Top margin for a page";
var(AquiredDataUI) inherited(1278) deusexprop int		PageBottomMargin	"Bottom margin for a page";

var(Vision) inherited(1781) deusexprop string WarmSignatureMaterial "When the vision biomod is activated and warm bodies are seen this is the heat signature material.";
var(Vision) inherited(1782) deusexprop string ColdSignatureMaterial "When the vision biomod is activated and cold bodies are seen this is the heat signature material.";

//----------------------------------------------------------------------------
// Automap properties
//----------------------------------------------------------------------------

enum eAutoMapIDEnums
{
	eAMIDF_0,
	eAMIDF_1,
	eAMIDF_2,
	eAMIDF_3,
	eAMIDF_4,
	eAMIDF_5,
	eAMIDF_6,
	eAMIDF_7,
	eAMIDF_8,
	eAMIDF_9,
	eAMIDF_10,
	eAMIDF_11,
	eAMIDF_12,
	eAMIDF_13,
	eAMIDF_14,
	eAMIDF_15,
	eAMIDF_16,
	eAMIDF_17,
	eAMIDF_18,
	eAMIDF_19,
};

struct AutoMapFilter
{
	var() eAutoMapIDEnums FilterEnum;			// used to filter against map data
	var() int ID;
	var() string Name;							// name of this filter (useful for designers only)
};



//----------------------------------------------------------------------------
// T3 Gameplay Properties
//----------------------------------------------------------------------------

enum eInvType
{
	eIT_MELEE,
	eIT_ARROW,
	eIT_ITEM,
	eIT_SPECIAL_ITEM,
	eIT_LOOT,
	eIT_BOOK,
	eIT_KEY,
	eIT_SPECIAL_LOOT
};

enum eLootType
{
	eLT_METAL,
	eLT_ART,
	eLT_GEM,
	eLT_SPECIAL
};

enum eBombMode
{
	eWM_NOMODE,
	eWM_IDLE,
	eWM_PROXIMITY,
	eWM_CONTACT,
	eWM_TIMER
};

enum eWeaponStance
{
	eWS_NONE,
	eWS_SWORD,
	eWS_BLACKJACK,
	eWS_BOW,
	eWS_HAMMER,
	eWS_RIFLE,
	eWS_PISTOL,
	eWS_GRENADE,
	eWS_ITEM,		// This is so the weapon loadout screen works with items such as keys, that need to be pickpocketed
	eWS_BOTWEAPON,	// Used for bot weapons which mean the weapon is always out and enabled
	eWS_DAGGER,
	eWS_BITE,		// Bites are special types of weapons that have different properties for driving attacks (see engine\src\AIWeaponHelper.cpp)
	eWS_MAGICWAND,	// Magic wands and their spells, which are very similar to bows, in fact.
	eWS_FAKEMELEE	// For fake melee weapons that get treated exactly the same as swords, but are always in hand
};

enum eItemAffect
{
	eIA_Health,
	eIA_Glyph,
	eIA_HealthAndGlyph,
};

//this if for internal use, nothing set by designers uses this enum
enum eSoundVolume
{
	eSV_None,
	eSV_Moss,
	eSV_Water
};

struct thiefprop LockPickHotspot
{
	var() float MinRadius;
	var() float MaxRadius;
	var() int MinAngle;
	var() int MaxAngle;
};

//thief structs
struct thiefprop LockPickStage
{
	var() Array<LockPickHotspot> Hotspots;	
};

struct thiefprop LPInfo
{
	var() Array<LockPickStage> PickStages;
	var int CurStage;
};

struct thiefprop PlayerMeleeWeaponInfo
{
	var() float MaxDist;
	var() float FocusDist;
	var() float SearchHeight;
	var() float SearchWidth;
};

struct thiefprop PlayerMovementSpeed
{
	var() float MinSpeed;
	var() float MaxSpeed;
};

struct thiefprop PickpocketInfo
{
	var() float MinimumSecondsAfter;
	var() float MaximumSecondsAfter;	
};

//thief props for editor
var(Junk) inherited(506) thiefprop bool bIsJunk			"Is this item junk - it will go to junk inventory when frobbed if so.";

var(Throw) inherited(622) thiefprop bool bCanThrow		"Can this item be thrown when it is used.";
var(Throw) inherited(2114) thiefprop vector MinThrowRotation  "When the item is thrown, its angular velocity will vary between this and MaxThrowRotation. (specified in degrees/sec) The components will vary individually. (x,y,z) = (pitch,yaw,roll)";
var(Throw) inherited(2115) thiefprop vector MaxThrowRotation  "When the item is thrown, its angular velocity will vary between this and MinThrowRotation. (specified in degrees/sec) The components will vary individually. (x,y,z) = (pitch,yaw,roll)";

var(Inventory) inherited(497) thiefprop bool bIsInventory	"Should this item go into the players inventory";
var(Inventory) inherited(176) thiefprop name InvName		"The name that will appear under this item in the inventory.";
var(Inventory) inherited(1220) thiefprop int SellPrice "Amount stores will buy this item for.";
var(Inventory) inherited(178) thiefprop bool bIsStackable	"If this item can be stacked.";
var(Inventory) inherited(181) thiefprop EInvType InvType	"What category this item should go into in the inventory screen.";
var(Inventory) inherited(1986) thiefprop ELootType LootType	"What type of loot is this?  Art, metal, or gems?";
var(Inventory) inherited(1992) thiefprop string HelpText	"Help text associated with this inventory object.";
var(Inventory) inherited(182) thiefprop float InvDrawScale	"How big/small this item should be scaled when drawn in the inventory.";
var(Inventory) inherited(183) thiefprop rotator InvOrientation	"How this item should be facing when drawn in the inventory.";
var(Inventory) inherited(764) thiefprop bool bDeleteOnUse "If this item should be deleted from inventory after it has been used. Leave this to false on thrown objects, they will handle themselves.";
var(Inventory) inherited(979) thiefprop eItemAffect ItemAffect		"What things does this item affect";
var(Inventory) inherited(1998) thiefprop int InvSlot "What slot should this item go into.";
var(Inventory) inherited(2088) thiefprop bool bCanUseWhileClimbing "Can this item be used while the player is on walls and ladders.";
var(Inventory) inherited(2110) thiefprop bool bDontUseOnFullHealth "If set to true this item cant be used when the player has full health.";

var(Store) inherited(1903) thiefprop int StoreWindowNumber "What window this item corresponds to on the store interface. Only set this on instantiated objects.";
var(Store) inherited(1904) thiefprop int StorePrice "How much this item costs at the store it is a part of. Make sure StoreWindowNumber is set.";
var(Store) inherited(2113) thiefprop bool bOnlyBuyOnce "This item is only allowed to be bought once, and then disappears from the store.";

var(Highlight) inherited(186) thiefprop int HighlightDist	"The maximum distance away it can be from Garrett and still be highlighted.";

var(Weapon) inherited(498) thiefprop bool bIsWeapon			"If this item is a weapon";
var(Weapon) inherited(194) eStimulusType WeaponStimulus	"What stimulus this weapon gives off when it attacks something. Note this is no longer used for player weapons.  Used for melee weapons across both projects.";
var(Weapon) inherited(666) int WeaponStimulusAmount "What dose of WeaponStimulus does this weapon give. Note this is no longer used for player weapons. Used for melee weapons across both projects.";
var(Weapon) inherited(187) float Exposure			"Additional amount light gem is lit when Garrett has equipped this item.";
var(Weapon) inherited(189)			 eWeaponStance WeaponStance "The type of weapon this is. The character using this weapon knows which animations to use based on how this is set.  DX2 should only set this on weapons AIs will use.";
var(Weapon) inherited(1316) thiefprop PlayerMeleeWeaponInfo MeleeWeaponSearchParams "For bow or sword this determines what kind of line checks will be performed, when searching for what the weapon hit. All of these vals are measured in unreal units.";
var(Weapon) inherited(1556) thiefprop vector ArrowGravity "How much gravity is on a given arrow in unreal units.";
var(Weapon) inherited(2154) thiefprop bool bHasBeenFired "This is used for scripting, and should never be set in the gamesys. -alc";

var(Bomb) inherited(499) thiefprop	bool bIsBomb		"Is this item a bomb.";
var(Bomb) inherited(509) thiefprop eBombMode BombMode	"The mode this bomb is currently it.";
var(Bomb) inherited(627) thiefprop eBombMode DefaultMode"The default mode bombs of this type should be in.";
var(Bomb) inherited(637) thiefprop bool	bBombProxNeedMovement	"If in proximity mode, does it need movement to explode.";
var(Bomb) inherited(196) thiefprop float BombProxDist	"If in proximity mode, this is the radius it will look for actors in.";
var(Bomb) inherited(197) thiefprop float BombProxTime	"If in proximity mode, time after thrown until starts looking for nearby actors";
var(Bomb) inherited(513) thiefprop float BombTimerTime	"If in timer mode, time until it explodes.";

var(Lock) inherited(386) thiefprop bool bIsLocked		"Is this actor locked.";
var(Lock) inherited(387) thiefprop string LockGroup		"If the key is a masterkey, this is the group of locks it can open. This should be set both on the key and on the lock.";
var(Lock) inherited(388) thiefprop string KeyOpenStr	"What string opens this lock, should match the LockOpenStr on the key.";

var(LockPick) inherited(1387) thiefprop LPInfo LockPickInfo "Set all the lockpick stages.";

var(LockHandle) inherited(825) thiefprop float MaxLockHandlePitch  "What is the maximum amount this lock should rotate when being opened.";

var(LockPlate) inherited(1386) thiefprop bool bIsLockPlate "Is this actor a lock plate?.";

var(Key) inherited(505) thiefprop Travel bool bIsKey				"Is this actor a key.";
var(Key) inherited(970) thiefprop Travel Array<string> LockOpenStr		"All the locks this key can open. Should match the KeyOpenStr on the lock.";
var(Key) inherited(390) thiefprop Travel bool bIsMasterKey			"If this is a master key. If so set MasterLockGroup, it will open all locks that have the same LockGroup.";
var(Key) inherited(823) thiefprop Travel string MasterLockGroup   "If this key is a master key, this will open any key with the same LockGroup prop set on it."; 

var(Climber) inherited(202) bool bIsLadder				"Is this actor a ladder.";
var(Climber) inherited(203) thiefprop bool bIsRope		"Is this actor a rope.";
var(Climber) inherited(1163) thiefprop bool bIsRailing  "Is this actor a railing.";

var(Book) inherited(510) thiefprop bool bIsBook			"Is this actor a book";
var(Book) inherited(455) thiefprop string BookFileName				"What file contains the text to this book.";

var(BookUI) inherited(1021) thiefprop int			LeftMargin					"Left margin for a page";
var(BookUI) inherited(1022) thiefprop int			RightMargin					"Right margin for a page";
var(BookUI) inherited(1023) thiefprop int			TopMargin					"Top margin for a page";
var(BookUI) inherited(1024) thiefprop int			BottomMargin				"Bottom margin for a page";
var(BookUI) inherited(1025) thiefprop string		PageTurnAnimation			"Name of animation to turn a page in book";

var(GlyphPower) inherited(977) thiefprop Travel float GlyphPowerCurrent	"Current amount of glyph power";
var(GlyphPower) inherited(978) thiefprop float GlyphPowerMax		"Maximum amount of glyph power";

var(Player) inherited(1053) thiefprop float JumpHeight  "The max height the player can jump.";
var(Player) inherited(1280) thiefprop float HoldArrowTime "The time the player can hold the arrow drawn, before he starts to get weak.";
var(Player) inherited(1281) thiefprop float WeakArrowTime "The time the player can hold the arrow weakly, before he undraws it.";
var(Player) inherited(1282) thiefprop float BowStrength "The max strength of the bow";
var(Player) inherited(1283) thiefprop int MaxWeakRotation "The max rotation the bow will move by when the player gets weak.";
var(Player) inherited(1284) thiefprop int WeakRotPerSec "The amnt of rotation the arms will move by per second when the player is weak.";
var(Player) inherited(1285) thiefprop float BowDrawPerSec "The amnt the player draws the bow back per second.";
var(Player) inherited(1289) thiefprop float BowFOVZoomIn "What the min fov should be when the player zooms in while shooting bow.";
var(Player) inherited(1290) thiefprop float BowFOVZoomInSpeed "The speed at which the fov should zoom in measured per second.";
var(Player) inherited(1291) thiefprop float BowFOVZoomInDelay "How long the camera should delay the fov zoom when the player shoots the bow.";
var(Player) inherited(1292) thiefprop float BowFOVZoomOutSpeed "The speed at which the fov should zoom out after firing bow, measured in seconds.";
var(Player) inherited(1293) thiefprop float BowFOVZoomOutDelay "How long the camera should delay the zoom out after the player has released the bow.";
var(Player) inherited(2126) thiefprop float BowFOVImmediateZoomInSpeed "The speed at which the fov should zoom in measured per second when the zoom toggle has been hit.";
var(Player) inherited(2127) thiefprop float BowFOVImmediateZoomOutSpeed "The speed at which the fov should zoom in measured per second when the zoom toggle has been hit.";
var(Player) inherited(1332) thiefprop float BaseFOV  "What the base fov should be while this actor is the player.";
var(Player) inherited(1351) thiefprop PlayerMovementSpeed BodyCarrySpeed "The min and max speeds garrett moves at while he is carrying a body.";
var(Player) inherited(1410) thiefprop float AddlLineHeight "How much further off the ground the player should be moved.";
var(Player) inherited(1909) thiefprop float MechEyeMaxZoomFOV "What is the fov value when the mechanical eye is zoomed in all the way.";
var(Player) inherited(1910) thiefprop float MechEyeZoomRate "How many degrees FOV zoom per second.";
var(Player) inherited(1911) thiefprop float MechExeQuickExitZoomRate "How many degrees FOV zoom per second when exiting due to movement or state change.";
var(Player) inherited(2055) thiefprop float CollisionDamageVelModifier "How many feet per second does something have to be moving to do 1 damage.";
var(Player) inherited(2056) thiefprop float CollisionDamageRatioMax "Get a programmer before changing this value.";
var(Player) inherited(2128) thiefprop float AirControlMultiplier "Value from 0 to 1 of how much inertia should remain in the players movement. A value of 1 results in no air movement, 0 will create fast movement.";

var(AIWeapon) inherited(1418) thiefprop float WeaponVelocity "The initial velocity to give this weapon when it is used by an AI.";
var(AIWeapon) inherited(1419) thiefprop float MeleeWeaponRange "If this is a melee weapon, set this to give the ai a general idea of how far its range is.";

// Paranoia
var(Paranoia) inherited(1730) thiefprop int ParanoiaContribution "This is the paranoia contribution of this object.";

//for internal use
var inherited(210) thiefprop bool WeaponCanAttack;  //if the weapon should spawn damage event on contact
var inherited(514) thiefprop float BombLife;  //how much time left before explode
var inherited(624) thiefprop bool bCanAttack; //if the object is currently in attck mode
var inherited(824) thiefprop rotator BaseLockPitchRot;
var inherited(962) thiefprop eSoundVolume SoundVolumeType;
var inherited(1996) thiefprop bool bIsBeingPicked;
var inherited(2132) transient thiefprop float LastFireStimTime;

struct LookupFunctionPoint
{
	var() float LookupInput "Point on input axis.  Value corresponds to whatever usage this particular lookup function has.";
	var() float LookupOutput "Point on output axis.";	
};

var(LightLevel) runtimeinstantiated(1463) array<LookupFunctionPoint>	LightLevelToVisibilityLookup "Translate the level light level to an actual visibility number";

struct PermaBoneControlStruct
{
	var() string	BoneName;
	var() float		PitchOffset;
	var() float		YawOffset;
	var() float		RollOffset;
	var() bool		bLockBone;
};

//AMSD:Due to the way serialization is handled at the moment (8/31/02),
//new flags must be added at the end.
var(Filter) inherited(837) deusexprop bitfield eDXObjectFilterFlags
{
	eDXOFF_Seattle,
	eDXOFF_Cairo,
	eDXOFF_Germany,
	eDXOFF_Antartica,
	eDXOFF_Liberty,
	eDXOFF_HiTech,
	eDXOFF_LowTech,
	eDXOFF_Indoor,
	eDXOFF_Outdoor,
	eDXOFF_Generic
} DXObjectFilter;

var(Filter)  inherited(844) thiefprop bitfield eThiefObjectFilterFlags
{
	eTOFF_Indoor,
	eTOFF_Outdoor
} ThiefObjectFilter;

var(Filter) inherited(822) int MapNumber "Pick a different one for each mission(dx) or map(t3) so that we can filter later.";

var(Respawn) inherited(2094) thiefprop bool		bDontRespawnOnMapLoad "Don't respawn this actor on a map level if it has been picked up or has died (in the case of AIs).";

var(LoadFilter) inherited(2003) bitfield eObjectLoadFilter 
{
	kLoadFilter_0,
	kLoadFilter_1,
	kLoadFilter_2,
	kLoadFilter_3,
	kLoadFilter_4,
	kLoadFilter_5,
	kLoadFilter_6,
	kLoadFilter_7,
	kLoadFilter_8,
	kLoadFilter_9,
	kLoadFilter_10,
	kLoadFilter_11,
	kLoadFilter_12,
	kLoadFilter_13,
	kLoadFilter_14,
	kLoadFilter_15,
	kLoadFilter_16,
	kLoadFilter_17,
	kLoadFilter_18,
	kLoadFilter_19,
	kLoadFilter_20,
	kLoadFilter_21,
	kLoadFilter_22,
	kLoadFilter_23,
	kLoadFilter_24,
	kLoadFilter_25,
	kLoadFilter_26,
	kLoadFilter_27,
	kLoadFilter_28,
	kLoadFilter_29,
	kLoadFilter_30
} ObjectLoadFilter "Determines when this object will be loaded.";

// RelevantChangeTypes property used to specify which change types are potentially interesting to NPCs for this actor
var(AIEvidence) inherited(871) bitfield eChangeType
{
	CHANGE_Moving,
	CHANGE_Missing,
	CHANGE_OutOfPlace,
	CHANGE_Damaged,
	CHANGE_Destroyed,
	CHANGE_Malfunctioning,
	CHANGE_Disabled,
	CHANGE_OpenClosed,
	CHANGE_OnOff,
	CHANGE_MissingAlly,
	CHANGE_Spooked,
	CHANGE_Burning,
	CHANGE_Smoke,
	CHANGE_Gas,
	CHANGE_LiveGrenade,
	CHANGE_BloodPuddle
} RelevantChangeTypes "Specifies which change types are potentially interesting to NPCs for this actor.";

//"If set on an object in an AI's loadout, determines how long after being pickpocketed the AI will wait before playing the 'Hey, I've been pickpocketed' bark. Omit this property or set its floats to -1 to prevent the AI from noticing this object is gone. Keys should *NOT* have this set.";
var (AIEvidence) inherited(1960) PickpocketInfo NoticeWhenPickpocketed "How long after having this pickpocketed an AI will react. Omit or set to -1 to ignore the robbery. Keys should *not* have this set, or should be -1.";

// Facial Expression enumeration
//
// IMPORTANT NOTE:  the following enum MUST be kept in synch with the enumeration (and string table) in FacialExpressionDefs.h 
//		However, do not copy over eFACE_MAX, as an analogous one is auto-generated by UCC MAKE

enum EFacialAnimations
{
	eFACE_None,
	eFACE_Angry,
	eFACE_Scared,
	eFACE_Happy,
	eFACE_Sad,
	eFACE_Surprised,
	eFACE_Blind,
	eFACE_Inquisitive,	
	eFACE_Cough,
	eFACE_Whistle,
	eFACE_Yawn,
	eFACE_Sneeze,
	eFACE_VeryAngry,
	eFACE_SlightlyAngry,
	eFACE_Intense,
	eFACE_Curious,
	eFACE_Focused,
	eFACE_Tense,
	eFACE_Pain,
	eFACE_Tired,
	eFACE_Drunk,
	eFACE_Sleepy,
	eFACE_Exasperated,
	eFACE_Guilty,
	eFACE_Embarrassed,	
	eFACE_NewExpression1,
	eFACE_NewExpression2,
	eFACE_NewExpression3,
	eFACE_NewExpression4,
	eFACE_NewExpression5,
	eFACE_NewExpression6,
	eFACE_NewExpression7,
	eFACE_NewExpression8,
	eFACE_NewExpression9,
	eFACE_NewExpression10,
	eFACE_NewExpression11,
	eFACE_NewExpression12
};

// FocusPoint properties dictate whether or not the AI should try and look at an object during various behaviors that suport
// the usage of focus points (patrolling, searching, etc)

var(FocusPoint) inherited(1917) objectlist bool bIsFocusPoint "Set to true to mark this object as a focus point.";

enum EFocusMovementModifier
{
	FOCUS_KeepMoving,
	FOCUS_StopAndLook,
	FOCUS_StopCrouchAndLook
};

var(FocusPoint) runtimeinstantiated(1918) EFocusMovementModifier FocusMovementModifier "Specifies whether or not the focus point will ask the AI to stop in place.";
var(FocusPoint) inherited(1919) float FocusStopTimerMin "Minimum amount of time an AI will stop to look at this focus point, if and only if the movement modifier on the FocusPoint tells the AI to stop.";
var(FocusPoint) inherited(1920) float FocusStopTimerMax "Maximum amount of time an AI will stop to look at this focus point, if and only if the movement modifier on the FocusPoint tells the AI to stop.";
var(FocusPoint) runtimeinstantiated(1932) float FocusMaxDistance "If specified, an AI will not use this focus point unless it is within this distance of the AI.";
var(FocusPoint) inherited(1936) float FocusPointTimeOut "After this focus point is used by an AI, no other AI will use it for this many seconds.";

var runtimeinstantiated(1921) float FocusTimeStamp "Used internally so more than one AI doesn't use the same focus point within a certain amount of time.";

var(FocusPoint) runtimeinstantiated(1922) bitfield EFocusAllowedBehaviors
{
	FB_Patrol,
	FB_Search
} FocusAllowedBehaviors "The AI will only use this focus point during the associated behavior.";

enum EVirtualPathBlockerType
{
	eDBT_None,
	eDBT_Cylinder,
	eDBT_OBB
};

var(AIPathfinding) inherited(1756) EVirtualPathBlockerType VirtualPathBlockerType "Set on NON-PHYSICAL actors to determine how this actor will be treated in pathfinding.";
var(AIPathfinding) inherited(1333) bool bIgnoreInLocalPathfinding "If true, the local pathfinder will not pay any attention to this object, physical or otherwise.";

//----------------------------------------------------------------------------
// End of new property system properties
//----------------------------------------------------------------------------


// Packing bools..
var(Events)	  bool		bLocalGameEvent;		// this event should be saved as a local saved game event
var(Events)	  bool		bTravelGameEvent;		// this event should travel across levels as a saved game event
var			  bool		bDestroyInPainVolume;	// destroy this actor if it enters a pain volume
var			  bool		bDontDestroy;			// Dont destroy this object

// These next flags, since they are visible to designers, will want to get moved into the new system
// Some of them should possibly NOT be visible to designers (editor flags, bRotateToDesired)...?

//Editing flags
var bool        bHiddenEd;     // Is hidden during editing.
var bool        bHiddenEdGroup;// Is hidden by the group brower.
var bool        bDirectional;  // Actor shows direction arrow during editing.
var() bool        bEdShouldSnap; // Snap to grid in editor.

// Should Tick in AppTime ? (default is ticked in sim time)
var bool		bShouldTickInAppTime;
var bool		bShouldNotTick; // to tick or not to tick, THAT is the question. whether it is nobler in the mind...
var bool		bNeedsToMove; // tick optimization/correction.  Set this if you try to move early, will update at appropriate time.

// These flags could conceivably move to the new system, but I'd rather leave them in the old system for now
// because they can't be seen by designers at the moment, and the old system handled flags very well from a memory
// efficiency standpoint.
var 		  bool		bOwnerNoSee;	 // Everything but the owner can see this actor.
var			  bool      bOnlyOwnerSee;   // Only owner can see this actor.
var			  bool		  bTrailerSameRotation;	// If PHYS_Trailer and true, have same rotation as owner.
var			  bool		  bTrailerPrePivot;	// If PHYS_Trailer and true, offset from owner by PrePivot.
var			  bool		  bWorldGeometry;	// Collision and Physics treats this actor as world geometry
var bool                  bEdLocked;     // Locked in editor (no movement or rotation).
var transient bool        bEdSnap;       // Should snap to grid in UnrealEd.
var	bool				  bScriptInitialized;// set to prevent re-initializing of actors spawned during level startup
var			  bool		bHurtEntry;			// keep HurtRadius from being reentrant
var			  bool		bCarriedItem;		// being carried, and not responsible for displaying self, so don't replicate location and rotation
var			  bool		bTravel;			// Actor is capable of travelling among servers.
var           bool        bInterpolating;    // Performing interpolating.
var			  const bool  bJustTeleported;   // Used by engine physics - not valid for scripts.
// Symmetric network flags, valid during replication only.
var const bool bNetInitial;       // Initial network update.
var const bool bNetOwner;         // Player owns this actor.
var const bool bNetRelevant;      // Actor is currently relevant. Only valid server side, only when replicating variables.
var const bool bSimulatedPawn;	  // True if Pawn and simulated proxy.
var const bool bDemoRecording;	  // True we are currently demo recording
var const bool bClientDemoRecording;// True we are currently recording a client-side demo
var const bool bClientDemoNetFunc;// True if we're client-side demo recording and this call originated from the remote.
var bool				  bPathColliding;// this actor should collide (if bWorldGeometry && bBlockActors is true) during path building (ignored if bStatic is true, as actor will always collide during path building)
//21 flags

// Other flags.

// Flags staying in old system
// AMSD: Since these flags can't be edited in the editor, and all told only count for one word, hashing them doesn't make
// much sense.  Having even one of them on an object would take up more memory hashed than 32 of them unhashed.
// Especially since a very large number of actors want to know about bTicked.
var const	bool			bDeleteMe;     // About to be deleted.
var transient const bool	bTicked;       // Actor has been updated.
var const	bool	   		bIsPawn;		 // True only for pawns.
var const	bool			bAnimFinished; // Unlooped animation sequence has finished.
var const	bool			bAnimLoop;		// Whether animation is looping.
var const	bool			bAnimNotify;	// Whether a notify is applied to the current sequence.
var const	bool			bAnimByOwner;	// Animation dictated by owner.
var const	bool			bIsMover;		// Is a mover.
var	const	bool			bNetOptional;  // Actor should only be replicated if bandwidth available.
var const	bool			bNetTemporary; // Tear-off simulation in network play.
var	const	bool			bAlwaysRelevant; // Always relevant for network.
var	const	bool			bReplicateInstigator;	// Replicate instigator to client (used by bNetTemporary projectiles).
var	const	bool			bClientAnim;
var	const	bool			bDirty;			// set when any attribute is assigned a value in unrealscript, reset when the actor is replicated
var	const	bool			bDirtyReplication;	// if true, only replicate actor is bDirty is true - useful if no C++ changed attributes (such as physics) 
											// bDirtyReplication only used with bAlwaysRelevant actors
var const	bool			bAlwaysTick;     // Update even when players-only. (like during a pause)
var transient const	bool	bLightChanged; // Recalculate this light's lighting now.
var const	bool			bDynamicLight; // Temporarily treat this as a dynamic light.
var const	bool			bTimerLoop;    // Timer loops (else is one-shot).
// Some editor flags.
var const bool            bMemorized;    // Remembered in UnrealEd.
var const bool            bHighlighted;  // Highlighted in UnrealEd.
var transient const bool  bTempEditor;   // Internal UnrealEd.
var	bool			  bBobbing;      // used for smoothing movement in water
var	const bool			  bObsolete;	 // actor is obsolete - warn level designers to remove it
var transient bool		  bPathTemp;	 // Internal/path building
var           bool        bAcceptsProjectors;// Projectors can project onto this actor
var			  bool		  bSentSpawnNotification; //For internal use, keep track of if this item has sent out a spawn message
var			  bool		  bCanBeDestroyedInPreBeginPlay;
var() bool bNoSpawnNotifications "Don't send any actor spawn notifications when this actor is spawned.";


//(29)

//Unused flags?
//var transient const bool	bAssimilated;  // Actor dynamics are assimilated in world geometry.

// Net Roles
// Since Role and RemoteRole are always set on spawn, there is little point in having them in the object system.
// On the other hand, if we aren't doing multiplayer, we should consider removing these or doing something about them.
enum ENetRole
{
	ROLE_None,              // No role at all.
	ROLE_DumbProxy,			// Dumb proxy of this actor.
	ROLE_SimulatedProxy,	// Locally simulated proxy of this actor.
	ROLE_AutonomousProxy,	// Locally autonomous proxy of this actor.
	ROLE_Authority,			// Authoritative control over the actor.
};
var ENetRole Role;
var ENetRole RemoteRole;

//-----------------------------------------------------------------------------
// Forces.

enum EForceType
{
	FT_None,
	FT_DragAlong,
};

var (Force) EForceType	ForceType;
//AMSD: Switched old "ForceRadius" and "ForceScale" (which we weren't using
//to newstyle, so we can query them if and when we care and have a ForceType set.
var(Force) inherited(1465) float		ParticleForceRadius;
var(Force) inherited(1466) float		ParticleForceScale;

// LastRenderTime
// Since LastRenderTime is set on any actor whenever it is rendered, every actor will eventually have this property. 
// So there isn't any point in putting it into the object system.  It won't save anything, and designers can't edit it
// anyway.
var	float	LastRenderTime;

//-----------------------------------------------------------------------------
// Structures.

// Identifies a unique convex volume in the world.
struct noexport PointRegion
{
	var zoneinfo Zone;       // Zone.
	var int      iLeaf;      // Bsp leaf.
	var byte     ZoneNumberLow;  // Zone number (low byte).
	var byte     ZoneNumberHigh; // Zone number (high byte).
};

//-----------------------------------------------------------------------------
// Major actor properties.

// Region is also important to every actor, and has no bearing from parents so we're not putting this in the new property system.
var notextexport const PointRegion     Region;        // Region this actor is in.

// Flesh BSP Zone number
var transient int				m_FleshBSPZone;

// Scriptable.
// These also don't go on abstract objects, so they have to live on the actors themselves, since every actor needs them.
var notextexport      const LevelInfo Level;         // Level this actor is on.
var notextexport transient const Level XLevel;        // Level object.

// Owner.
// Since Owner is set whenever an Actor is spawned, every actor will have this property.  So there isn't any point in putting
// it into the object system, it won't save anything, and designers can't edit it anyway.
var const Actor					Owner;         // Owner actor.

// TickPhase
// This determines when the object gets ticked (actor list is sorted by tick phase).
// Negative tickphases get ticked before physics, positive tick phases get ticked after
// physics
var transient int				TickPhase;

var const Actor					AttachedParent;          // Parent object to which we are attached (rigid attach, etc)

// Internal tags.
// Not sure what to do about these yet...  I think they're used fairly often, and they change frame to frame and don't
// depend on the parent.  So probbly don't belong in system.
var const native noexport int CollisionTag, LightingTag;

//-----------------------------------------------------------------------------
// Physics.

//AMSD:These are native so that they don't serialize in undo/redo either.  
//If you need them serialized, have to write custom serialize code for them.
var native noexport int m_physicsObjectPadding;
var native noexport int m_FleshObject;
var native noexport int m_FleshLight;
//this is transient not native... for undo?
var transient noexport int m_isSelectedPadding; // used by the Editor to determine selection

const MAXSTEPHEIGHT = 35.0; // Maximum step height walkable by pawns

// Internal.

//-----------------------------------------------------------------------------
// Enums.

// Travelling from server to server.
enum ETravelType
{
	TRAVEL_Absolute,	// Absolute URL.
	TRAVEL_Partial,		// Partial (carry name, reset server).
	TRAVEL_Relative,	// Relative URL.
};

// Input system states.
enum EInputAction
{
	IST_None,    // Not performing special input processing.
	IST_Press,   // Handling a keypress or button press.
	IST_Hold,    // Handling holding a key or button.
	IST_Release, // Handling a key or button release.
	IST_Axis,    // Handling analog axis movement.
    IST_Click,       // simtime-pause mouse action: Single-Click event
    IST_DoubleClick, // simtime-pause mouse action: Double-Click event
};

// double click move direction.
enum EDoubleClickDir
{
	DCLICK_None,
	DCLICK_Left,
	DCLICK_Right,
	DCLICK_Forward,
	DCLICK_Back,
	DCLICK_Active,
	DCLICK_Done
};

// Input keys.
enum EInputKey
{
/*00*/	IK_None			,IK_LeftMouse	,IK_RightMouse	,IK_Cancel		,
/*04*/	IK_MiddleMouse	,IK_Unknown05	,IK_Unknown06	,IK_Unknown07	,
/*08*/	IK_Backspace	,IK_Tab         ,IK_Unknown0A	,IK_Unknown0B	,
/*0C*/	IK_Unknown0C	,IK_Enter	    ,IK_Unknown0E	,IK_Unknown0F	,
/*10*/	IK_Shift		,IK_Ctrl	    ,IK_Alt			,IK_Pause       ,
/*14*/	IK_CapsLock		,IK_Unknown15	,IK_Unknown16	,IK_Unknown17	,
/*18*/	IK_Unknown18	,IK_Unknown19	,IK_Unknown1A	,IK_Escape		,
/*1C*/	IK_Unknown1C	,IK_Unknown1D	,IK_Unknown1E	,IK_Unknown1F	,
/*20*/	IK_Space		,IK_PageUp      ,IK_PageDown    ,IK_End         ,
/*24*/	IK_Home			,IK_Left        ,IK_Up          ,IK_Right       ,
/*28*/	IK_Down			,IK_Select      ,IK_Print       ,IK_Execute     ,
/*2C*/	IK_PrintScrn	,IK_Insert      ,IK_Delete      ,IK_Help		,
/*30*/	IK_0			,IK_1			,IK_2			,IK_3			,
/*34*/	IK_4			,IK_5			,IK_6			,IK_7			,
/*38*/	IK_8			,IK_9			,IK_Unknown3A	,IK_Unknown3B	,
/*3C*/	IK_Unknown3C	,IK_Unknown3D	,IK_Unknown3E	,IK_Unknown3F	,
/*40*/	IK_Unknown40	,IK_A			,IK_B			,IK_C			,
/*44*/	IK_D			,IK_E			,IK_F			,IK_G			,
/*48*/	IK_H			,IK_I			,IK_J			,IK_K			,
/*4C*/	IK_L			,IK_M			,IK_N			,IK_O			,
/*50*/	IK_P			,IK_Q			,IK_R			,IK_S			,
/*54*/	IK_T			,IK_U			,IK_V			,IK_W			,
/*58*/	IK_X			,IK_Y			,IK_Z			,IK_Unknown5B	,
/*5C*/	IK_Unknown5C	,IK_Unknown5D	,IK_Unknown5E	,IK_Unknown5F	,
/*60*/	IK_NumPad0		,IK_NumPad1     ,IK_NumPad2     ,IK_NumPad3     ,
/*64*/	IK_NumPad4		,IK_NumPad5     ,IK_NumPad6     ,IK_NumPad7     ,
/*68*/	IK_NumPad8		,IK_NumPad9     ,IK_GreyStar    ,IK_GreyPlus    ,
/*6C*/	IK_Separator	,IK_GreyMinus	,IK_NumPadPeriod,IK_GreySlash   ,
/*70*/	IK_F1			,IK_F2          ,IK_F3          ,IK_F4          ,
/*74*/	IK_F5			,IK_F6          ,IK_F7          ,IK_F8          ,
/*78*/	IK_F9           ,IK_F10         ,IK_F11         ,IK_F12         ,
/*7C*/	IK_F13			,IK_F14         ,IK_F15         ,IK_F16         ,
/*80*/	IK_F17			,IK_F18         ,IK_F19         ,IK_F20         ,
/*84*/	IK_F21			,IK_F22         ,IK_F23         ,IK_F24         ,
/*88*/	IK_JoyPovUp_XB  ,IK_JoyPovDown_XB,IK_JoyPovLeft_XB,IK_JoyPovRight_XB,
/*8C*/	IK_Unknown8C	,IK_Unknown8D	,IK_Unknown8E	,IK_Unknown8F	,
/*90*/	IK_NumLock		,IK_ScrollLock  ,IK_Unknown92	,IK_Unknown93	,
/*94*/	IK_Unknown94	,IK_Unknown95	,IK_Unknown96	,IK_Unknown97	,
/*98*/	IK_Unknown98	,IK_Unknown99	,IK_Unknown9A	,IK_Unknown9B	,
/*9C*/	IK_Unknown9C	,IK_Unknown9D	,IK_Unknown9E	,IK_Unknown9F	,
/*A0*/	IK_LShift		,IK_RShift      ,IK_LControl    ,IK_RControl    ,
/*A4*/	IK_Joy1_XB	    ,IK_Joy2_XB	    ,IK_Joy3_XB	    ,IK_Joy4_XB	    ,
/*A8*/	IK_Joy5_XB	    ,IK_Joy6_XB	    ,IK_Joy7_XB	    ,IK_Joy8_XB	    ,
/*AC*/	IK_Joy9_XB	    ,IK_Joy10_XB	,IK_Joy11_XB    ,IK_Joy12_XB	,
/*D0*/	IK_Joy13_XB		,IK_Joy14_XB    ,IK_Joy15_XB    ,IK_Joy16_XB    ,
/*B4*/  IK_JoyX_XB		,IK_JoyY_XB		,IK_JoyZ_XB		,IK_JoyR_XB		,
/*B8*/	IK_UnknownB8	,IK_UnknownB9	,IK_Semicolon	,IK_Equals		,
/*BC*/	IK_Comma		,IK_Minus		,IK_Period		,IK_Slash		,
/*C0*/	IK_Tilde		,IK_UnknownC1	,IK_UnknownC2	,IK_UnknownC3	,
/*C4*/	IK_UnknownC4	,IK_UnknownC5	,IK_UnknownC6	,IK_UnknownC7	,
/*C8*/	IK_Joy1	        ,IK_Joy2	    ,IK_Joy3	    ,IK_Joy4	    ,
/*CC*/	IK_Joy5	        ,IK_Joy6	    ,IK_Joy7	    ,IK_Joy8	    ,
/*D0*/	IK_Joy9	        ,IK_Joy10	    ,IK_Joy11	    ,IK_Joy12		,
/*D4*/	IK_Joy13		,IK_Joy14	    ,IK_Joy15	    ,IK_Joy16	    ,
/*D8*/	IK_UnknownD8	,IK_UnknownD9	,IK_UnknownDA	,IK_LeftBracket	,
/*DC*/	IK_Backslash	,IK_RightBracket,IK_SingleQuote	,IK_UnknownDF	,
/*E0*/  IK_JoyX			,IK_JoyY		,IK_JoyZ		,IK_JoyR		,
/*E4*/	IK_MouseX		,IK_MouseY		,IK_MouseZ		,IK_MouseW		,
/*E8*/	IK_JoyU			,IK_JoyV		,IK_UnknownEA	,IK_UnknownEB	,
/*EC*/	IK_MouseWheelUp ,IK_MouseWheelDown,IK_Unknown10E,UK_Unknown10F  ,
/*F0*/	IK_JoyPovUp     ,IK_JoyPovDown	,IK_JoyPovLeft	,IK_JoyPovRight	,
/*F4*/	IK_UnknownF4	,IK_UnknownF5	,IK_Attn		,IK_CrSel		,
/*F8*/	IK_ExSel		,IK_ErEof		,IK_Play		,IK_Zoom		,
/*FC*/	IK_NoName		,IK_PA1			,IK_OEMClear
};

//IMPORTANT: if you modify this array, make sure to add a 
//corresponding entry into the g_InputActionStrings array InputDefs.h -alc
enum eInputButtonAction
{	
	eIBA_Jump,
	eIBA_Crouch,
	eIBA_Frob,
	eIBA_Creep,
	eIBA_Walk,
	eIBA_LeanRight,
	eIBA_LeanLeft,
	eIBA_ZoomIn,
	eIBA_ZoomOut,
	eIBA_DisplayWeapon,
	eIBA_DisplayItem,
	eIBA_UseItem,
	eIBA_Pause,
	eIBA_Menu,
	eIBA_Ghost,
	eIBA_SwitchView,
	eIBA_Console,
	eIBA_Exec,
	eIBA_PrevAug,
	eIBA_NextAug,
	eIBA_PrevItem,
	eIBA_NextItem,
	eIBA_Select,
	eIBA_AltFire,
	eIBA_ThrowItem,
	eIBA_MenuItemUp,
	eIBA_MenuItemDown,
	eIBA_MenuItemLeft,
	eIBA_MenuItemRight,
	eIBA_MenuSelect,
	eIBA_MenuBack,
	eIBA_DebugMenu,
	eIBA_WallFlatten,
	eIBA_ScreenShot,
	eIBA_Swap,
	eIBA_SpecialMenuAction,
	eIBA_NextFocusItem,
	eIBA_PrevFocusItem,

	// T3 Stuff
	eIBA_ViewObjectives,
	eIBA_LoadingBriefing,	//Shown during load
	eIBA_Map,
	eIBA_PrevWeapon,
	eIBA_NextWeapon,
	eIBA_ClearItem,
	eIBA_ClearWeapon,
	eIBA_ItemNoiseSuppressor,
	eIBA_ItemOilFlask,
	eIBA_ItemHolyWater,
	eIBA_ItemHealthPotion,
	eIBA_ItemGasBomb,
	eIBA_ItemExplosiveMine,
	eIBA_ItemFlashBomb,
	eIBA_WeaponBlackjack,
	eIBA_WeaponDagger,
	eIBA_WeaponBroadHeadArrow,
	eIBA_WeaponWaterArrow,
	eIBA_WeaponMossArrow,
	eIBA_WeaponFireArrow,
	eIBA_WeaponGasArrow,
	eIBA_WeaponNoiseArrow,
	eIBA_BowZoomToggle,

	eIBA_QuickSave,
	eIBA_QuickLoad,	

	eIBA_AnalogAction, //Nobody really listens to this, it just means the input is bound
					   //analog instead

	eIBA_None,
	eIBA_Wild, //for registrations
	eIBA_Max
};

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     Mass=100.000000
     RenderType=(DrawType=DT_Sprite,Style=STY_Normal)
     Texture=Texture'Engine.S_Actor'
     ScaleGlow=1.000000
     SpriteProjForward=32.000000
     LODBias=1.000000
     bHighDetail=False
     Fatness=128
     CollisionRadius=22.000000
     CollisionHeight=22.000000
     bBlocksCamera=True
     bOverrideSMFlag_BlocksCamera=False
     NetPriority=1.000000
     NetUpdateFrequency=100.000000
     InitialState="None"
     Texture_a=Texture'Engine.Fleshlight_a'
     Texture_a_v=Texture'Engine.Fleshlight_a_v'
     Texture_d_s=Texture'Engine.Fleshlight_d_s'
     Texture_d_ns=Texture'Engine.Fleshlight_d_ns'
     Texture_o_ns=Texture'Engine.Fleshlight_o_ns'
     Texture_o_s=Texture'Engine.Fleshlight_o_s'
     Texture_o_v=Texture'Engine.Fleshlight_o_v'
     Texture_s_ns=Texture'Engine.Fleshlight_s_ns'
     Texture_s_s=Texture'Engine.Fleshlight_s_s'
     ChildCount=0
     RelevantChangeTypes=(CHANGE_Moving)
     bJustTeleported=True
     bCanBeDestroyedInPreBeginPlay=True
     Role=ROLE_Authority
     RemoteRole=ROLE_DumbProxy
}
