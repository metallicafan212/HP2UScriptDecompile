//================================================================================
// BedInfirmary.
//================================================================================

class BedInfirmary extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBedInfirmaryMesh'

    CollisionRadius=30.00

    CollisionWidth=65.00

    CollisionHeight=33.00

    // CollideType=2
	CollideType=CT_Box
}
