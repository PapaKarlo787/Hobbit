class AIMovementModel extends AIModel
	abstract
	native;

var(AIPathfinding) runtimeinstantiated(602) float MoveMaxFall "The maximum vertical distance an AI is willing to drop/fall during movement and pathfinding (specified in Unreal units, not feet)";
var(AIPathfinding) runtimeinstantiated(740) float MoveMaxRise "The maximum vertical distance an AI is willing to rise during movement and pathfinding (specified in Unreal units, not feet)";
var(AIPathfinding) runtimeinstantiated(603) float MoveProximityThreshold "The radius from an AI's destination point within which an AI considers acceptable (i.e. the distance at which it decides it has 'reached' the destination) -- this is specified in Unreal units, not feet";

var(AIBoneControl) inherited(811) float MaxHeadTurnYaw "The maximum yaw value that an AI can turn its head, specified in degrees";
var(AIBoneControl) inherited(812) float MaxHeadTurnPitch "The maximum pitch value that an AI can turn its head, specified in degrees";

enum EDoorHandlingStyle
{
	DOORSTYLE_FROB_TO_OPEN,
	DOORSTYLE_CANNOT_OPEN,
	DOORSTYLE_OPEN_WITHOUT_KEYS	
};

var(AIPathfinding) inherited(974) EDoorHandlingStyle DoorStyle "Determines whether an NPC can open closed doors";

enum EBeamTriggerHandlingStyle
{
	BEAMTRIGGERSTYLE_FROB_TO_DEACTIVATE,
	BEAMTRIGGERSTYLE_INSTANT_DEACTIVATE,
	BEAMTRIGGERSTYLE_CANT_DEACTIVATE_AVOID,
	BEAMTRIGGERSTYLE_CANT_DEACTIVATE_RUN_THROUGH
};

var(AIPathfinding) inherited(1215) EBeamTriggerHandlingStyle BeamTriggerStyle "Determines whether an NPC can deactivate beam triggers, and if so, how.";
var(AIPathfinding) runtimeinstantiated(741) float LocalPathfindingBaseDistance "The base distance to use for local pathfinding -- i.e. the initial scanning distance from the NPC's current location along the NavMesh path (specified in feet, not Unreal units)";

var(AIMovement) runtimeinstantiated(1329) bool NoTranslation "If NoTranslation is enabled, the animations for this NPC won't translate it.";

var(AIMovement) float CombatTurnSpeedMultiplier "Multiplier to turn speed during combat (1.0 = normal)";
var(AIMovement) float TurnSpeed "Default speed of rotation for AI's for turning in place.";
var(AIMovement) float BendSpeed "Default speed of rotation for AI's for turning while moving.";
var(AIMovement) float AimBeforeTurnAngleThreshold "Angle (in degrees) within which an AI will try to aim at a target before turning to face its target.";
var(AIMovement) float TurnBlendInTime "How much time elapses, in seconds, before AI is fully blended into its turning animations.";
var(AIMovement) float TurnBlendOutTime "How much time elapses, in seconds, before AI is fully blended out of its turning animations.";
var(AIMovement) float ConversationTurnSpeedMultiplier "Multiplier to turn speed during conversations (1.0 = normal)";

var(AIDynamicDamageSystem) inherited(971) float DynamicDamageMultiplier "A multiplier for the extent to which this unit can flinch via the dynamic damage system.  This is 1 (the default) for normal units, 0 for units that cannot flinch, or values in between.";

var(AIPermanentBoneController) inherited(988) array<PermaBoneControlStruct> BoneControlInfo;

var(AISkeleton) inherited(1027) name DirectionBoneName "Name of the AI skeleton's direction bone.";

var(AIFocus) inherited(1924) bool bUseFocusPoints "Don't bother looking for focus points if this property is set to false.";
var(AIFocus) inherited(1925) float FocusPointMaxDistance "AI's will only choose focus points within this distance of themselves (IN FEET).";

var(AIFocus) inherited(1926) float FocusPointPatrolLookMinTime "When on patrol, this is the minimum time that an AI will look at a single focus point.";
var(AIFocus) inherited(1927) float FocusPointPatrolLookMaxTime "When on patrol, this is the maximum time that an AI will look at a single focus point.";
var(AIFocus) inherited(1934) float FocusPointPatrolLaziness "The AI will skip focus points this percentage of the time while on patrol.  If set to 1.0, the AI will always ignore focus points while on patrol.";

var(AIFocus) inherited(1929) float FocusPointSearchLookMinTime "When searching, this is the minimum time that an AI will look at a single focus point.";
var(AIFocus) inherited(1930) float FocusPointSearchLookMaxTime "When searching, this is the maximum time that an AI will look at a single focus point.";
var(AIFocus) inherited(1935) float FocusPointSearchLaziness "The AI will skip focus points this percentage of the time while searching.  If set to 1.0, the AI will always ignore focus points while searching";

// pack bools here...
var(AIPermanentBoneController) bool bKillBoneControllerOnMeleeAttack "AI will kill its permanent bone controller when playing melee attacks, and resume the bone controller afterwards.";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     MoveMaxFall=-40.000000
     MoveMaxRise=16.000000
     MoveProximityThreshold=24.000000
     MaxHeadTurnYaw=55.000000
     MaxHeadTurnPitch=50.000000
     DoorStyle=DOORSTYLE_FROB_TO_OPEN
     BeamTriggerStyle=BEAMTRIGGERSTYLE_FROB_TO_DEACTIVATE
     LocalPathfindingBaseDistance=12.000000
     CombatTurnSpeedMultiplier=2.000000
     TurnSpeed=160.000000
     BendSpeed=100.000000
     AimBeforeTurnAngleThreshold=45.000000
     TurnBlendInTime=0.100000
     TurnBlendOutTime=0.100000
     ConversationTurnSpeedMultiplier=1.750000
     DynamicDamageMultiplier=1.000000
     DirectionBoneName="Direction"
     bUseFocusPoints=True
     FocusPointMaxDistance=20.000000
     FocusPointPatrolLookMinTime=2.000000
     FocusPointPatrolLookMaxTime=4.000000
     FocusPointPatrolLaziness=0.250000
     FocusPointSearchLookMinTime=1.000000
     FocusPointSearchLookMaxTime=1.750000
     FocusPointSearchLaziness=0.100000
}
