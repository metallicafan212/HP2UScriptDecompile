//================================================================================
// CountdownTimerManager.
//================================================================================

class CountdownTimerManager extends HudItemManager;

const fFULL_BAR_W= 118.0;
const fTIMER_EMPTY_H= 58.0;
const fTIMER_EMPTY_W= 205.0;
const strTIMER_BAR_EMPTY= "HP2_Menu.Icon.HP2EmptyBar";
const strTIMER_BAR_FULL= "HP2_Menu.Icon.HP2Timer";
var Texture textureTimerEmpty;
var Texture textureFullBar;
var float fFULL_OFFSET_X;
var float fFULL_OFFSET_Y;
var() bool bStartOnLevelLoad;
var() float fDuration;
var float fCountdownTime;
var float fLastTickTime;
var bool bShowNumericTime;


event PostBeginPlay ()
{
  if ( bStartOnLevelLoad == True )
  {
    SetTimer(0.2,False);
  }
  LoadTimerBarGraphics();
}

function LoadTimerBarGraphics ()
{
  fFULL_OFFSET_X = 51.0;
  fFULL_OFFSET_Y = 26.0;
  textureTimerEmpty = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2Timer",Class'Texture'));
  textureFullBar = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2EmptyBar",Class'Texture'));
}

function DrawCountdown (Canvas Canvas)
{
  local int Ox;
  local int Oy;
  local float fScaleFactor;
  local float fFullRatio;
  local float fSegmentWidth;

  fScaleFactor = Canvas.GetHudScaleFactor();
  Ox = Canvas.SizeX - 8 * fScaleFactor - 205.0 * fScaleFactor;
  Oy = Canvas.SizeY - 8 * fScaleFactor - 58.0 * fScaleFactor;
  Canvas.SetPos(Ox,Oy);
  Canvas.DrawIcon(textureTimerEmpty,fScaleFactor);
  fFullRatio = fCountdownTime / GetTimerDuration();
  fSegmentWidth = fFullRatio * 118.0;
  Canvas.SetPos(Ox + fFULL_OFFSET_X * fScaleFactor,Oy + fFULL_OFFSET_Y * fScaleFactor);
  Canvas.DrawTile(textureFullBar,fSegmentWidth * fScaleFactor,textureFullBar.VSize * fScaleFactor,0.0,0.0,fSegmentWidth,textureFullBar.VSize);
  DrawTuningModeData(Canvas);
}

event Timer ()
{
  if ( bStartOnLevelLoad )
  {
    if ( Level.PlayerHarryActor == None )
    {
      SetTimer(0.2,False);
    } else {
      if ( bStartOnLevelLoad )
      {
        StartCountDown();
      }
    }
  }
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local string sCutName;
  local Actor A;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "Capture" )
  {
    return True;
  } else //{
    if ( sActualCommand ~= "Release" )
    {
      return True;
    } else //{
      if ( sActualCommand ~= "StartCountdown" )
      {
        StartCountDown();
        CutNotifyActor.CutCue(cue);
        return True;
      } else //{
        if ( sActualCommand ~= "StopCountdown" )
        {
          StopCountDown();
          CutNotifyActor.CutCue(cue);
          return True;
        } else {
          return False;
        }
      // }
    // }
  // }
}

function float GetTimerDuration ()
{
  return fDuration;
}

function StartCountDown ()
{
  HPHud(Level.PlayerHarryActor.myHUD).RegisterCountdownTimerManager(self);
  GotoState('CountingDown');
}

function StopCountDown ()
{
  HPHud(Level.PlayerHarryActor.myHUD).RegisterCountdownTimerManager(None);
  GotoState('Idle');
}

function DrawTuningModeData (Canvas Canvas)
{
  local string strCurrTime;

  if ( bShowNumericTime )
  {
    Canvas.SetPos(Canvas.SizeX - 75,Canvas.SizeY - 60);
    strCurrTime = string(int(GetTimerDuration() - fCountdownTime));
	Canvas.DrawText(strCurrTime,False);
  }
}

function PlayCountdownSound ()
{
  local BaseCam Cam;

  if ( Abs(fLastTickTime - fCountdownTime) > 1.0 )
  {
    Cam = harry(Level.PlayerHarryActor).Cam;
    if ( fCountdownTime > 30.0 )
    {
      Cam.PlaySound(Sound'timer_1',/*0*/SLOT_None,0.5,,,,True);
    } else //{
      if ( fCountdownTime > 20.0 )
      {
        Cam.PlaySound(Sound'timer_2',/*0*/SLOT_None,0.5,,,,True);
      } else //{
        if ( fCountdownTime > 15.0 )
        {
          Cam.PlaySound(Sound'timer_3',/*0*/SLOT_None,0.5,,,,True);
        } else //{
          if ( fCountdownTime > 10.0 )
          {
            Cam.PlaySound(Sound'timer_4',/*0*/SLOT_None,0.5,,,,True);
          } else //{
            if ( fCountdownTime > 5.0 )
            {
              Cam.PlaySound(Sound'timer_5',/*0*/SLOT_None,0.5,,,,True);
            } else {
              Cam.PlaySound(Sound'timer_6',/*0*/SLOT_None,0.5,,,,True);
            }
          // }
        // }
      // }
    // }
    fLastTickTime = fCountdownTime;
  }
}

auto state Idle
{
  event Trigger (Actor Other, Pawn EventInstigator)
  {
    Level.PlayerHarryActor.ClientMessage("countdown ON");
    StartCountDown();
  }
  
}

state CountingDown
{
  event Tick (float fDelta)
  {
    if (  !HPHud(Level.PlayerHarryActor.myHUD).IsCutSceneOrPopupInProgress() )
    {
      fCountdownTime -= fDelta;
    }
    if ( fCountdownTime <= 0.0 )
    {
      StopCountDown();
      TriggerEvent(Event,None,None);
    }
  }
  
  event Trigger (Actor Other, Pawn EventInstigator)
  {
    Level.PlayerHarryActor.ClientMessage("countdown off");
    StopCountDown();
  }
  
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    if ( bMenuMode )
    {
      return;
    }
    DrawCountdown(Canvas);
    PlayCountdownSound();
  }
  
  event BeginState ()
  {
    fCountdownTime = GetTimerDuration();
    fLastTickTime = 0.0;
  }
  
}

defaultproperties
{
    bHidden=True

    // DrawType=1
	DrawType=DT_Sprite

    CutName="CountdownTimerManager"
}
