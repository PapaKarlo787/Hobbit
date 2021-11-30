class EnumEvidenceType extends Actor
	native
	abstract
	editorinvisible;

enum EEvidenceType
{
	// generic evidence

	EVIDENCE_GENERIC,
	
	// visual evidence types
	
	EVIDENCE_VISUAL,				// generic visual evidence: saw an actor, but not completely ("actor maybe seen")
	EVIDENCE_SAW_PLAYER,			// saw the player, for certain ("actor clearly seen")
	EVIDENCE_SAW_ENEMY_NPC,			// saw an enemy NPC
	EVIDENCE_SAW_ALERT_NPC,			// saw a friendly or allied NPC in an alert state
	EVIDENCE_SAW_CHANGED_ACTOR,		// saw an actor moved, destroyed, damaged, etc.
	EVIDENCE_SAW_BODY,				// saw a dead or unconscious body

	// auditory evidence types
	
	EVIDENCE_AUDIO,					// heard something (footsteps, explosions, etc.)
	EVIDENCE_HEARD_ALARM,			// heard an alarm

	// tactile evidence types

	EVIDENCE_TACTILE,				// generic tactile evidence (bumped by player or got hit with a box or something)

	// various stimulus-based evidence types

	EVIDENCE_STIMULUS_DAMAGE,		// received damage
	EVIDENCE_STIMULUS_GASSED,		// damaged by poison gas
	EVIDENCE_STIMULUS_SHOCKED,		// took shock damage
	EVIDENCE_STIMULUS_BLINDED		// blinded
};

var EEvidenceType DummyVariable;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
}
