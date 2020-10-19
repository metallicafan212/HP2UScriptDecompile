//================================================================================
// TableWoodRectangle2.
//================================================================================

class TableWoodRectangle2 extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skTableWoodRectangle2Mesh'

    CollisionRadius=85.00

    CollisionWidth=24.00

    CollisionHeight=28.00

    // CollideType=2
	CollideType=CT_Box
}
