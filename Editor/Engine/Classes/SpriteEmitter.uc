//=============================================================================
// Emitter: An Unreal Sprite Particle Emitter.
//=============================================================================
class SpriteEmitter extends ParticleEmitter
	native;


enum EParticleDirectionUsage
{
	PTDU_None,
	PTDU_Up,
	PTDU_Right,
	PTDU_Forward,
	PTDU_Normal,
	PTDU_UpAndNormal,
	PTDU_RightAndNormal,
	PTDU_Oriented
};


var (Sprite)		EParticleDirectionUsage		UseDirectionAs;
var (Sprite)		vector						ProjectionNormal;

var transient		vector						RealProjectionNormal;

enum EParticleTrailingLifetime
{
	kPTL_Independent,
	kPTL_Percentage
};


var (Sprite) bool	SortParticles;
var (ParticleTrailing) bool						UseTrailing;
var (ParticleTrailing) range					TrailersPerSecond;
var (ParticleTrailing) int						TrailEmitter;
var (ParticleTrailing) EParticleTrailingLifetime TrailLifetime;

var (Halo) float	PullDistance;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     ProjectionNormal=(Z=1.000000)
     StartSizeRange=(Y=(Min=1.000000,Max=1.000000),Z=(Min=1.000000,Max=1.000000))
}
