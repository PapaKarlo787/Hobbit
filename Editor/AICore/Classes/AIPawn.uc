class AIPawn extends Pawn
	native
	abstract;

enum EAnimalType
{
	ANIMAL_Human,
	ANIMAL_Rat,
	ANIMAL_Cat,
	ANIMAL_Bird,
	ANIMAL_Dog
};

enum EBoneAxis
{
	POSITIVE_X,
	POSITIVE_Y,
	POSITIVE_Z,
	NEGATIVE_X,
	NEGATIVE_Y,
	NEGATIVE_Z
};

enum EPatrolStyle
{
	PATROL_TurnAroundOnFailure,
	PATROL_KeepGoingOnFailure
};

enum ECharacterClass
{
	CCLASS_None,
	CCLASS_MilitarySecurity,
	CCLASS_LowerClass,
	CCLASS_WorkingClass,
	CCLASS_UpperClass
};

enum EThiefFaction
{
	TFACTION_None,
	TFACTION_Hammer,
	TFACTION_Pagan,
	TFACTION_Keeper	
};

// a FacialExpressionInfo struct determines which facial expressions map onto a given AI state and how often we choose between them

struct FacialExpressionInfo
{
	var() array<EFacialAnimations>		Expressions "Set of expressions used for this particular AI state.";
	var() float							DelayMinTime "If non-zero, the AI will switch between the available expressions every so often, as defined by the min and max times.";
	var() float							DelayMaxTime "If non-zero, the AI will switch between the available expressions every so often, as defined by the min and max times.";
	var() float							BlendInTime "Blending into this animation will take this many seconds.";
	var() float							BlendOutTime "Blending out of this animation will take this many seconds.";
	var() float							PlaybackMinTime "Animation will playback for a total amount of time between this and the max time (in seconds).";
	var() float							PlaybackMaxTime "Animation will playback for a total amount of time between this and the min time (in seconds).";
	var() float							AlphaMin "The animation will be played back at some random alpha (or strength) in between this alpha and the AlphaMax";
	var() float							AlphaMax "The animation will be played back at some random alpha (or strength) in between this alpha and the AlphaMin";
};

var() bool DiagnosticsOn;

var CustomEditor class<AISensoryModel> OldSensoryModelClass_MaintainedForCompatibility;
var() inherited(1058) CustomEditor CustomViewer class<AISensoryModel> SensoryModelClass;
var AISensoryModel SensoryModel;

var CustomEditor class<AIBehaviorModel> OldBehaviorModelClass_MaintainedForCompatibility;
var() inherited(1059) CustomEditor CustomViewer class<AIBehaviorModel> BehaviorModelClass;
var AIBehaviorModel BehaviorModel;

var CustomEditor class<AIMovementModel> OldMovementModelClass_MaintainedForCompatibility;
var() inherited(1060) CustomEditor CustomViewer class<AIMovementModel> MovementModelClass;
var AIMovementModel MovementModel;

var CustomEditor class<AICombatModel> OldCombatModelClass_MaintainedForCompatibility;
var() inherited(1061) CustomEditor CustomViewer class<AICombatModel> CombatModelClass;
var AICombatModel CombatModel;

var CustomEditor class<AIFactionModel> OldFactionModelClass_MaintainedForCompatibility;
var() inherited(1062) CustomEditor CustomViewer class<AIFactionModel> FactionModelClass;
var AIFactionModel FactionModel;

var(AI) inherited(736) bool UsesFlashlight "Cheesy hack for E3 -- if true, this pawn is carrying a flashlight";
var(AI) runtimeinstantiated(1514) deusexprop bool IsCamera  "True if this is a camera.";
var(AI) runtimeinstantiated(1515) deusexprop bool IsTurret  "True if this is a turret.";

