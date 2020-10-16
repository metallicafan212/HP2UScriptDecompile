//================================================================================
// BooksBigFlitwickBook.
//================================================================================

class BooksBigFlitwickBook extends HBooks;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBooksBigFlitwickBookMesh'

    DrawScale=1.20

    CollisionRadius=14.00

    CollisionWidth=18.00

    CollisionHeight=10.00

    // CollideType=2
	CollideType=CT_Box
}
