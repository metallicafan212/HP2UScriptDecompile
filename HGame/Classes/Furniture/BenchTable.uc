//================================================================================
// BenchTable.
//================================================================================

class BenchTable extends HFurniture;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBenchTableMesh'

    CollisionRadius=80.00

    CollisionHeight=30.00

    // CollideType=2
	CollideType=CT_Box
}
