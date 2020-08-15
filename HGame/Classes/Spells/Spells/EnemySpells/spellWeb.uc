//================================================================================
// spellWeb.
//================================================================================

//this is an old leftover file which isn't used anywhere -AdamJD

class spellWeb extends baseSpell;

var(VisualFX) ParticleFX fxHeadParticleEffect;
var(VisualFX) Class<ParticleFX> fxHeadParticleEffectClass;
var float fGravityEffect;
var Vector CurrentDir;
var Vector savedVelocity;
var bool bBounce;
var Vector currentVelocity;
var float GlobalSpeed;
var float fTimeToHitTarget;
var() float fIncreaseHitTimeDistance;
var() float fHitTimeIncrement;
var Vector hitDirection;
var Vector myHitLocation;
var float fWebLifetime;
var SpiderStickyWeb Web;

function PostBeginPlay ()
{
  Super.PostBeginPlay();
  fxHeadParticleEffect = Spawn(fxHeadParticleEffectClass);
  fxHeadParticleEffect.SetLocation(Location);
  fxHeadParticleEffect.SetRotation(fxHeadParticleEffect.Default.Rotation);
}

function Timer ()
{
}

function OnSpellShutdown ()
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
  return False;
}

function bounce (Vector HitNormal)
{
  SetLocation(OldLocation);
  Velocity *= 0.69999999;
  Velocity = MirrorVectorByNormal(Velocity,HitNormal);
  fxFlyParticleEffect.SetRotation(rotator(Velocity));
  CurrentDir = vector(Rotation);
  CurrentDir += HitNormal;
  SetRotation(rotator(CurrentDir));
}

function Vector GetTarget ()
{
  local Rotator AroundHarry;
  local Vector Target;

  AroundHarry = rotator(Location - PlayerHarry.Location);
  AroundHarry.Yaw = Rand(65534) + 1;
  Target = PlayerHarry.Location + vector(AroundHarry) * PlayerHarry.CollisionRadius;
  return Target;
}

function float getTime ()
{
  local float t;
  local float Distance;

  Distance = VSize(Location - PlayerHarry.Location);
  t = (Distance / fIncreaseHitTimeDistance) * fHitTimeIncrement;
  return t;
}

function float SetAngle ()
{
  local float Speed;
  local float Gravity;
  local float Distance;
  local float angle;
  local Rotator AroundHarry;
  local Vector Target;

  AroundHarry = rotator(Location - PlayerHarry.Location);
  AroundHarry.Yaw = Rand(65534) + 1;
  Target = PlayerHarry.Location + vector(AroundHarry) * PlayerHarry.CollisionRadius;
  Distance = VSize(Location - Target);
  GlobalSpeed = 300.0;
  if ( Distance > 550 )
  {
    Gravity = 300.0;
  } else //{
    if ( Distance > 475 )
    {
      Gravity = 200.0;
    } else {
      Gravity = 0.0;
    }
  //}
  Speed = GlobalSpeed;
  angle = Sin(Distance * Gravity / Speed * Speed) / 2;
  return angle;
}

function PlayerCutCapture ()
{
  GotoState('CutIdle');
}

function bool OnSpellHitWall (Actor aWall, Vector HitNormal)
{
  bBounce = False;
  return True;
}

function ProcessTouch (Actor Other, Vector HitLocation)
{
  if (  !Other.IsA('SpiderMarker') &&  !Other.IsA('largeSpider') &&  !Other.IsA('spellWeb') )
  {
    myHitLocation = HitLocation;
    GotoState('stateBouncing');
  }
}

function Landed (Vector HitNormal)
{
  bBounce = False;
  Web = Spawn(Class'SpiderStickyWeb',Owner,,OldLocation,rot(0,0,0));
  Web.fWebLifetime = fWebLifetime;
  OnSpellShutdown();
  Destroy();
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
  function BeginState ()
  {
    Velocity = ComputeTrajectoryByTime(Location,PlayerHarry.Location,getTime());
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
}

state stateBouncing
{
  event Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    Velocity.Z +=  -fGravityEffect * fTimeDelta;
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
  hitDirection = Normal(OldLocation - myHitLocation);
  bounce(hitDirection);
}

defaultproperties
{
    fxHeadParticleEffectClass=Class'HPParticle.Crabfireball'

    bBounce=True

    fIncreaseHitTimeDistance=150.00

    fHitTimeIncrement=0.50

    fxFlyParticleEffectClass=Class'HPParticle.Crabfire'

    fxHitParticleEffectClass=Class'HPParticle.SmokeExplo_01'

    // Physics=2
	Physics=PHYS_Falling

    // DrawType=0
	DrawType=DT_None
}
