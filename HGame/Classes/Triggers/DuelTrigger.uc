//================================================================================
// DuelTrigger.
//================================================================================

class DuelTrigger extends Trigger;

var harry PlayerHarry;
var Duellist DuelOpponent;

function PostBeginPlay()
{
// JL0014:
  foreach AllActors(Class'harry',PlayerHarry)
  {
    // goto JL0014;
	break;
  }
  foreach AllActors(Class'Duellist',DuelOpponent)
  {
    // goto JL0029;
	break;
  }
}

function TriggerEvent (name EventName, Actor Other, Pawn EventInstigator)
{
  if ( PlayerHarry == None )
  {
    return;
  }
  if ( DuelOpponent == None )
  {
    return;
  }
  PlayerHarry.TurnOnDuelingMode(DuelOpponent);
  DuelOpponent.GotoState('stateStartDuel');
}

state stateAuto
{
begin:
  GotoState('NormalTrigger');
}

defaultproperties
{
    bSendEventOnEvent=True

}
