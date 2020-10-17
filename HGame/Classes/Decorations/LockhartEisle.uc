//================================================================================
// LockhartEisle.
//================================================================================

class LockhartEisle extends HDecoration;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skLockhartEisleMesh'

    CollisionRadius=42.00

    CollisionWidth=22.00

    CollisionHeight=85.00

    // CollideType=2
	CollideType=CT_Box
}
