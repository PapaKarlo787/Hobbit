class CollisionSpawnLinkDataObject extends SpawnableHardpointLinkDataObject
        native;

//Src should be the object that will collide
//Dest should be the object that is spawned when src collides

var(Collision) bool Active	"A way for the collision manager to know if this link is active or not for purposes of spawning";
var(Collision) string Tag	"An identifier for programmers/designers to manipulate individual links from code and scripts";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_LinkFlavor=37297688
}
