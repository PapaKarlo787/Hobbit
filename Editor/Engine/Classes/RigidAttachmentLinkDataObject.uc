class RigidAttachmentLinkDataObject extends AttachmentLinkDataObject
	native;

var(Spawn) bool bDontSpawn								"The default behavior of this link is to spawn children, this overrides that and does NOT spawn the child";
var(Lifetime) bool bDeleteChildOnDeath					"The default behavior of this link is NOT delete children when the object is destroyed. This overrides that, causing the childrent to be deleted.";
var bool m_bConcretes									"The link has concretes on BOTH ends of it. (keep this in with the bools)";
var bool m_bRepositionAfterRotation						"Specifies it the rotation offset should allow the location to change";
var(Hidden) bool bDontPropogateHiddenFlagToChild		"If true, the bHidden flag will not propogate to children";

var(Offset) rotator m_rotationOffset					"This rotation offset is applied after the object is attached to the hardpoint";
var(Offset) vector m_translationOffset					"This translation offset is applied after the object is attached to the hardpoint, but before the rotation offset is applied";

var transient int m_pAttachmentUpdateCallback			"This is a custom callback to allow developers to do special attachment tweeking";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_LinkFlavor=42056144
}
