//================================================================================
// ChallengeScoreManager.
//================================================================================

class ChallengeScoreManager extends HudItemManager;

const nMASTER_BONUS_HPOINTS= 50;
const nTALLY_ICONS_Y=  2;
const nTALLY_HIGH_SCORE_MIDY= 115;
const nTALLY_HIGH_SCORE_MIDX= 93;
const nTALLY_CURR_SCORE_MIDY= 115;
const nTALLY_CURR_SCORE_MIDX= 30;
const nTALLY_SCORE_HEIGHT= 128;
const nTALLY_SCORE_WIDTH= 128;
const strTALLY_SCORE_ICON= "HP2_Menu.Icons.HP2BigChallengeScore";
const nHIGH_SCORE_MIDY= 65;
const nHIGH_SCORE_MIDX= 93;
const nCURR_SCORE_MIDY= 65;
const nCURR_SCORE_MIDX= 32;
const nSCORE_WIDTH= 128;
const strSCORE_ICON= "HP2_Menu.Icons.HP2ChallengeScore";
const STAR_VALUE= 200;
const DECREMENT_SECONDS= 1.0;
const DECREMENT_VALUE= 1;
var harry PlayerHarry;
var int nHighScore;
var Texture textureScoreIcon;
var Texture textureTallyScoreIcon;
var Texture textureTallyPointsIcon;
var int nCurrScore;
var int nAwardGryffPoints;
var StatusItem siGryffHousePoints;
var string strTallyCue;
var Sound soundTally;
var float fTallySoundDuration;
var int nTallyPointsPerTick;
var float fTickDelta;
var float fTicksPerSec;
var bool bFirstTime;
var bool bMastered;
var bool bSentWarnTimeEvent;
var bool bFastForwardTally;
var StatusItemJellybeans siJellybeans;
var StatusItemGryffindorPts siGryffPts;
var StatusItemStars siStars;
var(ChallengeManager) name nameChallengeLevel;
var(ChallengeManager) int nStartScore;
var(ChallengeManager) int nMaxHousePoints;
var(ChallengeManager) int nMaxScore;
var(ChallengeManager) name EventTimeUp;
var(ChallengeManager) name EventTimeUpRestart;
var(ChallengeManager) name EventRunningOutOfTime;
var(ChallengeManager) int nWarnTimeAlmostUp;


event PostBeginPlay ()
{
  Super.PostBeginPlay();
  textureScoreIcon = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2ChallengeScore",Class'Texture'));
  textureTallyScoreIcon = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2BigChallengeScore",Class'Texture'));
  bSentWarnTimeEvent = False;
}

