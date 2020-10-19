//================================================================================
// Trunk.
//================================================================================

class Trunk extends HDecoration;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skTrunkMesh'

    CollisionRadius=44.00

    CollisionWidth=25.00

    CollisionHeight=20.00

    // CollideType=2
	CollideType=CT_Box
}