var(AI) inherited(1505) deusexprop float CameraTurret_MaxYaw			"This is the maximum angle (in degrees) that the camera or turret will pan in one direction while searching.";
var(AI) inherited(1506) deusexprop float CameraTurret_YawDuration		"Amount of time (in seconds) that it takes the camera or turret to pan in one direction.";
var(AI) inherited(1507) deusexprop float CameraTurret_TargetLockTime	"Amount of time (in seconds) that it takes the camera or turret to lock onto it's target and start firing (turret) or set off alarms (camera).";

var(AISensory) runtimeinstantiated(769) float VisualAcuityMultiplier "A multiplier on this AI's visual sensory skills (1.0=default)";
var(AISensory) runtimeinstantiated(770) float AudioAcuityMultiplier "A multiplier on this AI's auditory sensory skills (1.0=default)";
var(AISensory) runtimeinstantiated(771) float TactileAcuityMultiplier "A multiplier on this AI's tactile sensory skills (1.0=default)";

var(AISensory) runtimeinstantiated(1821) bool IgnoreAllNonHostileAuditory "If true, this AI will ignore all auditory evidence from friendly/allied/neutral characters (including gunfire, explosions).";
var(AISensory) runtimeinstantiated(1822) bool IgnoreAllNonHostileVisual "If true, this AI will ignore all auditory evidence from friendly/allied/neutral characters (e.g., see-alert-npc).";

var(AI) inherited(784) float AnimationSpeedMultiplier "A multiplier on this NPC's animation playback speed; keep this at or very near 1.0 unless you have a good reason to do otherwise";
var(AI) inherited(1827) float AnimationSpeedRandomPercentageOffset "All animations played on this NPC will be randomly offset by some number up to this amount (percentage specified between 0 and 1)";

var(BotDomination) inherited(1100) deusexprop string BotDominationType "What type of bot is this for domination?  E.g., turret, adbot, etc.  Affects HUD etc.";
var(BotDomination) inherited(1219) deusexprop int BotDominationLevel "How 'high-level' is this bot for domination?  What aug upgrade level is required to dominate it? 0 = 1stlevelaug(0 upgrades), 1 = 2nd level aug(1upgrade), 2 = 3rd level aug(2 upgrades)";

var(Bot) inherited(1269) deusexprop float MaxScrambleTime		"How long (maximum) can this AI be scrambled (in seconds)";
var(Bot) runtimeinstantiated(1270) deusexprop float CurrentScrambleTime	"How long until this bot is no longer scrambled (in seconds)";

var(POV) inherited(1488) name POVBoneName "What's the name of the bone used by the AI for retrieving a point-of-view rotation?";
var(POV) runtimeinstantiated(1489) EBoneAxis POVAxis "Which axis does the POV bone get its rotation from?  e.g., for the X-axis, this vector is (1,0,0).";

var (AI) runtimeinstantiated(1695) bool bWeaponAlwaysSelected "Does an AI always have a weapon seleted?  This overrides the behavior model properties that define when an AI pulls out its weapon.";
var (AI) runtimeinstantiated(1800) bool bUseTensePatrol "If this flag is set, and an AI engages in combat or sees a dead body, the AI will subsequently always have its weapon selected.";

var (AI) inherited(1727) eBodyType BodyType "Tells the AI what type of body this AI will be when it is dead. This is used to make sure the right barks happen.";

var(AIPatrol) inherited(1754) EPatrolStyle PatrolStyle "How an AI will patrol, by default.  Can be overriden by corresponding properties on the pathnodes.";

var(AI) inherited(1761) EAnimalType AnimalType "What class of animal does this pawn belong to?  Set for ambient creatures.";

var(AI) inherited(1785) float HostileEnvironmentCheckDistance "If any AI's are dead or in red alert within this distance (IN FEET), the environment is deemed 'hostile' and this AI will not idle bark or greet people.";

var(AI) runtimeinstantiated(1823) bool bPerfectAccuracyTarget "If an AI targets this Pawn, they will shoot at perfect accuracy";

var(Render) inherited(1848) float CombatCloaking "(Optional) Amount of cloaking during combat (0.0 = none, 1.0 = invisible)";
var(Render) inherited(1850) string CombatCloakingShaderName "(Optional) Membrane Shader used for cloaking during combat";

