//=============================================================================
// LevelInfo contains information about the current level. There should 
// be one per level and it should be actor 0. UnrealEd creates each level's 
// LevelInfo automatically so you should never have to place one
// manually.
//
// The ZoneInfo properties in the LevelInfo are used to define
// the properties of all zones which don't themselves have ZoneInfo.
//=============================================================================
class LevelInfo extends ZoneInfo
	native
	nativereplication;

// Textures.
#exec Texture Import File=Textures\DefaultTexture.pcx
#exec Texture Import File=Textures\WhiteSquareTexture.pcx
#exec Texture Import File=Textures\WireframeTexture.tga

//-----------------------------------------------------------------------------
// Level time.

// Current time.
var           float	TimeSeconds;   // Time in seconds since level began play.
var transient int   Year;          // Year.
var transient int   Month;         // Month.
var transient int   Day;           // Day of month.
var transient int   DayOfWeek;     // Day of week.
var transient int   Hour;          // Hour.
var transient int   Minute;        // Minute.
var transient int   Second;        // Second.
var transient int   Millisecond;   // Millisecond.

//-----------------------------------------------------------------------------
// Text info about level.

var() localized string Title;
var()           string Author;		    // Who built it.
var() int IdealPlayerCount;	// Ideal number of players for this level. 
var() localized string LevelEnterText;  // Message to tell players when they enter.
var()           string LocalizedPkg;    // Package to look in for localizations.
var() int		MapNumber;				// Map number.
var           string VisibleGroups;		    // List of the group names which were checked when the level was last saved
//-----------------------------------------------------------------------------
// Flags affecting the level.

var() bool           bLonePlayer;     // No multiplayer coordination, i.e. for entranceways.
var bool             bBegunPlay;      // Whether gameplay has begun.
var bool             bPlayersOnly;    // Only update players.
var bool             bHighDetailMode; // Client high-detail mode.
var bool			 bDropDetail;	  // frame rate is below DesiredFrameRate, so drop high detail actors
var bool			 bAggressiveLOD;  // frame rate is well below DesiredFrameRate, so make LOD more aggressive
var bool             bStartup;        // Starting gameplay.
var	bool			 bPathsRebuilt;	  // True if path network is valid
var(CitySection) thiefprop bool			bIsCitySection;

//-----------------------------------------------------------------------------
// Legend - used for saving the viewport camera positions
var() vector  CameraLocationDynamic;
var() vector  CameraLocationTop;
var() vector  CameraLocationFront;
var() vector  CameraLocationSide;
var() rotator CameraRotationDynamic;

//-----------------------------------------------------------------------------
// Miscellaneous information.
var(CitySection) thiefprop string		CitySectionName;

var() float Brightness;
var() texture Screenshot;
var texture DefaultTexture;
var texture WireframeTexture;
var texture WhiteSquareTexture;
var int HubStackLevel;
var transient enum ELevelAction
{
	LEVACT_None,
	LEVACT_Loading,
	LEVACT_Saving,
	LEVACT_Connecting,
	LEVACT_Precaching
} LevelAction;

struct BroadphaseBoxStruct
{
	var vector m_minExtent;
	var vector m_maxExtent;
};

var inherited (1855) BroadphaseBoxStruct BroadphaseBox; // The broadphase box size for the level

//-----------------------------------------------------------------------------
// Renderer Management.
var() bool bNeverPrecache;

//-----------------------------------------------------------------------------
// Networking.

var enum ENetMode
{
	NM_Standalone,        // Standalone game.
	NM_DedicatedServer,   // Dedicated server, no local client.
	NM_ListenServer,      // Listen server.
	NM_Client             // Client only, no local server.
} NetMode;
var string ComputerName;  // Machine's name according to the OS.
var string EngineVersion; // Engine version.
var string MinNetVersion; // Min engine version that is net compatible.

//-----------------------------------------------------------------------------
// Conersation Package
var() string ConversationPackage;		// The conversation package associated with this map

//-----------------------------------------------------------------------------
// Gameplay rules

var() string DefaultGameType;

//-----------------------------------------------------------------------------
// Navigation point and Pawn lists (chained using nextNavigationPoint and nextPawn).

var const NavigationPoint NavigationPointList;
var const Controller ControllerList;


//-----------------------------------------------------------------------------
// Automap
//-----------------------------------------------------------------------------

struct AutoMapInfo
{
	var() Array<AutoMapFilter> Filters;			// used to filter against map data
	var() string Name;							// name of this map
};

var(AutoMapSystem) inherited(1009) Array<AutoMapInfo> AutoMapInfos "Define a single map.";

//-----------------------------------------------------------------------------
// Server related.

