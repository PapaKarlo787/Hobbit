class AIContextVolume extends Volume
	native
	abstract;

var(ContextVolume) inherited (14) float CanReprimand "Indicates whether an AI can reprimand the player (for bumping, odd behavior, etc.) in this type of volume (0=no, 1=yes)";
var(ContextVolume) inherited (15) int ContextPriority "Indicates the volume's priority relative to other volumes.  Lower values indicate higher priorities.  At any given point in space, the volume with the lowest numeric priority overrides all the others.  Valid priority values are 1 and above";

var(ContextVolume) inherited (16) float EvidenceMultiplier_MaybeSawActor "Indicates how AIs should treat the MAYBE-SAW-ACTOR type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";
var(ContextVolume) inherited (17) float EvidenceMultiplier_ClearlySawActor "Indicates how AIs should treat the CLEARLY-SAW-ACTOR type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";
var(ContextVolume) inherited (18) float EvidenceMultiplier_HeardSomething "Indicates how AIs should treat the HEARD-SOMETHING type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";
var(ContextVolume) inherited (19) float EvidenceMultiplier_FeltSomething "Indicates how AIs should treat the FELT-SOMETHING type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";
var(ContextVolume) inherited (20) float EvidenceMultiplier_TookDamage "Indicates how AIs should treat the TOOK-DAMAGE type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";
var(ContextVolume) inherited (490) float EvidenceMultiplier_Body "Indicates how AIs should treat the SAW-DEAD-BODY type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";
var(ContextVolume) inherited (687) float EvidenceMultiplier_ActorBumpedSomething "Indicates how AIs should treat the ACTOR-BUMPED-SOMETHING type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";
var(ContextVolume) inherited (709) float EvidenceMultiplier_Alarm "Indicates how AIs should treat the ALARM type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";
var(ContextVolume) inherited (1077) float EvidenceMultiplier_Gassed  "Indicates how AIs should treat the GASSED type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";
var(ContextVolume) inherited (1095) float EvidenceMultiplier_Shocked  "Indicates how AIs should treat the SHOCKED type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";
var(ContextVolume) inherited (1485) float EvidenceMultiplier_Blinded  "Indicates how AIs should treat the BLINDED type of evidence in this volume (1=standard, 0=ignore, 0-1= less important, >1=more important)";

enum ERemappedDisposition
{
	CHANGETO_HOSTILE,
	CHANGETO_FEARFUL,
	CHANGETO_NEUTRAL,
	CHANGETO_FRIENDLY,
	CHANGETO_ALLIED
};

var(ContextVolume) inherited(1193) ERemappedDisposition RemapHostileTo "NPCs that are HOSTILE to other actors will be remapped to this disposition in this volume";
var(ContextVolume) inherited(1194) ERemappedDisposition RemapFearfulTo "NPCs that are HOSTILE to other actors will be remapped to this disposition in this volume";
var(ContextVolume) inherited(1195) ERemappedDisposition RemapNeutralTo "NPCs that are HOSTILE to other actors will be remapped to this disposition in this volume";
var(ContextVolume) inherited(1196) ERemappedDisposition RemapFriendlyTo "NPCs that are HOSTILE to other actors will be remapped to this disposition in this volume";
var(ContextVolume) inherited(1197) ERemappedDisposition RemapAlliedTo "NPCs that are HOSTILE to other actors will be remapped to this disposition in this volume";

var(ContextVolume) inherited (458) string TagString "This is the tag string that will be sent to the tag system when sounds are played in this volume";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     CanReprimand=1.000000
     ContextPriority=0
     EvidenceMultiplier_MaybeSawActor=1.000000
     EvidenceMultiplier_ClearlySawActor=1.000000
     EvidenceMultiplier_HeardSomething=1.000000
     EvidenceMultiplier_FeltSomething=1.000000
     EvidenceMultiplier_TookDamage=1.000000
     EvidenceMultiplier_Body=1.000000
     EvidenceMultiplier_ActorBumpedSomething=1.000000
     EvidenceMultiplier_Alarm=1.000000
     EvidenceMultiplier_Gassed=1.000000
     EvidenceMultiplier_Shocked=1.000000
     RemapHostileTo=CHANGETO_HOSTILE
     RemapFearfulTo=CHANGETO_FEARFUL
     RemapNeutralTo=CHANGETO_NEUTRAL
     RemapFriendlyTo=CHANGETO_FRIENDLY
     RemapAlliedTo=CHANGETO_ALLIED
     TagString="context"
     VolumeType=VOLUME_AI
}
