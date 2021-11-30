class LinkDataObject extends Object
	native
	noexport
	placeable
	abstract;

var const private INT m_LinkFlavor;
var native const private INT m_pAssociatedLink; //placeholder for c version
var string m_LinkComment;
var(Link) string m_name							"The name of this link.";
var(Link) name m_GroupName						"Group this link is in.";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_LinkFlavor=16780945
}
