//================================================================================
// TriggerTurnOnAllSpells.
//================================================================================

class TriggerTurnOnAllSpells extends Triggers;

auto state Waiting
{
  event Trigger (Actor Other, Pawn EventInstigator)
  {
    ProcessTrigger();
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
  harry(Level.PlayerHarryActor).ClientMessage("<*> Turning on ALL spells for this level!! <*>");
  harry(Level.PlayerHarryActor).bNoSpellBookCheck = True;
}

