//================================================================================
// FramesEmpty.
//================================================================================

class FramesEmpty extends HDecoration;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skFramesEmptyMesh'

    CollisionRadius=25.00

    CollisionWidth=40.00

    CollisionHeight=50.00

    // CollideType=2
	CollideType=CT_Box
}