var(Movement) inherited(1814) Name AimingFiringOverlayBoneAnim "Name of bone to start the aiming/firing overlay animation";

var(AI) inherited(1866) ECharacterClass CharacterClass "General grouping of character type -- to distinguish between civilian upper, middle, and lower classes, and military/security forces.  For bark flavor.";
var(AI) inherited(1867) bool bNeverGreetPlayer "If set to true, this AI will never play greeting barks when the player frobs him.";

var(Combat) inherited(1879) float AI_to_AI_AccuracyBonus "Bonus for AI shooting another AI (should be between 0 and 0.75) - this is BEFORE Randomness/light level";
var(Combat) inherited(1895) bool CanRollInCombat "Flag whether AI should roll in combat. (default to true)";

var(AIBarks) runtimeinstantiated(1999) string OptionalVoiceTag "If this property is set, this string will be optionally appended to all tag queries.  e.g., if a barmaid character has custom +barmaid lines, this string should read simply 'barmaid'.";

var(Pickpocketing) float PickpocketingAngleThreshold "This is the cosine of the angle (from -1 to 1) within which pickpocketing is explicitly forbidden for the player, regardless of visibility.  If this is -1, the AI will not be pickpocketable";

var(AIStore) inherited(2019) thiefprop bitfield eT3StoreFictionFlags
{
	eT3SFF_date,
	eT3SFF_body,
	eT3SFF_quarantine,
	eT3SFF_quarantinelifted,
	eT3SFF_clocktower,
	eT3SFF_goons,
	eT3SFF_message,
	eT3SFF_questions,
	eT3SFF_theeye,
	eT3SFF_hood,
	eT3SFF_julian,
	eT3SFF_carmen,
	eT3SFF_pavelock,
	eT3SFF_shadowyfigures

} FictionForStoreBarks "These flags denote which fiction events the AI should pay attention to when figuring which barks to produce in a store";

var(AIStore) inherited(2146) thiefprop bitfield eT3FenceDontBuyType
{
	eT3FDBT_METAL,
	eT3FDBT_ART,
	eT3FDBT_GEM,
	eT3FDBT_SPECIAL

} FenceDontBuyTypes "Mark all types this fence is not supposed to buy.";

var(AIStore) inherited(2020) thiefprop bitfield eT3MissionFlags
{
	eT3MF_Pagan,
	eT3MF_Hammer,
	eT3MF_Castle
}MissionForStoreBarks "These flags denote which mission events the AI should pay attention to when figuring which barks to produce in a store.";

var(AIStore) inherited(2023) thiefprop bitfield eT3Factions
{
	eT3F_Pangan,
	eT3F_Hammer
}FactionForStoreBark "These flags denote which factions the AI should pay attention to when figuring which barks to produce in a store.";

var(AIStore) inherited(2022) thiefprop int LargeTransactionThreshold "The amount of gold in a transaction to qualify for a large transaction bark.";

var(AIFacialExpressions) inherited(2032) array<EFacialAnimations> DisabledFacialExpressions "If an expression is specified in this dynamic array, the character -may not- use the specified facial expression.  By default, all expressions are allowed.";

