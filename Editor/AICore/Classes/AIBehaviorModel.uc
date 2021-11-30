class AIBehaviorModel extends AIModel
	abstract
	native;


enum EWarnState
{
	WARNSTATE_NONE,
	WARNSTATE_1,
	WARNSTATE_2,
	WARNSTATE_3,
	WARNSTATE_RESPOND
};

enum EAlertState
{
	ALERTSTATE_NONE,
	ALERTSTATE_GREEN,
	ALERTSTATE_YELLOW,
	ALERTSTATE_RED
};

enum EWeaponSelectionTime
{
	WS_PRE_RAMP,
	WS_RAMP_1,
	WS_RAMP_2,
	WS_POST_RAMP
};

enum eDX2BotManager
{
	DX2BOTMANAGER_NONE,
	DX2BOTMANAGER_MEDBOT,
	DX2BOTMANAGER_REPAIRBOT,
	DX2BOTMANAGER_NANOFORMERBOT
};

// update the #define in AI_BehaviorController.h when you modify this.
enum WarnReason 
{
	WARN_NONE,
	WARN_BUMPED,
	WARN_STAREDAT,
	WARN_ODDBEHAVIOR,
	WARN_THREATENED,
	WARN_DAMAGED,
	WARN_HACKING,
	WARN_KILLEDALLY,
	WARN_STEALING,
	WARN_HITBYJUNK,
	WARN_DAMAGEANOTHER,
	WARN_VANDALISM,
	WARN_INTRUSION
};

enum EPersonalityMode
{
	PERSONALITY_Normal,
	PERSONALITY_Drunk,
	PERSONALITY_Sleepy
};

var(AIAlertStateParams) runtimeinstantiated(578) float StateGreenAlert_AlertThreshold "The alert level (from 0=unaware to AlertState_MaximumAwareness=keenly aware of bad stuff happening) at which an AI enters the green alert (mildly suspicious) state";
var(AIAlertStateParams) runtimeinstantiated(579) float StateYellowAlert_AlertThreshold "The alert level (from 0=unaware to AlertState_MaximumAwareness=keenly aware of bad stuff happening) at which an AI enters the yellow alert (somewhat suspicious and actively searching) state";
var(AIAlertStateParams) runtimeinstantiated(580) float StateRedAlert_AlertThreshold "The alert level (from 0=unaware to AlertState_MaximumAwareness=keenly aware of bad stuff happening) at which an AI enters the red alert (extremely suspicious and actively searching) state";

var(AIAlertStateParams) runtimeinstantiated(1399) float AlertState_RampDownThreshold "The alert level at which an AI will ramp down from green alert.  This needs to be less than the GreenAlert_AlertThreshold.";

var(AIAlertStateParams) runtimeinstantiated(968) float AlertState_MaximumAlertness "The maximum raw value that a characters alertness can be -- alertness is defined as the sum of the current weights of all the pieces of evidence we have received.";

var(AIAlertStateParams) runtimeinstantiated(575) float StateGreenAlert_MinDuration "The minimum amount of time (in seconds) an AI must remain in green alert before it can return to a lower alert state";
var(AIAlertStateParams) runtimeinstantiated(576) float StateYellowAlert_MinDuration "The minimum amount of time (in seconds) an AI must remain in yellow alert before it can return to a lower alert state";
var(AIAlertStateParams) runtimeinstantiated(577) float StateRedAlert_MinDuration "The minimum amount of time (in seconds) an AI must remain in red alert before it can return to a lower alert state";
var(AIAlertStateParams) runtimeinstantiated(1815) float StateRedAlert_RampDownTimeAfterFriendlyTargetID "If an AI is actually in the red alert behavior state (i.e., a friendly AI hears gunfire) and has identified the source of disturbance, force a ramp down after x seconds.";

var(AIAlertStateParams) inherited(586) float AlertState_AudioPingPeriodMin "The minimum threshold of the randomized delay between ongoing AI barks sounds while an AI remains in an alert state";
var(AIAlertStateParams) inherited(587) float AlertState_AudioPingPeriodMax "The maximum threshold of the randomized delay between ongoing AI barks sounds while an AI remains in an alert state";

var(T3AIBehavior) inherited(1392) EAlertState BluntStimKnockout_AlertMax "Blunt stimuli (i.e., blackjacking) will knock out the AI so long as its alertness is below this value.";
var(T3AIBehavior) inherited(1393) float BluntStimKnockout_AngleMax "Blunt stimuli (i.e., blackjacking) will knock out the AI so long as the angle from the back of the AI to the direction of the stimulus is less than this value.";

var(T3AIBehavior) inherited(1592) EAlertState BackstabKill_AlertMax "Backstabbing will kill the AI so long as the AI's alertness state is below this value.";

var(T3AIBehavior) inherited(1402) EAlertState Pickpocketable_MaxAlertThreshold "The AI can be pickpocketed by the player, so long as its alertness value is LESS THAN this value.";

var(T3AIBehavior) inherited(1517) EAlertState DamageMultiplier_MaxState "If the AI gets damaged at this state or lower, it will apply the DamageMultiplier_LowAlertness.";
var(T3AIBehavior) inherited(1518) float DamageMultiplier_LowAlertness "If the AI gets damaged at DamageMultiplier_MaxState or lower, it will apply this damage multiplier to the incoming damage value.";
var(T3AIBehavior) inherited(2052) array<eBodyLocation> DamageMultiplier_BodyLocations "AI will only accept low-alertness damage multiplier if hit in one of these body locations.";

