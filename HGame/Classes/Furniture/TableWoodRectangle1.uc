//================================================================================
// TableWoodRectangle1.
//================================================================================

class TableWoodRectangle1 extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skTableWoodRectangle1Mesh'

    CollisionRadius=24.00

    CollisionWidth=70.00

    CollisionHeight=24.00

    // CollideType=2
	CollideType=CT_Box
}
