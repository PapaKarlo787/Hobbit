//=============================================================================
// The SwooshEffectObject class.
//=============================================================================
class SwooshEffectObject extends MetaProperty
	abstract
	native;
	
struct SwooshEffectStruct
{
	var() color			Color		"Base color of effect";
	var() string		Material	"Effect material";
	var() bool			UVTile		"Tile texture?";	 
	var() float			AlphaDecay	"Time in seconds effect portion lasts";	
	var() Array<string> Points		"Set of points to define geometry";
};

var(Swoosh) inherited(1989) SwooshEffectStruct swoosh "Swoosh Visual Effect";
	

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
}
