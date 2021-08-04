//================================================================================
// Hermione.
//================================================================================

class Hermione extends Characters;

function float GetFootStepVol()
{
  return 1.0;
}

defaultproperties
{
    BumpLineSetPrefix="Her"

    GroundRunSpeed=220.00

    Mesh=SkeletalMesh'HPModels.skhermioneMesh'

    AmbientGlow=65

    CollisionRadius=15.00

    CollisionHeight=38.00

}