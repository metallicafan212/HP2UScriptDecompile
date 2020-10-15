//================================================================================
// BathroomSink.
//================================================================================

class BathroomSink extends HBathroom;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skBathroomSinkMesh'

    DrawScale=1.08

    CollisionRadius=23.00

    CollisionWidth=17.00

    CollisionHeight=33.00

    // CollideType=2
	CollideType=CT_Box
}