var(AIStateFlags) inherited(581) float StateEnabled_Idle "Indicates whether an AI can execute the idle state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(582) float StateEnabled_GreenAlert "Indicates whether an AI can execute the green alert state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(583) float StateEnabled_YellowAlert "Indicates whether an AI can execute the yellow alert state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(584) float StateEnabled_RedAlert "Indicates whether an AI can execute the red alert state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(585) float StateEnabled_WarnPlayer "Indicates whether an AI can execute the warn-player state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(1238) float StateEnabled_GreetActor "Indicates whether an AI can greet the player or other actors (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(734) float StateEnabled_Conversation "Indicates whether an AI can engage in a conversation with other AIs (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(848) float StateEnabled_Flee "Indicates whether an AI can flee (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(849) float StateEnabled_Guard "Indicates whether an AI can guard other AIs (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(850) float StateEnabled_Returning "Indicates whether an AI can return to its original position when re-entering an idle state after searching or combat is finished (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(851) float StateEnabled_Patrol "Indicates whether an AI can engage in patrolling behavior (i.e. following patrol paths) (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(852) float StateEnabled_PatrolLook "Indicates whether an AI can look at LookPoints when following patrol paths (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(853) float StateEnabled_PatrolFollow "Indicates whether an AI can take part in a relative formation on a patrol (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(854) float StateEnabled_PatrolFollowAbsolute "Indicates whether an AI can take part in an absolute formation on a patrol (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(855) float StateEnabled_PlayAnim "Indicates whether an AI can execute the PlayAnim state (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(1115) float StateEnabled_FrobAlarm "Indicates whether an AI can frob alarms (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(1142) float StateEnabled_ExitDangerZone "Indicates whether an AI can flee a danger zone such as an electric field or poison gas cloud (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(1616) float StateEnabled_Dormant "Indicates whether an AI can go into a dormant or sleep state.";
var(AIStateFlags) inherited(1615) float StateEnabled_ConversationIdle "Indicates whether an AI can execute the conversation idle state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(1623) float StateEnabled_Search "Indicates whether an AI can execute the search state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(1672) float StateEnabled_Wander "Indicates whether an AI can execute the wander state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(1693) float StateEnabled_Sit "Indicates whether an AI can execute the sit state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(1744) float StateEnabled_Approach "Indicates whether an AI can execute the approach state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(1742) float StateEnabled_FleeFromGrenade "Indicates whether an AI can flee from a grenade (1=enabled, 0=disabled).";
var(AIStateFlags) inherited(1979) float StateEnabled_Informing "AI will only involve itself in an informing behavior (as either informer or informee) if this is set to 1.0";
var(AIStateFlags) inherited(2015) float StateEnabled_Fetching "AI will only fetch other AI's out of combat if this is set to 1.0";
var(AIStateFlags) inherited(2016) float StateEnabled_Frustration "AI will only express its frustration at the player if this is set to 1.0";
var(AIStateFlags) inherited(2116) float StateEnabled_Slipping "AI will only react to oil puddles if this is set to 1.0";
var(AIStateFlags) inherited(2152) float StateEnabled_Being_Mugged "AI will only go through mugging sequence if this is set to 1.0";


var(AIFlee) inherited(1607) float UseCreatureFlee "If nonzero, this will cause the AI's flee state to behave as if it were an ambient creature.";
var(AIFlee) inherited(1129) float FleeDisappearDistance "If nonzero, specifies a distance from the player (in feet) at which an NPC should vanish after fleeing (if it is not visible to the player).  This change is PERMANENT; the NPC will no longer be accessible after it disappears.";
var(AIFlee) inherited(1414) float FleeSafeDistance "Distance IN FEET at which an AI will stop fleeing from its target.";
var(AIFlee) inherited(1509) float MaxCowerBarkDistance "Distance IN FEET within which target must be to AI for AI to issue cowering barks.";
var(AIFlee) inherited(1510) float MinCowerBarkTime "AI will issue cower barks every x seconds where x is between MinCowerBarkTime and MaxCowerBarkTime";
var(AIFlee) inherited(1511) float MaxCowerBarkTime "AI will issue cower barks every x seconds where x is between MinCowerBarkTime and MaxCowerBarkTime";
var(AIFlee) inherited(1970) float FleeAgain_NearbyHostileTargetDistance "Flee again from a cowered position if a hostile target is within this many FEET for some amount of time.";
var(AIFlee) inherited(1971) float FleeAgain_NearbyHostileTargetTime "Flee again from a cowered position if a hostile target is within some distance for this many SECONDS.";
var(AIFlee) inherited(2134) float FleeContinueBarkMinTime "+flee:continue barks will be played every x seconds, where x is between FleeContinueBarkMinTime and FleeContinueBarkMaxTime.";
var(AIFlee) inherited(2135) float FleeContinueBarkMaxTime "+flee:continue barks will be played every x seconds, where x is between FleeContinueBarkMinTime and FleeContinueBarkMaxTime.";
var(AIFlee) inherited(2136) int MaxNumberOfAlliesUsedDuringFleeBehavior "AI's will often choose unalert allies to flee towards instead of flee points when fleeing.  This number defines the maximum number of allies used per flee behavior before an AI stops using allies as flee targets.";

var(AIReactions) inherited(1072) float StateEnabled_Gassed "Indicates whether an AI can enter a 'poisoned' reaction state in response to various stimuli (1=enabled, 0=disabled).";
var(AIReactions) inherited(1094) float StateEnabled_Shocked "Indicates whether an AI can enter a 'shocked' reaction state in response to various stimuli (1=enabled, 0=disabled).";
var(AIReactions) inherited(1486) float StateEnabled_Blinded "Indicates whether an AI can enter a 'blinded' reaction state in response to various stimuli (1=enabled, 0=disabled).";
var(AIReactions) inherited(2095) float StateEnabled_Choking "Indicates whether an AI can enter a 'choking' reaction state in response to various stimuli (1=enabled, 0=disabled).";

var(AIReactions) inherited(1138) float MinMoveTimeWhenGassed "When an NPC gets gassed by an area-based effect, this is the minimum amount of time before it will attempt to exit the area causing the stimulus.  A value of 0 for min and max means the NPC will not attempt to exit to safety.";
var(AIReactions) inherited(1139) float MaxMoveTimeWhenGassed "When an NPC gets gassed by an area-based effect, this is the minimum amount of time before it will attempt to exit the area causing the stimulus.  A value of 0 for min and max means the NPC will not attempt to exit to safety.";
var(AIReactions) inherited(1140) float MinMoveTimeWhenShocked "When an NPC gets shocked by an area-based effect, this is the minimum amount of time before it will attempt to exit the area causing the stimulus.  A value of 0 for min and max means the NPC will not attempt to exit to safety.";
var(AIReactions) inherited(1141) float MaxMoveTimeWhenShocked "When an NPC gets shocked by an area-based effect, this is the minimum amount of time before it will attempt to exit the area causing the stimulus.  A value of 0 for min and max means the NPC will not attempt to exit to safety.";
var(AIReactions) inherited(1481) float MinMoveTimeWhenBlinded "When an NPC gets blinded by an area-based effect, this is the minimum amount of time before it will attempt to exit the area causing the stimulus.  A value of 0 for min and max means the NPC will not attempt to exit to safety.";
var(AIReactions) inherited(1482) float MaxMoveTimeWhenBlinded "When an NPC gets blinded by an area-based effect, this is the minimum amount of time before it will attempt to exit the area causing the stimulus.  A value of 0 for min and max means the NPC will not attempt to exit to safety.";

var(AIStateFlags) inherited(721) float StateEnabled_DX2Interface "Indicates whether an AI can execute the DX2 'interface' (repair, heal) state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(858) float StateEnabled_DX2StopForPlayer "Indicates whether an AI can stop when near the player (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(723) float StateEnabled_DX2BotCombat "Indicates whether an AI can execute the DX2 bot combat state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(724) float StateEnabled_DX2TurretCombat "Indicates whether an AI can execute the DX2 turret combat state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(857) float StateEnabled_DX2Pistol2HCombat "Indicates whether an AI can execute the DX2 2-handed pistol human combat state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(1080) float StateEnabled_DX2Pistol1HCombat "Indicates whether an AI can execute the DX2 1-handed pistol human combat state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(1394) float StateEnabled_RangedCombat "Indicates whether an AI can execute the ranged combat state (1=enabled, 0=disabled)";
var(AIStateFlags) inherited(1395) float StateEnabled_MeleeCombat "Indicates whether an AI can execute the melee combat state (1=enabled, 0=disabled)";

var(AIAmbient) inherited(593) float IdleStateAction_MinDelay "The minimum threshold of the randomized delay between ambient actions (animations or AI barks) in the idle state";
var(AIAmbient) inherited(594) float IdleStateAction_MaxDelay "The maximum threshold of the randomized delay between ambient actions (animations or AI barks) in the idle state";
var(AIAmbient) inherited(628) float IdleStateAction_ChanceToAnimate "An AI's chance to do an idle animation instead of saying an AI bark when it wants to do an idle action (from 0.0 to 1.0)";
var(AIAmbient) inherited(629) float IdleStateAction_AIBarkChanceForIdleConversation "When an AI chooses to do an idle AI bark, the chance that it will try to do a conversation with another neaby AI instead of just talking to itself (from 0.0 to 1.0)";
var(AIAmbient) inherited(630) float IdleStateAction_AIBarkChanceForSpeechVSNonSpeech "When an AI chooses to do a solo idle AI bark (i.e. one which is NOT an idle conversation with another NPC nearby), this is the chance that it will say a speech bark vs. a non-speech (coughing, sneezing) bark";
var(AIAmbient) inherited(1857) float IdleStateAction_AIBarkChanceForSpeechAboutAnimals "When an AI decides to play a speech ambient bark, if there is an ambient creature nearby, there is an x% chance the AI will comment on it.";

var(AIDeath) inherited(2101) float ChanceToPlayDeathAnimBeforeRagdoll "When an AI dies, it will play death animations before ragdolling this percentage of the time (expressed as 0 to 1)";
var(AIDeath) inherited(2102) float ChanceToPlayLastWordsDeathBark "When an AI dies AND it plays a death animation before ragdolling, this is the percentage chance that it plays an extra-long last-words death bark.";
var(AIDeath) inherited(2103) float MinDamageToAlwaysRagdoll "THIS IS ONLY FOR BLUNT STIM -- If the AI receives at least this much damage when dying, always ragdoll.";

var(AIGreetings) inherited(1868) float TimeBetweenPlayerGreetings "When the player frobs an AI, the AI must wait at least this long before issuing another greeting bark.";

var(AIWarnings) inherited(1802) float Reprimand_TimeAfterConversationBeforeBark "Wait this many seconds before playing reprimand barks after a conversation finishes.";
var(AIWarnings) inherited(1516) float Reprimand_MaxDistance "If the distance (IN FEET) between the AI and the player is greater than this distance, AI will not seek to reprimand the player.";
var(AIWarnings) inherited(1892) float Reprimand_SlowReprimandDelay "For STARING and PLAYER BUMPAGE:  In addition to the regular (and shorter) delay time specified, we add this amount for less frequently desired reprimands.";

var(AIWarnings) inherited(1673) int WarningsBeforeHostility_Damage "The number of warnings an AI will give its reprimand target before going hostile, after taking damage from a non-hostile source.";
var(AIWarnings) inherited(1722) float DamagePercentageBeforeHostility "If the AI is damaged by at least this percentage of its health (between 0 and 1) by the player, immediately go hostile.  This overrides the WarningsBeforeHostility property.";
var(AIWarnings) inherited(1748) int WarningsBeforeHostility_Hacking "The number of warnings an AI will give its reprimand target before going hostile, after witnessing hacking/lockpicking from a non-hostile source.";
var(AIWarnings) inherited(1896) int WarningsBeforeHostility_Stealing "The number of times an AI will reprimand its target for theft before going hostile.";
var(AIWarnings) inherited(1897) int WarningsBeforeHostility_Trespass "The number of times an AI will reprimand its target for intruding before going hostile.";
var(AIWarnings) inherited(1898) int WarningsBeforeHostility_Vandalism "The number of times an AI will reprimand its target for breaking things before going hostile.";
var(AIWarnings) inherited(1899) int WarningsBeforeHostility_HurtFriend "The number of times an AI will allow a WARN_DAMAGEANOTHER reprimand before going hostile.";
var(AIWarnings) inherited(1997) int WarningsBeforeHostility_Threatened "The number of times an AI will reprimand its target for pointing weapons at him before going hostile.";
var(AIWarnings) inherited(2000) int WarningsBeforeHostility_HitByJunk "The number of times an AI will reprimand its target for throwing things at him before going hostile.";

// deprecated on 12/16/03 [egr]: var(AIWarnings) inherited(588) EWarnState WarnPlayer_InitialState "The initial warning state for an AI warning or reprimanding the player; raising this will make the AI less patient";
var(AIWarnings) inherited(648) float VisibilityRequiredToReprimand "The base visibility value required for an AI to reprimand the player (0 to 1)";
var(AIWarnings) inherited(589) float WarnPlayer_MinDelay "The minimum threshold of the randomized delay between subsequent warnings (reprimands) to the player";
var(AIWarnings) inherited(590) float WarnPlayer_MaxDelay "The maximum threshold of the randomized delay between subsequent warnings (reprimands) to the player";
var(AIWarnings) inherited(591) float WarnPlayer_DecayTime "The delay (in seconds) it takes for an AI to decay from its current warning level back to its minimum warning level if it is left unmolested";
var(AIWarnings) inherited(751) float WarnPlayer_StareTime "The time (in seconds) required for the player to stare at an AI before the AI will reprimand him";
var(AIWarnings) inherited(752) float WarnPlayer_OddBehavior "The time (in seconds) required for the player to behave strangely before the AI will reprimand him";
var(AIWarnings) inherited(1747) float WarnPlayer_HackingTime "The time (in seconds) required for the player to be witnessed hacking before the AI will reprimand him";

var(AIWarnings) inherited(2089) float StareAngleReprimand "The AI will consider the player to be staring when the angle between player's viewline and AI is less than this many degrees."; 

var(AIBehavior) inherited(693) float HealthRegenRateWhenFrobbed "If >0, indicates that this NPC heals at the given rate when frobbed";

var(AIBehavior) inherited(1432) eDX2BotManager DX2BotManagerUsed "Indicates which bot manager, if any governs the behavior and abilities of this bot";
//var(AIBehavior) inherited(726) float UsesDX2MedBotManager "Indicates whether this AI uses the medbot manager";
//var(AIBehavior) inherited(727) float UsesDX2RepairBotManager "Indicates whether this AI uses the repairbot manager";
var(AIBehavior) inherited(732) float StateDX2TurretCombat_MinDuration "The minimum duration of the DX2 turret combat state";
var(AIBehavior) runtimeinstantiated(738) float StopWhenNearPlayerDistance "If nonzero, the distance from the player (in feet, not Unreal unit) that this AI should stop when near the player";
var(AIBehavior) inherited(1116) float MaxAlarmDistance "The maximum distance from a frobbable alarm (in feet) in order for an NPC to consider frobbing it.";
var(AIBehavior) inherited(2008) float SummonInCombatProbability "The percent chance that this AI will call for help in combat instead of using a +combatexpectation taunt, so long as an ally is nearby.";
var(AIBehavior) inherited(2009) float SummonIfAlliesWithinRadius "The AI will only emit a summons bark if there is at least one other ally within this many feet (and never if there's already an ally helping out). The other AI must actually be ALLIED, not just FRIENDLY.";

var(AINavigation) inherited(1720) bool bKnockStuffOver "If true, this AI will attempt to barrel into things during local pathfinding.";

var(AISearch) inherited(1168) float SearchUpdateAlertnessThreshold "Minimum new alertness that must be received during a search that will cause AI to update or restart its search.";
var(AISearch) inherited(2124) bool bScaleSearchUpdateValuesByLightGem "If true, the search update meter will be influenced by the incoming alertness values times Garrett's current light gem value.";

var(AISearch) inherited(1570) float SearchYellowMaxMoveDistance "During a Red Alert Search, Maximum distance AI will travel in any one iteration of search movement.";
var(AISearch) inherited(1169) float SearchYellowMaxTravelDistance "During a Yellow Alert Search (T3=Careless Search), Maximum distance AI will travel in any one iteration of search movement.";
var(AISearch) inherited(1170) float SearchYellowGridFillDistance "During a Yellow Alert Search (T3=Careless Search), AI will fill search grid up to this distance (IN FEET) in front of it while searching.";
var(AISearch) inherited(1171) float SearchYellowGridFillAngle "During a Yellow Alert Search (T3=Careless Search), AI will fill search grid only this many DEGREES to either side of its forward orientation.  90 degrees is the logical max, and represents everything in front of the AI.";

var(AISearch) inherited(1571) float SearchRedMaxMoveDistance "During a Red Alert Search, Maximum distance AI will travel in any one iteration of search movement.";
var(AISearch) inherited(1172) float SearchRedMaxTravelDistance "During a Red Alert Search, Maximum distance AI will travel over the course of the entire search.";
var(AISearch) inherited(1173) float SearchRedGridFillDistance "During a Red Alert Search, AI will fill search grid up to this distance (IN FEET) in front of it while searching.";
var(AISearch) inherited(1174) float SearchRedGridFillAngle "During a Red Alert Search, AI will fill search grid only this many DEGREES to either side of its forward orientation.  90 degrees is the logical max, and represents everything in front of the AI.";

var(AISearch) inherited(1180) float SearchYellowCreepChance "Yellow Alert Search Movement has this percentage chance (0 to 1) to use a creeping animation.";
var(AISearch) inherited(1181) float SearchYellowWalkChance "Yellow Alert Search Movement has this percentage chance (0 to 1) to use a walking animation.";
var(AISearch) inherited(1182) float SearchYellowRunChance "Yellow Alert Search Movement has this percentage chance (0 to 1) to use a running animation.";
var(AISearch) inherited(1183) float SearchRedCreepChance "Red Alert Search Movement has this percentage chance (0 to 1) to use a creeping animation.";
var(AISearch) inherited(1184) float SearchRedWalkChance "Red Alert Search Movement has this percentage chance (0 to 1) to use a walking animation.";
var(AISearch) inherited(1185) float SearchRedRunChance "Red Alert Search Movement has this percentage chance (0 to 1) to use a running animation.";

var(AISearch) inherited(1560) float SearchYellowMinLookTime "Minimum amount of time an AI will spend playing look animations while in a yellow alert search.";
var(AISearch) inherited(1561) float SearchRedMinLookTime "Minimum amount of time an AI will spend playing look animations while in a red alert search.";

var(AISearch) inherited(1247) float SearchYellowChanceToTurnBackOnTarget "In yellow alert search (T3 careless search), AI will turn back on player this % of the time (from 0 to 1)";
var(AISearch) inherited(1420) float SearchRedRunDistanceMin "In red alert search, if a search is initiated on some piece of evidence greater than this distance (in feet), the AI will run towards the disturbance)";

var(AISearch) runtimeinstantiated(2004) float SearchRedMoveFastMultiplier "During a red alert search, the AI may scale its movement speed up to this rate MAXIMUM.";
var(AISearch) runtimeinstantiated(2005) float SearchRedMoveSlowMultiplier "During a red alert search, the AI may scale its movement speed down to this rate MINIMUM.";
var(AISearch) runtimeinstantiated(2006) float SearchRedInterpolationRate "If an AI in red alert search wants to change its movement rate, this determines the alpha for the interpolation.  The closer the number is to 0, the slower the interpolation.";
var(AISearch) runtimeinstantiated(2007) float SearchRedSlowdownDistance "AI's in red alert search will start slowing down on secondary searches if they are within this distance IN FEET of their destination.";

var(AISearch) runtimeinstantiated(2010) float SearchHeadTurnLookTimeMin "Searching AI will turn its head towards some location for AT LEAST this many seconds.";
var(AISearch) runtimeinstantiated(2011) float SearchHeadTurnLookTimeMax "Searching AI will turn its head towards some location for AT MOST this many seconds.";
var(AISearch) runtimeinstantiated(2012) float SearchHeadTurnInterpolationAlphaMin "Searching AI will turn its head at some interpolation rate (0.001=very slow, 1.0=immediate) between this number and the specified max.";
var(AISearch) runtimeinstantiated(2013) float SearchHeadTurnInterpolationAlphaMax "Searching AI will turn its head at some interpolation rate (0.001=very slow, 1.0=immediate) between this number and the specified min.";

var(T3AIFatigue) runtimeinstantiated(1200) float FatigueMinTime "Minimum amount of time (in seconds) an AI will spend in fatigued behavior state.";
var(T3AIFatigue) runtimeinstantiated(1201) float FatigueMaxTime "Maximum amount of time (in seconds) an AI will spend in fatigued behavior state.";
var(T3AIFatigue) runtimeinstantiated(1202) float FatigueThreshold "Fatigue Meter value (from 0 to 100) above which AI will become fatigued.  Fatigue response will last as long as FatigueMinTime and MaxTime.";
var(T3AIFatigue) runtimeinstantiated(1203) float FatigueDecayRate "Rate of Fatigue Meter decay in units per second.";
var(T3AIFatigue) runtimeinstantiated(1204) float FatigueChargeIncreaseRate "Rate of Fatigue Meter increase when an AI is chasing after its target.";
var(T3AIFatigue) runtimeinstantiated(1205) float FatigueSuccessfulAttackIncrease "Fatigue Meter increased by this amount when an AI successfully connects with its target.";
var(T3AIFatigue) runtimeinstantiated(2129) float FatigueMaxDistanceFromPlayer "Fatigue will only be exhibited if the AI is this far from the player IN FEET and can see the player.";

var(T3AIFrustration) inherited(1206) float FrustrationThreshold "Fatigue Meter value (from 0 to 100) above which AI will become frustrated.";
var(T3AIFrustration) inherited(1207) float FrustrationDecayRate "Rate of Frustration Meter decay in units per second.";
var(T3AIFrustration) inherited(1208) float FrustrationMissedAttackIncrease "Amount of frustration added to the Frustration Meter when an AI misses an attack.";
var(T3AIFrustration) inherited(2105) float FrustrationSuccessfulAttackDecrease "Frustration meter goes down by this much every time the AI attacks and hits.";
var(T3AIFrustration) inherited(2017) float FrustrationMinTimeBeforeFetch "AI will act frustrated for minimum of x seconds (when target is unreachable) before trying to find a ranged combat ally.";
var(T3AIFrustration) inherited(2018) float FrustrationMaxTimeBeforeFetch "AI will act frustrated for maximum of x seconds (when target is unreachable) before trying to find a ranged combat ally.";
var(T3AIFrustration) inherited(2104) float FrustrationWarningBarksThreshold "AI will play enraged:warning barks if taunting in combat and above this threshold in frustration units.";
var(T3AIFrustration) inherited(2106) float FrustrationTakeDamageIncrease "AI increases frustration meter by this much when it takes damage (of any amount).";

var(AIAlertness) runtimeinstantiated(1407) EAlertState FirstWeaponSelectionState "State at which the AI will first decide to draw its weapon.  If ALERTSTATE_NONE, AI will ALWAYS have its weaopn out.";
var(AIAlertness) runtimeinstantiated(1413) EAlertState FirstTurnTowardsTargetState "State at which the AI will first decide to turn towards the current target (or most recent evidence).  If ALERTSTATE_NONE, AI will never turn towards evidence.";
var(AIAlertness) inherited(1491) EWeaponSelectionTime AlertWeaponSelectionTime "Within the ramp-up for the specified weapon-selection state, WHEN does the weapon actually get selected?  If set to RAMPUP_1 or RAMPUP_2, this will OVERRIDE the specified alertness ramp-up animation!.";
var(AIAlertness) inherited(1499) EWeaponSelectionTime SurprisedWeaponSelectionTime "Within the ramp-up for the SURPRISED RED-ALERT, WHEN does the weapon actually get selected?  If set to RAMPUP_1 or RAMPUP_2, this will OVERRIDE the specified alertness ramp-up animation!.";
var(AIAlertness) inherited(1502) EWeaponSelectionTime WeaponPutAwayTime "Within ramp-down behavior, WHEN does the weapon actually get put away?  Before ramp-down actions, during, or after?";

var(AIAlertness) inherited(1408) bool PutAwayWeaponAfterRedAlert "Should AI put away its weapon after ramping down from red alert?";
var(AIAlertness) inherited(1409) bool PutAwayWeaponAfterPlayerClearlySeen "Should AI put away its weapon after clearly seeing the player?";

var(AIAlertness) inherited(1500) EAlertState SurprisedWhenRedAlertFromState "If the AI ramps up to red alert from this state OR ANY STATE BELOW IT, the AI will consider itself to be surprised.";

var(AIGreenAlert) inherited(1421) float HeadTweak_YawMin "Specify the minimum value IN DEGREES that an AI will tweak its head left or right in green alert.  NOTE:  Keep Min and Max positive, because the direction (left or right) is mirrored randomly!";
var(AIGreenAlert) inherited(1422) float HeadTweak_YawMax "Specify the maximum value IN DEGREES that an AI will tweak its head left or right in green alert.  NOTE:  Keep Min and Max positive, because the direction (left or right) is mirrored randomly!";
var(AIGreenAlert) inherited(1423) float HeadTweak_PitchMin "Specify the minimum and maximum value IN DEGREES that an AI will tweak its head DOWN in green alert.  This is likely to be a negative number.";
var(AIGreenAlert) inherited(1424) float HeadTweak_PitchMax "Specify the maxmimum value IN DEGREES that an AI will tweak its head UP in green alert.  This is likely to be a positive number.";
var(AIGreenAlert) inherited(1425) float MinHeadTweakDelay "Minimum amount of time in between head tweaks.";
var(AIGreenAlert) inherited(1426) float MaxHeadTweakDelay "Maximum amount of time in between head tweaks.";

var(AIGreenAlert) inherited(1963) float MaxTimeForGreenAlertSubsequentBark "Play the greenalert:subsequent bark instead of the init bark if the AI ramps up into green alert again within this many seconds.";
var(AIGreenAlert) inherited(1964) float ChanceForGreenAlertSubsequentBark "AI will try to play subsequent bark instead of init bark this percentage (0 to 1) of the time as long as within specified MaxTime.";

var(AIWander) inherited(1680) bool bWanderByDefault "Use wander as default behavior instead of idle.";
var(AIWander) inherited(1681) float WanderDefault_MaxDistFromStart "Max Distance (IN FEET) AI will wander from this wander point's location.";
var(AIWander) inherited(1682) float WanderDefault_MaxDistFromWalls "Max Distance (IN FEET) AI will push away from walls or ledges when choosing a wander location.";
var(AIWander) inherited(1683) float WanderDefault_MinStopTime "Minimum time (IN SECONDS) AI will wait at a wander location before moving again.";
var(AIWander) inherited(1684) float WanderDefault_MaxStopTime "Maximum time (IN SECONDS) AI will wait at a wander location before moving again.";

var(AIGuardPlayer) inherited(1688) float GuardTooCloseDistance "If guarding the player within this distance (IN FEET), AI will try to move away from the player.";
var(AIGuardPlayer) inherited(1689) float GuardStopMovingDistance "If guarding the player within this distance (IN FEET), the AI will stop moving and face the player (or look around, TBD).";
var(AIGuardPlayer) inherited(1690) float GuardCatchupDistance "If guarding the player and outside this distance (IN FEET), the AI will run to try to get closer to the player.";

var(AIConversations) inherited(1757) float MinTimeBetweenConversationAnims "The minimum amount of time (in secs) between talking and listening conversation animations.";
var(AIConversations) inherited(1758) float MaxTimeBetweenConversationAnims "The maximum amount of time (in secs) between talking and listening conversation animations.";
var(AIConversations) inherited(1818) EAlertState InterruptOverheardConvoState "Overheard conversations will be interrupted by certain evidence types (non-damage types) only when the AI reaches at least this alert state.";

var(AITakeDamage) inherited(1759) float MinTimeBetweenFlinches "The minimum amount of time (in secs) that must pass before doing another flinch from damage.";
var(AITakeDamage) inherited(1760) float MaxTimeBetweenFlinches "The maximum amount of time (in secs) that must pass before doing another flinch from damage.";

var(AIPuddleResponse) inherited(2031) float TimeForSkidOnOilPuddle "The time (in seconds) that an AI will loop the feet-flailing slip animation after stepping on oil.";
var(AIPersonality) inherited(2054) EPersonalityMode PersonalityMode "Defines whether or not an AI has some specific non-standard personality traits (i.e., drunk or sleepy).";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     StateGreenAlert_AlertThreshold=25.000000
     StateYellowAlert_AlertThreshold=45.000000
     StateRedAlert_AlertThreshold=80.000000
     AlertState_RampDownThreshold=20.000000
     AlertState_MaximumAlertness=100.000000
     StateGreenAlert_MinDuration=4.000000
     StateYellowAlert_MinDuration=9.000000
     StateRedAlert_MinDuration=20.000000
     StateRedAlert_RampDownTimeAfterFriendlyTargetID=8.000000
     AlertState_AudioPingPeriodMin=10.000000
     AlertState_AudioPingPeriodMax=18.000000
     BluntStimKnockout_AlertMax=ALERTSTATE_YELLOW
     BluntStimKnockout_AngleMax=0.000000
     BackstabKill_AlertMax=ALERTSTATE_YELLOW
     Pickpocketable_MaxAlertThreshold=ALERTSTATE_YELLOW
     DamageMultiplier_MaxState=ALERTSTATE_NONE
     DamageMultiplier_LowAlertness=1.000000
     DamageMultiplier_BodyLocations(1)=BodyLocation_Head
     DamageMultiplier_BodyLocations(2)=BodyLocation_Torso
     StateEnabled_Idle=1.000000
     StateEnabled_GreenAlert=1.000000
     StateEnabled_YellowAlert=1.000000
     StateEnabled_RedAlert=1.000000
     StateEnabled_WarnPlayer=1.000000
     StateEnabled_GreetActor=1.000000
     StateEnabled_Conversation=1.000000
     StateEnabled_Flee=1.000000
     StateEnabled_Guard=1.000000
     StateEnabled_Returning=1.000000
     StateEnabled_Patrol=1.000000
     StateEnabled_PatrolLook=1.000000
     StateEnabled_PatrolFollow=1.000000
     StateEnabled_PatrolFollowAbsolute=1.000000
     StateEnabled_PlayAnim=1.000000
     StateEnabled_FrobAlarm=1.000000
     StateEnabled_ExitDangerZone=1.000000
     StateEnabled_Dormant=1.000000
     StateEnabled_ConversationIdle=1.000000
     StateEnabled_Search=1.000000
     StateEnabled_Wander=1.000000
     StateEnabled_Approach=1.000000
     StateEnabled_FleeFromGrenade=1.000000
     StateEnabled_Informing=1.000000
     StateEnabled_Fetching=1.000000
     StateEnabled_Frustration=1.000000
     StateEnabled_Slipping=1.000000
     StateEnabled_Being_Mugged=1.000000
     UseCreatureFlee=0.000000
     FleeDisappearDistance=0.000000
     FleeSafeDistance=20.000000
     MaxCowerBarkDistance=45.000000
     MinCowerBarkTime=8.000000
     MaxCowerBarkTime=13.000000
     FleeAgain_NearbyHostileTargetDistance=15.000000
     FleeAgain_NearbyHostileTargetTime=5.000000
     FleeContinueBarkMinTime=7.000000
     FleeContinueBarkMaxTime=10.000000
     MaxNumberOfAlliesUsedDuringFleeBehavior=2
     StateEnabled_Gassed=1.000000
     StateEnabled_Shocked=1.000000
     MinMoveTimeWhenGassed=6.000000
     MaxMoveTimeWhenGassed=10.000000
     MinMoveTimeWhenShocked=6.000000
     MaxMoveTimeWhenShocked=10.000000
     MinMoveTimeWhenBlinded=6.000000
     MaxMoveTimeWhenBlinded=10.000000
     StateEnabled_DX2Interface=0.000000
     StateEnabled_DX2StopForPlayer=0.000000
     StateEnabled_DX2BotCombat=0.000000
     StateEnabled_DX2TurretCombat=0.000000
     StateEnabled_DX2Pistol2HCombat=0.000000
     StateEnabled_DX2Pistol1HCombat=0.000000
     IdleStateAction_MinDelay=16.000000
     IdleStateAction_MaxDelay=32.000000
     IdleStateAction_ChanceToAnimate=0.500000
     IdleStateAction_AIBarkChanceForIdleConversation=0.700000
     IdleStateAction_AIBarkChanceForSpeechVSNonSpeech=0.250000
     IdleStateAction_AIBarkChanceForSpeechAboutAnimals=0.250000
     ChanceToPlayDeathAnimBeforeRagdoll=1.000000
     ChanceToPlayLastWordsDeathBark=0.650000
     MinDamageToAlwaysRagdoll=4.000000
     TimeBetweenPlayerGreetings=8.000000
     Reprimand_TimeAfterConversationBeforeBark=8.000000
     Reprimand_MaxDistance=20.000000
     Reprimand_SlowReprimandDelay=12.000000
     WarningsBeforeHostility_Damage=2
     DamagePercentageBeforeHostility=0.750000
     WarningsBeforeHostility_Hacking=3
     VisibilityRequiredToReprimand=0.400000
     WarnPlayer_MinDelay=8.000000
     WarnPlayer_MaxDelay=12.000000
     WarnPlayer_DecayTime=120.000000
     WarnPlayer_StareTime=12.000000
     WarnPlayer_OddBehavior=5.000000
     WarnPlayer_HackingTime=2.000000
     StareAngleReprimand=10.000000
     DX2BotManagerUsed=DX2BOTMANAGER_NONE
     StateDX2TurretCombat_MinDuration=20.000000
     StopWhenNearPlayerDistance=0.000000
     MaxAlarmDistance=30.000000
     SummonInCombatProbability=0.350000
     SummonIfAlliesWithinRadius=125.000000
     bKnockStuffOver=False
     SearchUpdateAlertnessThreshold=10.000000
     bScaleSearchUpdateValuesByLightGem=True
     SearchYellowMaxMoveDistance=36.000000
     SearchYellowMaxTravelDistance=240.000000
     SearchYellowGridFillDistance=10.000000
     SearchYellowGridFillAngle=90.000000
     SearchRedMaxMoveDistance=70.000000
     SearchRedMaxTravelDistance=360.000000
     SearchRedGridFillDistance=6.000000
     SearchRedGridFillAngle=60.000000
     SearchYellowCreepChance=1.000000
     SearchYellowWalkChance=0.000000
     SearchYellowRunChance=0.000000
     SearchRedCreepChance=1.000000
     SearchRedWalkChance=0.000000
     SearchRedRunChance=0.000000
     SearchYellowMinLookTime=3.000000
     SearchRedMinLookTime=1.000000
     SearchYellowChanceToTurnBackOnTarget=0.000000
     SearchRedRunDistanceMin=20.000000
     SearchRedMoveFastMultiplier=1.150000
     SearchRedMoveSlowMultiplier=0.850000
     SearchRedInterpolationRate=0.050000
     SearchRedSlowdownDistance=10.000000
     SearchHeadTurnLookTimeMin=0.600000
     SearchHeadTurnLookTimeMax=1.200000
     SearchHeadTurnInterpolationAlphaMin=0.050000
     SearchHeadTurnInterpolationAlphaMax=0.200000
     FatigueMaxDistanceFromPlayer=12.000000
     FrustrationSuccessfulAttackDecrease=9.000000
     FrustrationMinTimeBeforeFetch=5.000000
     FrustrationMaxTimeBeforeFetch=7.500000
     FrustrationWarningBarksThreshold=40.000000
     FrustrationTakeDamageIncrease=7.000000
     SurprisedWhenRedAlertFromState=ALERTSTATE_GREEN
     HeadTweak_YawMin=25.000000
     HeadTweak_YawMax=45.000000
     HeadTweak_PitchMin=-30.000000
     HeadTweak_PitchMax=30.000000
     MinHeadTweakDelay=3.000000
     MaxHeadTweakDelay=6.000000
     MaxTimeForGreenAlertSubsequentBark=15.000000
     ChanceForGreenAlertSubsequentBark=0.500000
     bWanderByDefault=False
     WanderDefault_MaxDistFromStart=12.000000
     WanderDefault_MaxDistFromWalls=3.000000
     WanderDefault_MinStopTime=2.500000
     WanderDefault_MaxStopTime=5.000000
     GuardTooCloseDistance=3.000000
     GuardStopMovingDistance=6.000000
     GuardCatchupDistance=20.000000
     MinTimeBetweenConversationAnims=2.000000
     MaxTimeBetweenConversationAnims=5.000000
     InterruptOverheardConvoState=ALERTSTATE_YELLOW
     MinTimeBetweenFlinches=0.500000
     MaxTimeBetweenFlinches=1.000000
     TimeForSkidOnOilPuddle=1.750000
     PersonalityMode=PERSONALITY_Normal
}
