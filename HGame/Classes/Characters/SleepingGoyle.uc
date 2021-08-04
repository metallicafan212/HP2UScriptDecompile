//================================================================================
// SleepingGoyle.
//================================================================================

class SleepingGoyle extends Characters;

var int WakeLevel;
var TriggerChangeLevel TriggerNextLevel;
var() int WakeUpDistance;
var() string CurrLevelName;
var() string NextLevelName;

function PostBeginPlay()
{
  local ChickenLeg leg;

  Super.PostBeginPlay();
  TriggerNextLevel = Spawn(Class'TriggerChangeLevel',,,);
  if ( TriggerNextLevel != None )
  {
    TriggerNextLevel.NewMapName = NextLevelName;
    TriggerNextLevel.SetCollision(False,False,False);
  }
  leg = Spawn(Class'ChickenLeg',,,);
  if ( leg != None )
  {
    leg.SetOwner(self);
    leg.AttachToOwner('RightHand');
  }
}

function Tick (float deltaT)
{
  Super.Tick(deltaT);
  if ( PlayerHarry.bFinishPickBitOfGoyle )
  {
    PlayerHarry.bFinishPickBitOfGoyle = False;
    if ( TriggerNextLevel != None )
    {
      TriggerNextLevel.ProcessTrigger();
    }
  }
}

function PigWakeGoyle()
{
  if ( GetStateName() != 'stateSleep' )
  {
    return;
  }
  if ( PlayerHarry.GetStateName() == 'statePickBitOfGoyle' )
  {
    return;
  }
  WakeLevel++;
  GotoState('stateWakeUp');
}

function bool TooCloseToHarry()
{
  local Vector vDifference;

  vDifference = PlayerHarry.Location - Location;
  if ( VSize(vDifference) <= WakeUpDistance )
  {
    return True;
  }
  return False;
}

auto state stateSleep
{
  function Bump (Actor Other)
  {
    if ( Other == PlayerHarry )
    {
      harry(Other).GotoState('statePickBitOfGoyle');
    }
  }
  
 begin:
  PlayAnim('Goyle_sleeping');
  FinishAnim();
  Sleep(0.01);
  goto ('Begin');
}

state stateBustHarry
{
begin:
  PlayAnim('Goyle_SitUp_Idle');
  FinishAnim();
  PlayerHarry.ConsoleCommand("LoadGame 0");
}

state stateWakeUp
{
begin:
  if ( WakeLevel == 1 )
  {
    PlayAnim('Goyle_Groggy');
    FinishAnim();
  } else //{
    if ( WakeLevel == 2 )
    {
      PlayAnim('Goyle_Groggy');
      FinishAnim();
    } else //{
      if ( WakeLevel == 3 )
      {
        PlayAnim('Goyle_Groggy');
        FinishAnim();
      } else //{
        if ( WakeLevel == 4 )
        {
          PlayAnim('Goyle_WakeUp');
          FinishAnim();
          GotoState('stateBustHarry');
        }
      //}
    //}
  //}
  if (  !TooCloseToHarry() )
  {
    GotoState('stateSleep');
  } else {
    WakeLevel++;
    GotoState('stateWakeUp');
  }
}

defaultproperties
{
    WakeUpDistance=200

    CurrLevelName="Adv6Goyle"

    NextLevelName="Adv7SlythComRoom"

    bDoEyeBlinks=False

    Mesh=SkeletalMesh'HPModels.skGoyleMesh'

    CollisionRadius=15.00

    CollisionHeight=44.00

}
