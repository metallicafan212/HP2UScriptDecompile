//================================================================================
// TriggerSpwnBsChrOnPPnt.
//================================================================================

class TriggerSpwnBsChrOnPPnt extends Trigger;

var() Class<HPawn> BaseCharToSpawn[8];
var() float BaseCharGroundSpeed[8];
var() name StartPatrolPoint_Tag;
var() name StartPatrolPoint_ObjectName;
const NUM_BASE_CHARS= 8;

event Trigger (Actor Other, Pawn EventInstigator)
{
  ProcessTrigger();
}

function Touch (Actor Other)
{
  Super.Touch(Other);
  ProcessTrigger();
}

function ProcessTrigger()
{
  local PatrolPoint sp;
  local HPawn A;
  local int N;
  local int I;

  if ( StartPatrolPoint_Tag != 'None' )
  {
    foreach AllActors(Class'PatrolPoint',sp,StartPatrolPoint_Tag)
    {
      // goto JL0028;
	  break;
    }
  } else {
    foreach AllActors(Class'PatrolPoint',sp)
    {
      if ( sp.Name == StartPatrolPoint_ObjectName )
      {
        // goto JL0058;
		break;
      }
    }
  }
  if ( sp == None )
  {
    Log("TriggerSpwnBsChrOnPPnt: Couldn't find Source patrol point");
    return;
  }
  // N = 0;
  // if ( N < 8 )
  for(N = 0; N < NUM_BASE_CHARS; N++)
  {
    if ( BaseCharToSpawn[N] == None )
    {
      // goto JL00D4;
	  break;
    }
    // N++;
    // goto JL00AA;
  }
  if ( N == 0 )
  {
    Log("TriggerSpwnBsChrOnPPnt: BaseCharToSpawn not set to a baseChar");
    return;
  }
  I = Rand(N);
  A = Spawn(BaseCharToSpawn[I],,,[SpawnLocation]sp.Location,[SpawnRotation]rotator(sp.NextPatrolPoint.Location - sp.Location));
  if ( A == None )
  {
    Log("TriggerSpwnBsChrOnPPnt: couldn't spawn the baseChar:" $ string(BaseCharToSpawn[I]));
    return;
  }
  A.ePatrolType =  PATROLTYPE_PATROL_POINTS;
  A.firstPatrolPointObjectName = sp.Name;
  if ( BaseCharGroundSpeed[I] != 0 )
  {
    A.GroundSpeed = BaseCharGroundSpeed[I];
  }
  A.GotoState('patrol');
}

