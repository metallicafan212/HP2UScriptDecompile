//================================================================================
// BathroomToiletTank.
//================================================================================

class BathroomToiletTank extends HBathroom;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBathroomToiletTankMesh'

    DrawScale=1.04

    CollisionRadius=7.00

    CollisionWidth=16.00

    CollisionHeight=38.00

    // CollideType=2
	CollideType=CT_Box
}
