//================================================================================
// spellSwordFire.
//================================================================================

class spellSwordFire extends baseSpell;

var() float fNormalDamage;
var() float fFullDamage;
var() float fNormalScale;
var() float fFullScale;
var float fCurrentScale;
var() float fHalfLife;

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

function bool OnSpellHitWall (Actor aWall, Vector HitNormal)
{
  if ( harry(Level.PlayerHarryActor).bMSword )
  {
    harry(Level.PlayerHarryActor).PlaySound(Sound'Big_whomp2',SLOT_None,RandRange(1.0,1.5),False,500.0,RandRange(0.5,1.0));
    Spawn(Class'DustCloud05_lrg',self,,Location);
    harry(Level.PlayerHarryActor).ShakeView(1.0,150.0,150.0);
    harry(Level.PlayerHarryActor).AutoHitAreaEffect(300.0);
  }
  return Super.OnSpellHitWall(aWall,HitNormal);
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  if ( harry(Level.PlayerHarryActor).bMSword )
  {
    aHit.Spawn(Class'ChessExplo');
    aHit.Spawn(Class'CloudPuffs',,,,rot(0,8000,0));
    aHit.Spawn(Class'DobbyBurst');
    aHit.Spawn(Class'DustCloud04_med');
    aHit.Spawn(Class'Verd_hit');
    aHit.PlaySound(Sound'Dueling_EXP_smack',SLOT_None,,,,RandRange(0.69999999,1.25));
    aHit.PlaySound(Sound'health_boost1',SLOT_None,,,,RandRange(0.69999999,1.25));
    aHit.PlaySound(Sound'pickup_wig_bark',SLOT_None,,,,RandRange(0.69999999,1.25));
    aHit.Destroy();
    CreateHitEffects(aHit,vHitLocation);
    return False;
  }
  if ( aHit.IsA('GenericColObj') )
  {
    return True;
  }
  if (  !aHit.bBlockActors )
  {
    return False;
  }
  return True;
}

function PlayIncantationSound (Actor Instigator)
{
}

function DamagePercent (float Scale)
{
  local float scale2;

  Damage = fNormalDamage + (fFullDamage - fNormalDamage) * Scale;
  scale2 = fNormalScale + (fFullScale - fNormalScale) * Scale;
  fxFlyParticleEffect.SizeWidth.Base = fxFlyParticleEffect.Default.SizeWidth.Base * scale2;
  fxFlyParticleEffect.SizeLength.Base = fxFlyParticleEffect.Default.SizeLength.Base * scale2;
  fxFlyParticleEffect.ParticlesPerSec.Base = fxFlyParticleEffect.Default.ParticlesPerSec.Base * scale2;
  fxFlyParticleEffect.SourceHeight.Base = fxFlyParticleEffect.Default.SourceHeight.Base * scale2;
  fxFlyParticleEffect.SourceWidth.Base = fxFlyParticleEffect.Default.SourceWidth.Base * scale2;
  fxFlyParticleEffect.SourceDepth.Base = fxFlyParticleEffect.Default.SourceDepth.Base * scale2;
  if ( Scale < 0.333 )
  {
    PlaySound(Sound'sword_shoot',SLOT_Interact);
  } else //{
    if ( Scale < 0.667 )
    {
      PlaySound(Sound'sword_shoot_big',SLOT_Interact);
    } else {
      PlaySound(Sound'sword_shoot_biggest',SLOT_Interact);
    }
  //}
}

auto state StateFlying
{
  function BeginState()
  {
    Velocity = vector(Rotation) * Speed;
  }
  
  event Tick (float fTimeDelta)
  {
    //local float Scale;
	local float fScale;
  
    Super.Tick(fTimeDelta);
    if ( fxFlyParticleEffect != None )
    {
      fxFlyParticleEffect.SetLocation(Location);
      if ( False )
      {
        fScale = 1.0 / Exp(fTimeDelta / fHalfLife);
        fCurrentScale *= fScale;
        fxFlyParticleEffect.SizeWidth.Base *= fScale;
        fxFlyParticleEffect.SizeLength.Base *= fScale;
        fxFlyParticleEffect.ParticlesPerSec.Base *= fScale;
        fxFlyParticleEffect.SourceHeight.Base *= fScale;
        fxFlyParticleEffect.SourceWidth.Base *= fScale;
        fxFlyParticleEffect.SourceDepth.Base *= fScale;
        fxFlyParticleEffect.AlphaStart.Base *= fScale;
        fxFlyParticleEffect.AlphaEnd.Base *= fScale;
        Damage *= fScale;
      }
    }
  }
  begin:
}

defaultproperties
{
    fNormalDamage=3.00

    fFullDamage=23.00

    fNormalScale=0.50

    fFullScale=6.00

    fCurrentScale=1.00

    fHalfLife=0.75

    // SpellType=13
	SpellType=SPELL_Flipendo

    SpellIcon=None

    SeekSpeed=50.00

    fxFlyParticleEffectClass=Class'HPParticle.SwordFireball'

    fxHitParticleEffectClass=Class'HPParticle.Flip_hit'

    SpellIncantation="spells1"

    QuietSpellIncantation="spells10"

    // DrawType=0
	DrawType=DT_None

    CollisionRadius=35.00

    CollisionHeight=35.00
}
