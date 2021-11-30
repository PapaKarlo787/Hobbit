class AttachmentLinkDataObject extends LinkDataObject
	abstract
	native;
	
var(Attachment) CustomEditor string m_attachmentBone	"The bone in the attachment we are attaching with";
var(Attachment) CustomEditor string m_parentBone		"The bone in the parent we are attching to";

var(Highlight) bool bPropagatesHighlight				"Any highlight event is passed between these two objects if true.";

var	int m_attachmentBoneIndex							"The runtime data (actual index into hardpoint array/bone index)";
var int m_parentBoneIndex								"The runtime data (actual index into hardpoint array/bone index)";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_LinkFlavor=33811154
}
