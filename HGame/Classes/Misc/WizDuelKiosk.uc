//================================================================================
// WizDuelKiosk.
//================================================================================

class WizDuelKiosk extends BlackboardWizDuel;

auto state Idle
{
  event Bump (Actor Other)
  {
    if ( (harry(Other) != None) &&  !HPConsole(harry(Level.PlayerHarryActor).Player.Console).menuBook.bIsOpen )
    {
      HPConsole(harry(Level.PlayerHarryActor).Player.Console).bQuickKeyEnable = False;
      HPConsole(harry(Level.PlayerHarryActor).Player.Console).LaunchUWindow(True);
      HPConsole(harry(Level.PlayerHarryActor).Player.Console).menuBook.OpenBook("DUEL");
      GotoState('debounce');
    }
  }
  
}

state debounce
{
begin:
  Sleep(2.0);
  GotoState('Idle');
}

defaultproperties
{
    CollisionRadius=70.00

    CollisionHeight=80.00

    // CollideType=0
	CollideType=CT_AlignedCylinder
}
