class DeathSpawnLinkDataObject extends HardPointLinkDataObject
	native;
	
var(Spawn) int			m_numberToSpawn;			//	how many of these

// NOTE: This is broken (i submited a bug). UCC is failing to compile actor before this class therefore it pukes when it gets to the enum
//var(Inventory) eStimulusType	m_stimulusTrigger;	//	if this is set to something besides NONE only spawns this if death trigger was same as this trigger
var(Spawn) int			m_stimulusTrigger;	// this is a place holder see line above this
var(Spawn) bool			m_bTakeParentRotation; //if this should take the parents exact rotation, if not come into world with no rotation on it

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_numberToSpawn=1
     m_bTakeParentRotation=True
     m_LinkFlavor=43457128
}
