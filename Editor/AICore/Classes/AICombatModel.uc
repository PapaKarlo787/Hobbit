class AICombatModel extends AIModel
	abstract
	native;

var(AICombat) inherited(1388) float MinTauntDelay "The minimum amount of time (seconds) that must pass before an AI will say a combat taunting bark. - MDB 3/6/03";
var(AICombat) inherited(1389) float MaxTauntDelay "The maximum amount of time (seconds) that can pass before an AI will say a combat taunting bark. - MDB 3/6/03";
var(AICombat) inherited(1390) float MinFleeTauntDelay "The minimum amount of time (seconds) that must pass before an AI will remark that the player is fleeing from combat. - MDB 3/6/03";
var(AICombat) inherited(1391) float MaxFleeTauntDelay "The minimum amount of time (seconds) that must pass before an AI will remark that the player is fleeing from combat. - MDB 3/6/03";
var(AICombat) inherited(1435) float MinTimeBetweenWeaponSwitches "The minimum amount of time that must pass before an AI will consider switching weapons. - MDB 3/21/03";
var(AICombat) inherited(1457) float CoverThreshold "This is a number between (0.0-1.0) that represents a percentage of health an AI must be below before seeking out cover.  If you don't want an AI to seek out cover, then set this to 0. - MDB 4/3/03";
var(AICombat) runtimeinstantiated(1544) bool MovementDisabled "This disables all ability for an AI to move during combat (this should be set to true for turrets.";
var(AICombat) inherited(1552) bool SideStepDisabled "This disables all side-stepping (most bots don't have sidestepping).";
var(AICombat) inherited(1569) bool NoWeaponSelectionPenalty "This let's an AI choose weapons without biasing towards keeping the same weapon.  Generally, this should be off for humans and on for bots and creatures. - MDB 4/29/03";
var(AICombat) inherited(1580) bool WeaponSwitchRangeDisabled "This disables weapon range considerations for weapon select. (May want this on greasel).";
var(AICombat) inherited(1692) float BaseChanceToFlee "The base chance to flee at the FleeingHealthPct will flee. The more damaged, the percentage increases from this value to 1.0";
var(AICombat) inherited(1861) float FleeingHealthPct "Health percentage for transition from harassing to fleeing combat movement. In Melee, it's the health pct fleeing is considered. 0.0 = NEVER FLEE";
var(AICombat) inherited(1881) float CombatRestlessness "Restlessness/Wildness. High restlessness means won't stand still very much during combat. Zero means normal combat.";

//var(AIRangedCombat) inherited(1445) float MinTimeBetweenMoves "(Point selection) The minimum amount of time (seconds) that must pass before an AI will attempt to move to another point during combat. - MDB 3/27/03";
//var(AIRangedCombat) inherited(1446) float MaxTimeBetweenMoves "(Point selection) The maximum amount of time (seconds) that must pass before an AI will attempt to move to another point during combat. - MDB 3/27/03";
//var(AIRangedCombat) inherited(1448) float MovementGridSize "(Point selection) The number of x and y points genreated in a grid pattern for combat movement. - MDB 3/27/03";
//var(AIRangedCombat) inherited(1451) float MovementGridSpacing "(Point selection) The space in feet between points in the combat movement grid. - MDB 3/27/03";
//var(AIRangedCombat) inherited(1450) float MovementGridOffset "(Point selection) The space if feet that the grid is biased toward the target (A default of zero means that the grid is centered around the AI). - MDB 3/27/03";
//var(AIRangedCombat) inherited(1460) float MinMovementDistance "(Point selection) If I'm going to move, the least amount of distance I should move. - MDB 4/3/03";

var(AIRangedCombat) inherited(1447) float CloseCombatDistance "(Point selection) The distance (in feet) that an AI will stop advancing on it's target. - MDB 3/27/03";
var(AIRangedCombat) inherited(1082) float CombatPointMinOpenness "(Point selection) How open a spatial database cell must be in order for this AI to move there.";
var(AIRangedCombat) inherited(1854) float CoverPointPickerRadius "(Point selection) Radius in feet that the AI will consider points during cover point picker";

