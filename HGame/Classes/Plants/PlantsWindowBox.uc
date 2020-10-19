//================================================================================
// PlantsWindowBox.
//================================================================================

class PlantsWindowBox extends HGreenhouse;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skPlantsWindowBoxMesh'

    DrawScale=1.50

    CollisionRadius=75.00

    CollisionWidth=22.00

    CollisionHeight=40.00

    // CollideType=2
	CollideType=CT_Box
}
