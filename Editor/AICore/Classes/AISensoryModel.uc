class AISensoryModel extends AIModel
	abstract
	native;


struct EvidenceTypeInfo
{
	var() float	MaxStrength "The maximum amount of strength that can ever be applied for this evidence type.";
	var() float MinDelay "Minimum amount of time before an AI registers the strength of a piece of alertness after collecting it.";
	var() float MaxDelay "Maximum amount of time before an AI registers the strength of a piece of alertness after collecting it.";
	var() float	MinTimeBetweenCollection "If the AI collects the same type of evidence within this period of time, the evidence will be discarded.";
};

struct NoiseTypeEvidenceInfo
{
	var() name							NoiseTypeName "The name of the noise type.  Must match an entry in the sounds.vcb listing.";
	var() bool							bAlwaysAccept "Noises are typically only accepted from hostile sources.  If this flag is set, we accept ALL NOISE of the type, regardless of culprit or culprit disposition.";	
	var() EvidenceTypeInfo				NoiseTypeInfo "General evidence type info -- strength / min & max delay";
	var() array<LookupFunctionPoint>	VelocityScalarLookup_Speed "Maps speed in feet per second onto the velocity scalar.";	
	var() array<LookupFunctionPoint>	AudioIntensityLookup_RelativeLoudness "Maps relative loudness * velocity scalar onto actual intensity";	
	var() float							MaximumAlertnessLevel "Clamp alertness to this value if we receive this type of noise.  0 means we don't clamp alertness (set the MaxStrength if you don't want this type recognized)";
	var() float							CrouchMultiplier "If the responsible party is crouched, multiply intensity by this value IF GREATER THAN 0.";
	var() float							CrouchModifier "If the responsible party is crouched, subtract intensity by this amount.";
};

struct ChangedActorEvidenceInfo
{
	var() eChangeType					ChangeType "What type of change does this info entry represent?";
	var() bool							bAlwaysAccept "If true, evidence strength will be added regardless of disposition towards source of changed-actor.";
	var() bool							bRemoveAfterNoticed "If true, this changed actor will be cleared out of the changed actor database after being noticed.";
	var() EvidenceTypeInfo				ChangedActorTypeInfo "General evidence type info -- strength / min & max delay";
	var() float							MaximumAlertnessLevel "Clamp alertness to this value if we receive this type of changed actor.  0 means we don't clamp alertness (set the MaxStrength if you don't want this type recognized)";
	var() float							VisThreshold "Changed actor must be 'seen' at at least this visibility score in order to be detected.";
};

struct AuditoryAlertnessMapping
{
    var() float							RawAuditoryIntensity "If auditory intensity is less than or equal to this value, the AI will stop ramping up at TargetAlertness.";
    var() float							TargetAlertness "This is the maximum alertness an AI will achieve while noticing auditory evidence less than or equal to the matching RawAuditoryIntensity.";
};
 
struct VisibilityAlertnessMapping
{
    var() float							RawVisibilityLevel "If visibility intensity is less than or equal to this value (between 0 and 1), the AI will ramp up to the TargetAlertness in the TimeToAlertness.";
    var() float							TargetAlertness "Target alertness for the AI to ramp up to at this light level.";
    var() float							TimeToAlertness "Seconds within which the AI will ramp up to the TargetAlertness if this is the current light level.";
};

struct SpecialCaseVisibilityCone
{
	var() float							MaxDistance "Target considered within the cone at this distance (IN FEET).";
	var() float							MaxYaw "Target considered within the cone at this yaw (IN DEGREES).";
	var() float							MaxPitch "Target considered within the cone at this pitch (IN DEGREES).";
	var() float							MinLight "Target considered within the cone at this light level or above (in raw visibility units, 0 to 1 -- see STAT VIS).";
	var() float							Intensity "This cone maps onto this intensity.  i.e., the AI will see its target at the specified intensity, whenever the target is within this cone.";
};

enum eVisionVulnerability
{
	VisionVulnerability_None,
	VisionVulnerability_Thermal,
	VisionVulnerability_Cloak
};

// GLOBAL EVIDENCE / SENSORY MODEL PARAMETERS

