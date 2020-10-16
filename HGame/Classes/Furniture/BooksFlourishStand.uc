//================================================================================
// BooksFlourishStand.
//================================================================================

class BooksFlourishStand extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBooksFlourishStandMesh'

    DrawScale=1.40

    CollisionWidth=60.00

    CollisionHeight=32.00

    // CollideType=2
	CollideType=CT_Box
}
