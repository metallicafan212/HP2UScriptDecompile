//================================================================================
// ChairsRedCouch.
//================================================================================

class ChairsRedCouch extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skChairsRedCouchMesh'

    DrawScale=1.10

    CollisionRadius=76.00

    CollisionWidth=32.00

    CollisionHeight=43.00

    // CollideType=2
	CollideType=CT_Box
}
