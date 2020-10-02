//================================================================================
// Ron.
//================================================================================

class Ron extends Characters;

function float GetFootStepVol ()
{
  return 1.0;
}

defaultproperties
{
    BumpLineSetPrefix="Ron"

    GroundRunSpeed=220.00

    Mesh=SkeletalMesh'HPModels.skronMesh'

    AmbientGlow=65

    CollisionRadius=15.00

    CollisionHeight=40.00

}