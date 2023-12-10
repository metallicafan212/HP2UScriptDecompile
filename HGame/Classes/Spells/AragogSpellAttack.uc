//================================================================================
// AragogSpellAttack.
//================================================================================

class AragogSpellAttack extends baseSpell;

const BOOL_DEBUG_AI= false;
var(VisualFX) ParticleFX fxHeadParticleEffect;
var(VisualFX) Class<ParticleFX> fxHeadParticleEffectClass;
var() float fIncreaseHitTimeDistance;
var() float fHitTimeIncrement;
var int iDamage;
var Vector hitTarget;

function PostBeginPlay()
{
  Super.PostBeginPlay();
  fxFlyParticleEffect = Spawn(fxFlyParticleEffectClass);
  fxFlyParticleEffect.SetLocation(Location);
  fxFlyParticleEffect.SetRotation(fxFlyParticleEffect.Default.Rotation);
  PlaySound(Sound'Basilisk_spit_acid2',,,,,0.75);
  SetTimer(0.25,False);
}

function Timer()
{
  SetCollisionSize(20.0,20.0);
}

function OnSpellShutdown()
{
  if ( fxHeadParticleEffect != None )
  {
    fxHeadParticleEffect.Shutdown();
  }
}

function bool OnSpellHitHarry (Actor aHit, Vector HitLocation)
{
  return True;
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
}

function GetTarget()
{
}

function float getTime()
{
  local float t;
  local float Distance;

  Distance = VSize(Location - PlayerHarry.Location);
  t = (Distance / fIncreaseHitTimeDistance) * fHitTimeIncrement;
  return t;
}

function PlayerCutCapture()
{
  GotoState('CutIdle');
}

state CutIdle
{
begin:
  SetTimer(0.0,False);
  OnSpellShutdown();
  Destroy();
}

auto state stateIdle
{
begin:
  GotoState('StateFlying');
}

state StateFlying
{
  function BeginState()
  {
    Velocity = ComputeTrajectoryByTime(Location,hitTarget,0.75);
    LoopAnim('Idle');
  }
  
  function ProcessTouch (Actor Other, Vector HitLocation)
  {
    if (  !Other.IsA('SpiderMarker') &&  !Other.IsA('largeSpider') &&  !Other.IsA('spellWeb') )
    {
      Aragog(Owner).createWeb(OldLocation);
      if ( Other.IsA('harry') )
      {
        PlayerHarry.TakeDamage(iDamage,Pawn(Owner),Location,Velocity * 1,'AragogSpellAttack');
      }
      OnSpellShutdown();
      Destroy();
    }
  }
  
  function Landed (Vector HitNormal)
  {
    Aragog(Owner).createWeb(OldLocation);
    OnSpellShutdown();
    Destroy();
  }
  
  function HitWall (Vector HitNormal, Actor HitWall)
  {
    Super.HitWall(HitNormal,HitWall);
    OnSpellShutdown();
    Destroy();
  }
  
  event Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    if ( fxFlyParticleEffect != None )
    {
      fxFlyParticleEffect.SetLocation(Location);
    }
    if ( fxHeadParticleEffect != None )
    {
      fxHeadParticleEffect.SetLocation(Location);
    }
  }
 begin:
 loop:
  Sleep(1.0);
  goto ('Loop');
}

defaultproperties
{
    fIncreaseHitTimeDistance=150.00

    fHitTimeIncrement=0.50

    fxFlyParticleEffectClass=Class'HPParticle.AragogAttackFx'

    fxHitParticleEffectClass=Class'HPParticle.SmokeExplo_01'

    // Physics=2
	Physics=PHYS_Falling

    Mesh=SkeletalMesh'HPModels.skAragogAttackMesh'
}
