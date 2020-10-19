//================================================================================
// Snake.
//================================================================================

class Snake extends HChar;

defaultproperties
{
    ShadowClass=None

    Mesh=SkeletalMesh'HPModels.sksnakeMesh'

    AmbientGlow=65

    CollisionRadius=15.00

    CollisionHeight=15.00

    // CollideType=3
	CollideType=CT_Shape
}
