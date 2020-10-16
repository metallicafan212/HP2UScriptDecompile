//================================================================================
// BookcaseGlassDoors.
//================================================================================

class BookcaseGlassDoors extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBookcaseGlassDoorsMesh'

    DrawScale=1.20

    CollisionRadius=81.00

    CollisionWidth=18.00

    CollisionHeight=72.00

    // CollideType=2
	CollideType=CT_Box
}
