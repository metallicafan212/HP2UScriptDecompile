//================================================================================
// DeskTeacher.
//================================================================================

class DeskTeacher extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skDeskTeacherMesh'

    CollisionRadius=25.00

    CollisionWidth=50.00

    CollisionHeight=27.00

    // CollideType=2
	CollideType=CT_Box
}
