//================================================================================
// spellAcidSpit.
//================================================================================

class spellAcidSpit extends baseSpell;

var float FloorZ;
var() int iDamage;
var bool bSpawnPool;
var float fPoolShrinkTimeMult;

function PostBeginPlay()
{
  Super.PostBeginPlay();
  InitSpell(None,None);
}

event BeginEvent()
{
}

event EndEvent()
{
}

event KilledBy (Pawn EventInstigator)
{
}

function OnSpellShutdown()
{
}

function HitWall (Vector HitNormal, Actor Wall)
{
  local AcidSpitPool A;
  local Rotator R;

  if ( Location.Z - CollisionHeight / 2 - FloorZ > 10 )
  {
    Velocity = MirrorVectorByNormal(Velocity,HitNormal);
    Velocity *= 0.25;
    if ( VSize(Velocity) < 100 )
    {
      Velocity *= 100 / VSize(Velocity);
    }
  } else {
    if ( bSpawnPool )
    {
      A = Spawn(Class'AcidSpitPool');
      R.Yaw = Rand(65536);
      A.SetRotation(R);
      if ( fPoolShrinkTimeMult > 0 )
      {
        A.fShrinkTime *= fPoolShrinkTimeMult;
      }
    }
    Destroy();
  }
}

auto state StateFlying
{
  function BeginState()
  {
    Velocity = vector(Rotation) * Speed;
  }
  
  event Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    if ( fxFlyParticleEffect != None )
    {
      fxFlyParticleEffect.SetLocation(Location);
    }
  }
  begin:
}

function ProcessTouch (Actor Other, Vector HitLocation)
{
  if ( Other.IsA('harry') && (iDamage > 0) )
  {
    PlayerHarry.TakeDamage(iDamage,None,Location,Vec(0.0,0.0,0.0),'AcidHit');
    CreateHitEffects(Other,HitLocation);
    Destroy();
    return;
  }
  Super.ProcessTouch(Other,HitLocation);
}

defaultproperties
{
    iDamage=25

    bSpawnPool=True

    // SpellType=13
	SpellType=SPELL_Flipendo

    SpellIcon=None

    fxFlyParticleEffectClass=Class'HPParticle.SnakeVenomFX'

    fxHitParticleEffectClass=Class'HPParticle.Flip_hit'

    SpellIncantation="spells1"

    QuietSpellIncantation="spells10"

    Speed=1000.00

    ImpactSound=Sound'HPSounds.Adv11_COS.ss_COS_venom_hit_Harry'

    // Physics=2
	Physics=PHYS_Falling

    // DrawType=0
	DrawType=DT_None

    CollisionRadius=10.00

    CollisionHeight=10.00

    bBounce=True
}
