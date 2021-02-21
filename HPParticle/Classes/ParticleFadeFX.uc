//================================================================================
// ParticleFadeFX.
//================================================================================

class ParticleFadeFX extends ParticleFX;

var bool bTurningOn;

event Trigger (Actor Other, Pawn EventInstigator)
{
  if ( ParentBlend == 0 )
  {
    ParentBlend = 1.0;
  } 
  else 
  {
    ParentBlend = 0.0;
  }
  bHidden = False;
}

defaultproperties
{
    ParentBlend=1.00
}
