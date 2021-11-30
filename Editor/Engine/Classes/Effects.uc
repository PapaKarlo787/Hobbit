//=============================================================================
// Effects, the base class of all gratuitous special effects.
// 
//=============================================================================
class Effects extends Actor
	editorinvisible;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     Physics=PHYS_None
     RenderType=(DrawType=DT_Sprite,Style=STY_Normal)
     RenderFlags=(bUnlit=True)
     CollisionRadius=0.000000
     CollisionHeight=0.000000
     bGameRelevant=True
     bNetTemporary=True
     RemoteRole=ROLE_SimulatedProxy
}
