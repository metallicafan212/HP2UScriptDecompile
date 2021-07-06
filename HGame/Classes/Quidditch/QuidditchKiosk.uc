//================================================================================
// QuidditchKiosk.
//================================================================================

class QuidditchKiosk extends BlackboardQuidditch;

function PostBeginPlay()
{
}

auto state Idle
{
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    if ( harry(Other).bIsGoyle )
    {
      return;
    }
    if (  !HPConsole(harry(Level.PlayerHarryActor).Player.Console).menuBook.bIsOpen )
    {
      HPConsole(harry(Level.PlayerHarryActor).Player.Console).bQuickKeyEnable = False;
      HPConsole(harry(Level.PlayerHarryActor).Player.Console).LaunchUWindow(True);
      HPConsole(harry(Level.PlayerHarryActor).Player.Console).menuBook.OpenBook("QUID");
      GotoState('debounce');
    }
  }
  
  event Bump (Actor Other)
  {
    if ( (harry(Other) == None) || harry(Other).bIsGoyle )
    {
      return;
    }
    if (  !HPConsole(harry(Level.PlayerHarryActor).Player.Console).menuBook.bIsOpen )
    {
      HPConsole(harry(Level.PlayerHarryActor).Player.Console).bQuickKeyEnable = False;
      HPConsole(harry(Level.PlayerHarryActor).Player.Console).LaunchUWindow(True);
      HPConsole(harry(Level.PlayerHarryActor).Player.Console).menuBook.OpenBook("QUID");
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
    // CollideType=0
	CollideType=CT_AlignedCylinder
}