var(AIRangedCombat) inherited(1551) float ShootingVariation "The AI's variation in shooting (value between 0-1).  0.3 is a good value.  0=dead on, 1=wild shot.";
var(AIRangedCombat) inherited(596) float MaxFireDistance "The maximum distance (in feet) an AI can fire a ranged weapon with any degree of accuracy (note that this is NOT the weapon's maximum fire range)";
var(AIRangedCombat) inherited(600) float MaxFireAngle "The maximum angle (in degrees) an AI can fire a ranged weapon relative to the direction the weapon is pointing";
var(AIRangedCombat) inherited(1557) float ThrowAngle "The throw angle (in degrees) for any thrown projectiles (this includes arrows).";
var(AIRangedCombat) inherited(1558) float ChanceToOpenWithThrown "The chance to open combat with a thrown weapon (grenade). 0=no chance, 1=always.";
var(AIRangedCombat) inherited(1885) float MinThrowEquipHealthPct "The minimum health that we're allowed to equip a throwing weapons";
var(AIRangedCombat) inherited(1738) float MinimumThrowVelocity "This prevents the AI from throwing to near itself, in addition to the blast radius checking.";
var(AIRangedCombat) inherited(1603) float MinTimeToRemainInCover "The minimum amount of time an AI will remain under cover.";
var(AIRangedCombat) inherited(1604) float MaxTimeToRemainInCover "The maximum amount of time an AI will remain under cover.";
var(AIRangedCombat) inherited(1605) float MinTimeOutFromCover "The minimum amount of time an AI will move out from under cover.";
var(AIRangedCombat) inherited(1606) float MaxTimeOutFromCover "The maximum amount of time an AI will move out from under cover.";
var(AIRangedCombat) inherited(1859) float CautiousHealthPct "Health percentage for transition from aggressive to cautious combat movement.";
var(AIRangedCombat) inherited(1860) float HarassingHealthPct "Health percentage for transition from cautious to harassing combat movement.";
// NOTE - FleeingHealthPct is in AICombat (used for both Melee and Ranged)
var(AIRangedCombat) inherited(1875) float AggressiveCoverChance "Percentage chance cover will be used when damage is taken in Aggressive combat movement.";
var(AIRangedCombat) inherited(1876) float CautiousCoverChance "Percentage chance cover will be used when damage is taken in Cautious combat movement.";
var(AIRangedCombat) inherited(1877) float HarassingCoverChance "Percentage chance cover will be used when damage is taken in Harassing combat movement.";
var(AIRangedCombat) inherited(2024) float SummonHelpDistance "The distance (in feet) a target must be within in order for this ranged combatant to start summoning help.";
var(AIRangedCombat) inherited(2025) float MinSummonHelpDelay "The minimum amount of time (seconds) between summons for help for a ranged combatant.";
var(AIRangedCombat) inherited(2026) float MaxSummonHelpDelay "The maximum amount of time (seconds) between summons for help for a ranged combatant.";
var(AIRangedCombat) inherited(2142) float FireDelayMinTime "Minimum amount of time in seconds between firing projectiles (spells, arrows, etc.).";
var(AIRangedCombat) inherited(2143) float FireDelayMaxTime "Maximum amount of time in seconds between firing projectiles (spells, arrows, etc.).";
var(AIRangedCombat) inherited(2144) float RangedSidestepAnimRate "The base animation rate for ranged combat sidesteps -- the default rate is 1.0";

var(AIDX2Combat) inherited(1017) float DX2MaxMedbotSearchDistance "The radius within which a wounded NPC can search for a MedBot.";
var(AIDX2Combat) inherited(1018) float DX2MinHealthToUseMedbot "The min current health level for an NPC to consider using a medbot, specified as a value from 0 to 1 (0=dead, 1=unhurt).";
var(AIDX2Combat) inherited(1019) float DX2MaxHealthToUseMedbot "The max current health level for an NPC to consider using a medbot, specified as a value from 0 to 1 (0=dead, 1=unhurt).";
var(AIDX2Combat) inherited(1031) float DX2MinMoraleToRetreat "The minimum morale level for an NPC in combat to consider fleeing, specified as a value from 0 to 1 (0=dispirited, 1=confident).";
var(AIDX2Combat) inherited(1032) float DX2MaxMoraleToRetreat "The maximum morale level for an NPC in combat to consider fleeing, specified as a value from 0 to 1 (0=dispirited, 1=confident).";
var(AIDX2Combat) inherited(1033) float DX2RetreatDistance "The distance a retreating NPC will attempt to flee from its target, in feet.";
var(AIDX2Combat) inherited(1044) float DX2ChanceToUseMedbot "The chance that an NPC will attempt to use a medbot if it decides it can and should do so.  This is specified between 0=never and 1=always.";
var(AIDX2Combat) inherited(1045) float DX2ChanceToRetreat "The chance that an NPC will attempt to retreat if it decides it can and should do so.  This is specified between 0=never and 1=always.";

