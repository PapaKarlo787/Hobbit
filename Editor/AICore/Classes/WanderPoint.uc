class WanderPoint extends PatrolPoint
	placeable
	native;
	
#exec Texture Import File=Textures\wanderpoint_img.pcx Name=wanderpoint_img Mips=Off Flags=2
	
var() inherited(1674) float MaxDistFromStart "Max Distance (IN FEET) AI will wander from this wander point's location.";
var() inherited(1675) float MaxDistFromWalls "Max Distance (IN FEET) AI will push away from walls or ledges when choosing a wander location.";
var() inherited(1676) float MinStopTime "Minimum time (IN SECONDS) AI will wait at a wander location before moving again.";
var() inherited(1677) float MaxStopTime "Maximum time (IN SECONDS) AI will wait at a wander location before moving again.";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     MaxDistFromStart=12.000000
     MaxDistFromWalls=3.000000
     MinStopTime=2.500000
     MaxStopTime=5.000000
     Texture=Texture'AICore.wanderpoint_img'
}
