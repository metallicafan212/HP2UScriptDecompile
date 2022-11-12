//================================================================================
// spellFireLarge.
//================================================================================

class spellFireLarge extends baseSpell;

const BOOL_DEBUG_AI= false;
enum enumTargetZone {
  ZONE_ONE,
  ZONE_TWO
};

var(VisualFX) ParticleFX fxHeadParticleEffect;
var(VisualFX) Class<ParticleFX> fxHeadParticleEffectClass;
var(VisualFX) ParticleFX fxFlyParticleEffect;
var(VisualFX) Class<ParticleFX> fxFlyParticleEffectClass;
var enumTargetZone eTargetZone;
var float fGravityEffect;
var Vector CurrentDir;
var Vector savedVelocity;
var bool bBounce;
var Vector currentVelocity;
var float GlobalSpeed;
var float fIncreaseHitTimeDistance;
var float fHitTimeIncrement;
var float timeToTarget;
var Vector hitTarget;
var float GrenadeRadius;
var float GrenadeBounceInterval;
var float GrenadeGravity;
var float GrenadeExplosionGravity;
var int iDamage;
var FireballLarge Fireball;
var float smallDamage;

function PostBeginPlay()
{
  Super.PostBeginPlay();
  fxHeadParticleEffect = Spawn(fxHeadParticleEffectClass);
  fxHeadParticleEffect.SetLocation(Location);
  fxHeadParticleEffect.SetRotation(fxHeadParticleEffect.Default.Rotation);
  fxFlyParticleEffect = Spawn(fxFlyParticleEffectClass);
  fxFlyParticleEffect.SetLocation(Location);
  fxFlyParticleEffect.SetRotation(fxFlyParticleEffectClass.Default.Rotation);
}

function Timer()
{
  bBounce = False;
}

function bool IsRelevantToMover()
{
  return False;
}

function OnSpellShutdown()
{
  if ( fxHeadParticleEffect != None )
  {
    fxHeadParticleEffect.Shutdown();
  }
  if ( fxFlyParticleEffect != None )
  {
    fxFlyParticleEffect.Shutdown();
  }
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return False;
}

function ShootFireballs()
{
  local int I;
  //local Crabfire Fireball;
  local spellFireSmall smallFire;
  local int NumFireballs;
  local Rotator rotate_fireball;
  local Vector fireball_locn;
  local Vector harrys_head;

  harrys_head = PlayerHarry.Location;
  harrys_head.Z += PlayerHarry.CollisionHeight / 2;
  NumFireballs = 5;
  rotate_fireball = rotator(harrys_head - Location);
  rotate_fireball.Roll = 0;
  rotate_fireball.Pitch += (65536 * 10) / 4;
  PlayerHarry.ShakeView(0.3,200.0,200.0);
  // I = 0;
  // if ( I < NumFireballs )
  for(I = 0; I< NumFireballs; ++I) //for loop -AdamJD
  {
    rotate_fireball.Yaw = (65536 / NumFireballs) * I + Rand(10000);
    fireball_locn = Location;
    smallFire = Spawn(Class'spellFireSmall',Owner,,fireball_locn,rotate_fireball);
    // ++I;
    // goto JL0098;
  }
}

function bounce (Vector HitNormal)
{
  PlayerHarry.ClientMessage("In bounce.  Velocity :  " $ string(Velocity));
  SetLocation(OldLocation);
  Velocity *= 0.4;
  Velocity = MirrorVectorByNormal(Velocity,HitNormal);
  fxFlyParticleEffect.SetRotation(rotator(Velocity));
  CurrentDir = vector(Rotation);
  CurrentDir += HitNormal;
  SetRotation(rotator(CurrentDir));
}

function SetTargetZone (int Z)
{
  switch (Z)
  {
    case 0:
    eTargetZone =  ZONE_ONE;
    break;
    case 1:
    eTargetZone =  ZONE_TWO;
    break;
    default:
    eTargetZone =  ZONE_ONE;
    break;
  }
}

