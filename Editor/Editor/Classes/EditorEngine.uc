//=============================================================================
// EditorEngine: The UnrealEd subsystem.
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class EditorEngine extends Engine
	native
	noexport
	transient;

#exec Texture Import File=Textures\B_MenuDn.pcx Mips=Off
#exec Texture Import File=Textures\B_MenuUp.pcx Mips=Off
#exec Texture Import File=Textures\B_CollOn.pcx Mips=Off
#exec Texture Import File=Textures\B_CollOf.pcx Mips=Off
#exec Texture Import File=Textures\B_PlyrOn.pcx Mips=Off
#exec Texture Import File=Textures\B_PlyrOf.pcx Mips=Off
#exec Texture Import File=Textures\B_LiteOn.pcx Mips=Off
#exec Texture Import File=Textures\B_LiteOf.pcx Mips=Off
#exec Texture Import File=Textures\HandleLeft.pcx Mips=Off Flags=2
#exec Texture Import File=Textures\HandleRight.pcx Mips=Off Flags=2

#exec Texture Import File=Textures\Bad.pcx
#exec Texture Import File=Textures\Bkgnd.pcx
#exec Texture Import File=Textures\BkgndHi.pcx

// Objects.
var const int         NotifyVtbl;
var const level       Level;
var const model       TempModel;
var const texture     CurrentTexture;
var const staticmesh  CurrentStaticMesh;
var const mesh		  CurrentMesh;
var const class       CurrentClass;
var const transbuffer Trans;
var const textbuffer  Results;
var const int         Pad[6];

// stub place holder
var native noexport int AttachmentLinkDlgPtrStub;

// Icons.
var const texture MenuUp, MenuDn;
var const texture CollOn, CollOff;
var const texture PlyrOn, PlyrOff;
var const texture LiteOn, LiteOff;
var const texture HandleLeft, HandleRight;

// Textures.
var const texture Bad, Bkgnd, BkgndHi;

// Toggles.
var const bool bFastRebuild, bBootstrapping;

// Other variables.
var const config int AutoSaveIndex;
var const int AutoSaveCount, Mode, TerrainEditBrush, ClickFlags;
var const float MovementSpeed;
var const package PackageContext;
var const vector ClickLocation;
var const plane ClickPlane;

// Grid snapping.
var const int GridSnap;

// Misc.
var const array<Object> Tools;
var const class BrowseClass;

// Grid.
var const int ConstraintsVtbl;
var(Grid) configed bool GridEnabled;
var(Grid) configed bool SnapVertices;
var(Grid) configed float SnapDistance;
var(Grid) configed vector GridSize;

// Rotation grid.
var(RotationGrid) configed bool RotGridEnabled;
var(RotationGrid) configed rotator RotGridSize;

// Advanced.
var(Advanced) config bool UseSizingBox;
var(Advanced) config bool UseAxisIndicator;
var(Advanced) float FovAngleDegrees;
var(Advanced) config bool GodMode;
var(Advanced) configed bool AutoSave;
var(Advanced) configed byte AutosaveTimeMinutes;
var(Advanced) config string GameCommandLine;
var(Advanced) config array<string> EditPackages;
var(Advanced) config array<string> Users;
var(Advanced) config array<string> SMStatus;
var(Advanced) config bool AlwaysShowTerrain;
var(Advanced) config bool UseActorRotationGizmo;	// Use the gizmo for rotating actors?
var(Advanced) config bool AlwaysUseDirectionArrows;	// Shows actor directional arrows even when bdirectional is false
var(Advanced) config float MatineeCurveDetail;
var(Advanced) config bool bLocalTrafosOnly;			// all editor movements strictly relative to local location/rotation

var native noexport int EditorPhysicsSimulatorPadding;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     MenuUp=Texture'Editor.B_MenuUp'
     MenuDn=Texture'Editor.B_MenuDn'
     CollOn=Texture'Editor.B_CollOn'
     CollOff=Texture'Editor.B_CollOf'
     PlyrOn=Texture'Editor.B_PlyrOn'
     PlyrOff=Texture'Editor.B_PlyrOf'
     LiteOn=Texture'Editor.B_LiteOn'
     HandleLeft=Texture'Editor.HandleLeft'
     HandleRight=Texture'Editor.HandleRight'
     Bad=Texture'Editor.Bad'
     Bkgnd=Texture'Editor.Bkgnd'
     BkgndHi=Texture'Editor.BkgndHi'
     AutoSaveIndex=6
     GridEnabled=True
     GridSize=(X=16.000000,Y=16.000000,Z=16.000000)
     RotGridEnabled=True
     RotGridSize=(Pitch=1024,Yaw=1024,Roll=1024)
     UseSizingBox=True
     UseAxisIndicator=True
     FovAngleDegrees=90.000000
     GodMode=True
     AutoSave=True
     AutosaveTimeMinutes=5
     GameCommandLine="-log"
     EditPackages(0)="Core"
     EditPackages(1)="Engine"
     EditPackages(2)="Editor"
     EditPackages(3)="AICore"
     EditPackages(4)="Fire"
     EditPackages(5)="T3Game"
     EditPackages(6)="T3AI"
     EditPackages(7)="T3Player"
     EditPackages(8)="T3Gamesys"
     SMStatus(0)="Requested"
     SMStatus(1)="p1-no texture"
     SMStatus(2)="p1-textured"
     SMStatus(3)="p2-Multi-pass"
     SMStatus(4)="p2-Multi-pass-Normal"
     SMStatus(5)="FIX/REDO"
     SMStatus(6)="OPTIMIZE"
     SMStatus(7)="Review"
     SMStatus(8)="Final"
     CacheSizeMegs=16
}
