//================================================================================
// CoatRack1.
//================================================================================

class CoatRack1 extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skCoatRack1Mesh'

    DrawScale=1.10

    CollisionRadius=50.00

    CollisionWidth=9.00

    CollisionHeight=8.00

    // CollideType=2
	CollideType=CT_Box
}
