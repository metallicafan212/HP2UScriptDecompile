//================================================================================
// Telescope.
//================================================================================

class Telescope extends HDecoration;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skTelescopeMesh'

    CollisionRadius=26.00

    CollisionWidth=100.00

    CollisionHeight=140.00

    // CollideType=2
	CollideType=CT_Box
}
