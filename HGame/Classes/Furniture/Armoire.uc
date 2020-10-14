//================================================================================
// Armoire.
//================================================================================

class Armoire extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skArmoireMesh'

    CollisionRadius=40.00

    CollisionWidth=18.00

    CollisionHeight=60.00

    // CollideType=2
	CollideType=CT_Box
}