var string NextURL;
var bool bNextItems;
var float NextSwitchCountdown;

// Build Options
var bool bSavedBuildInfo; //Has anyone saved build info for this level? if not, use defaults
var int BSPOptSetting; //EBspOptimization values (enum) (UnRebuildTools.h)
var int RebuildFlags; // bitfield : REBUILD_ (UnRebuildTools.h)
var int BSPTreeBalance; //Balance of BSP tree (0-100) 15 is default
var int BSPPortalBias; //Portal cutting strength (0-100) 70 is default
var int NavMeshBuildFlags; // bitfield (AI_NavMesh.h)

var(NavMesh) inherited(785) float NodeMinCircumference "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(786) float MinDegenerateRectangleEdgeLength "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(787) float MinCircumferenceForCautiousHSplit "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(788) float HeightSplitOffsetInitial "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(789) float HeightSplitOffsetSecondary "Don't touch this unless you know what you're doing";

var(NavMesh) inherited(790) float MaxLinkZDelta "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(791) float MaxFarLinkZDelta "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(792) float MinAdjacentLineLength "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(793) float VertexRadiusMaxZDelta "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(794) float VertexRadiusTestHeight "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(795) float AdjacentLinkXYFudgeDistance "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(796) float MaxGridletHeightDelta "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(797) float MaxPolyArea "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(798) float MinNeighborGridletZDelta "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(799) float MaxNeighborGridletZDelta "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(800) float PolyMinAreaProportion "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(819) float StaticMeshZExaggerate "Don't touch this unless you know what you're doing";
var(NavMesh) inherited(820) float StaticMeshMinSubdivideCircumference "Don't touch this unless you know what you're doing";

var(EditorPathfinding) inherited(801) int EditorPathfindingMinRadius "The radius to use for in-editor pathfinding, specified in Unreal units";
var(EditorPathfinding) inherited(802) int EditorPathfindingMaxRise "The maximum rise distance to use for in-editor pathfinding, specified in Unreal units";
var(EditorPathfinding) inherited(803) int EditorPathfindingMaxFall "The maximum fall distance to use for in-editor pathfinding, specified in Unreal units";
var(EditorPathfinding) inherited(804) int EditorPathfindingMoveTypeFlags "The movement type flags to use for in-editor pathfinding";
var(EditorPathfinding) inherited(805) float EditorPathfindingProximityThreshold "The proximity threshold to use for in-editor pathfinding, specified in Unreal units";
var(EditorPathfinding) inherited(807) float EditorPathfindingMinHeight "The object height to use for in-editor pathfinding, specified in Unreal units";


var(AISearch) inherited(1574) float SearchGridRefreshRate "How long (in seconds) before a search grid that was once marked as 'seen' is treated as unseen?";
var(AISearch) inherited(1575) float NewEvidenceGridUpdateMinStrength "New evidence above this strength will zero out cells in the search grid of a radius between MinRadius and MaxRadius";
var(AISearch) inherited(1576) float NewEvidenceGridUpdateMaxStrength "New evidence up to this strength will zero out cells in the search grid of a radius between MinRadius and MaxRadius";
var(AISearch) inherited(1577) float NewEvidenceGridUpdateMinRadius "New evidence will clear out search grid cells within a radius of at least this and at most, the MaxRadius";
var(AISearch) inherited(1578) float NewEvidenceGridUpdateMaxRadius "New evidence will clear out search grid cells within a radius of at most this amount";

var(AIBarks) float MinTimeBetweenAmbientBarks "idle barks will be globally forbidden from playing within this many seconds of one another.";
var(AIBarks) float MinTimeBetweenNearObjectBarks "NearObject barks will be globally forbidden from playing within this many seconds of one another.";
var(AIBarks) float NearObjectBarkTimestamp "AI's will never play NearObject barks regarding a single game object more than once within this many seconds.";

var(AIBarks) float NearShadowMaxDistanceToPlayer "AI's may say near shadow barks when searching if chosen location is within this many FEET from the player.";
var(AIBarks) float NearShadowMaxLightLevel "AI's may say near shadow barks only if player's light gem value is lower than this value.";

