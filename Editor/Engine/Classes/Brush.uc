//=============================================================================
// The brush class.
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class Brush extends Actor
	native
	editorinvisible;

#exec Texture Import File=Textures\S_Vertex.pcx Name=S_Vertex Mips=Off Flags=2

//-----------------------------------------------------------------------------
// Variables.

// CSG operation performed in editor.
var() enum ECsgOper
{
	CSG_Active,			// Active brush.
	CSG_Add,			// Add to world.
	CSG_Subtract,		// Subtract from world.
	CSG_Intersect,		// Form from intersection with world.
	CSG_Deintersect,	// Form from negative intersection with world.
} CsgOper;

// Outdated.
var const object UnusedLightMesh;
var vector  PostPivot;

// Scaling.
// Outdated : these are only here to allow the "ucc mapconvert" commandlet to work.
//            They are NOT used by the engine/editor for anything else.
var scale MainScale;
var scale PostScale;
var scale TempScale;

// Information.
var() color BrushColor;
var() int	PolyFlags;
var() bool  bColored;

var native private const Object pStaticMesh;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     MainScale=(Scale=(X=1.000000,Y=1.000000,Z=1.000000))
     PostScale=(Scale=(X=1.000000,Y=1.000000,Z=1.000000))
     TempScale=(Scale=(X=1.000000,Y=1.000000,Z=1.000000))
     bFixedRotationDir=True
     RenderType=(DrawType=DT_Brush,Style=STY_Normal)
     bHidden=True
     bNoDelete=True
     bNotTickable=True
     bNotMoveableRender=True
     bNotSpawnable=True
     bNotMoveablePhysics=True
     bEdShouldSnap=True
}
