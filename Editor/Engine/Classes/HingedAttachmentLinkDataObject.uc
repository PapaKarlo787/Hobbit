class HingedAttachmentLinkDataObject extends AttachmentLinkDataObject
	native;

var(Physics) vector m_hingeLocation; // offset for hinge location in source Actor's local space
var(Physics) vector m_hingeAxis;     // axis of rotation in source Actor's local space
var(Physics) float  m_hingeLimitMin; // minimum hinge limit (in degrees)
var(Physics) float  m_hingeLimitMax; // maximum hinge limit (in degrees)
var(Physics) float  m_hingeFriction; // friction (0.0 to 1.0)

// ----------------------------------
// internal variables for save games
// ----------------------------------
// from hkLimitedHingeConstructionInfo
var vector m_pivotInA;         // the pivot point in reference object space
var vector m_pivotInB;         // the pivot point in attached object space
var vector m_axleInA;          // the axle in reference object space
var vector m_axleInB;          // the axle in attached object space
var vector m_perpToAxleInA1;   // mutually perpendicular vectors in reference object space
var vector m_perpToAxleInA2;   // mutually perpendicular vectors in reference object space
var vector m_perpToFreeAxisInB; // perpendicular to free axis in attached space
var float  m_maxFrictionTorque;// maximum angular friction impulse

// from hkLimitedHingeConstraint
var float  m_lastAngle;        // last angle, used by limits

// from hkPoweredHingeConstraint
var float  m_rotations;        // number of times 0 has been passed (negative if passed backwards)

// for the motor
var bool   m_motorActive;      // is the motor active?

// tells us whether or not we have save data in this data object
var bool   m_containsSaveData; // whether or not this link has save data

classproperties
{
    ClassPlaceableStatus=TRUE
}


defaultproperties
{
     m_hingeAxis=(Z=1.000000)
     m_hingeLimitMin=-1.000000
     m_hingeLimitMax=-1.000000
     m_LinkFlavor=39100139
}
