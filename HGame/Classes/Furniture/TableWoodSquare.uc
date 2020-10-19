//================================================================================
// TableWoodSquare.
//================================================================================

class TableWoodSquare extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skTableWoodSquareMesh'

    CollisionRadius=40.00

    CollisionHeight=28.00

    // CollideType=2
	CollideType=CT_Box
}
