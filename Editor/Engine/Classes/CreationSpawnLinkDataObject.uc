class CreationSpawnLinkDataObject extends HardpointLinkDataObject
	native;
	
var(Spawn) int			m_numberToSpawn				"how many of these to spawn";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_numberToSpawn=1
     m_LinkFlavor=43006118
}
