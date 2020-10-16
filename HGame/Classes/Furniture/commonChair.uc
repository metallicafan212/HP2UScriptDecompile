//================================================================================
// commonChair.
//================================================================================

class commonChair extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skcommonChairMesh'

    CollisionRadius=35.00

    CollisionHeight=45.00

    // CollideType=2
	CollideType=CT_Box
}
