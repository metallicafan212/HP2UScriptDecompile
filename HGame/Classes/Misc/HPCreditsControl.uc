//================================================================================
// HPCreditsControl.
//================================================================================

class HPCreditsControl extends UWindowDialogControl;

var float _StartTime;
var int _FirstVisibleCreditIdx;
var float _FirstVisibleCreditYDelta;

function Created ()
{
  Super.Created();
  _StartTime = -1.0;
  bAlwaysOnTop = True;
}

function Reset ()
{
  _StartTime = -1.0;
}

function Paint (Canvas C, float MouseX, float MouseY)
{
  local float LineWidth;
  local float LineHeight;
  local float Y;
  local float YDelta;
  local int idx;
  local bool bDone;
  local int FontIdx;
  local string S;

  if ( _StartTime < 0.0 )
  {
    _StartTime = GetLevel().TimeSeconds;
    _FirstVisibleCreditIdx = 0;
    _FirstVisibleCreditYDelta = 0.0;
  }
  C.DrawColor = TextColor;
  Y = WinHeight - (GetLevel().TimeSeconds - _StartTime) * 30.0;
  YDelta = _FirstVisibleCreditYDelta;
  idx = _FirstVisibleCreditIdx;
  bDone = False;
  // if (  !bDone )
  while (  !bDone )
  {
    C.Font = Root.Fonts[2];
    S = Localize("all","Line" $idx,"HPCredits");
    if ( Left(S,1) == "/" )
    {
      if ( Mid(S,1,1) ~= "Q" )
      {
        bDone = True;
        S = "";
      } else //{
        if ( Mid(S,1,1) ~= "B" )
        {
          C.Font = Root.Fonts[3];
          S = Mid(S,2);
        }
      //}
    }
    if ( S != "" )
    {
      TextSize(C,S,LineWidth,LineHeight);
      ClipText(C,(WinWidth - LineWidth) / 2,Y + YDelta,S);
    } else {
      TextSize(C,"A",LineWidth,LineHeight);
    }
    YDelta += LineHeight;
    idx++;
    if ( Y + YDelta < 0.0 )
    {
      _FirstVisibleCreditIdx = idx;
      _FirstVisibleCreditYDelta = YDelta;
    }
    if ( Y + YDelta > WinHeight )
    {
      bDone = True;
    }
    // goto JL0092;
  }
  if ( Y + YDelta < 0.0 )
  {
    _StartTime = -1.0;
  }
}

defaultproperties
{
    TextColor=(R=255,G=255,B=255,A=0)

}
