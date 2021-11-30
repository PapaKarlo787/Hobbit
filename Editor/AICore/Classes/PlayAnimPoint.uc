class PlayAnimPoint extends LookPoint
	placeable
	native;

#exec Texture Import File=Textures\playanimpt_img.pcx Name=playanimpoint_img Mips=Off Flags=2

var() inherited(809) CustomEditor string LocomotionName "The name of the LOCOMODE to play; see the *MotionTags.ini file in System";
var() inherited(1503) CustomEditor string AnimName "The name of the ANIMATION to play.  If this is specified, it will be used in place of the LOCOMODE.";

var() inherited(810) int NumTimesToPlay "The number of times to play the animation.  Use 0 or -1 to indicate that the animation should loop indefinitely.";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     LocomotionName=""
     AnimName=""
     NumTimesToPlay=1
     LookDurationMin=0.000000
     LookDurationMax=0.000000
     OrderInSequence=0
     Texture=Texture'AICore.playanimpoint_img'
}
