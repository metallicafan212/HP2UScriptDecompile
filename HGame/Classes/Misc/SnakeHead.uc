//================================================================================
// SnakeHead.
//================================================================================

class SnakeHead extends HDecoration;

var int TimingStage;
var() float InitialDelayTime;
var() float TimeToNextShot[20];
var Vector vShootLocation;
var() float SpeedScalar;
var() bool bPlayFlameSound;

function PostBeginPlay ()
{
  local TorchFire03 A;
  local float fClosest;
  local Actor aClosest;
  local float f;
  local int I;
  local int N;

  fClosest = 1000000.0;
  foreach AllActors(Class'TorchFire03',A)
  {
    f = VSize(A.Location - Location);
    if ( f < fClosest )
    {
      fClosest = f;
      aClosest = A;
    }
  }
  vShootLocation = aClosest.Location;
  aClosest.Destroy();
  if ( TimeToNextShot[0] == 0 )
  {
    TimeToNextShot[0] = RandRange(1.25,1.5);
  }
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  if ( IsInState('stateShooting') )
  {
    GotoState('stateIdle');
  } else {
    GotoState('stateShooting');
  }
}

auto state stateIdle
{
}

state stateShooting
{
begin:
  TimingStage = 0;
  Sleep(InitialDelayTime / SpeedScalar);
  do
  {
	  Sleep(TimeToNextShot[TimingStage] / SpeedScalar);
	  SpawnFireBall();
	  TimingStage++;
	  if ( (TimingStage >= 20) || (TimeToNextShot[TimingStage] == 0) )
	  {
		TimingStage = 0;
	  }
  }
  until(false);
  // if (! False ) goto JL0016;
}

function SpawnFireBall ()
{
  local spellSnakeHeadFire A;

  A = Spawn(Class'spellSnakeHeadFire',,,vShootLocation,Rotation);
  if ( bPlayFlameSound )
  {
    switch (Rand(3))
    {
      case 0:
      A.PlaySound(Sound'flame_shoot1',,0.6661);
      break;
      case 1:
      A.PlaySound(Sound'flame_shoot2',,0.6661);
      break;
      case 2:
      A.PlaySound(Sound'flame_shoot3',,0.6661);
      break;
      default:
    }
  }
}

defaultproperties
{
    SpeedScalar=2.00

    bPlayFlameSound=True

    Mesh=SkeletalMesh'HProps.skSnakeHeadMesh'
}
