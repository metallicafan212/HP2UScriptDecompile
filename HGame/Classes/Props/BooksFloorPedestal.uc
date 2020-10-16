//================================================================================
// BooksFloorPedestal.
//================================================================================

class BooksFloorPedestal extends HBooks;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBooksFloorPedestalMesh'

    DrawScale=1.10

    CollisionWidth=18.00

    CollisionHeight=21.00

    // CollideType=2
	CollideType=CT_Box
}
