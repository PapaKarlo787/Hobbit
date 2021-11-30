class AIPathPoint extends Marker
	abstract
	native;

var noexport native int pad;

var(AIFleePoint) inherited(1436) objectlist bool bFleePoint "This is a point in the map that scared AI's will attempt to flee to.";
var(AIFleePoint) inherited(1799) array<byte> SupportedFactionIDs "Optionally specifies which faction IDs are allowed to use this flee point.";

var inherited(1801) bool bIsFleePointTaken "Set to true when an AI starts moving towards a flee point.";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     bIsFleePointTaken=False
     DrawScale=1.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bHidden=True
     bNotTickable=True
     bNotMoveableRender=True
     bNotSpawnable=True
     bNotMoveablePhysics=True
}
