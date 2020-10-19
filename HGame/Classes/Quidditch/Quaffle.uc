//================================================================================
// Quaffle.
//================================================================================

class Quaffle extends QuidditchPawn;

function PostBeginPlay ()
{
  if ( Mesh == None )
  {
    Mesh = SkeletalMesh'skQuidditchQuaffleMesh';
  }
  if ( ParticleTrail == None )
  {
    ParticleTrail = Class'Quaffle_FX';
  }
  Super.PostBeginPlay();
}

defaultproperties
{
    ParticleTrail=Class'HPParticle.Quaffle_FX'

    IPSpeed=800.00

    Mesh=SkeletalMesh'HProps.skQuidditchQuaffleMesh'

    CollisionRadius=40.00

    CollisionHeight=40.00

}
