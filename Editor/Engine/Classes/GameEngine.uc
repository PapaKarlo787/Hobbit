//=============================================================================
// GameEngine: The game subsystem.
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class GameEngine extends Engine
	native
	noexport
	transient;

// URL structure.
struct URL
{
	var string			Protocol,	// Protocol, i.e. "unreal" or "http".
						Host;		// Optional hostname, i.e. "204.157.115.40" or "unreal.epicgames.com", blank if local.
	var int				Port;		// Optional host port.
	var string			Map;		// Map name, i.e. "SkyCity", default is "Index".
	var array<string>	Op;			// Options.
	var string			Portal;		// Portal to enter through, default is "".
	var bool			Valid;
};

var Level			GLevel,
					GEntry;
var URL				LastURL;
var array<string>	ServerActors,
					ServerPackages;
var config array<string> EnginePackages;
					

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     EnginePackages(0)="Core"
     EnginePackages(1)="Engine"
     EnginePackages(2)="AICore"
     EnginePackages(3)="Fire"
     EnginePackages(4)="T3Game"
     EnginePackages(5)="T3AI"
     EnginePackages(6)="T3Player"
     CacheSizeMegs=1
}
