//================================================================================
// TriggerEndDemo.
//================================================================================

class TriggerEndDemo extends Trigger;

auto state Waiting
{
  event Trigger (Actor Other, Pawn EventInstigator)
  {
    ProcessTrigger();
    Level.PlayerHarryActor.ClientMessage(string(self) $ " Here");
  }
  
  function Touch (Actor Other)
  {
    Super.Touch(Other);
    if ( Other == Level.PlayerHarryActor )
    {
      ProcessTrigger();
    }
  }
}

function ProcessTrigger ()
{
  local harry PlayerHarry;

  PlayerHarry = harry(Level.PlayerHarryActor);
  if ( PlayerHarry == None )
  {
    Log("TriggerEndDemo: Couldn't find Harry, and that ain't right!");
    return;
  }
  HPConsole(PlayerHarry.Player.Console).menuBook.ShowDemoAds(20.0);
}

defaultproperties
{
    InitialState=None
}
