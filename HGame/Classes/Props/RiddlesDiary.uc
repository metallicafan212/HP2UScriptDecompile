//================================================================================
// RiddlesDiary.
//================================================================================

class RiddlesDiary extends HBooks;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skRiddlesDiaryMesh'

    CollisionRadius=15.00

    CollisionHeight=3.00

    // CollideType=2
	CollideType=CT_Box
}