var(AIFacialExpressions) inherited(2033) FacialExpressionInfo Face_DefaultExpressions "Default facial expressions.";
var(AIFacialExpressions) inherited(2034) FacialExpressionInfo Face_CoughingExpressions "coughing facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2035) FacialExpressionInfo Face_WhistlingExpressions "whistling facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2036) FacialExpressionInfo Face_YawningExpressions "yawning facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2037) FacialExpressionInfo Face_SneezingExpressions "sneezing facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2038) FacialExpressionInfo Face_FrustrationExpressions "frustrated facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2039) FacialExpressionInfo Face_EnragedExpressions "enraged facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2040) FacialExpressionInfo Face_ReprimandExpressions "Reprimanding the player facial expressions.";
var(AIFacialExpressions) inherited(2041) FacialExpressionInfo Face_CombatExpressions "Combat facial expressions.  This is a looping expression, so make sure to specify DELAYS";
var(AIFacialExpressions) inherited(2042) FacialExpressionInfo Face_YellowSearchExpressions "Careless search facial expressions.  This is a looping expression, so make sure to specify DELAYS";
var(AIFacialExpressions) inherited(2043) FacialExpressionInfo Face_RedSearchExpressions "Cautious search facial expressions.  This is a looping expression, so make sure to specify DELAYS";
var(AIFacialExpressions) inherited(2044) FacialExpressionInfo Face_FleeingExpressions "Fleeing facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2045) FacialExpressionInfo Face_TakeDamageExpressions "Taking damage facial expressions.";
var(AIFacialExpressions) inherited(2046) FacialExpressionInfo Face_SurprisedExpressions "Surprised facial expressions.";
var(AIFacialExpressions) inherited(2047) FacialExpressionInfo Face_SlippingExpressions "Slipping facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2048) FacialExpressionInfo Face_BlindedExpressions "Blinded facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2049) FacialExpressionInfo Face_FatiguedExpressions "Fatigued facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2050) FacialExpressionInfo Face_DrunkExpressions "Drunk facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";
var(AIFacialExpressions) inherited(2051) FacialExpressionInfo Face_SleepyExpressions "Sleepy facial expressions.  DO NOT specify PlaybackTimes as it will be setup to match the behavior's length.";

var(T3AIFaction) inherited(2097) EThiefFaction ThiefFaction "Does this AI belong to one of the three primary factions?  (hammer/pagan/keeper)";

var(AIBarks) inherited(2137) array<string> CustomSpeechVolumeNames "If the AI is standing within a volume with one of these names specified, the idle speech associated with this volume will always be chosen OVER the character's standard idle speech.";

