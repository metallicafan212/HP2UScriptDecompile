//================================================================================
// CartMiners.
//================================================================================

class CartMiners extends HCave;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skCartMinersMesh'

    DrawScale=0.40

    CollisionRadius=45.00

    CollisionWidth=50.00

    CollisionHeight=29.00

    // CollideType=2
	CollideType=CT_Box
}
