//================================================================================
// basePopup.
//================================================================================

class basePopup extends Actor;

var harry PlayerHarry;

function Draw (Canvas Canvas)
{
}

function PostBeginPlay ()
{
  Super.PostBeginPlay();
  foreach AllActors(Class'harry',PlayerHarry)
  {
    // goto JL001A;
	break;
  }
}

auto state popstate
{
begin:
  Sleep(0.5);
  PlayerHarry.ClearMessages = False;
poploop:
  if ( PlayerHarry.ClearMessages )
  {
    PlayerHarry.ClearMessages = False;
    Destroy();
  }
  Sleep(0.03);
  goto ('poploop');
}

defaultproperties
{
    bHidden=True

    LifeSpan=1.00

}
