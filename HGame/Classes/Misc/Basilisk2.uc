//================================================================================
// Basilisk2.
//================================================================================

//this is an old basilisk file -AdamJD

class Basilisk2 extends baseBasilisk;

const HeadAttackCount= 6;
var() name HoleMarkerCommonTag;
var() float IdleTimerStart;
var() float AttackTime;
var Vector LastNoiseLoc;
var float TimeSinceLastHearNoise;
var float HarryMakingNoiseTimer;
var int ActualYaw;
var int startYaw;
var int DesiredYaw;
var int YawTime;
var int YawTimeDest;
var() float HeadYawRate;
var() float HeadAttackNearest;
var() float HeadAttackFarthest;
var name HeadAttackAnimName[6];
var Rotator TempRot;

function PostBeginPlay ()
{
  local GenericColObj A;

  Super.PostBeginPlay();
  A = Spawn(Class'GenericColObj',self);
  A.AttachToOwner('Bone_Tent03');
  A = Spawn(Class'GenericColObj',self);
  A.AttachToOwner('Bone_Tent05');
  // A.eVulnerableToSpell = 13;
  A.eVulnerableToSpell = SPELL_Flipendo;
  A = Spawn(Class'GenericColObj',self);
  A.AttachToOwner('Bone_Tent07');
  A = Spawn(Class'GenericColObj',self);
  A.AttachToOwner('Bone_Tent09');
  A = Spawn(Class'GenericColObj',self);
  A.AttachToOwner('Bone_Tent11');
  // A.eVulnerableToSpell = 13;
  A.eVulnerableToSpell = SPELL_Flipendo;
  A.bIsHead = True;
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  if ( IsInState('stateIdle') )
  {
    PlayerHarry.HearHarryRecipient = self;
    GotoState('stateWaiting');
  }
}

function RotateTo (int Yaw, optional float Time, optional float Rate)
{
  ActualYaw = ActualYaw & 65535;
  Yaw = Yaw & 65535;
  DesiredYaw = Yaw;
  startYaw = ActualYaw;
  if ( Abs(DesiredYaw - startYaw) > 32767 )
  {
    if ( DesiredYaw > startYaw )
    {
      DesiredYaw -= 65536;
    } else {
      DesiredYaw += 65536;
    }
  }
  YawTime = 0;
  /*
  if ( Time != 0 )
  {
    YawTimeDest = Time = } else {;
    if ( Rate != byte(0) )
    {
      YawTimeDest = Abs(byte(DesiredYaw - startYaw)) * byte(360) / byte(65536) / Rate = } else {;
      YawTimeDest = Abs(byte(DesiredYaw - startYaw)) * byte(360) / byte(65536) / HeadYawRate = bRotateToDesired = False;
      // There are 2 jump destination(s) inside the last statement!
    }
  }
  */
  
  if ( Time != 0 )
  {
    YawTimeDest = Time;
  }
  else if ( Rate != 0 )
  {
	YawTimeDest = Abs(DesiredYaw - startYaw) * 360 / 65536 / Rate; 
  }
  else 
  {
    YawTimeDest = Abs(DesiredYaw - startYaw) * 360 / 65536 / HeadYawRate;
  }
  bRotateToDesired = False;
}

function RotateToHarry (optional float Time, optional float Rate)
{
  RotateTo(IntRotToHarry(),Time,Rate);
}

function float IntRotToHarry ()
{
  local int YawToHarry;

  YawToHarry = rotator((PlayerHarry.Location - Location) * vect(1.00,1.00,0.00)).Yaw - Rotation.Yaw + 131072 & 65535;
  return YawToHarry;
}

function Tick (float dtime)
{
  TimeSinceLastHearNoise += dtime;
  if ( TimeSinceLastHearNoise < 0.69999999 )
  {
    HarryMakingNoiseTimer += dtime;
  } else {
    HarryMakingNoiseTimer = 0.0;
  }
  if (  !bRotateToDesired )
  {
    if ( YawTime < YawTimeDest )
    {
      YawTime += dtime;
	  if( YawTime > YawTimeDest )
      {
        YawTime = YawTimeDest;
      }
      ActualYaw = startYaw + (DesiredYaw - startYaw) * EaseBetween(YawTime / YawTimeDest);
	} else {
      ActualYaw = DesiredYaw;
    }
    SetBasilYaw(ActualYaw);
  }
}

