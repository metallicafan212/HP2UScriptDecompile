//================================================================================
// FordAngliaDamaged.
//================================================================================

class FordAngliaDamaged extends HProp;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skFordAngliaDamagedMesh'

    DrawScale=1.10

    CollisionRadius=140.00

    CollisionWidth=55.00

    CollisionHeight=53.00

    // CollideType=2
	CollideType=CT_Box
}
