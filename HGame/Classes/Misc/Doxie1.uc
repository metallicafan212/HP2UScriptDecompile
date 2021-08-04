//================================================================================
// Doxie1.
//================================================================================

//this is a HP1 leftover file -AdamJD

class Doxie1 extends HChar;

var() bool bLookForHarry;
var Vector stoppoint;
var Vector harryat;
var Vector home;
var Vector startposition;
var Vector tempvelocity;
var Rotator TempRot;
var float oldYaw;
var float OldAirSpeed;
var float strength;
var() float startstrength;
var() bool bAttackOnSight;
var() float nDoxieDamage;
var() bool bMoveAround;
var() float nAttackDelay;
var BaseCam pcam;
var float fDestroyFlyTime;
var ParticleFX ParticleFXActor;
var() float fParticleTrailLife;

function PostBeginPlay()
{
  Super.PostBeginPlay();
  // SetPhysics(4);
  SetPhysics(PHYS_Flying);
  SetCollision(True,True,True);
  ParticleFXActor = Spawn(Class'Doxie_fx',,,Location);
  ParticleFXActor.Lifetime.Base = fParticleTrailLife;
  home = Location;
  startposition = Location;
  strength = startstrength;
  OldAirSpeed = AirSpeed;
}

function float GetHealth()
{
  return strength / startstrength;
}

event Tick (float DeltaTime)
{
  Super.Tick(DeltaTime);
  ParticleFXActor.SetLocation(Location);
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  GotoState('PreMovePrep');
}

auto state startstate
{
begin:
  if ( bMoveAround )
  {
    GotoState('patrol');
  } else {
    GotoState('idlehover');
  }
}

state idlehover
{
  event Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    ParticleFXActor.SetLocation(Location);
    if ( bAttackOnSight )
    {
      if ( CanSee(PlayerHarry) )
      {
        GotoState('PreMovePrep');
      }
    }
  }
 begin:
  LoopAnim('hover');
 loophere:
  Sleep(1.0);
  goto ('loophere');
}

state patrol
{
  event Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    ParticleFXActor.SetLocation(Location);
    if ( bAttackOnSight )
    {
      if ( CanSee(PlayerHarry) )
      {
        GotoState('PreMovePrep');
      }
    }
  }
  
  function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
  {
    strength = strength - 1;
    PlayerHarry.ClientMessage("Doxie Hit.  Strength:" @ string(strength));
    EndState();
    GotoState('KnockBack');
    return True;
  }
  
  function EndState()
  {
    LastLevelTime = 0.0;
  }
  
}

state PreMovePrep
{
  function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
  {
    strength = strength - 1;
    PlayerHarry.ClientMessage("Doxie Hit.  Strength:" @ string(strength));
    EndState();
    GotoState('KnockBack');
    return True;
  }
  
 begin:
  if ( nAttackDelay > 0 )
  {
    TurnToward(PlayerHarry);
    LoopAnim('hover');
    Sleep(nAttackDelay);
  }
  PlayAnim('hover_to_fly');
  FinishAnim();
  GotoState('MoveToScowl');
}

state MoveToScowl
{
  function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
  {
    strength = strength - 1;
    PlayerHarry.ClientMessage("Doxie Hit.  Strength:" @ string(strength));
    EndState();
    GotoState('KnockBack');
    return True;
  }
  
  event Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    ParticleFXActor.SetLocation(Location);
    if ( VSize(Location - PlayerHarry.Location) < 128 )
    {
      GotoState('SwoopAttacking');
    } else {
      GotoState('MoveToScowl');
    }
  }
  
  function Bump (Actor Other)
  {
    if ( Other == PlayerHarry )
    {
      PlayerHarry.TakeDamage(nDoxieDamage, self,Location,Location * 0,'exploded');
      GotoState('Backoff');
    }
  }
  
 begin:
  PlayerHarry.ClientMessage("Entered State Move To Scowl");
  LoopAnim('Fly');
  MoveTo(PlayerHarry.Location);
  GotoState('SwoopAttacking');
}

state SwoopAttacking
{
  function Bump (Actor Other)
  {
    if ( Other == PlayerHarry )
    {
      Disable('Bump');
      PlayerHarry.TakeDamage(nDoxieDamage, self,Location,Location * 0,'exploded');
      GotoState('Backoff');
    }
  }
  
  function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
  {
    strength = strength - 1;
    PlayerHarry.ClientMessage("Doxie Hit.  Strength:" @ string(strength));
    EndState();
    GotoState('KnockBack');
    return True;
  }
  
 begin:
  harryat = PlayerHarry.Location;
  FinishAnim();
  PlayAnim('hover_to_fly');
  FinishAnim();
  LoopAnim('Fly');
  Enable('Bump');
  MoveTo(harryat);
  GotoState('Backoff');
}

state KnockBack
{
begin:
  PlayerHarry.ClientMessage("Doxie entered state Knockback");
  tempvelocity = -1 * Velocity;
  tempvelocity.Z += 160.0;
  PlayAnim('hover_to_spin');
  Velocity = tempvelocity;
  FinishAnim();
  LoopAnim('spin');
  if ( strength <= 0 )
  {
    // goto JL009A;
	//KW left this empty? -AdamJD
  }
  else
  {
    switch (Rand(3))
    {
	 //KW left these empty? -AdamJD
     case 1:
      break;
     case 2:
      break;
     default:
      break;
    }
  }
  switch (Rand(3))
  {
// JL009A:
	//KW left these empty? -AdamJD
    case 1:
    break;
    case 2:
    break;
    default:
    break;
  }
  Sleep(1.0);
  FinishAnim();
  home = Location;
  LoopAnim('hover');
  if ( strength <= 0 )
  {
    EndState();
    GotoState('KillDoxie');
  } else {
    GotoState('Backoff');
  }
}

state Backoff
{
begin:
  PlayerHarry.ClientMessage("Doxie entered state Backoff");
  Disable('Bump');
  LoopAnim('hover');
  MoveTo(home);
  GotoState('MoveToScowl');
}

state KillDoxie
{
  event Tick (float Delta)
  {
    local Vector Dest;
  
    fDestroyFlyTime -= Delta;
    Move((PlayerHarry.CameraToWorld(vect(0.10,0.10,32.00)) - Location) / (fDestroyFlyTime / Delta));
  }
  
 begin:
  PlayerHarry.ClientMessage("Doxie entered state KillDoxie");
  foreach AllActors(Class'BaseCam',pcam)
  {
    // goto JL0042;
	break;
  }
  LoopAnim('Fly');
  TurnToward(pcam);
  Disable('Touch');
  bProjTarget = False;
  // eVulnerableToSpell = 0;
  eVulnerableToSpell = SPELL_None;
  bCollideWorld = False;
  fDestroyFlyTime = 0.25;
  // if ( fDestroyFlyTime > byte(0) )
  while ( fDestroyFlyTime > 0 )
  {
    Sleep(0.1);
    // goto JL007D;
  }
  ParticleFXActor.Destroy();
  Destroy();
}

defaultproperties
{
    bLookForHarry=True

    startstrength=1.00

    nDoxieDamage=5.00

    bMoveAround=True

    fParticleTrailLife=2.00

    AirSpeed=200.00

    AccelRate=4000.00

    AirControl=2.00

    BaseEyeHeight=30.00

    EyeHeight=30.00

    MenuName="Doxie1"

    IdleAnimName=hover

    // eVulnerableToSpell=13
	eVulnerableToSpell=SPELL_Flipendo

    Mesh=None

    DrawScale=2.00

    AmbientGlow=200

    Mass=20.00
}