var(AIBarks) float SearchContinueBarkMinTimer "Globally AI's will only say xalert:continue barks on some frequency as determined by these properties.";
var(AIBarks) float SearchContinueBarkMaxTimer "Globally AI's will only say xalert:continue barks on some frequency as determined by these properties.";
var(AIBarks) float SearchUpdateBarkMinTimer "Globally AI's will only say xalert:new_evidence barks on some frequency as determined by these properties.";
var(AIBarks) float SearchUpdateBarkMaxTimer "Globally AI's will only say xalert:new_evidence barks on some frequency as determined by these properties.";
var(AIBarks) float FrustrationBarkMinTimer "Globally, AI's will only say frustration barks every x seconds.";
var(AIBarks) float FrustrationBarkMaxTimer "Globally, AI's will only say frustration barks every x seconds.";
var(AIBarks) float CombatBarkMinTimer "Globally, AI's will only say combat taunt / summon barks every x seconds.";
var(AIBarks) float CombatBarkMaxTimer "Globally, AI's will only say combat taunt / summon barks every x seconds.";

var(AISpellcasters) float DefensiveSpellUsageMinTimer "Globally, AI's will only use defensive spells on friendlies every x seconds.";
var(AISpellcasters) float DefensiveSpellUsageMaxTimer "Globally, AI's will only use defensive spells on friendlies every x seconds.";

var(AIInforming) float TimeBetweenInformBehaviors "After an AI uses the inform behavior, no informing will take place for this many seconds.";
var(AIInforming) float InformCharacterDistance "An AI will initiate the inform routine if it approaches a friendly, armed character within this distance, in feet.";
var(AIInforming) float InformBehaviorTimeout "If an AI attempts to run for help, the inform behavior will only execute if that AI finds somebody within this amount of time.";

var(Leaving) inherited(1612) float LeavingDistance "The distance (in feet) an AI must be away from the player before it's considered for deletion.";

struct thiefprop LoadoutItem
{
	var() string ItemName;
	var() int Num;
};

var(DefaultInventory) inherited(1686) thiefprop Array<LoadoutItem> DefaultInventory "What items the player should have in his inventory when this level starts.";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     Title="Untitled"
     VisibleGroups="None"
     bHighDetailMode=True
     Brightness=1.000000
     DefaultTexture=Texture'Engine.DefaultTexture'
     WireframeTexture=Texture'Engine.WireframeTexture'
     WhiteSquareTexture=Texture'Engine.WhiteSquareTexture'
     NodeMinCircumference=-1.000000
     MinDegenerateRectangleEdgeLength=-1.000000
     MinCircumferenceForCautiousHSplit=-1.000000
     HeightSplitOffsetInitial=-1.000000
     HeightSplitOffsetSecondary=-1.000000
     MaxLinkZDelta=-1.000000
     MaxFarLinkZDelta=-1.000000
     MinAdjacentLineLength=-1.000000
     VertexRadiusMaxZDelta=-1.000000
     VertexRadiusTestHeight=-1.000000
     AdjacentLinkXYFudgeDistance=-1.000000
     MaxGridletHeightDelta=-1.000000
     MaxPolyArea=-1.000000
     MinNeighborGridletZDelta=-1.000000
     MaxNeighborGridletZDelta=-1.000000
     PolyMinAreaProportion=-1.000000
     StaticMeshZExaggerate=-1.000000
     StaticMeshMinSubdivideCircumference=-1.000000
     EditorPathfindingMinRadius=-1
     EditorPathfindingMaxRise=-1
     EditorPathfindingMaxFall=-1
     EditorPathfindingMoveTypeFlags=-1
     EditorPathfindingProximityThreshold=-1.000000
     EditorPathfindingMinHeight=-1.000000
     SearchGridRefreshRate=100.000000
     NewEvidenceGridUpdateMinStrength=1.000000
     NewEvidenceGridUpdateMaxStrength=25.000000
     NewEvidenceGridUpdateMinRadius=3.000000
     NewEvidenceGridUpdateMaxRadius=7.000000
     MinTimeBetweenAmbientBarks=7.000000
     MinTimeBetweenNearObjectBarks=20.000000
     NearObjectBarkTimestamp=60.000000
     NearShadowMaxDistanceToPlayer=15.000000
     NearShadowMaxLightLevel=0.100000
     SearchContinueBarkMinTimer=8.000000
     SearchContinueBarkMaxTimer=12.000000
     SearchUpdateBarkMinTimer=5.000000
     SearchUpdateBarkMaxTimer=7.000000
     FrustrationBarkMinTimer=7.500000
     FrustrationBarkMaxTimer=12.500000
     CombatBarkMinTimer=10.000000
     CombatBarkMaxTimer=17.500000
     DefensiveSpellUsageMinTimer=6.000000
     DefensiveSpellUsageMaxTimer=10.000000
     TimeBetweenInformBehaviors=120.000000
     InformCharacterDistance=15.000000
     InformBehaviorTimeout=180.000000
     LeavingDistance=40.000000
     bHiddenEd=True
     bWorldGeometry=True
     bAlwaysRelevant=True
}
