//=============================================================================
// The StimulusModifierObject class.
//=============================================================================
class StimulusModifierObject extends MetaProperty
	native;

struct StimulusModifier
{
	var()		eStimulusType StimulusType "The type of stimulus this modifier affects";
	var()		float		  StimulusScalar "How much does this object multiply the stim by";
};

var(Stimulus) inherited(965) bitfield eStimModLocationFlags
{
	eSMLF_Head,
	eSMLF_Body,
} StimModLocationFlags "Flags for what locations this stim modifier affects.";

var(Stimulus) inherited(961) customviewer Array<StimulusModifier> StimModifiers "Array of modifiers for stimuli applied to actors linked to this.";

	

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     StimModLocationFlags=(eSMLF_Head,eSMLF_Body)
}
