//================================================================================
// HutchSlytherin.
//================================================================================

class HutchSlytherin extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skHutchSlytherinMesh'

    DrawScale=1.20

    CollisionRadius=45.00

    CollisionWidth=22.00

    CollisionHeight=76.00

    // CollideType=2
	CollideType=CT_Box
}
