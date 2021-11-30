//=============================================================================
// BeamEmitter: An Unreal Beam Particle Emitter.
//=============================================================================
class DynamicBeamEmitter extends BeamEmitter
	native;

var(Dynamic)	array<vector>	DynamicPointList	"Points to use to test this in the editor only";
var(Dynamic)	bool			UseDynamicPoints	"Defaults to false so code can turn this on if it uses the point list";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
}
