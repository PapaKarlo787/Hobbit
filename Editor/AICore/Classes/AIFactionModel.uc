class AIFactionModel extends AIModel
	abstract
	native;

enum EFactionDisposition
{
	DISPOSITION_HOSTILE,			// NPCs are hostile to that faction
	DISPOSITION_FEARFUL,			// NPCs avoid/flee that faction on sight
	DISPOSITION_NEUTRAL,			// NPCs ignore that faction unless attacked or threatened by it
	DISPOSITION_FRIENDLY,			// same as neutral, but NPCs can engage in conversations with NPCs they are friendly to
	DISPOSITION_ALLIED				// same as friendly, but NPCs will assist members of that faction if necessary and can be summoned by members of that faction for assistance
};

var(AIFaction) runtimeinstantiated(605) byte FactionGUID "This is a faction's globally unique ID number; each faction corresponds to a number from 0 to 9";

var(AIFaction) runtimeinstantiated (1192) EFactionDisposition Disposition_vs_Player "This property determines this faction's disposition toward the player";
var(AIFaction) runtimeinstantiated (606) EFactionDisposition Disposition_vs_Faction0 "This property determines this faction's disposition toward the faction whose FactionGUID is 0";
var(AIFaction) runtimeinstantiated (607) EFactionDisposition Disposition_vs_Faction1 "This property determines this faction's disposition toward the faction whose FactionGUID is 1";
var(AIFaction) runtimeinstantiated (608) EFactionDisposition Disposition_vs_Faction2 "This property determines this faction's disposition toward the faction whose FactionGUID is 2";
var(AIFaction) runtimeinstantiated (609) EFactionDisposition Disposition_vs_Faction3 "This property determines this faction's disposition toward the faction whose FactionGUID is 3";
var(AIFaction) runtimeinstantiated (610) EFactionDisposition Disposition_vs_Faction4 "This property determines this faction's disposition toward the faction whose FactionGUID is 4";
var(AIFaction) runtimeinstantiated (611) EFactionDisposition Disposition_vs_Faction5 "This property determines this faction's disposition toward the faction whose FactionGUID is 5";
var(AIFaction) runtimeinstantiated (612) EFactionDisposition Disposition_vs_Faction6 "This property determines this faction's disposition toward the faction whose FactionGUID is 6";
var(AIFaction) runtimeinstantiated (613) EFactionDisposition Disposition_vs_Faction7 "This property determines this faction's disposition toward the faction whose FactionGUID is 7";
var(AIFaction) runtimeinstantiated (614) EFactionDisposition Disposition_vs_Faction8 "This property determines this faction's disposition toward the faction whose FactionGUID is 8";
var(AIFaction) runtimeinstantiated (615) EFactionDisposition Disposition_vs_Faction9 "This property determines this faction's disposition toward the faction whose FactionGUID is 9";
var(AIFaction) runtimeinstantiated (932) EFactionDisposition Disposition_vs_Faction10 "This property determines this faction's disposition toward the faction whose FactionGUID is 10";
var(AIFaction) runtimeinstantiated (933) EFactionDisposition Disposition_vs_Faction11 "This property determines this faction's disposition toward the faction whose FactionGUID is 11";
var(AIFaction) runtimeinstantiated (934) EFactionDisposition Disposition_vs_Faction12 "This property determines this faction's disposition toward the faction whose FactionGUID is 12";
var(AIFaction) runtimeinstantiated (935) EFactionDisposition Disposition_vs_Faction13 "This property determines this faction's disposition toward the faction whose FactionGUID is 13";
var(AIFaction) runtimeinstantiated (936) EFactionDisposition Disposition_vs_Faction14 "This property determines this faction's disposition toward the faction whose FactionGUID is 14";
var(AIFaction) runtimeinstantiated (937) EFactionDisposition Disposition_vs_Faction15 "This property determines this faction's disposition toward the faction whose FactionGUID is 15";
var(AIFaction) runtimeinstantiated (938) EFactionDisposition Disposition_vs_Faction16 "This property determines this faction's disposition toward the faction whose FactionGUID is 16";
var(AIFaction) runtimeinstantiated (939) EFactionDisposition Disposition_vs_Faction17 "This property determines this faction's disposition toward the faction whose FactionGUID is 17";
var(AIFaction) runtimeinstantiated (940) EFactionDisposition Disposition_vs_Faction18 "This property determines this faction's disposition toward the faction whose FactionGUID is 18";
var(AIFaction) runtimeinstantiated (941) EFactionDisposition Disposition_vs_Faction19 "This property determines this faction's disposition toward the faction whose FactionGUID is 19";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     FactionGUID=0
     Disposition_vs_Player=DISPOSITION_NEUTRAL
     Disposition_vs_Faction0=DISPOSITION_NEUTRAL
     Disposition_vs_Faction1=DISPOSITION_NEUTRAL
     Disposition_vs_Faction2=DISPOSITION_NEUTRAL
     Disposition_vs_Faction3=DISPOSITION_NEUTRAL
     Disposition_vs_Faction4=DISPOSITION_NEUTRAL
     Disposition_vs_Faction5=DISPOSITION_NEUTRAL
     Disposition_vs_Faction6=DISPOSITION_NEUTRAL
     Disposition_vs_Faction7=DISPOSITION_NEUTRAL
     Disposition_vs_Faction8=DISPOSITION_NEUTRAL
     Disposition_vs_Faction9=DISPOSITION_NEUTRAL
     Disposition_vs_Faction10=DISPOSITION_NEUTRAL
     Disposition_vs_Faction11=DISPOSITION_NEUTRAL
     Disposition_vs_Faction12=DISPOSITION_NEUTRAL
     Disposition_vs_Faction13=DISPOSITION_NEUTRAL
     Disposition_vs_Faction14=DISPOSITION_NEUTRAL
     Disposition_vs_Faction15=DISPOSITION_NEUTRAL
     Disposition_vs_Faction16=DISPOSITION_NEUTRAL
     Disposition_vs_Faction17=DISPOSITION_NEUTRAL
     Disposition_vs_Faction18=DISPOSITION_NEUTRAL
     Disposition_vs_Faction19=DISPOSITION_NEUTRAL
}