var(AICitySection) inherited(2138) bool bDisappearsOnCitySectionFlee "When true, this AI will be set bLeaving when it flees Garrett in a citysection and is neither armed nor informing.";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     UsesFlashlight=False
     VisualAcuityMultiplier=1.000000
     AudioAcuityMultiplier=1.000000
     TactileAcuityMultiplier=1.000000
     IgnoreAllNonHostileAuditory=False
     IgnoreAllNonHostileVisual=False
     AnimationSpeedMultiplier=1.000000
     AnimationSpeedRandomPercentageOffset=0.050000
     POVBoneName="head"
     POVAxis=NEGATIVE_Y
     bWeaponAlwaysSelected=False
     bUseTensePatrol=False
     BodyType=BodyType_Human
     PatrolStyle=PATROL_TurnAroundOnFailure
     HostileEnvironmentCheckDistance=50.000000
     CharacterClass=CCLASS_None
     bNeverGreetPlayer=False
     AI_to_AI_AccuracyBonus=0.100000
     CanRollInCombat=True
     PickpocketingAngleThreshold=0.250000
     Face_DefaultExpressions=(Expressions=(eFACE_None))
     Face_CoughingExpressions=(Expressions=(eFACE_Cough),BlendInTime=0.500000,BlendOutTime=0.500000,PlaybackMinTime=3.000000,PlaybackMaxTime=4.000000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_WhistlingExpressions=(Expressions=(eFACE_Whistle),BlendInTime=0.500000,BlendOutTime=0.500000,PlaybackMinTime=3.000000,PlaybackMaxTime=4.000000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_YawningExpressions=(Expressions=(eFACE_Yawn),BlendInTime=0.500000,BlendOutTime=0.500000,PlaybackMinTime=3.000000,PlaybackMaxTime=4.000000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_SneezingExpressions=(Expressions=(eFACE_Sneeze),BlendInTime=0.500000,BlendOutTime=0.500000,PlaybackMinTime=3.000000,PlaybackMaxTime=4.000000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_FrustrationExpressions=(Expressions=(eFACE_Angry),BlendInTime=0.500000,BlendOutTime=0.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_EnragedExpressions=(Expressions=(eFACE_VeryAngry),BlendInTime=0.500000,BlendOutTime=0.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_ReprimandExpressions=(Expressions=(eFACE_SlightlyAngry),BlendInTime=0.500000,BlendOutTime=0.500000,PlaybackMinTime=5.000000,PlaybackMaxTime=7.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_CombatExpressions=(Expressions=(eFACE_Angry,eFACE_Intense),DelayMinTime=5.000000,DelayMaxTime=10.000000,BlendInTime=0.500000,BlendOutTime=0.500000,PlaybackMinTime=5.000000,PlaybackMaxTime=7.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_YellowSearchExpressions=(Expressions=(eFACE_Curious,eFACE_Inquisitive),DelayMinTime=5.000000,DelayMaxTime=10.000000,BlendInTime=0.500000,BlendOutTime=0.500000,PlaybackMinTime=4.500000,PlaybackMaxTime=12.000000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_RedSearchExpressions=(Expressions=(eFACE_Focused,eFACE_Tense),DelayMinTime=5.000000,DelayMaxTime=10.000000,BlendInTime=0.500000,BlendOutTime=0.500000,PlaybackMinTime=4.500000,PlaybackMaxTime=12.000000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_FleeingExpressions=(Expressions=(eFACE_Scared),BlendInTime=0.500000,BlendOutTime=0.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_TakeDamageExpressions=(Expressions=(eFACE_Pain),BlendInTime=0.500000,BlendOutTime=0.500000,PlaybackMinTime=3.000000,PlaybackMaxTime=5.000000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_SurprisedExpressions=(Expressions=(eFACE_Surprised),BlendInTime=0.500000,BlendOutTime=0.500000,PlaybackMinTime=5.000000,PlaybackMaxTime=7.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_SlippingExpressions=(Expressions=(eFACE_Surprised),BlendInTime=0.500000,BlendOutTime=0.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_BlindedExpressions=(Expressions=(eFACE_Blind),BlendInTime=0.500000,BlendOutTime=0.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_FatiguedExpressions=(Expressions=(eFACE_Tired),BlendInTime=0.500000,BlendOutTime=0.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_DrunkExpressions=(Expressions=(eFACE_Drunk),BlendInTime=0.500000,BlendOutTime=0.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     Face_SleepyExpressions=(Expressions=(eFACE_Sleepy),BlendInTime=0.500000,BlendOutTime=0.500000,AlphaMin=0.850000,AlphaMax=1.000000)
     ThiefFaction=TFACTION_None
     bDisappearsOnCitySectionFlee=True
     Physics=PHYS_Havok
     InitialHavokState=Havok_Walking
     ControlledObjectImpulse=(MinImpulse=1000.000000,MaxImpulse=1200.000000)
     PrePivot=()
     CollisionRadius=16.000000
     CollisionHeight=44.000000
     bHidden=False
     CastShadows=ShadowCasting_True
     LightLevelToVisibilityLookup(0)=(LookupInput=0.020000,LookupOutput=0.090000)
     LightLevelToVisibilityLookup(1)=(LookupInput=0.030000,LookupOutput=0.270000)
     LightLevelToVisibilityLookup(2)=(LookupInput=0.040000,LookupOutput=0.350000)
     LightLevelToVisibilityLookup(3)=(LookupInput=0.070000,LookupOutput=0.430000)
     LightLevelToVisibilityLookup(4)=(LookupInput=0.100000,LookupOutput=0.500000)
     LightLevelToVisibilityLookup(5)=(LookupInput=0.120000,LookupOutput=0.590000)
     LightLevelToVisibilityLookup(6)=(LookupInput=0.140000,LookupOutput=0.680000)
     LightLevelToVisibilityLookup(7)=(LookupInput=0.160000,LookupOutput=0.720000)
     LightLevelToVisibilityLookup(8)=(LookupInput=0.180000,LookupOutput=0.830000)
     LightLevelToVisibilityLookup(9)=(LookupInput=0.210000,LookupOutput=0.930000)
}
