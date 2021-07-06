//================================================================================
// HPMenuOptionComboButton.
//================================================================================

class HPMenuOptionComboButton extends UWindowComboButton;

function Created()
{
  Super.Created();
}

function BeforePaint (Canvas C, float X, float Y)
{
  local float W;
  local float H;

  C.Font = Root.Fonts[Font];
  TextSize(C,RemoveAmpersand(Text),W,H);
  switch (Align)
  {
    // case 0:
	case TextAlign.TA_Left:
    TextX = 0.0;
    break;
    // case 1:
	case TextAlign.TA_Right:
    TextX = WinWidth - W;
    break;
    // case 2:
	case TextAlign.TA_Center:
    TextX = (WinWidth - W) / 2;
    break;
    default:
  }
  TextY = (WinHeight - H) / 2;
  bMouseDown = Owner.bListVisible;
}

