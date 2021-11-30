class FlinderizeLinkDataObject extends HardpointLinkDataObject
	native;

var(Spawn) int					m_numberToSpawn			"Number of flinders of the architype pointed to by this link to spawn";
var(ConeSpreadPattern) FLOAT	m_ConeTheta	"How many degrees is the cone (ie, how wide 90 = cylinder)";

enum eSpreadPattern
{
	SpreadPattern_Cone = 1,
	SpreadPattern_ReverseCone = 2,
};

var(Spread) eSpreadPattern	m_spreadPattern	"How these things spread.";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_numberToSpawn=1
     m_spreadPattern=SpreadPattern_Cone
     m_LinkFlavor=46596621
}
