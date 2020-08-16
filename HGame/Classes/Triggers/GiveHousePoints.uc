//================================================================================
// GiveHousePoints.
//================================================================================

class GiveHousePoints extends Trigger;

var() int HousePoints;

event Trigger (Actor Other, Pawn EventInstigator)
{
  ProcessTrigger();
}

function Touch (Actor Other)
{
}

function ProcessTrigger ()
{
  local harry A;

  foreach AllActors(Class'harry',A)
  {
    // goto JL0014;
	break;
  }
  if ( A == None )
  {
    Log("TriggerChangeLevel: Couldn't find Harry, and that ain't right!");
    return;
  }
  A.AddHousePoints(HousePoints);
}

