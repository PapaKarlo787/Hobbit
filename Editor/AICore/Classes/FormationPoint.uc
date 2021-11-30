class FormationPoint extends AIPathPoint
	native
	placeable;

#exec Texture Import File=Textures\formationpt_img.pcx Name=formationpt_img Mips=Off Flags=2

var(FormationPoint) inherited(314) int CatchUpThresholdInFeet;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     CatchUpThresholdInFeet=15
     Texture=Texture'AICore.formationpt_img'
}
