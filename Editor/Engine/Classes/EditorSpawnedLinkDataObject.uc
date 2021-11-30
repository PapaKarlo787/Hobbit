class EditorSpawnedLinkDataObject extends LinkDataObject
	native
	editorinvisible;

//AMSD:This represents a spawned subchild object.  It is only used in the editor(deleted on
//postload in the game).  We use it so that cut/paste don't have to generate spawn events.

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_LinkFlavor=46699988
}
