//////////////////////////////////////////////////////////////////////////////
//
// PlayerPawn - This is the place to hang functionality/data off a player 
//		that is not project specific
//

class PlayerPawn extends Pawn
	native;

enum eGoalState
{
	kGS_Pending,
	kGS_Success,
	kGS_Failed,
	kGS_Cancelled,
	kGS_Hidden
};

enum eGoalType
{
	kGT_Objective,
	kGT_Restriction,
	kGT_Note
};

struct sGoal
{
	var Name				GoalName;
	var localized string	FriendlyName;
	var localized String	GoalText;
	var eGoalState			GoalState;
	var bool		bPrimary;
	var eGoalType	GoalType;
	var bool		bHasParent;
	var Name		GoalParent;
};

struct sCitySectionGoal
{
	var Name CitySectionName;
	var sGoal goal;
};

var Travel array<sGoal>		Goals;		// A list of current goals held by the player
var thiefprop Travel  array<sCitySectionGoal> CitySectionGoals; //list of t3 city section goals

struct sNote
{
	var Name			NoteName;
	var localized string FriendlyName;
	var localized String NoteText;
	var int				 Expiration;			// Last map that this note is good for, -1 is the current map only
};

var Travel array<sNote>		PlayerNotes;		// A list of current notes held by the player

var(AIGreetings) inherited(1240) float MinTimeBetweenNPCGreetings "The AI system enforces a random delay between NPC-to-NPC greeting barks -- this property specifies the minimum value of that delay";
var(AIGreetings) inherited(1241) float MaxTimeBetweenNPCGreetings "The AI system enforces a random delay between NPC-to-NPC greeting barks -- this property specifies the maximum value of that delay";
var(AIGreetings) inherited(1242) float MaxDistFromPlayerForNPCGreetings "The maximum distance (in feet) that two NPCs can be from the player in order to play a greeting bark";

// Light Level Calculations
//struct sBoneLightWeight
//{
//	var() float				Weight		"Weight of Light Level that is a minimum distance from the center of player";
//	var() float				MinDistance "The minimum distance that uses this weight";
//};


struct sLightLevelOffsetWeights
{
	var() vector						SamplePoint_LocalOffset "Sample point is taken at this offset from the character's location, in local space.";
	var() float							SamplePoint_Weight "Light level weights per offset.";
};

struct sLightLevelModifiers
{
	var() array<LookupFunctionPoint>	VelocityModifierLookup "Lookup function that translates player velocity (Unreal Units per second) to a light level modifier";
	var() float							MinWallDistance "The minimum wall distance (Unreal Units) before the wall modifier is applied";
	var() float							WallLightModifier "The modifier to the light level applied when player is within a minimum distance from a wall";
	var() float							CrouchLightModifier "Modifier applied to light level while player is crouching -- for DX2 this is a percentage (0 to 1) of the light level, for T3 this is additive";
	var() float							InterpolationRate "Interpolation rate to ramp light level from current level to calculated level";
};

struct sBrightnessWeights
{
	var() float		RedWeight;
	var() float		BlueWeight;
	var() float		GreenWeight;
};

var(LightLevel) runtimeinstantiated(949) CustomEditor array<string>		BonesForLightLevelCalc "These are the bones used to calculate the light level for this actor";
var(LightLevel) runtimeinstantiated(1512) array<float>					BoneWeightsForLightLevel "Light level weights for each bone";
var(LightLevel) runtimeinstantiated(1462) sLightLevelModifiers			LightLevelMods "Modifiers for different player actions";
var(LightLevel) runtimeinstantiated(1513) sBrightnessWeights			BrightnessWeights "Weights for RGB to calculate brightness";
var(LightLevel) runtimeinstantiated(1519) float							AmbientWeight "Weight for the global ambient light in a level";

var(LightLevel) runtimeinstantiated(1547) array<sLightLevelOffsetWeights> LightLevelOffsetWeights "Defines sample points that are offset in local space and weighted accordingly.  These will only be used if no bones are specified.";

var transient array<int>										BoneIndicesForLightLevelCalc; // bones index for the above strings.

struct LightLevelInfo
{
	var vector		LightLevel;
	var int			WeightClass;
};

var transient array<LightLevelInfo>		LightLevels;
var transient int 						BoneToUseForLightCalc;
var(LightLevel) int LightLevelCalculationsPerFrame "Number of per-bone light level calculations performed per frame.  Typically set to 1 for performance reasons.";
var float								InterpolatedLightLevel;

struct sLightLevelDebugInfo
{
	var vector		CalculatedLightLevel;
	var float		CalculatedRawVisibility;
	var float		RawVisibilityWithModifiers;
	var float		TargetVisibility;
	var float		CurrentVisibilty;
};

var transient sLightLevelDebugInfo		LightLevelDebugInfo;

//This hidden var gets ticked within the engine with no reguards to simtime
//it is used for Save/Load UI purposes with units of seconds.
var Travel float TotalPlayTime;

// For T3 :
// Sim time played (periodically reset by the designers in trigger scripts) mainly
// used to time seconds spent on missions for time limits.  Also used for time spent
// in citysections.
var Travel float SimtimePlayedTimer;			// all the sim time played (not including the current map)

//When this is zero, travel is enabled, but there are certain times when designers
//want to disable travel so that objectives come through
var Travel int TravelDisabledTokens;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     MinTimeBetweenNPCGreetings=50.000000
     MaxTimeBetweenNPCGreetings=70.000000
     MaxDistFromPlayerForNPCGreetings=30.000000
     BrightnessWeights=(RedWeight=0.450000,BlueWeight=0.200000,GreenWeight=0.350000)
     LightLevelOffsetWeights(0)=(SamplePoint_Weight=1.000000)
     LightLevelCalculationsPerFrame=2
}
