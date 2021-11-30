//=============================================================================
// Bitmap: An abstract bitmap.
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class Bitmap extends Object
	native
	noexport;

// Texture format.
var(TextureFormat) const editconst enum ETextureFormat
{
	TEXF_P8,
	TEXF_RGBA7,
	TEXF_RGB16,
	TEXF_DXT1,
	TEXF_RGB8,
	TEXF_RGBA8,
	TEXF_NODATA,
	TEXF_DXT3,
	TEXF_DXT5,
	TEXF_G8,
	TEXF_G16
} Format;

// Palette.
var(Texture) palette Palette;

// Internal info.
var const byte  UBits, VBits;
var const int   USize, VSize;
var(Texture) const int UClamp, VClamp;
var const color MipZero;
var const color MaxColor;
var const int   InternalTime[2];

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     MipZero=(B=64,G=128,R=64)
     MaxColor=(B=255,G=255,R=255,A=255)
}
