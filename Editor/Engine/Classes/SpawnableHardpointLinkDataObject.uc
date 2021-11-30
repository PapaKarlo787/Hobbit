class SpawnableHardpointLinkDataObject extends HardPointLinkDataObject
	abstract
	native;
	

var(Spawn)		int			NumberToSpawn				"how many of these";

var(Spawn)		bool		bTakeParentRotation		"if this should take the parents exact rotation, if not come into world with no rotation on it";
var(Hardpoint)	bool		bAttachObjects			"if the objects should be attached";
var(Lifetime)	bool		bDeleteOnDeath			"if (bAttachObjects) should the parent delete me when it dies";

var(Hardpoint) CustomEditor string m_childBone		"The bone in the child we are attching to";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     NumberToSpawn=1
     bTakeParentRotation=True
     m_LinkFlavor=42760374
}
