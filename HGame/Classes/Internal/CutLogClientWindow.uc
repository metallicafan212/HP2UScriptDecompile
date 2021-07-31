//================================================================================
// CutLogClientWindow.
//================================================================================

class CutLogClientWindow extends UWindowDialogClientWindow;

var UWindowConsoleTextAreaControl TextArea;

function Created()
{
  TextArea = UWindowConsoleTextAreaControl(CreateWindow(Class'UWindowConsoleTextAreaControl',0.0,0.0,WinWidth,WinHeight));
}

function Notify (UWindowDialogControl C, byte E)
{
  local string S;

  Super.Notify(C,E);
  switch (E)
  {
    case DE_EnterPressed:
    break;
    case DE_WheelUpPressed:
    TextArea.VertSB.Scroll(-1.0);
    break;
    case DE_WheelDownPressed:
    TextArea.VertSB.Scroll(1.0);
    break;
    default:
  }
}

function BeforePaint (Canvas C, float X, float Y)
{
  Super.BeforePaint(C,X,Y);
  TextArea.SetSize(WinWidth,WinHeight);
}

function Paint (Canvas C, float X, float Y)
{
  DrawStretchedTexture(C,0.0,0.0,WinWidth,WinHeight,Texture'BlackTexture');
}