function BeginChallenge ()
{
  foreach AllActors(Class'harry',PlayerHarry)
  {
    // goto JL0014;
	break;
  }
  siJellybeans = StatusItemJellybeans(PlayerHarry.managerStatus.GetStatusItem(Class'StatusGroupJellybeans',Class'StatusItemJellybeans'));
  siGryffPts = StatusItemGryffindorPts(PlayerHarry.managerStatus.GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemGryffindorPts'));
  siStars = StatusItemStars(PlayerHarry.managerStatus.GetStatusItem(Class'StatusGroupStars',Class'StatusItemStars'));
  HPHud(PlayerHarry.myHUD).RegisterChallengeManager(self);
  GotoState('ChallengeInProgress');
}

function EndChallenge ()
{
  local HPawn foreachActor;

  foreach AllActors(Class'HPawn',foreachActor)
  {
    foreachActor.PlayerCutCapture();
  }
  GotoState('Idle');
}

function TallyChallenge ()
{
  GotoState('Tally');
}

function PickedUpStar ()
{
  Log("Error: Picked up star, but challenge has not been started");
}

function PickedUpFinalStar ()
{
  EndChallenge();
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
      if ( sActualCommand ~= "BeginChallenge" )
      {
        BeginChallenge();
        CutNotifyActor.CutCue(cue);
        return True;
      } else //{
        if ( sActualCommand ~= "EndChallenge" )
        {
          EndChallenge();
          CutNotifyActor.CutCue(cue);
          return True;
        } else //{
          if ( sActualCommand ~= "TallyChallenge" )
          {
            strTallyCue = cue;
            if ( bFastFlag )
            {
              bFastForwardTally = True;
            } else {
              bFastForwardTally = False;
            }
            TallyChallenge();
            return True;
          } else {
            return False;
          }
        // }
      // }
    // }
  // }
}

function bool CutQuestion (string question)
{
  //local StatusItem siStars;
  local StatusItem stiStars;

  CutErrorString = "";
  if ( question ~= "ChallengeIsFirstTime" )
  {
    return bFirstTime;
  } else //{
    if ( question ~= "ChallengePreviouslyBeaten" )
    {
      return  !bFirstTime &&  !bMastered;
    } else //{
      if ( question ~= "ChallengePreviouslyMastered" )
      {
        return bMastered;
      } else //{
        if ( question ~= "ChallengeWorseThanBefore" )
        {
          return WorseThanBefore() &&  !PreviouslyMastered();
        } else //{
          if ( question ~= "ChallengeJustWonFirstTime" )
          {
            return JustWonFirstTime() &&  !JustMastered();
          } else //{
            if ( question ~= "ChallengeJustMastered" )
            {
              return JustMastered();
            } else //{
              if ( question ~= "ChallengeNewBestScore" )
              {
                return NewBestScore() &&  !JustMastered() &&  !PreviouslyMastered();
              } else //{
                if ( question ~= "ChallengeMissedStars" )
                {
                  stiStars = PlayerHarry.managerStatus.GetStatusItem(Class'StatusGroupStars',Class'StatusItemStars');
                  if ( stiStars != None )
                  {
                    if ( (stiStars.nCount == 0) && (stiStars.nMaxCount == 0) )
                    {
                      return True;
                    } else {
                      return stiStars.nCount != stiStars.nMaxCount;
                    }
                  } else {
                    return True;
                  }
                } else {
                  return Super.CutQuestion(question);
                }
              // }
            // }
          // }
        // }
      // }
    // }
  // }
}

function bool WorseThanBefore ()
{
  return nCurrScore <= nHighScore;
}

function bool JustWonFirstTime ()
{
  return (nHighScore == 0) && (nCurrScore > 0);
}

function bool NewBestScore ()
{
  return (nCurrScore > nHighScore) && (nHighScore > 0);
}

function bool JustMastered ()
{
  return (nHighScore < nMaxScore) && (nCurrScore >= nMaxScore);
}

function bool PreviouslyMastered ()
{
  return bMastered;
}

function GetScorePosition (Canvas Canvas, out int nIconX, out int nIconY)
{
  Log("ERROR: states need to override GetScorePosition()");
}

function GetInProgressScorePosition (Canvas Canvas, out int nIconX, out int nIconY)
{
  local float fScaleFactor;

  fScaleFactor = GetScaleFactor(Canvas);
  nIconX = Canvas.SizeX / 2 - (128 / 2 * fScaleFactor);
  nIconY = 4 * fScaleFactor;
  return;
}

function GetTallyScorePosition (Canvas Canvas, out int nIconX, out int nIconY)
{
  local float fScaleFactor;

  fScaleFactor = GetScaleFactor(Canvas);
  nIconX = Canvas.SizeX / 2 - (128 / 2 * fScaleFactor);
  nIconY = 2 * fScaleFactor;
  return;
}

function GetCurrScoreTextXY (out int nMidX, out int nMidY)
{
  Log("ERROR: states need to override GetCurrScoreTextXY()");
}

function GetHighScoreTextXY (out int nMidX, out int nMidY)
{
  Log("ERROR: states need to override GetCurrScoreTextXY()");
}

function Texture GetScoreTexture ()
{
  Log("ERROR: states need to override GetScoreTexture()");
}

function DrawScore (Canvas Canvas, bool bMenuMode)
{
  local float fScaleFactor;
  local int nIconX;
  local int nIconY;
  local int nMidX;
  local int nMidY;
  local Color colorSave;
  local Font fontSave;
  local string strCurrScore;
  local string strPrevHighScore;
  local float nXTextLen;
  local float nYTextLen;

  if ( bMenuMode )
  {
    return;
  }
  fScaleFactor = GetScaleFactor(Canvas);
  GetScorePosition(Canvas,nIconX,nIconY);
  Canvas.SetPos(nIconX,nIconY);
  Canvas.DrawIcon(GetScoreTexture(),fScaleFactor);
  nXTextLen = 0.0;
  nYTextLen = 0.0;
  colorSave = Canvas.DrawColor;
  fontSave = Canvas.Font;
  strCurrScore = string(nCurrScore);
  strPrevHighScore = string(nHighScore);
  Canvas.DrawColor.R = 0;
  Canvas.DrawColor.G = 0;
  Canvas.DrawColor.B = 0;
  Canvas.Font = GetScoreFont(Canvas);
  Canvas.TextSize(strCurrScore,nXTextLen,nYTextLen);
  GetCurrScoreTextXY(nMidX,nMidY);
  Canvas.SetPos(nIconX + (nMidX * fScaleFactor) - nXTextLen / 2,nIconY + (nMidY * fScaleFactor) - nYTextLen / 2);
  Canvas.DrawText(strCurrScore,False);
  Canvas.TextSize(strPrevHighScore,nXTextLen,nYTextLen);
  GetHighScoreTextXY(nMidX,nMidY);
  Canvas.SetPos(nIconX + (nMidX * fScaleFactor) - nXTextLen / 2,nIconY + (nMidY * fScaleFactor) - nYTextLen / 2);
  Canvas.DrawText(strPrevHighScore,False);
  Canvas.DrawColor = colorSave;
  Canvas.Font = fontSave;
}

function Font GetScoreFont (Canvas Canvas)
{
  local Font fontRet;

  if ( Canvas.SizeX <= 512 )
  {
    fontRet = baseConsole(PlayerHarry.Player.Console).LocalSmallFont;
  } else //{
    if ( Canvas.SizeX <= 640 )
    {
      fontRet = baseConsole(PlayerHarry.Player.Console).LocalMedFont;
    } else {
      fontRet = baseConsole(PlayerHarry.Player.Console).LocalBigFont;
    }
  //}
  return fontRet;
}

function int GetHousePointsFromScore (int nScore)
{
  local int A;
  local int B;

  A = nMaxScore;
  B = nMaxHousePoints;
  if ( nScore <= 0 )
  {
    return 0;
  } else //{
    if ( nScore < A / 3 )
    {
      return (B * nScore) / (2 * A);
    } else //{
      if ( nScore < 2 * A / 3 )
      {
        return (B * nScore / A) - (B / 6);
      } else //{
        if ( nScore < A )
        {
          return (3 * B * nScore) / (2 * A) - (B / 2);
        } else {
          return B;
        }
      // }
    // }
  //}
}

auto state Idle
{
}

state ChallengeInProgress
{
  function Timer ()
  {
    if ( (nCurrScore > 0) && (baseHUD(PlayerHarry.myHUD).bCutSceneMode == False) &&  !PlayerHarry.IsInState('CelebrateCardSet') )
    {
      nCurrScore -= 1;
    }
    if ( nCurrScore <= 0 )
    {
      nCurrScore = 0;
      if ( nHighScore == 0 )
      {
        if ( EventTimeUpRestart != 'None' )
        {
          TriggerEvent(EventTimeUpRestart,self,None);
        }
      } else {
        if ( EventTimeUp != 'None' )
        {
          TriggerEvent(EventTimeUp,self,None);
        }
      }
    } else //{
      if ( (nWarnTimeAlmostUp != 0) && (nWarnTimeAlmostUp >= nCurrScore) &&  !bSentWarnTimeEvent )
      {
        bSentWarnTimeEvent = True;
        TriggerEvent(EventRunningOutOfTime,self,None);
      }
    //}
  }
  
  function PickedUpStar ()
  {
    nCurrScore += STAR_VALUE;
  }
  
  function GetScorePosition (Canvas Canvas, out int nIconX, out int nIconY)
  {
    GetInProgressScorePosition(Canvas,nIconX,nIconY);
  }
  
  function Texture GetScoreTexture ()
  {
    return textureScoreIcon;
  }
  
  function GetCurrScoreTextXY (out int nMidX, out int nMidY)
  {
    nMidX = 32;
    nMidY = 65;
  }
  
  function GetHighScoreTextXY (out int nMidX, out int nMidY)
  {
    nMidX = 93;
    nMidY = 65;
  }
  
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    if (  !bFullCutMode )
    {
      DrawScore(Canvas,bMenuMode);
    }
  }
  
  function BeginState ()
  {
    nCurrScore = nStartScore;
    SetTimer(1.0,True);
  }
  
}

