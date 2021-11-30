class LookPoint extends AIPathPoint
	placeable
	native;

#exec Texture Import File=Textures\lookpoint_img.pcx Name=lookpoint_img Mips=Off Flags=2

enum ELookBehavior
{
	CAN_LOOK_AROUND,
	LOOK_STRAIGHT_AHEAD_ONLY,
	LOOK_AT_PLAYER
};

var() inherited(640) float LookDurationMin "The minimum duration that an AI can look in this direction, in seconds";
var() inherited(641) float LookDurationMax "The maximum duration that an AI can look in this direction, in seconds";

var() inherited(643) ELookBehavior LookBehavior "Determines how an NPC behaves when looking in this direction";

var() inherited(642) int OrderInSequence "Represents this look point's order in the sequence; if all are 0, the NPC looks at the points in random order";

var() inherited(890) float TurnSpeedMultiplier "A multiplier on the turn speed.  1.0 is standard speed (default); higher values cause faster turns, and lower values make turns slower.  Must be > 0.";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     LookDurationMin=10.000000
     LookDurationMax=20.000000
     LookBehavior=CAN_LOOK_AROUND
     OrderInSequence=0
     TurnSpeedMultiplier=1.000000
     Texture=Texture'AICore.lookpoint_img'
}
