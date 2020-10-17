//================================================================================
// MagicStrengthManager.
//================================================================================

//this is an unused file -AdamJD

class MagicStrengthManager extends HudItemManager;

const fRECOVER_RATE= 0.1;
const fTOTAL_STRENGTH= 120;
const fSLIDER_POINTER_YOFFSET= 66;
const fSLIDER_W= 128;
const fBAR_Y= 25.0;
const fBAR_X= 25.0;
const fBAR_H= 128.0;
const fBAR_W= 36.0;
const strBAR_FULL= "HP_Menu.Hud.MagicStrengthFull";
const strBAR_EMPTY= "HP_Menu.Hud.MagicStrengthEmpty";
const strSLIDER= "HP_Menu.Hud.MagicStrengthSlider";
var float fRemainingStrength;
var Texture textureSlider;
var Texture textureBarEmpty;
var Texture textureBarFull;
var bool bHarryAvailable;
var float fTimeSinceLastRecover;
var harry PlayerHarry;
var() bool bDisplayAtLevelLoad;

event Tick (float fDelta)
{
  if (  !bHarryAvailable )
  {
    if ( Level.PlayerHarryActor != None )
    {
      PlayerHarry = harry(Level.PlayerHarryActor);
      bHarryAvailable = True;
      if ( bDisplayAtLevelLoad )
      {
        StartMagicStrength();
      }
    }
  }
}

event PostBeginPlay ()
{
  Super.PostBeginPlay();
  textureSlider = Texture(DynamicLoadObject("HP_Menu.Hud.MagicStrengthSlider",Class'Texture'));
  textureBarEmpty = Texture(DynamicLoadObject("HP_Menu.Hud.MagicStrengthEmpty",Class'Texture'));
  textureBarFull = Texture(DynamicLoadObject("HP_Menu.Hud.MagicStrengthFull",Class'Texture'));
}

function StartMagicStrength ()
{
  HPHud(PlayerHarry.myHUD).RegisterMagicStrength(self);
  GotoState('DisplayStrength');
}

function EndMagicStrength ()
{
  HPHud(PlayerHarry.myHUD).RegisterMagicStrength(None);
  GotoState('Idle');
}

function UseUpStrength (int nPercent)
{
  fRemainingStrength -= 120 * (nPercent / 100.0);
  PlayerHarry.ClientMessage("remaining strength " $ string(fRemainingStrength));
  if ( fRemainingStrength < 0 )
  {
    fRemainingStrength = 0.0;
  }
}

auto state Idle
{
}

state DisplayStrength
{
  function Tick (float fDelta)
  {
    local float fPercentFull;
  
    if ( baseHUD(PlayerHarry.myHUD).bCutSceneMode == True )
    {
      return;
    }
    if ( fRemainingStrength <= 0 )
    {
      TriggerEvent(Event,None,None);
      EndMagicStrength();
    }
    fTimeSinceLastRecover += fDelta;
    if ( fTimeSinceLastRecover >= 0.1 )
    {
      fTimeSinceLastRecover = 0.0;
      fRemainingStrength += 1 + (fTimeSinceLastRecover - 0.1);
      if ( fRemainingStrength > 120 )
      {
        fRemainingStrength = 120.0;
      }
    }
  }
  
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    local float fScaleFactor;
    local float fBarScaledX;
    local float fBarScaledY;
    local float fSliderX;
    local float fSliderY;
    local float fBarEmptyH;
  
    fScaleFactor = GetScaleFactor(Canvas);
    fBarScaledX = 25.0 * fScaleFactor;
    fBarScaledY = 25.0 * fScaleFactor;
    Canvas.SetPos(fBarScaledX,fBarScaledY);
    Canvas.DrawIcon(textureBarFull,fScaleFactor);
    fBarEmptyH = 120.0 - fRemainingStrength;
    Canvas.SetPos(fBarScaledX,fBarScaledY);
    Canvas.DrawTile(textureBarEmpty,textureBarEmpty.USize * fScaleFactor,fBarEmptyH * fScaleFactor,0.0,0.0,textureBarEmpty.USize,fBarEmptyH);
    fSliderX = fBarScaledX - (128 - 36.0 / 2) * fScaleFactor;
    fSliderY = (25.0 + fBarEmptyH - 66) * fScaleFactor;
    Canvas.SetPos(fSliderX,fSliderY);
    Canvas.DrawIcon(textureSlider,fScaleFactor);
  }
  
  event BeginState ()
  {
    fRemainingStrength = 120.0;
  }
  
}

defaultproperties
{
    bHidden=True

    // DrawType=1
	DrawType=DT_Sprite
}
