//================================================================================
// DeskStudent1.
//================================================================================

class DeskStudent1 extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skDeskStudent1Mesh'

    CollisionRadius=23.00

    CollisionWidth=47.00

    CollisionHeight=26.00

    // CollideType=2
	CollideType=CT_Box
}
