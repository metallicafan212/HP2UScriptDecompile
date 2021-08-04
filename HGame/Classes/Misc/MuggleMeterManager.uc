//================================================================================
// MuggleMeterManager.
//================================================================================

//this is an unused file -AdamJD

class MuggleMeterManager extends HudItemManager;

const fUPDATE_RATE= 0.1;
const fMETER_Y= 25;
const fMETER_X= 25;
const fBAR_FULL_EXTRA= 14.0;
const fEYE_POINTER_YOFFSET= 45.0;
const fEYE_W= 64.0;
const fBAR_Y= 8.0;
const fBAR_H= 128.0;
const fBAR_W= 31.0;
const strBAR_FULL= "HP_Menu.Hud.MuggleBarFull";
const strBAR_EMPTY= "HP_Menu.Hud.MuggleBarEmpty";
const strEYE4= "HP_Menu.Hud.MuggleEye4";
const strEYE3= "HP_Menu.Hud.MuggleEye3";
const strEYE2= "HP_Menu.Hud.MuggleEye2";
const strEYE1= "HP_Menu.Hud.MuggleEye1";
var harry PlayerHarry;
var Texture textureEye1;
var Texture textureEye2;
var Texture textureEye3;
var Texture textureEye4;
var Texture textureBarEmpty;
var Texture textureBarFull;
var Texture textureCurrEye;
var bool bHarryAvailable;
var float fMovement;
var float fBarFullAmount;
var float fTimeSinceLastUpdate;
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
        BeginDetection();
      }
    }
  }
}

event PostBeginPlay()
{
  Super.PostBeginPlay();
  textureEye1 = Texture(DynamicLoadObject("HP_Menu.Hud.MuggleEye1",Class'Texture'));
  textureEye2 = Texture(DynamicLoadObject("HP_Menu.Hud.MuggleEye2",Class'Texture'));
  textureEye3 = Texture(DynamicLoadObject("HP_Menu.Hud.MuggleEye3",Class'Texture'));
  textureEye4 = Texture(DynamicLoadObject("HP_Menu.Hud.MuggleEye4",Class'Texture'));
  textureBarEmpty = Texture(DynamicLoadObject("HP_Menu.Hud.MuggleBarEmpty",Class'Texture'));
  textureBarFull = Texture(DynamicLoadObject("HP_Menu.Hud.MuggleBarFull",Class'Texture'));
}

function BeginDetection()
{
  HPHud(PlayerHarry.myHUD).RegisterMuggleMeter(self);
  GotoState('DetectMuggles');
}

function EndDetection()
{
  HPHud(PlayerHarry.myHUD).RegisterMuggleMeter(None);
  GotoState('Idle');
}

function MugglesInRange (int nWeight)
{
  fMovement = nWeight;
}

function MugglesOutOfRange (int nWeight)
{
  fMovement = -nWeight;
}

auto state Idle
{
}

state DetectMuggles
{
  function Tick (float fDelta)
  {
    local float fPercentFull;
  
    if ( baseHUD(PlayerHarry.myHUD).bCutSceneMode == True )
    {
      return;
    }
    fTimeSinceLastUpdate += fDelta;
    if ( fTimeSinceLastUpdate < 0.1 )
    {
      return;
    }
    fTimeSinceLastUpdate = 0.0;
    fBarFullAmount += fMovement;
    if ( fBarFullAmount < 0 )
    {
      fBarFullAmount = 0.0;
    }
    if ( fBarFullAmount >= 128.0 )
    {
      TriggerEvent(Event,None,None);
      EndDetection();
    } else {
      fPercentFull = fBarFullAmount / 128.0;
      if ( fPercentFull < 0.25 )
      {
        textureCurrEye = textureEye1;
      } else //{
        if ( fPercentFull < 0.5 )
        {
          textureCurrEye = textureEye2;
        } else //{
          if ( fPercentFull < 0.75 )
          {
            textureCurrEye = textureEye3;
          } else {
            textureCurrEye = textureEye4;
          }
        //}
      //}
    }
  }
  
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    local float fScaleFactor;
    local float fBarEmptyX;
    local float fBarEmptyY;
    local float fBarFullX;
    local float fBarFullY;
    local float fEyeX;
    local float fEyeY;
    local float fBarFullH;
    local float fBottomOfBar;
  
    fScaleFactor = GetScaleFactor(Canvas);
    fBarEmptyX = 25.0 * fScaleFactor;
    fBarEmptyY = 25.0 * fScaleFactor;
    Canvas.SetPos(fBarEmptyX,fBarEmptyY);
    Canvas.DrawIcon(textureBarEmpty,fScaleFactor);
    fBottomOfBar = fBarEmptyY + 128.0 * fScaleFactor;
    fBarFullH = fBarFullAmount + 14.0;
    if ( fBarFullH >= 128.0 )
    {
      Canvas.SetPos(fBarEmptyX,fBarEmptyY);
      Canvas.DrawIcon(textureBarFull,fScaleFactor);
    } else {
      Canvas.SetPos(fBarEmptyX,fBottomOfBar - fBarFullH * fScaleFactor);
      Canvas.DrawTile(textureBarFull,textureBarFull.USize * fScaleFactor,fBarFullH * fScaleFactor,0.0,128.0 - fBarFullH,textureBarFull.USize,fBarFullH);
    }
    fEyeX = fBarEmptyX - (64.0 - 31.0) / 2 * fScaleFactor;
    fEyeY = fBottomOfBar - fBarFullAmount * fScaleFactor - (45.0 * fScaleFactor);
    Canvas.SetPos(fEyeX,fEyeY);
    Canvas.DrawIcon(textureCurrEye,fScaleFactor);
  }
  
  event BeginState()
  {
    textureCurrEye = textureEye1;
    fBarFullAmount = 0.0;
  }
  
}

defaultproperties
{
    bHidden=True

    // DrawType=1
	DrawType=DT_Sprite
}
