//================================================================================
// Bludger.
//================================================================================

class Bludger extends QuidditchPawn;

const NUM_HIT_SOUNDS= 2;
const fMinTimeBetweenDamages= 1.0;
var Sound HitSounds[2];
var(Quidditch) int Damage;
var float fTimeOfLastDamage;

function PostBeginPlay()
{
  if ( Mesh == None )
  {
    Mesh = SkeletalMesh'skQuidditchBludgerMesh';
  }
  if ( ParticleTrail == None )
  {
    ParticleTrail = Class'Bludger_FX';
  }
  Super.PostBeginPlay();
  bRecycle = True;
  fTimeOfLastDamage = 0.0;
}

function Touch (Actor Other)
{
  local Pawn Subject;

  Subject = Pawn(Other);
  if ( (Subject != None) && (Subject != Emitter) )
  {
    if ( Level.TimeSeconds - fTimeOfLastDamage >= 1.0 )
    {
      if ( bMine )
      {
        if ( Other == Target )
        {
          ExplodeMine();
          Subject.TakeDamage(Damage,self,Location,100 * Normal(Velocity),'Bludgered');
          fTimeOfLastDamage = Level.TimeSeconds;
          FinishMine();
        }
      } else {
        PlaySound(HitSounds[Rand(2)],SLOT_Interact,,,2000.0);
        Subject.TakeDamage(Damage,self,Location,100 * Normal(Velocity),'Bludgered');
        fTimeOfLastDamage = Level.TimeSeconds;
        Super.Touch(Other);
      }
    }
  }
}

defaultproperties
{
    Damage=10

    ParticleTrail=Class'HPParticle.Bludger_FX'

    HaloClass=Class'HPParticle.Bludger_Halo'

    PursuitSound=Sound'HPSounds.Quidditch_sfx.bludger_loop'

    IPSpeed=800.00

    Mesh=SkeletalMesh'HProps.skQuidditchBludgerMesh'

    CollisionRadius=50.00

    CollisionHeight=50.00
}
