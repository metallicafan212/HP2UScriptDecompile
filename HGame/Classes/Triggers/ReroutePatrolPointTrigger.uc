//================================================================================
// ReroutePatrolPointTrigger.
//================================================================================

class ReroutePatrolPointTrigger extends Trigger;

var() name SourcePatrolPoint_Tag;
var() name SourcePatrolPoint_ObjectName;
var() name DestPatrolPoint_Tag;
var() name DestPatrolPoint_ObjectName;

event Trigger (Actor Other, Pawn EventInstigator)
{
  ProcessTrigger();
}

function Touch (Actor Other)
{
  ProcessTrigger();
}

function ProcessTrigger()
{
  local PatrolPoint sp;
  local PatrolPoint dp;

  if ( SourcePatrolPoint_Tag != 'None' )
  {
    foreach AllActors(Class'PatrolPoint',sp,SourcePatrolPoint_Tag)
    {
      // goto JL0028;
	  break;
    }
  } else {
    foreach AllActors(Class'PatrolPoint',sp)
    {
      if ( sp.Name == SourcePatrolPoint_ObjectName )
      {
        // goto JL0058;
		break;
      }
    }
  }
  if ( DestPatrolPoint_Tag != 'None' )
  {
    foreach AllActors(Class'PatrolPoint',dp,DestPatrolPoint_Tag)
    {
      // goto JL0081;
	  break;
    }
  } else {
    foreach AllActors(Class'PatrolPoint',dp)
    {
      if ( dp.Name == DestPatrolPoint_ObjectName )
      {
        // goto JL00B1;
		break;
      }
    }
  }
  if ( sp == None )
  {
    Log("ReroutePatrolPointTrigger: Couldn't find Source patrol point");
    return;
  }
  if ( dp == None )
  {
    Log("ReroutePatrolPointTrigger: Couldn't find Dest patrol point");
    return;
  }
  Log("************* reroute " $ string(sp) $ " to " $ string(dp));
  sp.NextPatrolPoint = dp;
}

