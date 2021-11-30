class TerrainInfo extends Info
	noexport
	native
	placeable;

#exec Texture Import File=Textures\Terrain_info.pcx Name=S_TerrainInfo Mips=Off Flags=2
#exec Texture Import File=Textures\S_WhiteCircle.pcx Name=S_WhiteCircle Mips=Off Flags=2
#exec Texture Import File=Textures\Bad.pcx Name=TerrainBad Mips=Off Flags=0
#exec Texture Import File=Textures\DecoPaint.pcx Name=DecoPaint Mips=Off Flags=0

struct NormalPair
{
	var vector Normal1;
	var vector Normal2;
};

enum ETexMapAxis
{
	TEXMAPAXIS_XY,
	TEXMAPAXIS_XZ,
	TEXMAPAXIS_YZ,
};

struct TerrainLayer
{
	var() Texture	Texture;
	var() Texture	AlphaMap;
	var() float		UScale;
	var() float		VScale;
	var() float		UPan;
	var() float		VPan;
	var() ETexMapAxis TextureMapAxis;
	var() float		TextureRotation;
	var() Rotator	LayerRotation;
};

struct DecorationLayer
{
	var() bool			ShowOnTerrain;
	var() Texture		ScaleMap;
	var() Texture		DensityMap;
	var() Texture		ColorMap;
	var() StaticMesh	StaticMesh;
	var() vector		ScaleMultiplier;
	var() range			FadeoutRadius;
	var() range			DensityMultiplier;
	var() int			MaxPerQuad;
	var() int			Seed;
	//this int is really a UBOOL in c++
	var() int			AlignToTerrain;
	var() byte			DrawOrder;
	//this int is really a UBOOL in c++
	var() int			ShowOnInvisibleTerrain;
};

var() Texture				TerrainMap;
var() vector				TerrainScale;
var() TerrainLayer			Layers[32];
var() array<DecorationLayer>	DecoLayers;

//AMSD:Put here so the sizes match...
var native const int DummyTerrainPadding[4];

var native const array<TerrainSector>	Sectors;
var native const array<vector> Vertices;
var native const int HeightmapX;
var native const int HeightmapY;
var native const int SectorsX;
var native const int SectorsY;
var native const TerrainPrimitive Primitive;
var native const array<NormalPair> FaceNormals;
var native const vector ToWorld[4];
var native const vector ToHeightmap[4];
var native const array<int>	SelectedVertices;
var native const int ShowGrid;
var const array<int> QuadVisibilityBitmap;
var const array<int> EdgeTurnBitmap;

// OLD
var native const Texture OldTerrainMap;
var native const array<byte> OldHeightmap;

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     TerrainScale=(X=64.000000,Y=64.000000,Z=64.000000)
     Texture=Texture'Engine.S_TerrainInfo'
     RenderFlags=(bStaticLighting=True)
     bNotTickable=True
     bNotMoveableRender=True
     bNotSpawnable=True
     bNotMoveablePhysics=True
     bWorldGeometry=True
}
