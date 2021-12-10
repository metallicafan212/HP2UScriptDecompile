//================================================================================
// baseWarning.
//================================================================================

class baseWarning extends basePopup;

//texture import -AdamJD
#exec Texture Import File=Textures\Icons\leftPanel.PNG	GROUP=Icons	Name=leftPanel COMPRESSION=3 UPSCALE=1 Mips=0 Flags=0

var string DisplayText;
var float fFlashTime;
var bool bShow;

function Tick (float fDeltaTime)
{
  Super.Tick(fDeltaTime);
  fFlashTime += fDeltaTime;
}

function Draw (Canvas Canvas)
{
  local Font saveFont;
  local float fTextHeight;
  local float fTextWidth;
  local int t;
  local Texture Background;

  saveFont = Canvas.Font;
  if ( bShow )
  {
    if ( fFlashTime > 1 )
    {
      bShow = True;
      fFlashTime = 0.0;
    }
    Background = Texture'leftPanel';
    Background.Alpha = 0.5;
    Background.bTransparent = True;
    Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalBigFont;
    Canvas.TextSize(DisplayText,fTextWidth,fTextHeight);
    if ( fTextWidth > Canvas.SizeX - 32 )
    {
      Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalMedFont;
      Canvas.TextSize(DisplayText,fTextWidth,fTextHeight);
      if ( fTextWidth > Canvas.SizeX - 32 )
      {
        Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalSmallFont;
        Canvas.TextSize(DisplayText,fTextWidth,fTextHeight);
      }
    }
    Canvas.SetPos(Canvas.SizeX / 2 - (fTextWidth / 2) - 8,8.0);
    Canvas.DrawTile(Background,fTextWidth + 16,fTextHeight + 16,0.0,0.0,1.0,1.0);
    Canvas.SetPos(Canvas.SizeX / 2 - (fTextWidth / 2),16.0);
    Canvas.DrawText(DisplayText,False);
  } else {
    if ( fFlashTime > 0.5 )
    {
      bShow = True;
      fFlashTime = 0.0;
    }
  }
  Canvas.Font = saveFont;
}

defaultproperties
{
    DisplayText="WARNING"

    bShow=True

    LifeSpan=0.00

}
