//=============================================================================
// SubActionTrigger:
//
// Fires off a trigger.
//=============================================================================
class SubActionTrigger extends MatSubAction
	native;

var(Trigger)	name	EventName;		// The event to trigger

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     Icon=Texture'Engine.SubActionTrigger'
     Desc="Trigger"
}
