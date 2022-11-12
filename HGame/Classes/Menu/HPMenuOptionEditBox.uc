//================================================================================
// HPMenuOptionEditBox.
//================================================================================

class HPMenuOptionEditBox extends UWindowEditBox;

function Created()
{
}

function Paint (Canvas C, float X, float Y)
{
  local float W;
  local float H;
  //local float TextY;
  local float fTextY;

  C.Font = Root.Fonts[Font];
  TextSize(C,"A",W,H);
  fTextY = (WinHeight - H) / 2;
  TextSize(C,Left(Value,CaretOffset),W,H);
  C.DrawColor.R = 255;
  C.DrawColor.G = 255;
  C.DrawColor.B = 255;
  if ( W + Offset < 0 )
  {
    Offset =  -W;
  }
  if ( W + Offset > WinWidth - 2 )
  {
    Offset = (WinWidth - 2) - W;
    if ( Offset > 0 )
    {
      Offset = 0.0;
    }
  }
  C.DrawColor = TextColor;
  if ( bAllSelected )
  {
    DrawStretchedTexture(C,Offset + 1,fTextY,W,H,Texture'WhiteTexture');
    C.DrawColor.R = 255 ^ C.DrawColor.R;
    C.DrawColor.G = 255 ^ C.DrawColor.G;
    C.DrawColor.B = 255 ^ C.DrawColor.B;
  }
  ClippingRegion.H += 5;
  ClipText(C,Offset + 11,fTextY,Value);
  if (  !bHasKeyboardFocus ||  !bCanEdit )
  {
    bShowCaret = False;
  } else {
    if ( (GetLevel().TimeSeconds > LastDrawTime + 0.3) || (GetLevel().TimeSeconds < LastDrawTime) )
    {
      LastDrawTime = GetLevel().TimeSeconds;
      bShowCaret =  !bShowCaret;
    }
  }
  if ( bShowCaret )
  {
    ClipText(C,Offset + W - 1,fTextY,"|");
  }
}

