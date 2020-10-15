//================================================================================
// BenchWithArms.
//================================================================================

class BenchWithArms extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBenchWithArmsMesh'

    CollisionRadius=80.00

    CollisionWidth=24.00

    CollisionHeight=37.00

    // CollideType=2
	CollideType=CT_Box
}