state Tally
{
  function CutBypass ()
  {
    Super.CutBypass();
    bFastForwardTally = True;
    if ( nHighScore < nCurrScore )
    {
      nHighScore = nCurrScore;
    }
    GotoState('PostTallyHoldPoints');
  }
  
  function Tick (float fDeltaTime)
  {
    if ( fTickDelta > 0.0 )
    {
      if ( nHighScore < nCurrScore )
      {
        nHighScore += nTallyPointsPerTick;
        if ( nHighScore > nCurrScore )
        {
          nHighScore = nCurrScore;
        }
      } else {
        GotoState('PostTallyHold');
      }
    } else {
      fTickDelta = fDeltaTime;
    }
  }
  
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    DrawScore(Canvas,bMenuMode);
  }
  
  function GetScorePosition (Canvas Canvas, out int nIconX, out int nIconY)
  {
    GetTallyScorePosition(Canvas,nIconX,nIconY);
  }
  
  function Texture GetScoreTexture ()
  {
    return textureTallyScoreIcon;
  }
  
  function GetCurrScoreTextXY (out int nMidX, out int nMidY)
  {
    nMidX = 30;
    nMidY = 115;
  }
  
  function GetHighScoreTextXY (out int nMidX, out int nMidY)
  {
    nMidX = 93;
    nMidY = 115;
  }
  
  function BeginState ()
  {
    local StatusGroup sgHousePoints;
    local float fTallyPointsPerSec;
  
    fTickDelta = 0.0;
    if ( nCurrScore < nHighScore )
    {
      nAwardGryffPoints = 0;
      GotoState('PostTallyHold');
    } else {
      nAwardGryffPoints = GetHousePointsFromScore(nCurrScore);
      nAwardGryffPoints -= GetHousePointsFromScore(nHighScore);
      if (  !bMastered && (nCurrScore >= nMaxScore) )
      {
        nAwardGryffPoints += 50;
      }
    }
    if ( bFastForwardTally == True )
    {
      if ( nHighScore < nCurrScore )
      {
        nHighScore = nCurrScore;
      }
      GotoState('PostTallyHoldPoints');
    }
  }
  
  function EndState ()
  {
    StopSound(soundTally,SLOT_Interact);
    bFirstTime = False;
    if (  !bMastered && (nHighScore >= nMaxScore) )
    {
      bMastered = True;
    }
  }
  
 begin:
  // if ( fTickDelta <= 0.0 )
  while ( fTickDelta <= 0.0 )
  {
    Sleep(0.1);
    // goto JL0000;
  }
  fTicksPerSec = 1.0 / fTickDelta;
  nTallyPointsPerTick = (nCurrScore - nHighScore) / 3.0 * fTicksPerSec;
  if ( nTallyPointsPerTick < 1 )
  {
    nTallyPointsPerTick = 1;
  }
  fTallySoundDuration = GetSoundDuration(soundTally);
 loop:
  PlayerHarry.PlaySound(soundTally,SLOT_Interact);
  Sleep(fTallySoundDuration);
  goto ('Loop');
}

