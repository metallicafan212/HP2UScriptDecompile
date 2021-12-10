//================================================================================
// CreatureGenerator.
//================================================================================

class CreatureGenerator extends HPawn;

const MAX_CREATURES= 20;
const NUM_BASE_CHARS= 16;
var() Class<HPawn> BaseCreatureToSpawn[16];
var() float BaseCreatureGroundSpeed[16];
var() float BaseCreatureLife[16];
var() name BaseCreatureAnim[16];
var() string BaseBumpLineSet[16];
var() bool bCaptureHarry;
var() int TooFar;
var() int MinDelayInSeconds;
var() int MaxDelayInSeconds;
var() int MaxCreaturesOnFastMachine;
var() int MaxCreaturesOnSlowMachine;
var() name FirstPatrolPoint_ObjectName;
var() float TriggerWaitingTime;
var BaseCam Camera;
var PatrolPoint FirstPP;
var HPawn Creatures[20];
var float TotalLifes[20];
var float Lifes[20];
var int HowManyBaseCreatures;
var int PreviousBaseCreatureIndex;
var int NumCreatures;
var int MaxCreatures;
var float fCurrTime;
var float fWaitTime;
var bool bGenerateCreature;
var bool bOff;


function PostBeginPlay()
{
  local BaseCam Cam;
  local PatrolPoint pP;
  local int I;

  Super.PostBeginPlay();
  foreach AllActors(Class'BaseCam',Cam)
  {
    Camera = Cam;
  }
  FirstPP = None;
  foreach AllActors(Class'PatrolPoint',pP)
  {
    if ( pP.Name == FirstPatrolPoint_ObjectName )
    {
      FirstPP = pP;
	  break;
    }
  }
  HowManyBaseCreatures = 0;
  for(I = 0; I < NUM_BASE_CHARS; I++)
  {
    if ( BaseCreatureToSpawn[I] == None )
    {
	  break;
    }
  }
  HowManyBaseCreatures = I;
}

function Tick (float DeltaTime)
{
  fCurrTime += DeltaTime;
  if ( fCurrTime < fWaitTime )
  {
    return;
  }
  UpdateCreaturesLife(fWaitTime);
  fCurrTime = 0.0;
  if ( MinDelayInSeconds >= MaxDelayInSeconds )
  {
    fWaitTime = MinDelayInSeconds;
  } else {
    fWaitTime = RandRange(MinDelayInSeconds,MaxDelayInSeconds);
  }
  DestroyCreatures();
  GenerateCreature();
}

event OnResolveGameState()
{
  if (  !bInCurrentGameState )
  {
    bHidden = True;
    SetCollision(False,False,False);
    bOff = True;
  }
}

function bool TooFarFromHarry (Vector Loc)
{
  local float Dist;

  Dist = VSize(Loc - PlayerHarry.Location);
  if ( Dist > TooFar )
  {
    return True;
  }
  return False;
}

function bool CameraCanSeeYou (Vector Loc)
{
  if ( TooFarFromHarry(Loc) )
  {
    return False;
  }
  return Camera.CameraCanSeeYou(Loc);
}

function UpdateCreatureLife (int Index, float DeltaTime)
{
  if ( Creatures[Index] != None )
  {
    Lifes[Index] += DeltaTime;
  }
}

function UpdateCreaturesLife (float DeltaTime)
{
  local int I;

  for(I = 0; I < MAX_CREATURES; I++)
  {
    UpdateCreatureLife(I,DeltaTime);
  }
}

function DestroyCreature (int Index)
{
  local HPawn creature;

  creature = Creatures[Index];
  if ( creature == None )
  {
    return;
  }
  if ( Lifes[Index] < TotalLifes[Index] )
  {
    return;
  }
  if ( CameraCanSeeYou(creature.Location) )
  {
    return;
  }
  creature.Destroy();
  creature = None;
  NumCreatures--;
}

function DestroyCreatures()
{
  local int I;

  for(I = 0; I < MAX_CREATURES; I++)
  {
    DestroyCreature(I);
  }
}

function GenerateCreature()
{
  local HPawn A;
  local HChar H;
  local int I;
  local int J;
  local bool IsSoftRendering;

  IsSoftRendering = PlayerHarry.IsSoftwareRendering();
  if ( IsSoftRendering )
  {
    MaxCreatures = MaxCreaturesOnSlowMachine;
  } else {
    MaxCreatures = MaxCreaturesOnFastMachine;
  }
  if ( bOff )
  {
    return;
  }
  if ( TriggerWaitingTime != 0 && !bGenerateCreature )
  {
    return;
  }
  if ( NumCreatures >= MaxCreatures )
  {
    return;
  }
  if ( FirstPP == None )
  {
    Log("CreatureGenerator: Couldn't find first patrol point");
    return;
  }
  if ( CameraCanSeeYou(FirstPP.Location) )
  {
    return;
  }
  if ( HowManyBaseCreatures == 0 )
  {
    Log("CreatureGenerator: BaseCreatureToSpawn not set.");
    return;
  }
  if ( HowManyBaseCreatures == 1 )
  {
    I = 0;
  } else {
	while ( True )
    {
      I = Rand(HowManyBaseCreatures);
      if ( I != PreviousBaseCreatureIndex )
      {
        PreviousBaseCreatureIndex = I;
		break;
      } 
    }
  }
  A = Spawn(BaseCreatureToSpawn[I],,,[SpawnLocation]FirstPP.Location,[SpawnRotation]rotator(FirstPP.NextPatrolPoint.Location - FirstPP.Location));
  A.DesiredRotation = A.Rotation;
  if ( A == None )
  {
    Log("CreatureGenerator: couldn't spawn the baseCreature:" $ string(BaseCreatureToSpawn[I]));
    return;
  }
  // A.ePatrolType = 0;
  A.ePatrolType = PATROLTYPE_PATROL_POINTS;
  A.firstPatrolPointObjectName = FirstPP.Name;
  if ( BaseCreatureGroundSpeed[I] != 0 )
  {
    A.GroundSpeed = BaseCreatureGroundSpeed[I];
  }
  A.bPlayRunAnim = False;
  if ( BaseCreatureAnim[I] == 'run' )
  {
    A.bPlayRunAnim = True;
  }
  H = HChar(A);
  H.bUseBumpLine = True;
  H.bBumpCaptureHarry = bCaptureHarry;
  H.BumpLineSet = BaseBumpLineSet[I];
  // J = 0;
  // if ( J < 20 )
  for(J = 0; J < MAX_CREATURES; J++)
  {
    if ( Creatures[J] == None )
    {
      Creatures[J] = A;
      TotalLifes[J] = BaseCreatureLife[I];
      Lifes[J] = 0.0;
      NumCreatures++;
      A.GotoState('patrol');
      return;
    }
    // J++;
    // goto JL02F3;
  }
}

state() TriggerOpenTimed
{
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    GotoState('TriggerOpenTimed','Start');
  }
  
 //this is NOT begin, KW used 'Start' as described in the trigger function above -AdamJD
 Start:
  Disable('Trigger');
  if ( bGenerateCreature )
  {
    bGenerateCreature = False;
  } else {
    bGenerateCreature = True;
  }
  Sleep(TriggerWaitingTime);
  Enable('Trigger');
}

defaultproperties
{
    TooFar=10000

    MinDelayInSeconds=10

    MaxDelayInSeconds=30

    MaxCreaturesOnFastMachine=10

    MaxCreaturesOnSlowMachine=5

    PreviousBaseCreatureIndex=-1

    bHidden=True

    InitialState=TriggerOpenTimed

    bBlockActors=False

    bBlockPlayers=False

}
