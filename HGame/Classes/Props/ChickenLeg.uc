//================================================================================
// ChickenLeg.
//================================================================================

class ChickenLeg extends HProp;

defaultproperties
{
    // Physics=2
	Physics=PHYS_Falling

    Mesh=SkeletalMesh'HPModels.skChickenLegMesh'

    CollisionRadius=10.00

    CollisionHeight=10.00

    bCollideActors=False

    bBlockActors=False

    bBlockPlayers=False

    bBlockCamera=False
}
