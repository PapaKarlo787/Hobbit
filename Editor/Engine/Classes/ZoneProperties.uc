// ZoneProperties.uc

class ZoneProperties extends Info
	placeable
	native;
	
#exec Texture Import File=Textures\ZoneProperties.pcx Name=S_ZoneProperties Mips=Off Flags=2

var(Active) inherited(1263) bool bIsActive;
var(SoundStreaming) inherited(1287) CustomEditor string StreamSchema1;
var(SoundStreaming) inherited(1286) CustomEditor string StreamSchema2;
var(SoundStreaming) inherited(1467) CustomEditor string NonStreamSchema1;
var(SoundStreaming) inherited(1786) CustomEditor string NonStreamSchema2;
var(SoundStreaming) inherited(1787) CustomEditor string NonStreamSchema3;
var(ZoneProperty) inherited(1563) deusexprop bool bVentZone;
var(ZoneProperty) inherited(2108) CustomEditor string ReverbStyle;

//-----------------------------------------------------------------------------
// Automap System

var(AutoMapSystem) inherited(1308) bool bMapZone "Zone is considered a map zone by the AutoMapSystem - NOTE: this must be set TRUE.";
var(AutoMapSystem) inherited(1309) bool bMapVisible "Whether this map zone is visible to the AutoMapSystem.";
var(AutoMapSystem) inherited(1310) Array<AutoMapFilter> AutoMapFilters "Define map ID's";
var(AutoMapSystem) inherited(1745) string RoomName "Name to display at this zone properties location.";
var bool bZoneVisited "Zone has been visited.";

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     bIsActive=True
     Texture=Texture'Engine.S_ZoneProperties'
     bNotTickable=True
}
