//================================================================================
// Fawkes.
//================================================================================

class Fawkes extends Characters;

function PlayWingFlap ()
{
  PlaySound(Sound'Fawkes_wing_flap',,,,,RandRange(0.81,1.0));
}

defaultproperties
{
    bDoEyeBlinks=False

    Mesh=SkeletalMesh'HPModels.skFawkesMesh'

    AmbientGlow=65

    CollisionRadius=15.00

    CollisionHeight=49.00

}
