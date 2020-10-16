//================================================================================
// BooksSmallBook.
//================================================================================

class BooksSmallBook extends HBooks;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBooksSmallBookMesh'

    CollisionRadius=10.00

    CollisionWidth=15.00

    CollisionHeight=5.00

    // CollideType=2
	CollideType=CT_Box
}
