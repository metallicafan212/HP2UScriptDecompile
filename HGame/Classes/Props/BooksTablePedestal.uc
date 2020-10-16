//================================================================================
// BooksTablePedestal.
//================================================================================

class BooksTablePedestal extends HBooks;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBooksTablePedestalMesh'

    DrawScale=1.10

    CollisionRadius=23.00

    CollisionWidth=17.00

    CollisionHeight=7.00

    // CollideType=2
	CollideType=CT_Box
}