state PostTallyHold
{
  function CutBypass ()
  {
    Super.CutBypass();
    SetTimer(0.0,False);
    bFastForwardTally = True;
    GotoState('PostTallyHoldPoints');
  }
  
  function Timer ()
  {
    GotoState('PostTallyHoldPoints');
  }
  
  function BeginState ()
  {
    SetTimer(4.0,False);
  }
  
  function GetScorePosition (Canvas Canvas, out int nIconX, out int nIconY)
  {
    GetTallyScorePosition(Canvas,nIconX,nIconY);
  }
  
  function Texture GetScoreTexture ()
  {
    return textureTallyScoreIcon;
  }
  
  function GetCurrScoreTextXY (out int nMidX, out int nMidY)
  {
    nMidX = 30;
    nMidY = 115;
  }
  
  function GetHighScoreTextXY (out int nMidX, out int nMidY)
  {
    nMidX = 93;
    nMidY = 115;
  }
  
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    DrawScore(Canvas,bMenuMode);
  }
  
}

state PostTallyHoldPoints
{
  function CutBypass ()
  {
    Super.CutBypass();
    SetTimer(0.0,False);
    GotoState('Idle');
  }
  
  function Timer ()
  {
    GotoState('Idle');
  }
  
  function BeginState ()
  {
    if ( bFastForwardTally == True )
    {
      GotoState('Idle');
    } else {
      SetTimer(5.0,False);
    }
  }
  
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    local string strPoints;
    local string strBeans;
    local string strStars;
    local int nNumBeans;
    local int nNumStars;
    local float fScaleFactor;
    local int nPointsIconX;
    local int nPointsIconY;
    local int nBeansIconX;
    local int nBeansIconY;
    local int nStarIconX;
    local int nStarIconY;
    local Color colorSave;
    local Font fontSave;
    local float nXTextLen;
    local float nYTextLen;
    local StatusItem siHudItem;
  
    if ( bMenuMode )
    {
      return;
    }
    fScaleFactor = GetScaleFactor(Canvas);
    nPointsIconX = Canvas.SizeX / 2 - (siGryffPts.GetHudIconUSize() / 2) * fScaleFactor;
	nPointsIconY = 2 * fScaleFactor;
	Canvas.SetPos(nPointsIconX,nPointsIconY);
    Canvas.DrawIcon(siGryffPts.textureHudIcon,fScaleFactor);
    siGryffPts.DrawSpecifiedCount(Canvas,nPointsIconX,nPointsIconY,fScaleFactor,nAwardGryffPoints);
    nBeansIconX = nPointsIconX - (siJellybeans.GetHudIconUSize() + 30) * fScaleFactor;
	nBeansIconY = nPointsIconY + (siGryffPts.GetHudIconVSize() / 2) * fScaleFactor - (siJellybeans.GetHudIconVSize() / 2) * fScaleFactor;
	Canvas.SetPos(nStarIconX,nStarIconY);
    siJellybeans.DrawItem(Canvas,nBeansIconX,nBeansIconY,fScaleFactor);
    nStarIconX = nPointsIconX + (siGryffPts.GetHudIconUSize() + 30) * fScaleFactor;
	nStarIconY = nPointsIconY + (siGryffPts.GetHudIconVSize() / 2) * fScaleFactor - (siStars.GetHudIconVSize() / 2) * fScaleFactor;
	Canvas.SetPos(nStarIconX,nStarIconY);
    siStars.DrawItem(Canvas,nStarIconX,nStarIconY,fScaleFactor);
  }
  
  function EndState ()
  {
    siGryffHousePoints = PlayerHarry.managerStatus.GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemGryffindorPts');
    siGryffHousePoints.IncrementCount(nAwardGryffPoints);
    PlayerHarry.UpdateChallengeScores(string(nameChallengeLevel),nHighScore,nMaxScore);
    CutNotifyActor.CutCue(strTallyCue);
  }
  
}

defaultproperties
{
    soundTally=Sound'HPSounds.menu_sfx.score_tally_up'

    bFirstTime=True

    nStartScore=1000

    nMaxHousePoints=200

    nMaxScore=1260

    EventTimeUp=ChallengeTimeUp

    EventTimeUpRestart=ChallengeTimeUpRestart

    EventRunningOutOfTime=ChallengeRunningOutOfTime

    nWarnTimeAlmostUp=100

    bHidden=True

    bPersistent=True

    // DrawType=1
	DrawType=DT_Sprite

    CutName="ChallengeScoreManager"
}
