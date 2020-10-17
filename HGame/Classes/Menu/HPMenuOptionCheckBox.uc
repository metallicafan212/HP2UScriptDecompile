//================================================================================
// HPMenuOptionCheckBox.
//================================================================================

class HPMenuOptionCheckBox extends UWindowCheckbox;

function Checkbox_SetupSizes (UWindowCheckbox W, Canvas C)
{
  local float TW;
  local float TH;

  W.TextSize(C,W.Text,TW,TH);
  W.WinHeight = Max(TH + 1,16);
  W.ImageX = 0.0;
  W.TextX = 13.0 + 4;
  W.ImageY = (W.WinHeight - 12) / 2;
  W.TextY = (W.WinHeight - TH) / 2;
  if ( W.bChecked )
  {
    W.UpTexture = Texture'FEOptionTickCheckedTex';
    W.DownTexture = Texture'FEOptionTickCheckedOverTex';
    W.OverTexture = Texture'FEOptionTickCheckedOverTex';
    W.DisabledTexture = None;
  } else {
    W.UpTexture = Texture'FEOptionTickUncheckedTex';
    W.DownTexture = Texture'FEOptionTickUncheckedOverTex';
    W.OverTexture = Texture'FEOptionTickUncheckedOverTex';
    W.DisabledTexture = None;
  }
}

function BeforePaint (Canvas C, float X, float Y)
{
  Checkbox_SetupSizes(self,C);
}

function Paint (Canvas C, float X, float Y)
{
  Super.Paint(C,X,Y);
}