var(AISensory) runtimeinstantiated(1348) bool bSensoryInputDisabled "Set this flag to true if you want to disable the AI's sensory model entirely.";
var(AISensory) runtimeinstantiated(1620) bool bVisualInputDisabled  "Set this flag to true if you want to disable the AI's visual input model entirely.";
var(AISensory) runtimeinstantiated(1621) bool bAuditoryInputDisabled  "Set this flag to true if you want to disable the AI's auditory input model entirely.";
var(AISensory) runtimeinstantiated(1622) bool bTactileInputDisabled  "Set this flag to true if you want to disable the AI's tactile input model entirely.";

var(AIEvidenceCollection) inherited(549) float EvidenceGarbageCollectRate "The rate (in seconds) at which AI garbage-collects its known evidence to discard obsolete evidence";
var(AIEvidenceCollection) inherited(947) float Evidence_DecayRate "Overall rate of evidence decay in units per second.";
var(AIEvidenceCollection) inherited(1358) float Evidence_Timeout "Minimum amount of time before a piece of evidence gets removed from the evidence container.  Evidence must also have a strength of 0 to get cleared.";
var(AIEvidenceCollection) inherited(1349) float EvidenceBuffer_Time "The time (in seconds) within which an AI will refuse to decay old evidence after recording a new piece of evidence.";


// AUDITORY EVIDENCE PARAMETERS

var(AIAuditory) inherited(1471) array<AuditoryAlertnessMapping> AuditoryAlertnessMap "A mapping of auditory intensity onto maximum target alertness.  This is how we can globally clamp the AI's alertness based on the intensity of sounds.";
var(AIAuditory) inherited(1359) array<NoiseTypeEvidenceInfo> NoiseTypeInfoArray "Array that represents evidence data for each individual noise type.";
var(AIAuditory) inherited(1382) EvidenceTypeInfo Evidence_Alarm_Info "Common information describing the alertness impact of Heard Alarm style evidence.";


// VISUAL EVIDENCE PARAMETERS

// general case Visibility detection

var(AIVisibility_General) inherited(1365) EvidenceTypeInfo Evidence_Visual_Info "Common information (MaxStrength, Min/MaxDelay) regarding generic visual evidence.";

var(AIVisibility_General) inherited(1352) array<LookupFunctionPoint> VisibilityLookupFunction_Distance "A series of points that defines a piecewise linear function mapping DISTANCE IN FEET onto some normalized INTENSITY VALUE from 0 to 1.";
var(AIVisibility_General) inherited(1353) array<LookupFunctionPoint> VisibilityLookupFunction_Yaw "A series of points that defines a piecewise linear function mapping YAW IN DEGREES onto some normalized INTENSITY VALUE from 0 to 1.";
var(AIVisibility_General) inherited(1354) array<LookupFunctionPoint> VisibilityLookupFunction_Pitch "A series of points that defines a piecewise linear function mapping PITCH IN DEGREES onto some normalized INTENSITY VALUE from 0 to 1.";

var(AIVisibility_General) inherited(1553) array<VisibilityAlertnessMapping> VisibilityAlertnessMap "If visibility intensity is less than or equal to the RawVisibilityLevel, the AI will ramp up to the corresponding TargetAlertness in TimeToAlertness seconds.";

var(AIVisibility) inherited(548) float VisualMultiplier_Crouched "A multiplier (1=100%) applied to a visual stimulus for an opponent who is crouching";
var(AIVisibility) runtimeinstantiated(546) float VisualRefreshRateForPlayer "The rate (in seconds) at which an AI updates its sensory information FOR THE PLAYER when its alert level is zero (or very close to zero)";
var(AIVisibility) runtimeinstantiated(1314) float VisualRefreshRateForActors "The rate (in seconds) at which an AI updates its sensory information FOR ACTORS -- i.e., bodies, other NPC's, changed actors.  Anything aside from the player.";
var(AIVisibility) runtimeinstantiated(1668) float VisualRefreshRateForBasicLODPlayer "The rate (in seconds) at which an AI updates its sensory information FOR THE PLAYER when its alert level is zero at the basic LOD level.";
var(AIVisibility) runtimeinstantiated(1669) float VisualRefreshRateForBasicLODActors "The rate (in seconds) at which an AI updates its sensory information FOR ACTORS at the basic LOD level.";

var(AIVisibility) runtimeinstantiated(883) float VisualEvidenceDistanceThreshold "The distance (in feet) at which visual stimuli are separated into different pieces of evidence.  Two pieces of visual evidence within this distance from each other are merged.";

