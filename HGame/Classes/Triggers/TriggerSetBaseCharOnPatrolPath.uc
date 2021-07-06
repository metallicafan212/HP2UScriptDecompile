//================================================================================
// TriggerSetBaseCharOnPatrolPath.
//================================================================================

class TriggerSetBaseCharOnPatrolPath extends Trigger;

var() name DestPatrolPoint_ObjectName;
var() bool bAlsoTriggerBaseChar;

event Trigger (Actor Other, Pawn EventInstigator)
{
  ProcessTrigger();
}

function Touch (Actor Other)
{
  if ( bAlsoTriggerBaseChar )
  {
    Super.Touch(Other);
  }
  ProcessTrigger();
}

function ProcessTrigger()
{
  local PatrolPoint dp;
  local HPawn A;

  foreach AllActors(Class'PatrolPoint',dp)
  {
    if ( dp.Name == DestPatrolPoint_ObjectName )
    {
      // goto JL002C;
	  break;
    }
  }
  if ( dp == None )
  {
    Log("TriggerSetBaseCharOnPatrolPath: Couldn't find Dest patrol point");
    return;
  }
  foreach AllActors(Class'HPawn',A,Event)
  {
    A.firstPatrolPointObjectName = DestPatrolPoint_ObjectName;
    A.ePatrolType =  PATROLTYPE_PATROL_POINTS;
    A.bGoBackToLastNavPoint = False;
    A.navP = None;
    A.tempNavP = None;
    A.LastNavP = None;
    A.GotoState('patrol');
  }
}

defaultproperties
{
    bAlsoTriggerBaseChar=True

}
