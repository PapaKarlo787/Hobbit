class SpecialOptions extends MetaData
        abstract
        notplaceable
        native;

struct sSpecialOptionInfo
{
		var() Name Name;
		var() localized string OptionFriendlyName;
		var() CustomEditor Name TriggerScript;
		
		// May want to add an image file or something when we get a real UI up and going
};

var(SpecialOptions) inherited(1248) Array<sSpecialOptionInfo> SpecialOptionList "Reference the special option by its name.  The OptionFriendlyName is what will be shown to the player from the UI.  And the ScriptName is the trigger script that will be forcably fired if that option is chosen. - MDB 12/12/02";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
}
