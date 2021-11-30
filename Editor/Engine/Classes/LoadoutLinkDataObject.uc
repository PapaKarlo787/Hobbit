class LoadoutLinkDataObject extends LinkDataObject
	native
	notplaceable
	editorinvisible;

var() string m_parentBone		"The bone in the parent we are attaching to(if any)";
var() string m_childBone		"The bone in the child we are attaching to(if any)";
var() bool bIsWeaponAttachment "Are we a weapon attachment?  (If not, we're an inventory item)";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     m_LinkFlavor=49119293
}
