//================================================================================
// TriggerChangeLevel.
//================================================================================

class TriggerChangeLevel extends Trigger;

var() string NewMapName;

auto state Waiting
{
  event Trigger (Actor Other, Pawn EventInstigator)
  {
    ProcessTrigger();
    Level.PlayerHarryActor.ClientMessage(string(self) $ " Here1");
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

function ProcessTrigger()
{
  local harry PlayerHarry;

  PlayerHarry = harry(Level.PlayerHarryActor);
  if ( PlayerHarry == None )
  {
    Log("TriggerChangeLevel: Couldn't find Harry, and that ain't right!");
    return;
  }
  PlayerHarry.LoadLevel(NewMapName);
  if ( InStr(Caps(NewMapName),"STARTUP") > -1 )
  {
    HPConsole(PlayerHarry.Player.Console).menuBook.bGamePlaying = False;
    HPConsole(PlayerHarry.Player.Console).menuBook.OpenBook("Main");
    HPConsole(PlayerHarry.Player.Console).LaunchUWindow();
  }
}

defaultproperties
{
    InitialState=None

}
