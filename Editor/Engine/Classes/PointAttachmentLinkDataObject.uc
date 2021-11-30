class PointAttachmentLinkDataObject extends AttachmentLinkDataObject
	native;

var(Physics) vector m_pointOffset; // offset for point location in source Actor's local space
var(Physics) float  m_pointLimitMin; // minimum point limit (in degrees)
var(Physics) float  m_pointLimitMax; // maximum point limit (in degrees)

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_pointLimitMin=-1.000000
     m_pointLimitMax=-1.000000
     m_LinkFlavor=49289084
}
