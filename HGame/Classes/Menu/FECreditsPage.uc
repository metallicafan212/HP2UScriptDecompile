//================================================================================
// FECreditsPage.
//================================================================================

class FECreditsPage extends baseFEPage;

var HPCreditsControl CreditsTextWindow;

function Created()
{
  if ( CreditsTextWindow == None )
  {
    CreditsTextWindow = HPCreditsControl(CreateControl(Class'HPCreditsControl',50.0,10.0,WinWidth - 100,WinHeight - 20));
  }
}

function Paint (Canvas C, float MouseX, float MouseY)
{
  Super.Paint(C,MouseX,MouseY);
}

function bool KeyEvent (byte Key, byte Action, float Delta)
{
  // if ( (bool(Action) == 1) && ((bool(Key) == 27) || (bool(Key) == 32)) )
  if( (Action == 1) && (Key == 27 || Key == 32) ) 
  {
    Root.EnableMouse();
  }
  return False;
}

function ShowWindow()
{
  Root.DisableMouse();
  CreditsTextWindow.Reset();
  Super.ShowWindow();
}

