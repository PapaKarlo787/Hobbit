class ObjSysTest extends Actor
	native
	editorinvisible;

struct TestStruct
{
    var() string StartString;
	var() int SingleInteger;
	var() float FloatArray[3];
	var() Vector SingleVector;
	var() string EndString;
};

// new objectsystem stuff

//Inherited properties
var(ObjectSystemTest) inherited(772) int TestInheritedInteger "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(773) int TestInstantiatedInteger "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(774) int TestInheritedIntegerArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(775) int TestInstantiatedIntegerArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(776) array<int> TestInheritedIntegerDynArray "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(777) array<int> TestInstantiatedIntegerDynArray "Property for test purposes only.  Do not use."; 
var(ObjectSystemTest) runtimeinstantiated(778) int TestRunTimeInstantiatedInteger "Property for test purposes only.  Do not use.";

var(ObjectSystemTest) inherited(779) float TestInheritedFloat "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(780) float TestInstantiatedFloat "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(781) float TestInheritedFloatArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(782) float TestInstantiatedFloatArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(120) array<float> TestInheritedFloatDynArray "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(121) array<float> TestInstantiatedFloatDynArray "Property for test purposes only.  Do not use."; 

var(ObjectSystemTest) inherited(122) Actor.ELightType TestInheritedLightTypeEnum "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(123) Actor.ELightType TestInstantiatedLightTypeEnum "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(124) Actor.ELightType TestInheritedLightTypeEnumArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(125) Actor.ELightType TestInstantiatedLightTypeEnumArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(126) array<Actor.ELightType> TestInheritedLightTypeEnumDynArray "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(127) array<Actor.ELightType> TestInstantiatedLightTypeEnumDynArray "Property for test purposes only.  Do not use."; 

var(ObjectSystemTest) inherited(128) bool TestInheritedBOOL "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(129) bool TestInstantiatedBOOL "Property for test purposes only.  Do not use.";
//var(ObjectSystemTest) inherited(130) bool TestInheritedBOOLArray[5] "Property for test purposes only.  Do not use."; //Unreal doesn't allow these
//var(ObjectSystemTest) runtimeinstantiated(131) bool TestInstantiatedBOOLArray[5] "Property for test purposes only.  Do not use."; //Unreal doesn't allow these
var(ObjectSystemTest) inherited(132) array<bool> TestInheritedBOOLDynArray "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(133) array<bool> TestInstantiatedBOOLDynArray "Property for test purposes only.  Do not use."; 

var(ObjectSystemTest) inherited(134) string TestInheritedString "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(135) string TestInstantiatedString "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(136) string TestInheritedStringArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(137) string TestInstantiatedStringArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(138) array<string> TestInheritedStringDynArray "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(139) array<string> TestInstantiatedStringDynArray "Property for test purposes only.  Do not use."; 

var(ObjectSystemTest) inherited(140) Object TestInheritedObject "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(141) Object TestInstantiatedObject "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(142) Object TestInheritedObjectArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(143) Object TestInstantiatedObjectArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(144) array<Object> TestInheritedObjectDynArray "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(145) array<Object> TestInstantiatedObjectDynArray "Property for test purposes only.  Do not use."; 

var(ObjectSystemTest) inherited(146) Class TestInheritedClass "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(147) Class TestInstantiatedClass "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(148) Class TestInheritedClassArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(149) Class TestInstantiatedClassArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(150) array<Class> TestInheritedClassDynArray "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(151) array<Class> TestInstantiatedClassDynArray "Property for test purposes only.  Do not use."; 

var(ObjectSystemTest) inherited(152) Vector TestInheritedVector "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(153) Vector TestInstantiatedVector "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(154) Vector TestInheritedVectorArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(155) Vector TestInstantiatedVectorArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(156) array<Vector> TestInheritedVectorDynArray "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(157) array<Vector> TestInstantiatedVectorDynArray "Property for test purposes only.  Do not use."; 

