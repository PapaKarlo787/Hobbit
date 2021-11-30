//=============================================================================
// Volume:  a bounding volume
// touch() and untouch() notifications to the volume as actors enter or leave it
// enteredvolume() and leftvolume() notifications when center of actor enters the volume
// pawns with bIsPlayer==true  cause playerenteredvolume notifications instead of actorenteredvolume()
// This is a built-in Unreal class and it shouldn't be modified.
//=============================================================================
class Volume extends Brush
	native;

var() localized string LocationName;

var inherited(173) vector RenderColor; 
var inherited(174) string RenderName;

enum EVolumeType
{
	VOLUME_BASIC,
	VOLUME_PHYSICS,
	VOLUME_LADDER,
	VOLUME_AI,
	VOLUME_TAG,
	VOLUME_AMBIENT_LIGHT,
	VOLUME_SHALLOW_WATER,
	VOLUME_DEATH_WATER
};

struct VolumeStimPing
{
	var() StimulusAmount	Amount		"The stimulus and amount we are applying per ping";
};

struct VolumePinger
{	
	var() bool					Inactive	"Is this pinger inactive";				
	var() array<VolumeStimPing>	Stim		"The stimulus info";
	var() float					Frequency	"How often to apply this stim in seconds. You should not go below 0.25 or so.";		
};

var inherited(175) EVolumeType VolumeType;

var(Stimulus) inherited(907) VolumePinger	VolumePingInfo "Every second a volume pulse of the stim specefied is emitted";

struct TeleportStruct
{
	var() string TeleportName			"This is the teleporter's name. It will be used to link other teleporters to it.";
	var() string TeleportDestination	"This the TeleportName of the destination teleporter.";
	var() string TeleportMap			"This the Map name to teleport to. Leave blank if destination teleporter is in the current map.";
	var() bool	 PromptForTeleport		"When TRUE, a dialog box will appear prompting the player if they want to enter the teleport.";
	var() bool   UsePlayerOrientation   "When TRUE, the player will keep his orientation during the teleport.";
	var() string TeleportDisplayName	"This is a localized string table entry that lists the name of the destination the *player* will see when asked if they want to teleport.";
	var() string FirstVisitGlobalVar	"The global variable name; if this global var is false, it means it's the first time we've visited the dest map and will play a voice-over.";
};

var(Teleport) inherited(1245) TeleportStruct TeleportInfo "Information used if you want to make this volume a teleporter.";

var() inherited(1125) bool Enabled "Indicates whether this volume is currently enabled (this applies to AI-related volumes, such as context and tagged volumes AND water volumes).";
var(AI) inherited(1790) bool bEditorOnlyVolume "If true, this volume will not be monitored for game events like other volumes -- primarily intended for the NavMeshSubtractionVolume.";

var() Box CachedWorldBBox;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     LocationName="unspecified"
     RenderColor=(X=0.200000,Y=0.200000,Z=0.200000)
     RenderName="VOLUME"
     VolumeType=VOLUME_BASIC
     Enabled=True
     bEditorOnlyVolume=False
     CollisionFlags=(bCollideActors=True)
     bNotTickable=False
}
