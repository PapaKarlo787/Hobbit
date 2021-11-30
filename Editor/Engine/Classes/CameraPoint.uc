//=============================================================================
// CameraPoint
// Used for to change "view" location of player, partly for screenshot generation
//=============================================================================
class CameraPoint extends Keypoint
	native;

#exec Texture Import File=Textures\CameraPoint_Img.pcx Name=CameraPoint_Img Mips=Off MASKED=1

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Texture=Texture'Engine.CameraPoint_Img'
     bDirectional=True
}
