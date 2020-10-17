//================================================================================
// HPMenuOptionCombo.
//================================================================================

class HPMenuOptionCombo extends UWindowComboControl;

var Texture IdleTexture;
var Texture OverTexture;

function Created ()
{
  Super.Created();
  IdleTexture = Texture'FEComboIdleTexture';
  OverTexture = Texture'FEComboOverTexture';
}

function CreateEditBox ()
{
  EditBox = HPMenuOptionEditBox(CreateWindow(Class'HPMenuOptionEditBox',0.0,0.0,WinWidth,WinHeight));
}

function CreateComboButton ()
{
  Button = HPMenuOptionComboButton(CreateWindow(Class'HPMenuOptionComboButton',0.0,0.0,WinWidth,WinHeight));
}

function CreateComboList ()
{
  List = HPMenuOptionComboList(Root.CreateWindow(ListClass,0.0,0.0,WinWidth,WinHeight));
}

function BeforePaint (Canvas C, float X, float Y)
{
  local float W;
  local float H;

  C.Font = Root.Fonts[Font];
  List.bLeaveOnscreen = bListVisible && bLeaveOnscreen;
  TextSize(C,Text,W,H);
  TextY = (WinHeight - H) / 2;
  TextX = WinWidth - W - 20 - EditBoxWidth;
}

function Paint (Canvas C, float X, float Y)
{
  if ( Text != "" )
  {
    C.DrawColor = TextColor;
    ClipText(C,TextX,TextY,Text);
    C.DrawColor.R = 255;
    C.DrawColor.G = 255;
    C.DrawColor.B = 255;
  }
  if ( bListVisible )
  {
    DrawClippedTexture(C,WinWidth - EditBoxWidth,1.0,OverTexture);
  } else //{
    if ( MouseIsOver() || EditBox.MouseIsOver() || Button.MouseIsOver() )
    {
      DrawClippedTexture(C,WinWidth - EditBoxWidth,1.0,OverTexture);
    } else {
      DrawClippedTexture(C,WinWidth - EditBoxWidth,1.0,IdleTexture);
    }
  //}
}

function CloseUpWithNoSound ()
{
  bListVisible = False;
  EditBox.SetEditable(bCanEdit);
  EditBox.SelectAll();
  List.HideWindow();
}

defaultproperties
{
    ListClass=Class'HPMenuOptionComboList'

}
