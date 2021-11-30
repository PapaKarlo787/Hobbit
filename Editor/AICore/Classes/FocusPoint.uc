class FocusPoint extends Marker
	placeable
	native;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Texture=Texture'AICore.lookpoint_img'
     bIsFocusPoint=True
     FocusMovementModifier=FOCUS_KeepMoving
     FocusStopTimerMin=1.000000
     FocusStopTimerMax=2.000000
     FocusPointTimeOut=8.000000
     FocusAllowedBehaviors=(FB_Patrol,FB_Search)
}