struct MeleeAttackAnimInfo
{
	var() 	string		LocoMode;
	var()	int			MinDamageModifier;
	var()	int			MaxDamageModifier;
	var()	float		ChanceToSelect;
};

var(AIMeleeCombat) inherited(1083) array<MeleeAttackAnimInfo> SwordAttackAnimInfo "The set of info about animations used for general sword attacks -- includes damage modifiers and chance to select.";
var(AIMeleeCombat) inherited(1198) array<MeleeAttackAnimInfo> EnragedSwordAttackAnimInfo "The set of info about animations used for ENRAGED sword attacks -- includes damage modifiers and chance to select.";
var(AIMeleeCombat) inherited(1093) array<MeleeAttackAnimInfo> HammerAttackAnimInfo "The set of info about animations used for general hammer attacks -- includes damage modifiers and chance to select.";
var(AIMeleeCombat) inherited(1199) array<MeleeAttackAnimInfo> EnragedHammerAttackAnimInfo "The set of info about animations used for ENRAGED hammer attacks -- includes damage modifiers and chance to select.";
var(AIMeleeCombat) inherited(1084) float Strafe_Chance "Percentage chance [0 to 1] that an AI will choose to strafe as its next maneuver when up close in melee combat.";
var(AIMeleeCombat) inherited(1085) float Strafe_MinDelay "Minimum amount of time before next melee combat strafe maneuver.";
var(AIMeleeCombat) inherited(1086) float Strafe_MaxDelay"Maximum amount of time before next melee combat strafe maneuver.";
var(AIMeleeCombat) inherited(1090) float Wait_Chance "Percentage chance [0 to 1] that an AI will choose to wait as its next maneuver when up close in melee combat.";
var(AIMeleeCombat) inherited(1091) float Wait_MinTime "If AI decides to Wait, Minimum amount of time AI will wait before choosing next maneuver.";
var(AIMeleeCombat) inherited(1092) float Wait_MaxTime "If AI decides to Wait, Maximum amount of time AI will wait before choosing next maneuver.";
var(AIMeleeCombat) inherited(1112) float MeleeAttackDistance "Distance (in feet) within which AI can swing sword with good chance of hitting.";
var(AIMeleeCombat) inherited(1113) float MeleeManeuverDistance "Distance (in feet) within which AI will certainly step forward to approach the target.";
var(AIMeleeCombat) inherited(1114) float MeleeChargeDistance "If AI is outside this distance (in feet) from its target, it will run towards the target to get closer.";
var(AIMeleeCombat) inherited(1458) float MeleeSpeedMultiplierMin "Speed multiplier MIN applied to all melee attacks by AI.";
var(AIMeleeCombat) inherited(1459) float MeleeSpeedMultiplierMax "Speed multiplier MAX applied to all melee attacks by AI.";
var(AIMeleeCombat) inherited(1981) float MeleeVerticalSwingBias "Vertical distance (in feet) a target must be in order for the AI to bias towards low or high swings when attacking.";
var(AIMeleeCombat) inherited(1982) float MeleeStrafeAnimMultiplier "The animation multiplier to speed up melee strafing.  > 1.0 is faster, < 1.0 is slower.";
var(AIMeleeCombat) inherited(1983) int MeleeCombatAttackChainMax "The maximum number of attacks an AI can chain together.";
var(AIMeleeCombat) inherited(1984) int MeleeCombatAttackChainMin "The minimum number of attacks an AI can chain together.";
var(AIMeleeCombat) inherited(1985) float MeleeCombatChainChance "Percentage chance [0 to 1] that an AI will execute a chained attack vs. single attack.";
var(AIMeleeCombat) inherited(1988) int MeleeMaxConsecutiveStrafes "The maximum number of strafes that can be performed before doing something else.";
var(AIMeleeCombat) inherited(1991) int MeleeMinConsecutiveStrafes "The minimum number of strafes that can be performed before doing something else.";
var(AIMeleeCombat) inherited(1994) float MeleeTargetNearDistance "The distance that an AI will consider a target as being nearby for the purposes of finishing an attack.";