function SetBasilYaw (int Yaw)
{
  local Rotator R;

  R = Rotation;
  R.Yaw = Yaw;
  SetRotation(R);
  ActualYaw = Yaw;
  DesiredYaw = Yaw;
  DesiredRotation = R;
}

function HideBasil ()
{
  SetLocation(Location + vect(0.00,0.00,-200.00));
}

function ColObjTouch (Actor Other, GenericColObj ColObj)
{
  if ( harry(Other) == None )
  {
    return;
  }
  if ( ColObj.bIsHead )
  {
    harry(Other).TakeDamage(HeadDamage,self,ColObj.Location,vect(0.00,0.00,0.00),'None');
  } else {
    harry(Other).TakeDamage(TailDamage,self,ColObj.Location,vect(0.00,0.00,0.00),'None');
  }
}

function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
{
  GotoState('stateHit');
  return True;
}

auto state stateIdle //extends stateIdle
{
begin:
  Sleep(2.0);
  HideBasil();
  Trigger(None,None);
}

function PawnHearHarryNoise ()
{
  LastNoiseLoc = PlayerHarry.Location;
  TimeSinceLastHearNoise = 0.0;
  if ( bRotateToDesired )
  {
    DesiredRotation = rotator((LastNoiseLoc - Location) * vect(1.00,1.00,0.00));
  }
}

state stateWaiting
{  
  function BeginState ()
  {
    TimeSinceLastHearNoise = 0.0;
    HarryMakingNoiseTimer = 0.0;
    SetTimer(IdleTimerStart + RandRange( -IdleTimerStart / 3,IdleTimerStart / 2),False);
  }
  
  function PawnHearHarryNoise()
  {
	if( TimeSinceLastHearNoise > AttackTime * 1.5 || TimeSinceLastHearNoise > AttackTime &&  HarryMakingNoiseTimer > 1 || HarryMakingNoiseTimer > 2 )
	{
	  DoHarryAttack( PlayerHarry.Location - LastNoiseLoc );
	}
  }
  
  function Timer ()
  {
    switch (4)
    {
      case 0:
      GotoState('stateTailSwing');
      break;
      case 1:
      GotoState('stateRandomAttack');
      break;
      case 2:
      GotoState('stateTailWiggle');
      break;
      case 3:
      GotoState('stateTailPound');
      break;
      case 4:
      GotoState('stateLookAround');
      break;
      default:
    }
  }
  
 begin:
  do
  {
    Sleep(RandRange(1.0,2.0));
  }
  until(false);
  // if (! False ) goto JL0000;
}

state stateTail
{
  function BeginState ()
  {
  }
  
  function EndState ()
  {
    Mesh = SkeletalMesh'skbasiliskMesh';
  }
  
}

state stateTailSwing //extends stateTail
{
begin:
  MoveToRandomVisibleHole();
  TempRot = rotator((PlayerHarry.Location - Location) * vect(1.00,1.00,0.00));
  TempRot.Yaw += RandRange(-32767.0,32767.0);
  PlayAnim('lunge1');
  AnimFrame = 36.0 / 64.0;
  Sleep(1.5);
  HideBasil();
  GotoState('stateWaiting');
}

state stateRandomAttack
{
begin:
  MoveToRandomVisibleHole();
  TempRot = rotator((PlayerHarry.Location - Location) * vect(1.00,1.00,0.00));
  TempRot.Yaw += RandRange(-32767.0,32767.0);
  PlayAnim('lunge1');
  AnimFrame = 36.0 / 64.0;
  Sleep(1.5);
  HideBasil();
  GotoState('stateWaiting');
}

state stateTailWiggle //extends stateTail
{
begin:
  MoveToRandomVisibleHole();
  PlayAnim('lunge1');
  FinishAnim();
  HideBasil();
  GotoState('stateWaiting');
}

state stateTailPound //extends stateTail
{
begin:
  MoveToRandomVisibleHole();
  TempRot = rotator((PlayerHarry.Location - Location) * vect(1.00,1.00,0.00));
  TempRot.Yaw += RandRange(-32767.0,32767.0);
  PlayAnim('lunge1');
  Sleep(0.5);
  HideBasil();
  GotoState('stateWaiting');
}