var(AIVisibility) runtimeinstantiated(924) float OverrideYaw "If > 0, this pawn forces yaw to be equal to this value when performing distance calculations";
var(AIVisibility) runtimeinstantiated(925) float OverridePitch "If > 0, this pawn forces pitch to be equal to this value when performing distance calculations";
var(AIVisibility) runtimeinstantiated(926) float OverrideDistance "If > 0, this pawn forces distance to be equal to this value when performing distance calculations";
var(AIVisibility) runtimeinstantiated(927) float OverrideLightLevel "If > 0 , this pawn forces light levels to be equal to this value when performing distance calculations";
var(AIVisibility) inherited(1617) float AlwaysUseIntrinsicVisibility "If > 0, this will force the intrinsic visibility check for this AI.";
var(AIVisibility) inherited(1381) eVisionVulnerability VisionVulnerability "Type of vision vulnerability this AI has.";

// SPECIAL-CASE VISIBILITY DETECTION -- clearly seen parameters, close range vision cone, etc.

var(AIvisibility_Special) inherited(1568) array<SpecialCaseVisibilityCone> SpecialCaseVisibilityCones "If an AI's target is within a cone, map its targets visual INTENSITY onto the value specified within the struct.  These cones get checked in order.";
var(AIVisibility_Special) inherited(1362) float PlayerClearlySeen_MinimumAlertness "Minimum alertness (expressed as PERCENTAGE OF MAX -- 0 to 1) AI must be at to clearly notice THE PLAYER.";
var(AIVisibility_Special) inherited(1355) array<LookupFunctionPoint> ClearlySeenThresholdLookup_Distance "A series of points that defines a piecewise linear function mapping DISTANCE IN FEET onto a Visibility THRESHOLD over an AI will consider its target to be clearly visible.";
var(AIVisibility_Special) inherited(1766) float NPCClearlySeenIntensity_Multiplier "All AI to AI visibility clearly-seen visibility checks will multiply the visibility intensity by this amount.  AI's will see each other more readily as this scales upwards.";
var(AIVisibility_Special) inherited(1366) EvidenceTypeInfo Evidence_PlayerSeen_Info "Common information (MaxStrength, Min/MaxDelay) regarding special case visual evidence related to the presence of the player.";

var(AIVisibility_NearDamage) inherited(1886) float NearbyDamageVisibilityIntensity_Penalty "Penalty applied to non-zero visual intensity calculations if someone nearby was damaged.";
var(AIVisibility_NearDamage) inherited(1887) float NearbyDamageVisibilityIntensity_Time "Penalty is applied for this many seconds.";
var(AIVisibility_NearDamage) inherited(1888) float NearbyDamageVisibilityIntensity_Distance "Penalty is applied to AI's within this many feet of damaged AI.";

var(AIVisibility_PostCombat) runtimeinstantiated(1869) float PostCombatPenalty_DistanceThreshold "If the AI is looking for the player after losing him in combat, a penalty is applied to the player's visibility if within this distance (IN FEET) from the last known location.";
var(AIVisibility_PostCombat) runtimeinstantiated(1870) float PostCombatPenalty_TimeThreshold "If the AI is looking for the player after losing him in combat, a penalty is applied to the player's visibility if it has been less than this amount of time (IN SECONDS) since last seen.";
var(AIVisibility_PostCombat) runtimeinstantiated(1872) float PostCombatPenalty_AngleThreshold "If the player is within this angle (IN DEGREES) of the line from the AI to the expected player location, the player is penalized (independently of the distance threshold).";
var(AIVisibility_PostCombat) runtimeinstantiated(1871) float PostCombatPenalty_Amount "This scalar is applied to the visibility intensity if the player is within the distance and time thresholds.";

// NPC VISIBILITY PARAMETERS

