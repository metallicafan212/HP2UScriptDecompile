//================================================================================
// CutLogWindow.
//================================================================================

class CutLogWindow extends UWindowFramedWindow;

function Created()
{
  Super.Created();
  bSizable = False;
  bStatusBar = False;
  bLeaveOnscreen = True;
}

defaultproperties
{
    ClientClass=Class'CutLogClientWindow'

    WindowTitle="CutScene Log"

}