state stateLookAround
{
begin:
  MoveToRandomVisibleHole();
  TempRot = rotator((PlayerHarry.Location - Location) * vect(1.00,1.00,0.00));
  TempRot.Yaw += (Rand(2) * 2 - 1) * RandRange(8000.0 - 2000,8000.0 + 2000);
  PlayAnim('lunge1');
  AnimFrame = 36.0 / 64.0;
  Sleep(1.5);
  HideBasil();
  GotoState('stateWaiting');
}

state stateHit
{
begin:
  Sleep(2.0);
  HideBasil();
  GotoState('stateWaiting');
}

function MoveToRandomVisibleHole ()
{
  local int NumVisibleHoles;
  local int NumHoles;
  local Actor Holes[20];
  local Actor VisibleHoles[20];
  local Vector vDir;
  local Actor A;

  vDir = Normal(vector(PlayerHarry.Rotation) * vect(1.00,1.00,0.00));
  foreach AllActors(Class'Actor',A,HoleMarkerCommonTag)
  {
    Holes[NumHoles++ ] = A;
    if ( vDir Dot Normal((A.Location - PlayerHarry.Location) * vect(1.00,1.00,0.00)) > 0.5 )
    {
      VisibleHoles[NumVisibleHoles++ ] = A;
    }
  }
  if ( NumHoles > 20 )
  {
    PlayerHarry.ClientMessage("*************** ERROR ERROR ERROR: Too many holes...");
  }
  if ( (NumVisibleHoles == 0) || (FRand() < 0.2) )
  {
    A = Holes[Rand(NumHoles)];
  } else {
    A = VisibleHoles[Rand(NumVisibleHoles)];
  }
  SetLocation(A.Location);
}

function DoHarryAttack (Vector vDir)
{
  local Vector vLoc;
  local Actor ClosestActor;
  local Actor A;
  local float fClosestDist;

  fClosestDist = 100000.0;
  foreach AllActors(Class'Actor',A,HoleMarkerCommonTag)
  {
    if ( VSize2D(A.Location - LastNoiseLoc) < fClosestDist )
    {
      fClosestDist = VSize2D(A.Location - LastNoiseLoc);
      ClosestActor = A;
    }
  }
  SetLocation(ClosestActor.Location);
  TempRot = rotator((LastNoiseLoc - ClosestActor.Location) * vect(1.00,1.00,0.00));
  SetBasilYaw(TempRot.Yaw);
  GotoState('stateAttackHarry');
}

state stateAttackHarry
{
  function BeginState ()
  {
    bRotateToDesired = True;
    DesiredRotation = Rotation;
  }
  
  function EndState ()
  {
    bRotateToDesired = False;
  }
  
 begin:
  PlayLungeAnim();
  FinishAnim();
  Sleep(2.0);
  HideBasil();
  GotoState('stateWaiting');
}

function PlayLungeAnim ()
{
  local int I;
  local int W;

  W = (HeadAttackFarthest - HeadAttackNearest) / (6 - 1);
  I = ( VSize2D(PlayerHarry.Location - Location) - HeadAttackNearest + W / 2 ) / W;
  I = Clamp( I, 0, HeadAttackCount - 1 );
  PlayAnim(HeadAttackAnimName[I],1.0,0.2); 
}

defaultproperties
{
    HoleMarkerCommonTag=BasiliskHoleMarker

    IdleTimerStart=5.00

    AttackTime=3.00

    HeadYawRate=45.00

    HeadAttackNearest=370.00

    HeadAttackFarthest=1700.00

    HeadAttackAnimName(0)=lunge1

    HeadAttackAnimName(1)=lunge1

    HeadAttackAnimName(2)=lunge1

    HeadAttackAnimName(3)=lunge1

    HeadAttackAnimName(4)=lunge1

    HeadAttackAnimName(5)=lunge1

    // Physics=5
	Physics=PHYS_Rotating

    Mesh=SkeletalMesh'HPModels.skbasiliskMesh'

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False

    bRotateToDesired=False

    RotationRate=(Pitch=4096,Yaw=5000,Roll=3072)
}
