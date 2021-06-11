//================================================================================
// TentaculaLimb.
//================================================================================

class TentaculaLimb extends HChar;

var Vector vTargetDir;
var float relYaw;
var float TooClose;
var float HarryDamageTimer;
var float TestTime;
var float idleTime;
var float stunnedTime;
var float MinIdleTime;
var float MaxIdleTime;
var float MinStunnedTime;
var float MaxStunnedTime;
var int DamageToHarry;
var bool bGood;
var TentaculaSpell spellBox;
var GenericColObj headBox;

function ColObjTouch (Actor Other, GenericColObj ColObj)
{
  if ( harry(Other) == None )
  {
    return;
  }
  if ( HarryDamageTimer > 0.2 )
  {
    HarryDamageTimer = 0.0;
    harry(Other).TakeDamage(DamageToHarry,self,ColObj.Location,vect(0.00,0.00,0.00),'None');
  }
  if ( (GetStateName() != 'stateTwitch') && (GetStateName() != 'stateDie') && (GetStateName() != 'stateStun') && (GetStateName() != 'stateStunned') && (GetStateName() != 'stateBackToIdle') )
  {
    GotoState('stateBackToIdle');
  }
}

function PlaySoundOuch ()
{
  switch (Rand(3))
  {
    case 0:
    PlaySound(Sound'VT_big_ouch1');
    break;
    case 1:
    PlaySound(Sound'VT_big_ouch2');
    break;
    case 2:
    PlaySound(Sound'VT_big_ouch3');
    break;
    default:
    break;
  }
}

function PlaySoundWilt ()
{
  switch (Rand(8))
  {
    case 0:
    PlaySound(Sound'VT_big_wilt');
    break;
    default:
    break;
  }
}

function PlaySoundAttack ()
{
  switch (Rand(3))
  {
    case 0:
    PlaySound(Sound'VT_big_attack1');
    break;
    case 1:
    PlaySound(Sound'VT_big_attack2');
    break;
    case 2:
    PlaySound(Sound'VT_big_attack3');
    break;
    default:
    break;
  }
}

function Tick (float dtime)
{
  HarryDamageTimer += dtime;
  if ( bGood )
  {
    TestTime = 0.0;
    return;
  }
  TestTime += dtime;
  if ( (TestTime > 1) && (headBox.Owner != None) )
  {
    headBox.AnimBone = 0;
    headBox.SetOwner(None);
  }
}

auto state stateIdle
{
begin:
  LoopAnim('Idle');
  idleTime = RandRange(MinIdleTime,MaxIdleTime);
  if ( idleTime <= 0 )
  {
    idleTime = 0.01;
  }
  Sleep(idleTime);
  AnimRate = 0.0;
  GotoState('statePatrol');
}

state stateBackToIdle
{
begin:
  PlayAnim('Idle',,0.5);
  FinishAnim();
  GotoState('stateIdle');
}

state statePatrol
{
begin:
  if ( (Owner != None) && (Tentacula(Owner).AttackLimb != self) )
  {
    GotoState('stateIdle');
  }
  vTargetDir = PlayerHarry.Location - Location;
  if ( VSize(vTargetDir) <= TooClose )
  {
    PlaySoundAttack();
    PlayAnim('Attack');
    FinishAnim();
  }
  GotoState('stateIdle');
}

state stateStun
{
begin:
  PlaySoundOuch();
  PlayAnim('stun');
  FinishAnim();
  GotoState('stateStunned');
}

state stateStunned
{
begin:
  PlaySoundWilt();
  LoopAnim('Stunned');
  stunnedTime = RandRange(MinStunnedTime,MaxStunnedTime);
  if ( stunnedTime <= 0 )
  {
    stunnedTime = 0.01;
  }
  Sleep(stunnedTime);
  FinishAnim();
  GotoState('stateWake');
}

state stateWake
{
begin:
  PlayAnim('wake');
  FinishAnim();
  GotoState('stateIdle');
}

state stateDie
{
begin:
  PlaySoundOuch();
  PlayAnim('Die');
  FinishAnim();
  GotoState('stateTwitch');
}

state stateTwitch
{
begin:
  LoopAnim('twitch');
  Sleep(10.0);
  FinishAnim();
  GotoState('stateTwitch');
}

defaultproperties
{
    bGood=True

    SightRadius=100.00

    // Physics=2
	Physics=PHYS_Falling

    Mesh=SkeletalMesh'HPModels.skvenomous2Mesh'

    bCollideActors=False

    bCollideWorld=False

    bBlockActors=False

    bRotateToDesired=False
}
