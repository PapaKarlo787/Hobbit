//=============================================================================
// Canvas: A drawing canvas.
// This is a built-in Unreal class and it shouldn't be modified.
//
// Notes.
//   To determine size of a drawable object, set Style to STY_None,
//   remember CurX, draw the thing, then inspect CurX and CurYL.
//=============================================================================
class Canvas extends Object
	native
	noexport;
	
#exec Font Import File=Textures\smallfont.bmp Name=SmallFont
#exec Font Import File=Textures\ArialFont.bmp Name=MedFont
#exec Texture Import File=Textures\Border.pcx
#exec new TrueTypeFontFactory PACKAGE="Engine" Name=XFont FontName="Lucida Console" Height=14 AntiAlias=1 CharactersPerPage=128
#exec new TrueTypeFontFactory PACKAGE="Engine" Name=HudFont1 FontName="Agency FB" Height=20 AntiAlias=1 CharactersPerPage=128
#exec new TrueTypeFontFactory PACKAGE="Engine" Name=HudFont1B FontName="Agency FB Bold" Height=20 AntiAlias=1 CharactersPerPage=128

// Modifiable properties.
var font    Font;            // Font for DrawText.
var float   SpaceX, SpaceY;  // Spacing for after Draw*.
var float   OrgX, OrgY;      // Origin for drawing.
var float   ClipX, ClipY;    // Bottom right clipping region.
var float   CurX, CurY;      // Current position for drawing.
var float   Z;               // Z location. 1=no screenflash, 2=yes screenflash.
var byte    Style;           // Drawing style STY_None means don't draw.
var float   CurYL;           // Largest Y size since DrawText.
var color   DrawColor;       // Color for drawing.
var bool    bCenter;         // Whether to center the text.
var bool    bNoSmooth;       // Don't bilinear filter.
var const int SizeX, SizeY;  // Zero-based actual dimensions.

// Stock fonts.
var font SmallFont;          // Small system font.
var font MedFont;           // Medium system font.
var font XBoxFont;

// Internal.
var const viewport Viewport; // Viewport that owns the canvas.

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     Z=1.000000
     Style=1
     DrawColor=(B=127,G=127,R=127)
     SmallFont=Font'Engine.SmallFont'
     MedFont=Font'Engine.MedFont'
     XBoxFont=Font'Engine.XFont'
}
