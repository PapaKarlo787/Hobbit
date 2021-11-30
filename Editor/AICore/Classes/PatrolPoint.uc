class PatrolPoint extends AIPathPoint
	placeable
	native;

#exec Texture Import File=Textures\patrolpoint_img.pcx Name=patrolpoint_img Mips=Off Flags=2

var() inherited(474) int RelativeChancePath1 "This is the relative chance (0-100) that an NPC will take the first path leading from this patrol point.  Values of 0 for all indicates equal probabilities of taking all output paths.";
var() inherited(475) int RelativeChancePath2 "This is the relative chance (0-100) that an NPC will take the second path leading from this patrol point.  Values of 0 for all indicates equal probabilities of taking all output paths.";
var() inherited(476) int RelativeChancePath3 "This is the relative chance (0-100) that an NPC will take the third path leading from this patrol point.  Values of 0 for all indicates equal probabilities of taking all output paths.";
var() inherited(477) int RelativeChancePath4 "This is the relative chance (0-100) that an NPC will take the fourth path leading from this patrol point.  Values of 0 for all indicates equal probabilities of taking all output paths.";
var() inherited(478) int RelativeChancePath5 "This is the relative chance (0-100) that an NPC will take the 5th path leading from this patrol point.  Values of 0 for all indicates equal probabilities of taking all output paths.";
var() inherited(479) int RelativeChancePath6 "This is the relative chance (0-100) that an NPC will take the 6th path leading from this patrol point.  Values of 0 for all indicates equal probabilities of taking all output paths.";
var() inherited(480) int RelativeChancePath7 "This is the relative chance (0-100) that an NPC will take the 7th path leading from this patrol point.  Values of 0 for all indicates equal probabilities of taking all output paths.";
var() inherited(481) int RelativeChancePath8 "This is the relative chance (0-100) that an NPC will take the 8th path leading from this patrol point.  Values of 0 for all indicates equal probabilities of taking all output paths.";

var() inherited(765) float ProximityThreshold "This is the distance (in feet) that an AI must come within a patrol point in order to have 'reached' it";

enum eMovementType
{
	MOVETYPE_RUN,
	MOVETYPE_WALK,
	MOVETYPE_CREEP
};

enum eLookPointSequenceType
{
	LOOK_SEQUENTIAL,
	LOOK_RANDOM,
	LOOK_SHUFFLE
};

var() inherited(783) eMovementType MovementType "The type of movement to use when moving forward from this patrol point"; 

var() inherited(808) bool CanStopToTurn "Indicates whether an AI can stop to turn toward the next patrol point after reaching this one (TRUE by default)";

var() inherited(861) string DebugMessage "A debug message spat out to the screen and log file when an AI reaches this patrol point";

var() inherited(884) bool LoopLookPoints "If at end of patrol, this flag tells AI to keep looping all look / play anim points.  Otherwise, look / play anim points will be triggered once only.";
var() inherited(957) bool ChangeDirection "If this patrol point is reached, the AI will stop and go the other way -- intended to replace the ChangeDirectionPoint class.";
var() inherited(1302) eLookPointSequenceType LookPointSequenceType "Cycle through look points sequentially, randomly, or shuffle (which means randomly, but selecting every point in the sequence).";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     RelativeChancePath1=0
     RelativeChancePath2=0
     RelativeChancePath3=0
     RelativeChancePath4=0
     RelativeChancePath5=0
     RelativeChancePath6=0
     RelativeChancePath7=0
     RelativeChancePath8=0
     MovementType=MOVETYPE_WALK
     CanStopToTurn=False
     ChangeDirection=False
     LookPointSequenceType=LOOK_SEQUENTIAL
     Texture=Texture'AICore.patrolpoint_img'
     Texture_a=Texture'AICore.changedirectionpt_img'
}
