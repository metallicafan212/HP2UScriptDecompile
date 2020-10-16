//================================================================================
// ChristmasOrnamentStar.
//================================================================================

class ChristmasOrnamentStar extends HChristmas;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skChristmasOrnamentStarMesh'

    DrawScale=2.20

    CollisionRadius=10.00

    CollisionWidth=3.00

    CollisionHeight=10.00

    // CollideType=2
	CollideType=CT_Box
}
