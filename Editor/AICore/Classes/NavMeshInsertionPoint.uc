class NavMeshInsertionPoint extends Marker
	native
	placeable;
	
#exec Texture Import File=Textures\AIPointer.pcx Name=aipointer_img Mips=Off Flags=2
	

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Texture=Texture'AICore.aipointer_img'
     bEdShouldSnap=True
}
