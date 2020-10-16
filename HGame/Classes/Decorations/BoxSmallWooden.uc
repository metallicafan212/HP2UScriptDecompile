//================================================================================
// BoxSmallWooden.
//================================================================================

class BoxSmallWooden extends HDecoration;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBoxSmallWoodenMesh'

    DrawScale=1.20

    CollisionRadius=18.00

    CollisionWidth=8.00

    CollisionHeight=11.00

    // CollideType=2
	CollideType=CT_Box
}