struct sMeleeWeaponDrawInfo
{
	var() bool bDoublesAsAttack;
	var() Name AnimName;
	var() int DamageModifier;
	var() float DistanceForAttack;
};

var(AIMeleeCombat) inherited(2028) array<sMeleeWeaponDrawInfo> SwordDrawAnims "An array of sword weapon draws that indicates whether a draw doubles as an attack or not.  NOTE: Multiple versions of a tagged animation with the same value for bDoublesAsAttack will always choose the first one.";
var(AIMeleeCombat) inherited(2029) array<sMeleeWeaponDrawInfo> HammerDrawAnims "An array of hammer weapon draws that indicates whether a draw doubles as an attack or not.  NOTE: Multiple versions of a tagged animation with the same value for bDoublesAsAttack will always choose the first one.";

struct sMeleeOptionalAnimInfo
{
	var() string LocoMode;
	var() float ChanceToPlay;
};

var(AIMeleeCombat) inherited(1572) array<sMeleeOptionalAnimInfo> OptionalAnims "An array of optional anims to play in between attacks for melee combat.";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     MinTauntDelay=10.000000
     MaxTauntDelay=17.000000
     MinFleeTauntDelay=4.000000
     MaxFleeTauntDelay=6.000000
     MinTimeBetweenWeaponSwitches=10.000000
     CoverThreshold=0.700000
     BaseChanceToFlee=0.400000
     FleeingHealthPct=0.250000
     CloseCombatDistance=10.000000
     CombatPointMinOpenness=100.000000
     ShootingVariation=0.050000
     MaxFireDistance=200.000000
     MaxFireAngle=15.000000
     ThrowAngle=35.000000
     ChanceToOpenWithThrown=0.330000
     MinThrowEquipHealthPct=0.900000
     MinimumThrowVelocity=400.000000
     MinTimeToRemainInCover=5.000000
     MaxTimeToRemainInCover=10.000000
     MinTimeOutFromCover=8.000000
     MaxTimeOutFromCover=15.000000
     CautiousHealthPct=0.750000
     HarassingHealthPct=0.500000
     AggressiveCoverChance=0.300000
     CautiousCoverChance=0.750000
     HarassingCoverChance=1.000000
     SummonHelpDistance=10.000000
     MinSummonHelpDelay=2.000000
     MaxSummonHelpDelay=4.000000
     FireDelayMinTime=0.000000
     FireDelayMaxTime=0.400000
     RangedSidestepAnimRate=1.000000
     DX2MaxMedbotSearchDistance=200.000000
     DX2MinHealthToUseMedbot=0.100000
     DX2MaxHealthToUseMedbot=0.300000
     DX2MinMoraleToRetreat=0.050000
     DX2MaxMoraleToRetreat=0.200000
     DX2RetreatDistance=200.000000
     DX2ChanceToUseMedbot=1.000000
     DX2ChanceToRetreat=1.000000
     MeleeSpeedMultiplierMin=1.100000
     MeleeSpeedMultiplierMax=1.300000
     MeleeVerticalSwingBias=1.800000
     MeleeStrafeAnimMultiplier=1.000000
     MeleeCombatAttackChainMax=3
     MeleeCombatAttackChainMin=2
     MeleeCombatChainChance=0.500000
     MeleeMaxConsecutiveStrafes=3
     MeleeMinConsecutiveStrafes=2
     MeleeTargetNearDistance=12.000000
     SwordDrawAnims(0)=(AnimName="M1_TRN_UA_to_SR",DistanceForAttack=9.000000)
     SwordDrawAnims(1)=(bDoublesAsAttack=True,AnimName="M1_TRN_UA_to_SR_attack",DistanceForAttack=9.000000)
     HammerDrawAnims(0)=(AnimName="UA_to_HR",DistanceForAttack=9.000000)
     HammerDrawAnims(1)=(bDoublesAsAttack=True,AnimName="UA_to_HR_attack",DistanceForAttack=9.000000)
}
