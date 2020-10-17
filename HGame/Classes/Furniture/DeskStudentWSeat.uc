//================================================================================
// DeskStudentWSeat.
//================================================================================

class DeskStudentWSeat extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skDeskStudentWSeatMesh'

    CollisionRadius=43.00

    CollisionWidth=47.00

    CollisionHeight=30.00

    // CollideType=2
	CollideType=CT_Box
}
