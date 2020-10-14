//================================================================================
// GnomeHome.
//================================================================================

class GnomeHome extends HProp;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skGnomeHomeMesh'

    DrawScale=0.75

    AmbientGlow=120

    CollisionRadius=95.00

    CollisionWidth=10.00

    CollisionHeight=65.00

    // CollideType=2
	CollideType=CT_Box

    bCollideActors=False

    bBlockActors=False
}
