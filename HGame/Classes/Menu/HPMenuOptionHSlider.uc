//================================================================================
// HPMenuOptionHSlider.
//================================================================================

class HPMenuOptionHSlider extends UWindowHSliderControl;

var Texture Image;
var Texture overImage;
var Texture knobImage;
var float fSliderOffsetX;

function Created ()
{
  Super.Created();
  SliderWidth = 145.0;
  Image = Texture'FESliderTexture';
  overImage = Texture'FEOverSliderTexture';
  knobImage = Texture'FESliderKnobTexture';
  WinHeight = 24.0;
  fSliderOffsetX = 2.0;
  TrackWidth = 22.0;
}

function BeforePaint (Canvas C, float X, float Y)
{
  local float W;
  local float H;

  TextSize(C,Text,W,H);
  SliderDrawX = fSliderOffsetX + WinWidth - SliderWidth;
  TextX = SliderDrawX - W - 23;
  SliderDrawY = (WinHeight - 2) / 2;
  TextY = (WinHeight - H) / 2;
  TrackStart = SliderDrawX + (SliderWidth - TrackWidth) * (Value - MinValue) / (MaxValue - MinValue);
}

function Paint (Canvas C, float X, float Y)
{
  local Texture t;
  local Region R;

  t = GetLookAndFeelTexture();
  if ( Text != "" )
  {
    C.DrawColor = TextColor;
    ClipText(C,TextX,TextY,Text);
    C.DrawColor.R = 255;
    C.DrawColor.G = 255;
    C.DrawColor.B = 255;
  }
  R = LookAndFeel.HLine;
  DrawClippedTexture(C,SliderDrawX - fSliderOffsetX,0.0,Image);
  if ( MouseIsOver() )
  {
    DrawClippedTexture(C,SliderDrawX - fSliderOffsetX,0.0,overImage);
  }
  DrawClippedTexture(C,TrackStart,0.0,knobImage);
}

