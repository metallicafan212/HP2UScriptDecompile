//================================================================================
// DisableTrigger.
//================================================================================

class DisableTrigger extends Trigger;

event Trigger (Actor Other, Pawn EventInstigator)
{
  ProcessTrigger(Other);
}

function Touch (Actor Other)
{
  if ( Other == Level.PlayerHarryActor )
  {
    ProcessTrigger(Other);
  }
}

function ProcessTrigger (Actor Other)
{
  local Actor sp;

  if ( Event != 'None' )
  {
    foreach AllActors(Class'Actor',sp,Event)
    {
      // goto JL0028;
	  break;
    }
  }
  if ( sp == None )
  {
    Log("DisableTrigger: Couldn't find Disable Tag");
    return;
  } else {
    sp.TriggerDisable();
  }
}

defaultproperties
{
    bTriggerOnceOnly=True

}
