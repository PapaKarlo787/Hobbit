// NavMeshSubtractionVolume -- the area defined by this volume will subtract out from the navmesh

class NavMeshSubtractionVolume extends Volume
	placeable
	editoronly
	native;
	

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     bEditorOnlyVolume=True
     AddSurfacesToNavMesh=AddSurfaces_Never
     CanSubdivideNavMesh=Subdivide_Always
}
