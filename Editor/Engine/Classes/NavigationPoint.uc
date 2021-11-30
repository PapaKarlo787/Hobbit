//=============================================================================
// NavigationPoint.
//
// NavigationPoints are organized into a network to provide AIControllers 
// the capability of determining paths to arbitrary destinations in a level
//
//=============================================================================
class NavigationPoint extends Keypoint
	native;

#exec Texture Import File=Textures\S_Pickup.pcx Name=S_Pickup Mips=Off Flags=2
#exec Texture Import File=Textures\SpwnAI.pcx Name=S_NavP Mips=Off Flags=2

// not used currently
#exec Texture Import File=Textures\s_alarmsound.dds Name=S_Alarm Mips=Off Flags=2

//------------------------------------------------------------------------------
// NavigationPoint variables
var int upstreamPaths[16];
var int Paths[16]; //index of reachspecs (used by C++ Navigation code)
var int PrunedPaths[16];
var() name ProscribedPaths[4];	// list of names of NavigationPoints which should never be connected from this path
var() name ForcedPaths[4];		// list of names of NavigationPoints which should always be connected from this path
var int visitedWeight;
var actor RouteCache;
var const int bestPathWeight;
var const NavigationPoint nextNavigationPoint;
var const NavigationPoint nextOrdered;	// for internal use during route searches
var const NavigationPoint prevOrdered;	// for internal use during route searches
var const NavigationPoint previousPath;
var int cost;				//added cost to visit this pathnode
var() int ExtraCost;		//Extra weight added by level designer

var bool bEndPoint;			//used by C++ navigation code
var bool bEndPointOnly;		//only used as an endpoint in routing network
var bool bSpecialCost;		//if true, navigation code will call SpecialCost function for this navigation point
var bool taken;				//set when a creature is occupying this spot
var() bool bBlocked;		// this path is currently unuseable 
var() bool bPropagatesSound; // this navigation point can be used for sound propagation (around corners)
var() bool bOneWayPath;		//reachspecs from this path only in the direction the path is facing (180 degrees)
var() bool bNeverUseStrafing; // shouldn't use bAdvancedTactics going to this point
var const bool bAutoBuilt;		// placed during execution of "PATHS BUILD"
var	bool bSpecialMove;		// if true, pawn will call SuggestMovePreparation() when moving toward this node
var bool bNoAutoConnect;	// don't connect this path to others except with special conditions (used by LiftCenter, for example)
var	const bool	bNotBased;	// used by path builder - if true, no error reported if node doesn't have a valid base
var const bool  bAutoPlaced;	// placed as marker for another object during a paths define

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     upstreamPaths(0)=-1
     upstreamPaths(1)=-1
     upstreamPaths(2)=-1
     upstreamPaths(3)=-1
     upstreamPaths(4)=-1
     upstreamPaths(5)=-1
     upstreamPaths(6)=-1
     upstreamPaths(7)=-1
     upstreamPaths(8)=-1
     upstreamPaths(9)=-1
     upstreamPaths(10)=-1
     upstreamPaths(11)=-1
     upstreamPaths(12)=-1
     upstreamPaths(13)=-1
     upstreamPaths(14)=-1
     upstreamPaths(15)=-1
     Paths(0)=-1
     Paths(1)=-1
     Paths(2)=-1
     Paths(3)=-1
     Paths(4)=-1
     Paths(5)=-1
     Paths(6)=-1
     Paths(7)=-1
     Paths(8)=-1
     Paths(9)=-1
     Paths(10)=-1
     Paths(11)=-1
     Paths(12)=-1
     Paths(13)=-1
     Paths(14)=-1
     Paths(15)=-1
     PrunedPaths(0)=-1
     PrunedPaths(1)=-1
     PrunedPaths(2)=-1
     PrunedPaths(3)=-1
     PrunedPaths(4)=-1
     PrunedPaths(5)=-1
     PrunedPaths(6)=-1
     PrunedPaths(7)=-1
     PrunedPaths(8)=-1
     PrunedPaths(9)=-1
     PrunedPaths(10)=-1
     PrunedPaths(11)=-1
     PrunedPaths(12)=-1
     PrunedPaths(13)=-1
     PrunedPaths(14)=-1
     PrunedPaths(15)=-1
     bPropagatesSound=True
     Texture=Texture'Engine.S_NavP'
     CollisionRadius=80.000000
     CollisionHeight=100.000000
     bCollideWhenPlacing=True
     bHidden=True
     bNotTickable=True
     bNotMoveableRender=True
     bNotSpawnable=True
     bNotMoveablePhysics=True
}
