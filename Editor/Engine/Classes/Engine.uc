//=============================================================================
// Engine: The base class of the global application object classes.
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class Engine extends Subsystem
	native
	noexport
	transient;

// Drivers.
var(Drivers) config class<Language>       Language;

// Variables.
var primitive Cylinder;
var const client Client;
var const aisubsystem AI;
var const physicssubsystem Physics;
var const gamesubsystem Game;
var const renderdevice GRenDev;
var int TickCycles, GameCycles, ClientCycles;
var(Settings) config int CacheSizeMegs;
var(Settings) config bool UseSound;
var(Settings) float CurrentTickRate;

var int  ProfileDisplayMode;
var int  ProfileDetailDisplayMode;
var int  ProfileSelectedGroups;
var int  ProfileSelectedStatsCategory;
var int  ProfileDisplayInstance;
var int  ProfileFrameTimeHistory;
var int  ProfileFrameTimeIndex;

// Color preferences.
var(Colors) configed color
	C_WorldBox,
	C_GroundPlane,
	C_GroundHighlight,
	C_BrushWire,
	C_Pivot,
	C_Select,
	C_Current,
	C_AddWire,
	C_SubtractWire,
	C_GreyWire,
	C_BrushVertex,
	C_BrushSnap,
	C_Invalid,
	C_ActorWire,
	C_ActorHiWire,
	C_Black,
	C_White,
	C_Mask,
	C_SemiSolidWire,
	C_NonSolidWire,
	C_WireBackground,
	C_WireGridAxis,
	C_ActorArrow,
	C_ScaleBox,
	C_ScaleBoxHi,
	C_ZoneWire,
	C_Mover,
	C_OrthoBackground,
	C_StaticMesh,
	C_VolumeBrush;

var const int	GameStats[5];

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     CacheSizeMegs=2
     UseSound=True
     C_WorldBox=(B=107)
     C_GroundPlane=(B=63)
     C_GroundHighlight=(B=127)
     C_BrushWire=(B=63,G=63,R=255)
     C_Pivot=(G=255)
     C_Select=(B=127)
     C_AddWire=(B=255,G=127,R=127)
     C_SubtractWire=(B=63,G=192,R=255)
     C_GreyWire=(B=163,G=163,R=163)
     C_Invalid=(B=163,G=163,R=163)
     C_ActorWire=(G=63,R=127)
     C_ActorHiWire=(G=127,R=255)
     C_White=(B=255,G=255,R=255)
     C_SemiSolidWire=(G=255,R=127)
     C_NonSolidWire=(B=32,G=192,R=63)
     C_WireGridAxis=(B=119,G=119,R=119)
     C_ActorArrow=(R=163)
     C_ScaleBox=(B=11,G=67,R=151)
     C_ScaleBoxHi=(B=157,G=149,R=223)
     C_Mover=(B=255,R=255)
     C_OrthoBackground=(B=163,G=163,R=163)
     C_StaticMesh=(B=255,G=255)
     C_VolumeBrush=(B=255,R=255)
}
