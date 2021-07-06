//================================================================================
// spellFireSmall.
//================================================================================

class spellFireSmall extends baseSpell;

const BOOL_DEBUG_AI= false;
var float fGravityEffect;
var Vector CurrentDir;
var Vector currentVelocity;
var float GlobalSpeed;
var float fIncreaseHitTimeDistance;
var float fHitTimeIncrement;
var int iDamage;
var Vector hitTarget;
var int iAccuracyMin;
var int iAccuracyMax;
var float GrenadeExplosionGravity;

function PostBeginPlay()
{
  Super.PostBeginPlay();
  fxFlyParticleEffect = Spawn(fxFlyParticleEffectClass);
  fxFlyParticleEffect.SetLocation(Location);
  fxFlyParticleEffect.SetRotation(fxFlyParticleEffect.Default.Rotation);
  CurrentDir = Normal(vector(Rotation) + Vec(0.0,0.0,0.41));
  SetRotation(rotator(CurrentDir));
}

function OnSpellShutdown()
{
}

function bool IsRelevantToMover()
{
  return False;
}

function float getTime()
{
  local float t;
  local float Distance;

  Distance = VSize(Location - PlayerHarry.Location);
  t = (Distance / fIncreaseHitTimeDistance) * fHitTimeIncrement; 
  return t;
}

function bool OnSpellHitHarry (Actor aHit, Vector HitLocation)
{
  aHit.TakeDamage(iDamage,Instigator,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
  return True;
}

function bool OnSpellHitHPawn (Actor aHit, Vector HitLocation)
{
  Spawn(Class'FireballOnHarry',,,Location);
  return True;
}

function bool OnSpellHitWall (Actor aWall, Vector HitNormal)
{
  Spawn(Class'Fireball',,,Location);
  return True;
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
  vTarget = PlayerHarry.Location + vector(BehindHarry) * (2 * PlayerHarry.CollisionRadius); //UTPT forgot to add BODMAS which made firecrab fire go above Harry's head instead of hitting him -AdamJD 
  Distance = VSize(Location - vTarget);
  GlobalSpeed = 300.0;
  if ( Distance > 390.0 )
  {
    Gravity = 350.0;
    GlobalSpeed = 350.0;
  } else //{
    if ( Distance > 356 )
    {
      Gravity = 300.0;
    } else {
      Gravity = 200.0;
    }
  //}
  fSpeed = GlobalSpeed;
  angle = Sin(Distance * Gravity / fSpeed * fSpeed) / 2;
  return angle;
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
  randomYaw = Rand(65536);
  TempRot.Yaw = randomYaw;
  TempVector = vector(TempRot);
  NewTarget = PlayerHarry.Location + (TempVector * (Rand(iAccuracyMax) + iAccuracyMin)); 
  return NewTarget;
}

function PlayerCutCapture()
{
  GotoState('CutIdle');
}

state CutIdle
{
begin:
  OnSpellShutdown();
  Destroy();
}

auto state stateIdle
{
begin:
  if ( Owner.IsA('firecrabLarge') )
  {
    GotoState('StateExplosion');
  } else {
    GotoState('StateFlying');
  }
}

state StateFlying
{
  function BeginState()
  {
    // SetPhysics(2);
	SetPhysics(PHYS_Falling);
    Velocity = ComputeTrajectoryByTime(Location,GetTarget(),getTime());
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

state StateExplosion
{
  function BeginState()
  {
    CurrentDir = vector(Rotation);
    fGravityEffect = GrenadeExplosionGravity;
    CurrentDir.Z = SetAngle();
    Speed = GlobalSpeed;
    SetRotation(rotator(CurrentDir));
    Velocity = vector(Rotation) * Speed;
    currentVelocity = Velocity;
  }
  
  event Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    Velocity.Z += fGravityEffect * fTimeDelta;
    if ( fxFlyParticleEffect != None )
    {
      fxFlyParticleEffect.SetLocation(Location);
    }
  }
 begin:
  Sleep(1.0);
  goto ('Loop');
}

defaultproperties
{
    fIncreaseHitTimeDistance=200.00

    fHitTimeIncrement=0.50

    iDamage=5

    // SpellType=24
	SpellType=SPELL_Fire

    fxFlyParticleEffectClass=Class'HPParticle.Crabfire'

    fxHitParticleEffectClass=Class'HPParticle.SmokeExplo_01'

    Speed=300.00

    // DrawType=0
	DrawType=DT_None
}
