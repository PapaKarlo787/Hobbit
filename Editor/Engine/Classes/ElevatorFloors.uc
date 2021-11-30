class ElevatorFloors extends MetaData
        abstract
        notplaceable
        native;

struct sElevatorFloorInfo
{
        var() name				FloorName;
        var() localized string	FriendlyName;
};

var(Elevator) inherited(1232) Array<sElevatorFloorInfo> FloorList "Reference a floor by the FloorName and type in a friendly name that may be seen by the player, e.g. Penthouse Suite. - Jerm 12/09/02";

classproperties
{
    ClassPlaceableStatus=FALSE
}


defaultproperties
{
}
