//=============================================================================
// StaticMeshActor.
// An actor that is drawn using a static mesh(a mesh that never changes, and
// can be cached in video memory, resulting in a speed boost).
//=============================================================================

class StaticMeshActor extends Actor
	native
	placeable;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Physics=PHYS_Havok
     InitialHavokState=Havok_HavokControlled
     RenderType=(DrawType=DT_StaticMesh,Style=STY_Normal)
     RenderFlags=(bShadowCast=True)
     CollisionFlags=(bCollideActors=True,bBlockActors=True,bBlockPlayers=True)
     AddSurfacesToNavMesh=AddSurfaces_Default
     CanSubdivideNavMesh=Subdivide_Default
     bNotTickable=True
     bNotMoveableRender=True
     bNotSpawnable=True
     bNotMoveablePhysics=True
     bEdShouldSnap=True
     bWorldGeometry=True
     bAcceptsProjectors=True
}
