//================================================================================
// BowTruckleTwig.
//================================================================================

class BowTruckleTwig extends HProp;

var Class<ParticleFX> Particles;
var int Damage;
var float MaxLiveTime;

function Touch (Actor Other)
{
  Super.Touch(Other);
  if ( Other == PlayerHarry )
  {
    PlayerHarry.TakeDamage(Damage,self,Location,vect(0.00,0.00,0.00),'None');
    DestroyTwig();
  }
}

function DestroyTwig()
{
  local Actor p;

  p = Spawn(Particles,,,Location,rot(0,0,0));
  PlaySoundMiss(p);
  Destroy();
}

function float PlaySoundMiss (Actor p)
{
  local float duration;
  local Sound snd;

  switch (Rand(3))
  {
    case 0:
    snd = Sound'BOW_miss_01';
    break;
    case 1:
    snd = Sound'BOW_miss_02';
    break;
    case 2:
    snd = Sound'BOW_miss_03';
    break;
    default:
    snd = None;
    break;
  }
  duration = GetSoundDuration(snd);
  p.PlaySound(snd);
  return duration;
}

auto state twigno
{
  function Tick (float DeltaTime)
  {
    MaxLiveTime -= DeltaTime;
    if ( MaxLiveTime < 0 )
    {
      DestroyTwig();
    }
  }
  
  function HitWall (Vector HitNormal, Actor Wall)
  {
    DestroyTwig();
  }
 
 begin:
 loop:
  Sleep(1.0);
  goto ('Loop');
}

defaultproperties
{
    // Physics=2
	Physics=PHYS_Falling

    AmbientGlow=200

    CollisionRadius=5.00

    CollisionHeight=5.00

    bBlockActors=False

    bBlockPlayers=False

    bProjTarget=False

    bBlockCamera=False

    bBounce=True
}
