class SlidingAttachmentLinkDataObject extends AttachmentLinkDataObject
	native;

var(Physics) vector m_slideAxis;     // axis of translation in source Actor's local space
var(Physics) float  m_slideFriction; // friction (0.0 to 1.0)
var(Physics) float  m_lip;           // specifies "overhang" for door movement

// internal variables for save games
var vector  m_pivotInA;           // pivot point in attached space
var vector  m_pivotInB;           // pivot point in reference space
var vector  m_shaftInA;           // slide axis in attached space
var vector  m_shaftInB;           // slide axis in reference space
var vector  m_perpToShaftInB1;    // perpendicular to slide axis in reference space
var vector  m_perpToShaftInB2;    // perpendicular to slide axis in reference space
var rotator m_BtoAoffsetRotation; // offset rotation
var float   m_minLimit;           // minimum linear limit
var float   m_maxLimit;           // maximum linear limit
var float   m_maxFrictionForce;   // maximum friction impulse along free axis
var bool    m_containsSaveData;   // whether or not this data object contains save info

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_slideAxis=(X=1.000000)
     m_LinkFlavor=36708074
}
