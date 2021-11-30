class FormationPointAbsolute extends AIPathPoint
	native
	placeable;

#exec Texture Import File=Textures\formationabspt_img.pcx Name=formationabspt_img Mips=Off Flags=2

var(FormationPointAbsolute) inherited(315) int CatchUpThresholdInFeetAbs;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     CatchUpThresholdInFeetAbs=15
     Texture=Texture'AICore.formationabspt_img'
}
