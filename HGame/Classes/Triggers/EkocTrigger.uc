//================================================================================
// EkocTrigger.
//================================================================================

class EkocTrigger extends Trigger;

function Activate (Actor Other, Pawn Instigator)
{
  local string ekoc;

  ekoc = Localize("LevelEnable","Enable","ABC");
  if ( InStr(ekoc,"<") < 0 )
  {
    Super.Activate(Other,Instigator);
  }
}

