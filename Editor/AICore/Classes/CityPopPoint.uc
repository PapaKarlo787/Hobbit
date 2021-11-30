//=============================================================================
// City Section Population Spawn Point Object
// These are placed in a city section where a designer desires dynamic AIs
// to mysteriously appear while Garrett isn't looking.
//=============================================================================

class CityPopPoint extends PatrolPoint
	placeable
	native;
	
	
var(AICitySectionSpawn) runtimeinstantiated(2117) bitfield eCityGroupBF
{
	CITYGROUP_Victims,
	CITYGROUP_Guards,
	CITYGROUP_Hammers,
	CITYGROUP_Pagans,
	CITYGROUP_Extra
} CityGroups "Which CityGroup types of pawns are allowed to spawn from this point.";

var(AICitySectionSpawn) runtimeinstantiated(2150) bool bOnlyOneAtATime "If true, once this point spawns an actor, it will not spawn another until the first has been DELETED (*not* just killed).";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     bOnlyOneAtATime=False
}
