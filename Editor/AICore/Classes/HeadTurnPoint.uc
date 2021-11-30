class HeadTurnPoint extends AIPathPoint
	placeable
	native;

#exec Texture Import File=Textures\headturnpoint_img.pcx Name=headturnpoint_img Mips=Off Flags=2

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Texture=Texture'AICore.headturnpoint_img'
}