function float SetAngle()
{
  //local float Speed;
  local float fSpeed;
  local float Gravity;
  local float Distance;
  local float angle;
  local Rotator BehindHarry;
  //local Vector Target;
  local Vector vTarget;

  BehindHarry = rotator(Location - PlayerHarry.Location);
  vTarget = PlayerHarry.Location + (vector(BehindHarry) * (2 * PlayerHarry.CollisionRadius)); //UTPT forgot to add BODMAS which made firecrab fire go above Harry's head instead of hitting him -AdamJD 
  Distance = VSize(Location - vTarget);
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
  fSpeed = GlobalSpeed;
  angle = Sin(Distance * Gravity / (fSpeed * fSpeed)) / 2;
  return angle;
}

function float getTime()
{
  local float t;
  local float Distance;

  Distance = VSize(Location - PlayerHarry.Location);
  t = (Distance / fIncreaseHitTimeDistance) * fHitTimeIncrement;
  return t;
}

function Vector GetTarget()
{
  local Vector directionFromHarry;
  local Rotator rotationFromHarry;
  local int randomYaw;
  local int minYaw;
  local Rotator TempRot;
  local Vector TempVector;
  local Vector NewTarget;

  directionFromHarry = Normal(Owner.Location - PlayerHarry.Location);
  rotationFromHarry = rotator(directionFromHarry);
  minYaw = rotationFromHarry.Yaw - 4095;
  randomYaw = minYaw + Rand(12288);
  if ( Rand(2) == 0 )
  {
    randomYaw =  -randomYaw;
  }
  TempRot.Yaw = rotationFromHarry.Yaw + randomYaw;
  TempVector = vector(TempRot);
  NewTarget = PlayerHarry.Location + (TempVector * (Rand(100) + 100));
  return NewTarget;
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
    fGravityEffect = GrenadeGravity;
    hitTarget = GetTarget();
    timeToTarget = getTime();
    Velocity = (hitTarget - Location) / timeToTarget;
    Velocity.Z = ((hitTarget.Z - Location.Z) - (0.5 * fGravityEffect * (timeToTarget * timeToTarget))) / timeToTarget;
    SetTimer(GrenadeBounceInterval,False);
  }
  
  function Landed (Vector HitNormal)
  {
    GotoState('stateExplode');
  }
  
  function bool OnSpellHitHarry (Actor aHit, Vector HitLocation)
  {
    aHit.TakeDamage(iDamage,Instigator,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
    return True;
  }
  
  function bool OnSpellHitWall (Actor aWall, Vector HitNormal)
  {
    if ( bBounce == False )
    {
      PlayerHarry.ClientMessage("Hit Wall: bBounce is false ");
      GotoState('stateExplode');
    } else {
      PlayerHarry.ClientMessage("Hit Wall: bBounce is true");
      bounce(HitNormal);
    }
    return False;
  }
  
  event Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    if ( bBounce == False )
    {
      Velocity.Z += (fGravityEffect * fTimeDelta);
    } else {
      Velocity.Z += (fGravityEffect * fTimeDelta);
    }
    if ( fxFlyParticleEffect != None )
    {
      fxFlyParticleEffect.SetLocation(Location);
    }
    if ( fxHeadParticleEffect != None )
    {
      fxHeadParticleEffect.SetLocation(Location);
    }
  }
}

state stateExplode
{
begin:
  Fireball = Spawn(Class'FireballLarge',Owner,,Location,Rotation);
  Fireball.GrenadeRadius = GrenadeRadius;
  Fireball.iDamage = iDamage;
  Fireball.smallDamage = smallDamage;
  Fireball.GrenadeExplosionGravity = GrenadeExplosionGravity;
}

defaultproperties
{
    fxHeadParticleEffectClass=Class'HPParticle.Crabfireball'

    fxFlyParticleEffectClass=Class'HPParticle.Crabfire'

    bBounce=True

    fIncreaseHitTimeDistance=200.00

    fHitTimeIncrement=0.50

    iDamage=10

    // SpellType=24
	SpellType=SPELL_Fire

    fxHitParticleEffectClass=Class'HPParticle.SmokeExplo_01'

    // DrawType=0
	DrawType=DT_None
}
