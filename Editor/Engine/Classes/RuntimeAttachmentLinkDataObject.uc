class RuntimeAttachmentLinkDataObject extends AttachmentLinkDataObject
	notplaceable
	editorinvisible
	native;

//@NOTE:AMSD If you delete this, you need to delete the associated assertmsg in ULinkDataObject::Serialize

//var(Attachment) CustomEditor string m_attachmentBone	"The bone in the attachment we are attaching with";
//var(Attachment) CustomEditor string m_parentBone		"The bone in the parent we are attching to";

var(Lifetime) bool bDeleteChildOnDeath					"If the child should be destroyed when the parent is.";

// hidden properties used internally
//var	int m_attachmentBoneIndex;				// The runtime data (actual index into hardpoint array/bone index)
//var int m_parentBoneIndex;					// The runtiem data (acutal index into hardpoint array/bone index)

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     m_LinkFlavor=48418604
}
