//================================================================================
// harrybed.
//================================================================================

class harrybed extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skharrybedMesh'

    CollisionRadius=33.00

    CollisionWidth=60.00

    // CollideType=2
	CollideType=CT_Box
}
