class PlayBarkPoint extends LookPoint
	placeable
	native;

#exec Texture Import File=Textures\barkpoint_img.pcx Name=barkpoint_img Mips=Off Flags=2

var() inherited(1974) string Schema "The name of the schema to play.";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Schema=""
     LookDurationMin=0.000000
     LookDurationMax=0.000000
     OrderInSequence=0
     Texture=Texture'AICore.barkpoint_img'
}
