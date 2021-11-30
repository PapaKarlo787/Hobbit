//=============================================================================
// WaypointMarker.
//=============================================================================
class WaypointMarker extends Keypoint
	native
	placeable;
	
#exec Texture Import File=Textures\addwaypoint_img.bmp Name=waypoint_img Mips=Off Flags=2

var(Elevator)		   inherited(1231)				int				  FloorNumber "Elevator floor number for this keypoint";
var(Elevator)		   inherited(1233)    CustomEditor name FloorName   "A floor name. The floor should be in the list kept in MetaData->ElevatorFloors. - Jerm 12/09/02";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Texture=Texture'Engine.waypoint_img'
     DrawScale=1.000000
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bHidden=True
     bNotTickable=True
     bNotMoveableRender=True
     bNotSpawnable=True
     bNotMoveablePhysics=True
}