var(AIVisibility_NPCs) inherited(1724) float MaxVisualRange_NPCs "Never detect other AI Pawns outside of this distance (IN FEET).";
var(AIVisibility_NPCs) inherited(1367) EvidenceTypeInfo Evidence_AlertNPCSeen_Info "When a friendly, neutral, or allied NPC is seen in an alertness state, use these properties for evidence creation.  Note that the evidence strength specified IS THE MAXIMUM ALERTNESS LEVEL.";
var(AIVisibility_NPCs) inherited(1729) EvidenceTypeInfo Evidence_CombatNPCSeen_Info "When a friendly, neutral, or allied NPC is seen in combat, use these properties for evidence creation.  Note that the evidence strength specified IS THE MAXIMUM ALERTNESS LEVEL.";
var(AIVisibility_NPCs) inherited(1368) EvidenceTypeInfo Evidence_EnemyNPCSeen_Info "Common information (MaxStrength, Min/MaxDelay) regarding special case visual evidence related to the presence of an enemy NPC.";
var(AIVisibility_NPCs) inherited(868) float VisualThresholdPawnToPawnSight "The minimum intrinsic Visibility value (0..1) at which a pawn will consider another pawn to be visible.";
var(AIVisibility_NPCs) inherited(1740) array<eBodyType> Evidence_AlertNPCSeen_IgnoreList "Types of AI's that should be seen but ignored (i.e., collected evidence will have no strength).";

// BODY EVIDENCE PARAMETERS

var(AIVisibility_Bodies) inherited(1725) float MaxVisualRange_Bodies "Never detect other AI Pawns outside of this distance (IN FEET).";
var(AIVisibility_Bodies) inherited(1369) EvidenceTypeInfo Evidence_BodySeen_Info "Common information (MaxStrength, Min/MaxDelay) regarding special case visual evidence related to the presence of a dead or unconscious friendly or allied body.";
var(AIVisibility_Bodies) inherited(574) float EvidenceThresholdToNoticeBody "The threshold value for an AI to notice a corpse or body, specified in alertness units, from 0 to 4";
var(AIVisibility_Bodies) inherited(1728) array<eBodyType> Evidence_BodySeen_IgnoreList "Types of bodies that we may see but don't want to collect evidence on.";

// CHANGED ACTOR EVIDENCE PARAMETERS

var(AIChangedActors) inherited(1723) float MaxVisualRange_ChangedActors "Never detect changed actors outside of this distance (IN FEET).";
var(AIChangedActors) inherited(867) float VisualThresholdPawnToActorSight "The minimum intrinsic Visibility value (0..1) at which a pawn will consider another actor to be visible.";
var(AIChangedActors) inherited(1656) array<ChangedActorEvidenceInfo> ChangedActorInfoArray "Array that represents evidence data for each individual changed actor type.";

var(AIChangedActors) inherited(930) eChangeType ChangeDetection_RelevantTypes "Determines which types of changed actors this AI Model cares about.";
var(AIChangedActors) inherited(948) float		ChangeDetection_VisibilityThreshold "Minimum Visibility calculation (from 0 to 1) at which a changed actor is considered to be visible.";
var(AIChangedActors) inherited(944) float		OutOfPlace_LateralMultiplier "An actor will be considered out of place if it it has moved along the XY plane by this number times its XY extent.";
var(AIChangedActors) inherited(945) float		OutOfPlace_VerticalMultiplier "An actor will be considered out of place if it has moved along the Z axis by this number times its extent height.";
var(AIChangedActors) inherited(946) float		Moving_MinSpeed "An actor will be considered to be MOVING if its speed exceeds this value in units per second.";

// TACTILE EVIDENCE PARAMETERS