var(ObjectSystemTest) inherited(158) TestStruct TestInheritedTestStruct "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(159) TestStruct TestInstantiatedTestStruct "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(160) TestStruct TestInheritedTestStructArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(161) TestStruct TestInstantiatedTestStructArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(162) array<TestStruct> TestInheritedTestStructDynArray "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(163) array<TestStruct> TestInstantiatedTestStructDynArray "Property for test purposes only.  Do not use."; 
var(ObjectSystemTest) runtimeinstantiated(164) array<TestStruct> TestRunTimeInstantiatedTestStructDynArray "Property for test purposes only.  Do not use.";

var(ObjectSystemTest) inherited(165) Name TestInheritedName "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(166) Name TestInstantiatedName "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(167) Name TestInheritedNameArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(168) Name TestInstantiatedNameArray[5] "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) inherited(169) array<Name> TestInheritedNameDynArray "Property for test purposes only.  Do not use.";
var(ObjectSystemTest) runtimeinstantiated(170) array<Name> TestInstantiatedNameDynArray "Property for test purposes only.  Do not use."; 

var(ObjectSystemSecondText) inherited(171) int UndefInhInt "Property for test purposes only.  Do not use.";
var(ObjectSystemSecondText) runtimeinstantiated(172) int UndefInstInt "Property for test purposes only.  Do not use.";

var(ObjectSystemTest) inherited(842) bitfield eObjectTestFilterFlags
{
	eOTFF_Minimal,
	eOTFF_Fur,
	eOTFF_Wings,
	eOTFF_EggLaying,
	eOTFF_FireBreathing
} ObjectSysTestFilter;

