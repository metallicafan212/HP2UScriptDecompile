//================================================================================
// TriggeredViewFlash.
//================================================================================

class TriggeredViewFlash extends Triggers;

var PlayerPawn Player;

function FIndPlayer ()
{
// JL0014:
  foreach AllActors(Class'PlayerPawn',Player)
  {
    // goto JL0014;
	break;
  }
}

function Trigger (Actor Other, Pawn Instigator)
{
  if ( Player == None )
  {
    FIndPlayer();
  }
  if ( Player != None )
  {
    Player.ClientFlash(1.0,vect(980.00,808.00,300.00));
  }
}

defaultproperties
{
    Texture=Texture'HPEdit.Icons.flash'

}
