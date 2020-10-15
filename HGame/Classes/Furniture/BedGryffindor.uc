//================================================================================
// BedGryffindor.
//================================================================================

class BedGryffindor extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBedGryffindorMesh'

    CollisionRadius=46.00

    CollisionWidth=81.00

    CollisionHeight=65.00

    // CollideType=2
	CollideType=CT_Box
}