var(ObjectSystemTest) inherited(843) array<eObjectTestFilterFlags> ObjSysTestFilterArray;

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
     TestInheritedInteger=5
     TestInstantiatedInteger=7
     TestInheritedIntegerArray(0)=0
     TestInheritedIntegerArray(1)=9
     TestInheritedIntegerArray(2)=0
     TestInheritedIntegerArray(3)=7
     TestInheritedIntegerArray(4)=0
     TestInstantiatedIntegerArray(0)=10
     TestInstantiatedIntegerArray(1)=0
     TestInstantiatedIntegerArray(2)=8
     TestInstantiatedIntegerArray(3)=0
     TestInstantiatedIntegerArray(4)=6
     TestInheritedIntegerDynArray(0)=1
     TestInheritedIntegerDynArray(1)=2
     TestInheritedIntegerDynArray(2)=3
     TestInheritedIntegerDynArray(3)=4
     TestInheritedIntegerDynArray(4)=5
     TestInstantiatedIntegerDynArray(0)=10
     TestInstantiatedIntegerDynArray(1)=9
     TestInstantiatedIntegerDynArray(2)=8
     TestRunTimeInstantiatedInteger=8
     TestInheritedFloat=5.000000
     TestInstantiatedFloat=7.000000
     TestInheritedFloatArray(0)=0.000000
     TestInheritedFloatArray(1)=9.000000
     TestInheritedFloatArray(2)=0.000000
     TestInheritedFloatArray(3)=7.000000
     TestInheritedFloatArray(4)=0.000000
     TestInstantiatedFloatArray(0)=10.000000
     TestInstantiatedFloatArray(1)=0.000000
     TestInstantiatedFloatArray(2)=8.000000
     TestInstantiatedFloatArray(3)=0.000000
     TestInstantiatedFloatArray(4)=6.000000
     TestInheritedFloatDynArray(0)=1.000000
     TestInheritedFloatDynArray(1)=2.000000
     TestInheritedFloatDynArray(2)=3.000000
     TestInheritedFloatDynArray(3)=4.000000
     TestInheritedFloatDynArray(4)=5.000000
     TestInstantiatedFloatDynArray(0)=10.000000
     TestInstantiatedFloatDynArray(1)=9.000000
     TestInstantiatedFloatDynArray(2)=8.000000
     TestInheritedLightTypeEnum=LT_Steady
     TestInstantiatedLightTypeEnum=LT_Pulse
     TestInheritedLightTypeEnumArray(0)=LT_None
     TestInheritedLightTypeEnumArray(1)=LT_Blink
     TestInheritedLightTypeEnumArray(2)=LT_None
     TestInheritedLightTypeEnumArray(3)=LT_Flicker
     TestInheritedLightTypeEnumArray(4)=LT_None
     TestInstantiatedLightTypeEnumArray(0)=LT_Strobe
     TestInstantiatedLightTypeEnumArray(1)=LT_None
     TestInstantiatedLightTypeEnumArray(2)=LT_BackdropLight
     TestInstantiatedLightTypeEnumArray(3)=LT_None
     TestInstantiatedLightTypeEnumArray(4)=LT_SubtlePulse
     TestInheritedLightTypeEnumDynArray(0)=LT_Steady
     TestInheritedLightTypeEnumDynArray(1)=LT_Pulse
     TestInheritedLightTypeEnumDynArray(2)=LT_Blink
     TestInstantiatedLightTypeEnumDynArray(0)=LT_SubtlePulse
     TestInstantiatedLightTypeEnumDynArray(1)=LT_BackdropLight
     TestInstantiatedLightTypeEnumDynArray(2)=LT_Strobe
     TestInheritedBOOL=True
     TestInstantiatedBOOL=False
     TestInheritedBOOLDynArray(0)=True
     TestInheritedBOOLDynArray(2)=True
     TestInheritedBOOLDynArray(4)=True
     TestInstantiatedBOOLDynArray(1)=True
     TestInstantiatedBOOLDynArray(3)=True
     TestInheritedString="InheritedString"
     TestInstantiatedString="InstantiatedString"
     TestInheritedStringArray(0)=""
     TestInheritedStringArray(1)="InheritedString1"
     TestInheritedStringArray(2)=""
     TestInheritedStringArray(3)="InheritedString3"
     TestInheritedStringArray(4)=""
     TestInstantiatedStringArray(0)="InstantiatedString0"
     TestInstantiatedStringArray(1)=""
     TestInstantiatedStringArray(2)="InstantiatedString2"
     TestInstantiatedStringArray(3)=""
     TestInstantiatedStringArray(4)="InstantiatedString4"
     TestInheritedStringDynArray(0)="1"
     TestInheritedStringDynArray(1)="2"
     TestInheritedStringDynArray(2)="3"
     TestInheritedStringDynArray(3)="4"
     TestInheritedStringDynArray(4)="5"
     TestInstantiatedStringDynArray(0)="10"
     TestInstantiatedStringDynArray(1)="9"
     TestInstantiatedStringDynArray(2)="8"
     TestInstantiatedStringDynArray(3)="7"
     TestInstantiatedStringDynArray(4)="6"
     TestInheritedObject=Class'Engine.Actor'
     TestInstantiatedObject=None
     TestInheritedObjectArray(0)=None
     TestInheritedObjectArray(1)=Class'Engine.Info'
     TestInheritedObjectArray(2)=None
     TestInheritedObjectArray(3)=Class'Engine.ZoneInfo'
     TestInheritedObjectArray(4)=None
     TestInstantiatedObjectArray(0)=Class'Engine.Pawn'
     TestInstantiatedObjectArray(1)=None
     TestInstantiatedObjectArray(2)=Class'Engine.PlayerController'
     TestInstantiatedObjectArray(3)=None
     TestInstantiatedObjectArray(4)=None
     TestInheritedObjectDynArray(0)=Class'Engine.Marker'
     TestInheritedObjectDynArray(1)=Class'Engine.Canvas'
     TestInstantiatedObjectDynArray(0)=Class'Engine.LevelInfo'
     TestInstantiatedObjectDynArray(1)=Class'Engine.AIController'
     TestInheritedClass=Class'Engine.Actor'
     TestInstantiatedClass=None
     TestInheritedClassArray(0)=None
     TestInheritedClassArray(1)=Class'Engine.Info'
     TestInheritedClassArray(2)=None
     TestInheritedClassArray(3)=Class'Engine.ZoneInfo'
     TestInheritedClassArray(4)=None
     TestInstantiatedClassArray(0)=Class'Engine.Pawn'
     TestInstantiatedClassArray(1)=None
     TestInstantiatedClassArray(2)=Class'Engine.PlayerController'
     TestInstantiatedClassArray(3)=None
     TestInstantiatedClassArray(4)=None
     TestInheritedClassDynArray(0)=Class'Engine.Marker'
     TestInheritedClassDynArray(1)=Class'Engine.Canvas'
     TestInstantiatedClassDynArray(0)=Class'Engine.LevelInfo'
     TestInstantiatedClassDynArray(1)=Class'Engine.AIController'
     TestInheritedVector=(X=5.000000,Y=6.000000,Z=7.000000)
     TestInstantiatedVector=(X=7.000000,Y=8.000000,Z=9.000000)
     TestInheritedVectorArray(0)=()
     TestInheritedVectorArray(1)=(X=9.000000,Y=8.000000,Z=7.000000)
     TestInheritedVectorArray(2)=()
     TestInheritedVectorArray(3)=(X=7.000000,Y=6.000000,Z=5.000000)
     TestInheritedVectorArray(4)=()
     TestInstantiatedVectorArray(0)=(X=10.000000,Y=9.000000,Z=8.000000)
     TestInstantiatedVectorArray(1)=()
     TestInstantiatedVectorArray(2)=(X=8.000000,Y=7.000000,Z=6.000000)
     TestInstantiatedVectorArray(3)=()
     TestInstantiatedVectorArray(4)=(X=6.000000,Y=5.000000,Z=4.000000)
     TestInheritedVectorDynArray(0)=(X=1.000000,Y=2.000000,Z=3.000000)
     TestInheritedVectorDynArray(1)=(X=2.000000,Y=3.000000,Z=4.000000)
     TestInstantiatedVectorDynArray(0)=(X=10.000000,Y=9.000000,Z=8.000000)
     TestInstantiatedVectorDynArray(1)=(X=9.000000,Y=8.000000,Z=7.000000)
     TestInheritedTestStruct=(StartString="InhStart",SingleInteger=5,FloatArray[0]=1.000000,FloatArray[1]=2.000000,FloatArray[2]=3.000000,SingleVector=(X=1.000000,Y=2.000000,Z=3.000000),EndString="InhEnd")
     TestInstantiatedTestStruct=(StartString="InstStart",SingleInteger=6,FloatArray[0]=2.000000,FloatArray[1]=3.000000,FloatArray[2]=4.000000,SingleVector=(X=3.000000,Y=4.000000,Z=5.000000),EndString="InstEnd")
     TestInheritedTestStructArray(0)=()
     TestInheritedTestStructArray(1)=(StartString="Inh1Start",SingleInteger=7,FloatArray[0]=3.000000,FloatArray[1]=4.000000,FloatArray[2]=5.000000,SingleVector=(X=6.000000,Y=7.000000,Z=8.000000),EndString="Inh1End")
     TestInheritedTestStructArray(2)=()
     TestInheritedTestStructArray(3)=(StartString="Inh3Start",SingleInteger=8,FloatArray[0]=4.000000,FloatArray[1]=5.000000,FloatArray[2]=6.000000,SingleVector=(X=10.000000,Y=11.000000,Z=12.000000),EndString="Inh3End")
     TestInheritedTestStructArray(4)=()
     TestInstantiatedTestStructArray(0)=(StartString="Inst0Start",SingleInteger=9,FloatArray[0]=5.000000,FloatArray[1]=6.000000,FloatArray[2]=7.000000,SingleVector=(X=15.000000,Y=16.000000,Z=17.000000),EndString="Inst0End")
     TestInstantiatedTestStructArray(1)=()
     TestInstantiatedTestStructArray(2)=(StartString="Inst2Start",SingleInteger=10,FloatArray[0]=6.000000,FloatArray[1]=7.000000,FloatArray[2]=8.000000,SingleVector=(X=21.000000,Y=22.000000,Z=23.000000),EndString="Inst2End")
     TestInstantiatedTestStructArray(3)=()
     TestInstantiatedTestStructArray(4)=(StartString="Inst4Start",SingleInteger=11,FloatArray[0]=7.000000,FloatArray[1]=8.000000,FloatArray[2]=9.000000,SingleVector=(X=28.000000,Y=29.000000,Z=30.000000),EndString="Inst4End")
     TestInheritedTestStructDynArray(0)=(StartString="InhD0Start",SingleInteger=12,FloatArray[0]=8.000000,FloatArray[1]=9.000000,FloatArray[2]=10.000000,SingleVector=(X=36.000000,Y=37.000000,Z=38.000000),EndString="InhD0End")
     TestInheritedTestStructDynArray(1)=(StartString="InhD1Start",SingleInteger=13,FloatArray[0]=9.000000,FloatArray[1]=10.000000,FloatArray[2]=11.000000,SingleVector=(X=45.000000,Y=46.000000,Z=47.000000),EndString="InhD1End")
     TestInstantiatedTestStructDynArray(0)=(StartString="InstD0Start",SingleInteger=14,FloatArray[0]=10.000000,FloatArray[1]=11.000000,FloatArray[2]=12.000000,SingleVector=(X=55.000000,Y=56.000000,Z=57.000000),EndString="InstD0End")
     TestInstantiatedTestStructDynArray(1)=(StartString="InstD1Start",SingleInteger=15,FloatArray[0]=11.000000,FloatArray[1]=12.000000,FloatArray[2]=13.000000,SingleVector=(X=66.000000,Y=67.000000,Z=68.000000),EndString="InstD1End")
     TestRunTimeInstantiatedTestStructDynArray(0)=(StartString="RunTimeInstD0Start",SingleInteger=14,FloatArray[0]=10.000000,FloatArray[1]=11.000000,FloatArray[2]=12.000000,SingleVector=(X=55.000000,Y=56.000000,Z=57.000000),EndString="RunTimeInstD0End")
     TestRunTimeInstantiatedTestStructDynArray(1)=(StartString="RunTimeInstD1Start",SingleInteger=15,FloatArray[0]=11.000000,FloatArray[1]=12.000000,FloatArray[2]=13.000000,SingleVector=(X=66.000000,Y=67.000000,Z=68.000000),EndString="RunTimeInstD1End")
     TestInheritedName="ZoneInfo"
     TestInstantiatedName="GameInfo"
     TestInheritedNameArray(0)="None"
     TestInheritedNameArray(1)="Pawn"
     TestInheritedNameArray(2)="None"
     TestInheritedNameArray(3)="Player"
     TestInheritedNameArray(4)="None"
     TestInstantiatedNameArray(0)="Info"
     TestInstantiatedNameArray(1)="None"
     TestInstantiatedNameArray(2)="Pickup"
     TestInstantiatedNameArray(3)="None"
     TestInstantiatedNameArray(4)="Marker"
     TestInheritedNameDynArray(0)="Mover"
     TestInheritedNameDynArray(1)="NavigationPoint"
     TestInstantiatedNameDynArray(0)="Ladder"
     TestInstantiatedNameDynArray(1)="LevelInfo"
     ObjectSysTestFilter=(eOTFF_Minimal,eOTFF_Wings)
     ObjSysTestFilterArray(0)=(eOTFF_FireBreathing)
     ObjSysTestFilterArray(1)=(eOTFF_EggLaying)
}
