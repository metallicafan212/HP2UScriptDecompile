//================================================================================
// CutSceneManager.
//================================================================================

class CutSceneManager extends HudItemManager;

//texture import -AdamJD
#exec Texture Import File=Textures\Icons\leftPanel.PNG	GROUP=Icons	Name=leftPanel COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0

const SLIDE_DIVISOR= 15;
var Texture textureBorder;
var float fCurrBorderHeight;
var bool bResetBorderHeightToMax;
var string strText;
var string strCutCommentText;
var bool bBothBordersActive;
var bool bPopupBorderActive;
var Color colorCutTextBlue;
var bool bShowFF;
var Texture textureFFIcons[3];
var int curFFIcon;

function StartCutScene ()
{
  if (  !IsInState('SlideIn') &&  !IsInState('Hold') )
  {
    GotoState('SlideIn');
  }
}

function EndCutScene ()
{
  strCutCommentText = "";
  if (  !IsInState('SlideOut') &&  !IsInState('Idle') )
  {
    GotoState('SlideOut');
  }
}

function SetText (string strSetText, float fSetTextDuration)
{
  SetTimer(0.0,False);
  strText = strSetText;
  if ( fSetTextDuration > 0 )
  {
    SetTimer(fSetTextDuration,False);
  }
  StartCutScene();
}

function ClearText ()
{
  strText = "";
  strCutCommentText = "";
  if (  !Level.PlayerHarryActor.bIsCaptured )
  {
    EndCutScene();
  }
}

function SetCutCommentText (string strText)
{
  strCutCommentText = strText;
}

event Timer ()
{
  strText = "";
  if (  !Level.PlayerHarryActor.bIsCaptured )
  {
    EndCutScene();
  }
}

function DrawBorder (Canvas Canvas)
{
  if ( Level.PlayerHarryActor.bIsCaptured )
  {
    Canvas.SetPos(0.0,0.0);
    Canvas.DrawTile(textureBorder,Canvas.SizeX,fCurrBorderHeight,0.0,0.0,1.0,1.0);
  }
  Canvas.SetPos(0.0,Canvas.SizeY - fCurrBorderHeight);
  Canvas.DrawTile(textureBorder,Canvas.SizeX,fCurrBorderHeight,0.0,0.0,1.0,1.0);
}

function SetCurrBorderHeight (Canvas Canvas)
{
}

function float GetMaxBorderHeight (Canvas Canvas)
{
  return GetMaxBorderHeightFromCanvasHeight(Canvas.SizeY);
}

function float GetMaxBorderHeightFromCanvasHeight (int nCanvasSizeY)
{
  return nCanvasSizeY / 8.0;
}

function DrawText (Canvas Canvas)
{
  HPHud(Level.PlayerHarryActor.myHUD).DrawCutStyleText(Canvas,strText,0,Canvas.SizeY - fCurrBorderHeight + 1,GetMaxBorderHeight(Canvas),colorCutTextBlue);
  if ( strCutCommentText != "" )
  {
    HPHud(Level.PlayerHarryActor.myHUD).DrawCutStyleText(Canvas,strCutCommentText,0,5,GetMaxBorderHeight(Canvas),colorCutTextBlue);
  }
  if ( bShowFF )
  {
    if ( textureFFIcons[0] == None )
    {
      textureFFIcons[0] = Texture(DynamicLoadObject("HP2_Menu.Icons.FF1",Class'Texture'));
      textureFFIcons[1] = Texture(DynamicLoadObject("HP2_Menu.Icons.FF2",Class'Texture'));
      textureFFIcons[2] = Texture(DynamicLoadObject("HP2_Menu.Icons.FF3",Class'Texture'));
    }
	//from UEExplorer because UTPT didn't decompile it -AdamJD
	Canvas.SetPos(Canvas.SizeX / 2 - (textureFFIcons[curFFIcon % 3].USize) / 2, Canvas.SizeY / 2 - (textureFFIcons[curFFIcon % 3].VSize) / 2);
    Canvas.DrawIcon(textureFFIcons[curFFIcon / 10 % 3], 1.0);
    ++curFFIcon;
  }
}

auto state Idle
{
}

state SlideIn
{
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    SetCurrBorderHeight(Canvas);
    DrawBorder(Canvas);
    DrawText(Canvas);
    if ( fCurrBorderHeight >= GetMaxBorderHeight(Canvas) )
    {
      GotoState('Hold');
    }
  }
  
  function SetCurrBorderHeight (Canvas Canvas)
  {
    local float fMaxBorderHeight;
  
    fMaxBorderHeight = GetMaxBorderHeight(Canvas);
    if ( fCurrBorderHeight < fMaxBorderHeight )
    {
      fCurrBorderHeight += fMaxBorderHeight / 15;
    }
    if ( fCurrBorderHeight > fMaxBorderHeight )
    {
      fCurrBorderHeight = fMaxBorderHeight;
    }
  }
  
  function BeginState ()
  {
    if ( Level.PlayerHarryActor.bIsCaptured )
    {
      bBothBordersActive = True;
    } else {
      bPopupBorderActive = True;
    }
    fCurrBorderHeight = 0.0;
  }
  
}

state Hold
{
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    DrawBorder(Canvas);
    DrawText(Canvas);
  }
  
}

state SlideOut
{
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    if ( bResetBorderHeightToMax == True )
    {
      fCurrBorderHeight = GetMaxBorderHeight(Canvas);
      bResetBorderHeightToMax = False;
    }
    SetCurrBorderHeight(Canvas);
    DrawBorder(Canvas);
    if ( fCurrBorderHeight <= 0 )
    {
      bBothBordersActive = False;
      bPopupBorderActive = False;
      GotoState('Idle');
    }
  }
  
  function SetCurrBorderHeight (Canvas Canvas)
  {
    if ( fCurrBorderHeight > 0 )
    {
      fCurrBorderHeight -= GetMaxBorderHeight(Canvas) / 15;
    }
    if ( fCurrBorderHeight < 0 )
    {
      fCurrBorderHeight = 0.0;
    }
  }
  
  function BeginState ()
  {
    bResetBorderHeightToMax = True;
  }
  
}

defaultproperties
{
    textureBorder=Texture'HGame.Icons.leftPanel'

    colorCutTextBlue=(R=127,G=127,B=255,A=0)

}
