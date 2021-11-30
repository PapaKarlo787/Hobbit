//=============================================================================
// City Section Population Info Object
// This is placed in a city section level with settings for how AI ought
// to be dynamically spawned and eliminated during gameplay.
//=============================================================================

class CitySectionPopulationInfo extends Info
	placeable
	native;
	
struct ThiefCitySectionSpawnCounts
{
	var() int	VictimsLimit "The maximum number of AI from group Victims to spawn";
	var() int	GuardsLimit	 "The maximum number of AI from group Guards to spawn";
	var() int	HammersLimit "The maximum number of AI from group Hammers to spawn";
	var() int	PagansLimit  "The maximum number of AI from group Pagans to spawn";
	var() int   ExtrasLimit  "The maximum number of AI from group Extras to spawn";
};

var(AICitySectionSpawn) inherited(2120) ThiefCitySectionSpawnCounts DynamicPawnLimits "Define limits for number of individs from each CityGroup to dynamically spawn.";
var(AICitySectionSpawn) inherited(2121) int MaxAllowedCorpses "When the number of corpses in this map exceeds this number, one will be recycled.";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     MaxAllowedCorpses=0
}