var(AITactile) inherited(1371) EvidenceTypeInfo Evidence_TactilePlayer_Info "Common information (MaxStrength, Min/MaxDelay) regarding evidence collected when we touch an object moved by the player.";
var(AITactile) inherited(1372) EvidenceTypeInfo Evidence_TactileNonPlayer_Info "Common information (MaxStrength, Min/MaxDelay) regarding evidence collected when we touch an object moved by a non-player.";
var(AITactile) inherited(1373) EvidenceTypeInfo Evidence_TookDamage_Info "Common information (MaxStrength, Min/MaxDelay) regarding evidence collected when we are damaged.";
var(AITactile) inherited(1374) EvidenceTypeInfo Evidence_Gassed_Info "Common information (MaxStrength, Min/MaxDelay) regarding evidence collected when we get gassed.  Note that GASSED evidence is applied after effect wears off.";
var(AITactile) inherited(1375) EvidenceTypeInfo Evidence_Shocked_Info "Common information (MaxStrength, Min/MaxDelay) regarding evidence collected when we get shocked.  Note that SHOCKED evidence is applied after effect wears off.";
var(AITactile) inherited(1484) EvidenceTypeInfo Evidence_Blinded_Info "Common information (MaxStrength, Min/MaxDelay) regarding evidence collected when we get shocked.  Note that BLINDED evidence is applied after effect wears off.";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     EvidenceGarbageCollectRate=1.000000
     Evidence_DecayRate=2.000000
     Evidence_Timeout=180.000000
     EvidenceBuffer_Time=2.000000
     AuditoryAlertnessMap(0)=(RawAuditoryIntensity=0.200000,TargetAlertness=0.300000)
     AuditoryAlertnessMap(1)=(RawAuditoryIntensity=0.600000,TargetAlertness=0.650000)
     AuditoryAlertnessMap(2)=(RawAuditoryIntensity=1.000000,TargetAlertness=1.000000)
     NoiseTypeInfoArray(0)=(NoiseTypeName="footstep_quiet",NoiseTypeInfo=(MaxStrength=10.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.650000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(1)=(NoiseTypeName="footstep_normal",NoiseTypeInfo=(MaxStrength=20.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.650000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(2)=(NoiseTypeName="footstep_loud",NoiseTypeInfo=(MaxStrength=30.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.650000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(3)=(NoiseTypeName="landing_quiet",NoiseTypeInfo=(MaxStrength=15.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.650000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(4)=(NoiseTypeName="landing_normal",NoiseTypeInfo=(MaxStrength=20.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.650000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(5)=(NoiseTypeName="landing_loud",NoiseTypeInfo=(MaxStrength=25.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.650000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(6)=(NoiseTypeName="collision_quiet",NoiseTypeInfo=(MaxStrength=15.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.250000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(7)=(NoiseTypeName="collision_normal",NoiseTypeInfo=(MaxStrength=25.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.250000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(8)=(NoiseTypeName="collision_loud",NoiseTypeInfo=(MaxStrength=35.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.250000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(9)=(NoiseTypeName="breakage_quiet",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=15.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.250000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(10)=(NoiseTypeName="breakage_normal",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=25.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.250000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(11)=(NoiseTypeName="breakage_loud",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=50.000000),VelocityScalarLookup_Speed=((LookupInput=100.000000),(LookupInput=200.000000,LookupOutput=0.250000),(LookupInput=400.000000,LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(12)=(NoiseTypeName="pain",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=100.000000),VelocityScalarLookup_Speed=((LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(13)=(NoiseTypeName="death",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=100.000000),VelocityScalarLookup_Speed=((LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(14)=(NoiseTypeName="explosion",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=100.000000),VelocityScalarLookup_Speed=((LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((LookupInput=0.200000),(LookupInput=0.200010,LookupOutput=1.000000)))
     NoiseTypeInfoArray(15)=(NoiseTypeName="gunfire",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=100.000000),VelocityScalarLookup_Speed=((LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((LookupInput=0.200000),(LookupInput=0.200010,LookupOutput=1.000000)))
     NoiseTypeInfoArray(16)=(NoiseTypeName="occlusion",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=50.000000),VelocityScalarLookup_Speed=((LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((),(LookupInput=1.000000,LookupOutput=1.000000)))
     NoiseTypeInfoArray(17)=(NoiseTypeName="noisemaker",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=100.000000),VelocityScalarLookup_Speed=((LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((LookupInput=0.200000),(LookupInput=0.200010,LookupOutput=1.000000)))
     NoiseTypeInfoArray(18)=(NoiseTypeName="combat",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=100.000000),VelocityScalarLookup_Speed=((LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((LookupInput=0.200000),(LookupInput=0.200010,LookupOutput=1.000000)))
     NoiseTypeInfoArray(19)=(NoiseTypeName="yellowalert",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=30.000000),VelocityScalarLookup_Speed=((LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((LookupInput=0.400000),(LookupInput=0.400010,LookupOutput=1.000000)),MaximumAlertnessLevel=0.300000)
     NoiseTypeInfoArray(20)=(NoiseTypeName="redalert",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=60.000000),VelocityScalarLookup_Speed=((LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((LookupInput=0.400000),(LookupInput=0.400010,LookupOutput=1.000000)),MaximumAlertnessLevel=0.600000)
     NoiseTypeInfoArray(21)=(NoiseTypeName="summon",bAlwaysAccept=True,NoiseTypeInfo=(MaxStrength=100.000000),VelocityScalarLookup_Speed=((LookupOutput=1.000000)),AudioIntensityLookup_RelativeLoudness=((LookupInput=0.600000),(LookupInput=0.600010,LookupOutput=1.000000)))
     Evidence_Alarm_Info=(MaxStrength=100.000000)
     Evidence_Visual_Info=(MaxStrength=4.000000)
     VisibilityLookupFunction_Distance(0)=(LookupInput=7.000000,LookupOutput=1.000000)
     VisibilityLookupFunction_Distance(1)=(LookupInput=8.000000,LookupOutput=0.950000)
     VisibilityLookupFunction_Distance(2)=(LookupInput=10.000000,LookupOutput=0.900000)
     VisibilityLookupFunction_Distance(3)=(LookupInput=15.000000,LookupOutput=0.800000)
     VisibilityLookupFunction_Distance(4)=(LookupInput=30.000000,LookupOutput=0.500000)
     VisibilityLookupFunction_Distance(5)=(LookupInput=60.000000,LookupOutput=0.300000)
     VisibilityLookupFunction_Distance(6)=(LookupInput=120.000000)
     VisibilityLookupFunction_Yaw(0)=(LookupInput=10.000000,LookupOutput=1.000000)
     VisibilityLookupFunction_Yaw(1)=(LookupInput=25.000000,LookupOutput=0.750000)
     VisibilityLookupFunction_Yaw(2)=(LookupInput=45.000000,LookupOutput=0.600000)
     VisibilityLookupFunction_Yaw(3)=(LookupInput=55.000000,LookupOutput=0.400000)
     VisibilityLookupFunction_Yaw(4)=(LookupInput=60.000000)
     VisibilityLookupFunction_Pitch(0)=(LookupInput=20.000000,LookupOutput=1.000000)
     VisibilityLookupFunction_Pitch(1)=(LookupInput=45.000000,LookupOutput=0.750000)
     VisibilityLookupFunction_Pitch(2)=(LookupInput=60.000000)
     VisibilityAlertnessMap(0)=(RawVisibilityLevel=0.050000)
     VisibilityAlertnessMap(1)=(RawVisibilityLevel=0.150000,TargetAlertness=0.300000,TimeToAlertness=7.000000)
     VisibilityAlertnessMap(2)=(RawVisibilityLevel=0.250000,TargetAlertness=0.550000,TimeToAlertness=5.000000)
     VisibilityAlertnessMap(3)=(RawVisibilityLevel=0.350000,TargetAlertness=0.750000,TimeToAlertness=5.000000)
     VisibilityAlertnessMap(4)=(RawVisibilityLevel=1.000000,TargetAlertness=1.000000,TimeToAlertness=5.000000)
     VisualMultiplier_Crouched=1.000000
     VisualRefreshRateForPlayer=0.150000
     VisualRefreshRateForActors=0.500000
     VisualRefreshRateForBasicLODPlayer=0.500000
     VisualRefreshRateForBasicLODActors=1.000000
     VisualEvidenceDistanceThreshold=2.500000
     OverrideYaw=0.000000
     OverridePitch=0.000000
     OverrideDistance=0.000000
     OverrideLightLevel=0.000000
     AlwaysUseIntrinsicVisibility=0.000000
     VisionVulnerability=VisionVulnerability_None
     PlayerClearlySeen_MinimumAlertness=0.850000
     ClearlySeenThresholdLookup_Distance(0)=(LookupInput=1.000000,LookupOutput=0.050000)
     ClearlySeenThresholdLookup_Distance(1)=(LookupInput=3.000000,LookupOutput=0.150000)
     ClearlySeenThresholdLookup_Distance(2)=(LookupInput=6.000000,LookupOutput=0.300000)
     ClearlySeenThresholdLookup_Distance(3)=(LookupInput=10.000000,LookupOutput=0.500000)
     NPCClearlySeenIntensity_Multiplier=2.000000
     Evidence_PlayerSeen_Info=(MaxStrength=100.000000)
     NearbyDamageVisibilityIntensity_Penalty=0.500000
     NearbyDamageVisibilityIntensity_Time=1.000000
     NearbyDamageVisibilityIntensity_Distance=25.000000
     PostCombatPenalty_DistanceThreshold=12.000000
     PostCombatPenalty_TimeThreshold=10.000000
     PostCombatPenalty_AngleThreshold=35.000000
     PostCombatPenalty_Amount=5.000000
     MaxVisualRange_NPCs=75.000000
     Evidence_AlertNPCSeen_Info=(MaxStrength=70.000000)
     Evidence_CombatNPCSeen_Info=(MaxStrength=100.000000)
     Evidence_EnemyNPCSeen_Info=(MaxStrength=100.000000)
     VisualThresholdPawnToPawnSight=0.200000
     Evidence_AlertNPCSeen_IgnoreList(0)=BodyType_Animal
     Evidence_AlertNPCSeen_IgnoreList(1)=BodyType_Monster
     MaxVisualRange_Bodies=75.000000
     Evidence_BodySeen_Info=(MaxStrength=100.000000)
     EvidenceThresholdToNoticeBody=0.100000
     Evidence_BodySeen_IgnoreList(0)=BodyType_Animal
     Evidence_BodySeen_IgnoreList(1)=BodyType_Bot
     MaxVisualRange_ChangedActors=50.000000
     VisualThresholdPawnToActorSight=0.350000
     ChangedActorInfoArray(0)=(ChangeType=(CHANGE_Moving),bRemoveAfterNoticed=True,ChangedActorTypeInfo=(MaxStrength=60.000000),MaximumAlertnessLevel=0.600000,VisThreshold=0.250000)
     ChangedActorInfoArray(1)=(ChangeType=(CHANGE_Burning),bRemoveAfterNoticed=True,ChangedActorTypeInfo=(MaxStrength=60.000000),MaximumAlertnessLevel=0.600000,VisThreshold=0.250000)
     ChangedActorInfoArray(2)=(ChangeType=(CHANGE_Gas),ChangedActorTypeInfo=(MaxStrength=60.000000),MaximumAlertnessLevel=0.600000,VisThreshold=0.250000)
     ChangedActorInfoArray(3)=(ChangeType=(CHANGE_Smoke),ChangedActorTypeInfo=(MaxStrength=60.000000),MaximumAlertnessLevel=0.600000,VisThreshold=0.250000)
     ChangedActorInfoArray(4)=(ChangeType=(CHANGE_LiveGrenade),ChangedActorTypeInfo=(MaxStrength=100.000000),MaximumAlertnessLevel=1.000000,VisThreshold=0.250000)
     ChangedActorInfoArray(5)=(ChangeType=(CHANGE_OpenClosed),ChangedActorTypeInfo=(MaxStrength=60.000000),MaximumAlertnessLevel=0.600000,VisThreshold=0.250000)
     ChangedActorInfoArray(6)=(ChangeType=(CHANGE_OnOff),bRemoveAfterNoticed=True,ChangedActorTypeInfo=(MaxStrength=60.000000),MaximumAlertnessLevel=0.600000,VisThreshold=0.000100)
     ChangedActorInfoArray(7)=(ChangeType=(CHANGE_Missing),bRemoveAfterNoticed=True,ChangedActorTypeInfo=(MaxStrength=60.000000),MaximumAlertnessLevel=0.600000,VisThreshold=0.750000)
     ChangedActorInfoArray(8)=(ChangeType=(CHANGE_MissingAlly),bRemoveAfterNoticed=True,ChangedActorTypeInfo=(MaxStrength=60.000000),MaximumAlertnessLevel=0.600000,VisThreshold=0.250000)
     ChangedActorInfoArray(9)=(ChangeType=(CHANGE_BloodPuddle),ChangedActorTypeInfo=(MaxStrength=60.000000),MaximumAlertnessLevel=0.600000,VisThreshold=0.250000)
     ChangeDetection_RelevantTypes=(CHANGE_Moving,CHANGE_OutOfPlace,CHANGE_OpenClosed,CHANGE_OnOff,CHANGE_Burning,CHANGE_Smoke,CHANGE_Gas,CHANGE_LiveGrenade,CHANGE_BloodPuddle)
     ChangeDetection_VisibilityThreshold=0.100000
     Evidence_TactilePlayer_Info=(MaxStrength=70.000000)
     Evidence_TactileNonPlayer_Info=(MaxStrength=10.000000)
     Evidence_TookDamage_Info=(MaxStrength=100.000000)
     Evidence_Gassed_Info=(MaxStrength=100.000000)
     Evidence_Shocked_Info=(MaxStrength=100.000000)
     Evidence_Blinded_Info=(MaxStrength=100.000000)
}
