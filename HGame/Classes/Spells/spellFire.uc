//================================================================================
// spellFire.
//================================================================================

//this is an old leftover file which isn't used anywhere -AdamJD

class spellFire extends baseSpell;

const BOOL_DEBUG_AI= false;
enum enumTargetZone {
  ZONE_ONE,
  ZONE_TWO,
  ZONE_THREE,
  ZONE_FOUR
};
var enumTargetZone eTargetZone;
var float fGravityEffect;
var Vector CurrentDir;
var Vector savedVelocity;
var bool bBounce;
var Vector currentVelocity;


function PostBeginPlay ()
{
  Super.PostBeginPlay();
  CurrentDir = Normal(vector(Rotation) + Vec(0.0,0.0,0.41));
  SetRotation(rotator(CurrentDir));
}

function Timer ()
{
  bBounce = False;
}

function OnSpellShutdown ()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
}

function bounce (Vector HitNormal)
{
  SetLocation(OldLocation);
  Velocity *= 0.89999998;
  Velocity = MirrorVectorByNormal(Velocity,HitNormal);
  fxFlyParticleEffect.SetRotation(rotator(Velocity));
  CurrentDir = vector(Rotation);
  CurrentDir += HitNormal;
  SetRotation(rotator(CurrentDir));
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
    Velocity = vector(Rotation) * Speed;
    currentVelocity = Velocity;
    if ( BOOL_DEBUG_AI )
    {
      PlayerHarry.ClientMessage("Begin Velocity =  " $ string(Velocity));
    }
    SetTimer(5.0,False);
  }
  
  function ProcessTouch (Actor Other, Vector HitLocation)
  {
    if ( bBounce == False )
    {
      if ( Pawn(Other) == Instigator )
      {
        return;
      }
      if ( Other.IsA('harry') )
      {
        Other.TakeDamage(5,Instigator,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
        CreateHitEffects(Other,HitLocation);
      } else {
        Spawn(Class'Fireball',,,Location);
      }
      OnSpellShutdown();
      Destroy();
    } else {
      if ( Pawn(Other) == Instigator )
      {
        OnSpellShutdown();
        Destroy();
      }
      if ( Other.IsA('harry') )
      {
        Other.TakeDamage(10,Instigator,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
        CreateHitEffects(Other,HitLocation);
        OnSpellShutdown();
        Destroy();
      }
    }
  }
  
  function HitWall (Vector HitNormal, Actor HitWall)
  {
    if ( bBounce == False )
    {
      Spawn(Class'Fireball',,,Location);
      Super.HitWall(HitNormal,HitWall);
    } else {
      bounce(HitNormal);
    }
  }
  
  event Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    if ( bBounce == False )
    {
      Velocity.Z +=  -fGravityEffect * fTimeDelta;
    } else {
      Velocity.Z +=  -fGravityEffect / 2 * fTimeDelta;
    }
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
    fGravityEffect=200.00

    bBounce=True

    // SpellType=24
	SpellType=SPELL_Fire

    fxFlyParticleEffectClass=Class'HPParticle.Crabfire'

    fxHitParticleEffectClass=Class'HPParticle.SmokeExplo_01'

    Speed=300.00

    // DrawType=0
	DrawType=DT_None
}
