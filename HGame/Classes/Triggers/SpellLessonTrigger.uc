//================================================================================
// SpellLessonTrigger.
//================================================================================

class SpellLessonTrigger extends Trigger;

const nNUM_LEVELS= 3;
const fEND_MUSIC_FADE_OUT= 0.5;
const fFAIL_MUSIC_LEN= 9.0;
const fWON_MUSIC_LEN= 7.5;
const strFAIL_MUSIC= "sm_bur_PlayfulFail_01";
const strWON_MUSIC= "sm_bur_PlayfulReward_01";
const strSKURGE_SPONG_GAME_MUSIC= "sm_bur_playful_01V2";
const strRICTU_DIFF_GAME_MUSIC= "sm_bur_playful_01_loopedit";
const fHITPOINT_NEXT_MISS_RANGE= 26;
const fHITPOINT_PREV_MISS_RANGE= 17;
const fHITPOINT_RANGE= 14;
const nHIT_INDICATOR_PAR_MID_Y= 92;
const nHIT_INDICATOR_PLAYER_MID_Y= 14;
const nHIT_INDICATOR_MID_X= 37;
const nHIT_INDICATOR_H= 93;
const nHIT_INDICATOR_W= 76;
enum ELessonKey {
  LessonKey_Up,
  LessonKey_Down,
  LessonKey_Left,
  LessonKey_Right
};

enum ELessonShape {
  LessonShape_Rictusempra,
  LessonShape_Skurge,
  LessonShape_Diffindo,
  LessonShape_Spongify
};

enum ECameraSettings {
  CS_GameShape,
  CS_BackToNormal
};
var() int nLevel;
var() ELessonShape LessonShape;
var() name nameShape;
var() name nameBackground;
var() name nameCutCam;
var() name nameSplinePath;
var() name nameIPStart;
var() name nameIPEnd;
var() float fWandSpeed;
var() int nMaxLoops[3];
var SpellLessonWand GameWand;
var SpellLessonShape GameShape;
var CutCameraPos GameCutCam;
var InterpolationPoint GameIPStart;
var InterpolationPoint GameIPEnd;
var Characters Professor;
var harry PlayerHarry;
var BaseCam Cam;
var int nKeyNeedsReset[4];
var Sound soundWand;
var int nHitPointHits;
var int nHitPointsInLevel;
var int nHitPointsPassed;
var int nCurrTimesAround;
var string strIntroDialogId;
var string strTutorial1aId;
var string strTutorial1bId;
var string strTutorial1cId;
var string strEncourageDoingGood[2];
var string strEncourageAny[2];
var string strTryAgain[3];
var string strTryOneLastTime[2];
var string strLevelCompleteId;
var string str5PointsAwardedId;
var string str10PointsAwardedId;
var string str15PointsAwardedId;
var string strAllLevelsCompleteId;
var string strMoveOnAnywayId;
var string strRound1Id;
var string strRound2Id;
var string strRound3Id;
var string strCurrRound;
var int I;
var StatusGroup sgHousePts;
var StatusItem siGryffPts;
var int nAddHousePts;
var Sound soundAddHousePts;
var float fDialogSleep;
var float fMusicSleep;
var SpellLessonInterpolationPoint IPPassedArrow[3];
var bool bForceFinish;
var float fTotalTime;
var Vector vectLastWandLoc;


event Activate (Actor Other, Pawn EventInstigator)
{
  InitDialogStrings();
  FindLessonActors();
  InitHitPointRotation();
  PlayerHarry.StartSpellLearning(self);
  // PlayerHarry.Cam.SetCameraMode(PlayerHarry.Cam.7);
  PlayerHarry.Cam.SetCameraMode(PlayerHarry.Cam.ECamMode.CM_CutScene);
  HPHud(PlayerHarry.myHUD).RegisterSpellLesson(self);
  ForceStasis(True);
  GotoState('GameIntro');
}

function ForceStasis (bool bOn)
{
  local HChar aHChar;
  local HProp aHProp;

  foreach AllActors(Class'HChar',aHChar)
  {
    aHChar.bForceStasis = bOn;
    aHChar.bStasis = bOn;
  }
  foreach AllActors(Class'HProp',aHProp)
  {
    aHProp.bForceStasis = bOn;
    aHProp.bStasis = bOn;
  }
}

function CheckForMissedArrows()
{
	local float fDist;
	local float fAdjustedMissRange;

  // I = 0;
  // if ( I < 3 )
  for(I = 0; I < ArrayCount(IPPassedArrow); I++) //for loop -AdamJD
  {
    if ( IPPassedArrow[I] != None )
    {
      if ( IPPassedArrow[I].IsActive(nLevel) )
      {
        fDist = VSize(IPPassedArrow[I].Location - GameWand.Location);
        fAdjustedMissRange = (fHITPOINT_PREV_MISS_RANGE + VSize(GameWand.Location - vectLastWandLoc)) + 0.01;
        if ( fDist > fAdjustedMissRange )
        {
          IPPassedArrow[I].OnPlayerMissed(nLevel);
          IPPassedArrow[I] = None;
        }
      } else {
        IPPassedArrow[I] = None;
      }
    }
    // I++;
    // goto JL0007;
  }
}

event PlayerInput (float DeltaTime)
{
}

function InitDialogStrings()
{
  switch (LessonShape)
  {
    // case 0:
	case(LessonShape_Rictusempra):
		strIntroDialogId = "PC_Gil_DADARictaTeach_09";
		strTutorial1aId = "PC_Gil_DADARictaTeach_08";
		strTutorial1bId = "PC_Gil_DADARictaTeach_19";
		strTutorial1cId = "PC_Gil_DADARictaTeach_20";
		strEncourageDoingGood[0] = "PC_Gil_DADARictaTeach_23";
		strEncourageDoingGood[1] = "PC_Gil_DADARictaTeach_24";
		strEncourageAny[0] = "";
		strEncourageAny[1] = "";
		strTryAgain[0] = "PC_Gil_DADARictaTeach_28";
		strTryAgain[1] = "PC_Gil_DADARictaTeach_29";
		strTryAgain[2] = "";
		strTryOneLastTime[0] = "PC_Gil_DADARictaTeach_30";
		strTryOneLastTime[1] = "";
		strLevelCompleteId = "PC_Gil_DADARictaTeach_00";
		str5PointsAwardedId = "PC_Gil_DADARictaTeach_01";
		str10PointsAwardedId = "PC_Gil_DADARictaTeach_02";
		str15PointsAwardedId = "PC_Gil_DADARictaTeach_04";
		strAllLevelsCompleteId = "PC_Gil_DADARictaTeach_12";
		strMoveOnAnywayId = "PC_Gil_DADARictaTeach_13";
		strRound1Id = "PC_Gil_DADARictaTeach_14";
		strRound2Id = "PC_Gil_DADARictaTeach_15";
		strRound3Id = "PC_Gil_DADARictaTeach_16";
		break;
    // case 1:
	case(LessonShape_Skurge):
		strIntroDialogId = "PC_Flt_CharmSkurgTeach_02";
		strTutorial1aId = "PC_Flt_CharmSkurgTeach_08";
		strTutorial1bId = "PC_Flt_CharmSkurgTeach_09";
		strTutorial1cId = "PC_Flt_CharmSkurgTeach_22";
		strEncourageDoingGood[0] = "PC_Flt_CharmSkurgTeach_07";
		strEncourageDoingGood[1] = "";
		strEncourageAny[0] = "PC_Flt_CharmSkurgTeach_06";
		strEncourageAny[1] = "";
		strTryAgain[0] = "PC_Flt_CharmSkurgTeach_04";
		strTryAgain[1] = "PC_Flt_CharmSkurgTeach_05";
		strTryAgain[2] = "";
		strTryOneLastTime[0] = "";
		strTryOneLastTime[1] = "";
		strLevelCompleteId = "PC_Flt_CharmSkurgTeach_15";
		str5PointsAwardedId = "PC_Flt_CharmSkurgTeach_14";
		str10PointsAwardedId = "PC_Flt_CharmSkurgTeach_13";
		str15PointsAwardedId = "PC_Flt_CharmSkurgTeach_12";
		strAllLevelsCompleteId = "PC_Flt_CharmSkurgTeach_23";
		strMoveOnAnywayId = "PC_Flt_CharmSkurgTeach_26";
		strRound1Id = "PC_Flt_CharmSkurgTeach_17";
		strRound2Id = "PC_Flt_CharmSkurgTeach_18";
		strRound3Id = "PC_Flt_CharmSkurgTeach_19";
		break;
	// case 2:
	case(LessonShape_Diffindo):
		strIntroDialogId = "PC_Spr_HerbDiffTeach_03";
		strTutorial1aId = "PC_Spr_HerbDiffTeach_13";
		strTutorial1bId = "PC_Spr_HerbDiffTeach_11";
		strTutorial1cId = "PC_Spr_HerbDiffTeach_12";
		strEncourageDoingGood[0] = "PC_Spr_HerbDiffTeach_06";
		strEncourageDoingGood[1] = "";
		strEncourageAny[0] = "PC_Spr_HerbDiffTeach_04";
		strEncourageAny[1] = "PC_Spr_HerbDiffTeach_07";
		strTryAgain[0] = "PC_Spr_HerbDiffTeach_29";
		strTryAgain[1] = "PC_Spr_HerbDiffTeach_31";
		strTryAgain[2] = "PC_Spr_HerbDiffTeach_33";
		strTryOneLastTime[0] = "PC_Spr_HerbDiffTeach_30";
		strTryOneLastTime[1] = "PC_Spr_HerbDiffTeach_32";
		strLevelCompleteId = "PC_Spr_HerbDiffTeach_16";
		str5PointsAwardedId = "PC_Spr_HerbDiffTeach_17";
		str10PointsAwardedId = "PC_Spr_HerbDiffTeach_09";
		str15PointsAwardedId = "PC_Spr_HerbDiffTeach_10";
		strAllLevelsCompleteId = "PC_Spr_HerbDiffTeach_25";
		strMoveOnAnywayId = "PC_Spr_HerbDiffTeach_28";
		strRound1Id = "PC_Spr_HerbDiffTeach_20";
		strRound2Id = "PC_Spr_HerbDiffTeach_21";
		strRound3Id = "PC_Spr_HerbDiffTeach_22";
		break;
    // case 3:
	case(LessonShape_Spongify):
		strIntroDialogId = "PC_Gil_SpongeTeach_03";
		strTutorial1aId = "PC_Gil_SpongeTeach_17";
		strTutorial1bId = "PC_Gil_SpongeTeach_11";
		strTutorial1cId = "PC_Gil_SpongeTeach_12";
		strEncourageDoingGood[0] = "PC_Gil_SpongeTeach_30";
		strEncourageDoingGood[1] = "";
		strEncourageAny[0] = "";
		strEncourageAny[1] = "";
		strTryAgain[0] = "PC_Gil_SpongeTeach_32";
		strTryAgain[1] = "PC_Gil_SpongeTeach_33";
		strTryAgain[2] = "PC_Gil_SpongeTeach_34";
		strTryOneLastTime[0] = "PC_Gil_SpongeTeach_35";
		strTryOneLastTime[1] = "";
		strLevelCompleteId = "PC_Gil_DADARictaTeach_00";
		str5PointsAwardedId = "PC_Gil_SpongeTeach_21";
		str10PointsAwardedId = "PC_Gil_SpongeTeach_22";
		str15PointsAwardedId = "PC_Gil_SpongeTeach_23";
		strAllLevelsCompleteId = "PC_Gil_SpongeTeach_25";
		strMoveOnAnywayId = "PC_Gil_SpongeTeach_28";
		strRound1Id = "PC_Gil_DADARictaTeach_14";
		strRound2Id = "PC_Gil_DADARictaTeach_15";
		strRound3Id = "PC_Gil_DADARictaTeach_16";
		break;
    default:
		PlayerHarry.ClientMessage("Lesson shape not initialized.  Using Rictusempra dialog.");
		strIntroDialogId = "PC_Gil_DADARictaTeach_09";
		strTutorial1aId = "PC_Gil_DADARictaTeach_08";
		strTutorial1bId = "PC_Gil_DADARictaTeach_19";
		strTutorial1cId = "PC_Gil_DADARictaTeach_20";
		strEncourageDoingGood[0] = "PC_Gil_DADARictaTeach_23";
		strEncourageDoingGood[1] = "PC_Gil_DADARictaTeach_24";
		strEncourageAny[0] = "";
		strEncourageAny[1] = "";
		strTryAgain[0] = "PC_Gil_DADARictaTeach_28";
		strTryAgain[1] = "PC_Gil_DADARictaTeach_29";
		strTryAgain[2] = "";
		strTryOneLastTime[0] = "PC_Gil_DADARictaTeach_30";
		strTryOneLastTime[1] = "";
		strLevelCompleteId = "PC_Gil_DADARictaTeach_00";
		str5PointsAwardedId = "PC_Gil_DADARictaTeach_01";
		str10PointsAwardedId = "PC_Gil_DADARictaTeach_02";
		str15PointsAwardedId = "PC_Gil_DADARictaTeach_04";
		strAllLevelsCompleteId = "PC_Gil_DADARictaTeach_12";
		strMoveOnAnywayId = "PC_Gil_DADARictaTeach_13";
		strRound1Id = "PC_Gil_DADARictaTeach_14";
		strRound2Id = "PC_Gil_DADARictaTeach_15";
		strRound3Id = "PC_Gil_DADARictaTeach_16";
		break;
  }
}

function FindLessonActors()
{
  foreach AllActors(Class'harry',PlayerHarry)
  {
    if ( PlayerHarry.bIsPlayer && (PlayerHarry != self) )
    {
      // goto JL0033;
	  break;
    }
  }
  Cam = PlayerHarry.Cam;
  GameShape = SpellLessonShape(GetLessonActor(Class'SpellLessonShape',nameShape));
  GameIPStart = InterpolationPoint(GetLessonActor(Class'InterpolationPoint',nameIPStart));
  GameIPEnd = InterpolationPoint(GetLessonActor(Class'InterpolationPoint',nameIPEnd));
  GameCutCam = CutCameraPos(GetLessonActor(Class'CutCameraPos',nameCutCam));
  Professor = GetLessonProfessor();
}

function Actor GetLessonActor (Class<Actor> classActor, name nameActor)
{
  local Actor A;

  foreach AllActors(classActor,A)
  {
    if ( A.Name == nameActor )
    {
      return A;
    }
  }
  PlayerHarry.ClientMessage("SpellLesson could not locate " $ string(classActor) $ " " $ string(nameActor));
  return None;
}

function Characters GetLessonProfessor()
{
  local Class<Actor> classProf;
  local Actor Prof;
  local Actor ClosestProf;
  local float fDist;
  local float fClosestDistSoFar;

  switch (LessonShape)
  {
    // case 0:
	case(LessonShape_Rictusempra):
		classProf = Class'ProfLockhart';
		break;
    // case 1:
	case(LessonShape_Skurge):
		classProf = Class'ProfFlitwick';
		break;
    // case 2:
	case(LessonShape_Diffindo):
		classProf = Class'ProfSprout';
		break;
    // case 3:
	case(LessonShape_Spongify):
		classProf = Class'ProfLockhart';
		break;
    default:
		return None;
  }
  foreach AllActors(classProf,Prof)
  {
    fDist = VSize2D(Prof.Location - PlayerHarry.Location);
    if ( ClosestProf == None )
    {
      ClosestProf = Prof;
      fClosestDistSoFar = fDist;
    } else //{
      if ( fDist < fClosestDistSoFar )
      {
        ClosestProf = Prof;
        fClosestDistSoFar = fDist;
      }
    //}
  }
  return Characters(ClosestProf);
}

function SetupCamera (ECameraSettings CameraSettings)
{
  switch (CameraSettings)
  {
    // case 0:
	case(CS_GameShape):
		// if ( bool(Cam.CameraMode) != bool(Cam.7) )
		if(Cam.CameraMode != Cam.ECamMode.CM_CutScene)
		{
		  // Cam.SetCameraMode(Cam.7);
		  Cam.SetCameraMode(Cam.ECamMode.CM_CutScene);
		}
		Cam.SetTargetActor(nameShape);
		Cam.SetSyncPosWithTarget(False);
		break;
    // case 1:
	case(CS_BackToNormal):
		// if ( bool(Cam.CameraMode) != bool(Cam.3) )
		if(Cam.CameraMode != Cam.ECamMode.CM_Standard)
		{
		  // Cam.SetCameraMode(Cam.3);
		  Cam.SetCameraMode(Cam.ECamMode.CM_Standard);
		}
		Cam.CamTarget.SetAttachedTo(PlayerHarry);
		break;
    default:
		PlayerHarry.ClientMessage("Unrecognized spell lesson camera setting");
		break;
  }
}

function bool WandAtInterpolationPoint (InterpolationPoint IPoint, InterpolationManager IManager)
{
  if ( (nameIPEnd != 'None') && (nameIPEnd == IPoint.Name) )
  {
    GameWand.StopWand();
    nCurrTimesAround++;
    if ( (nCurrTimesAround >= nMaxLoops[nLevel]) || (nHitPointsInLevel == nHitPointHits) )
    {
      GotoState('LevelOver');
    } else {
      ResetForNextLoop();
      SayTryAgain(nCurrTimesAround == nMaxLoops[nLevel] - 1);
      GameWand.StartWand(fWandSpeed + (10 * PlayerHarry.Difficulty));
    }
    return False;
  } else {
    if ( SpellLessonInterpolationPoint(IPoint).IsInLevel(nLevel) )
    {
      ++nHitPointsPassed;
      // I = 0;
      // if ( I < 3 )
	  for(I = 0; I < ArrayCount(IPPassedArrow); I++) //for loop -AdamJD
      {
        if ( IPPassedArrow[I] != None )
        {
          if ( IPPassedArrow[I].IsActive(nLevel) )
          {
            IPPassedArrow[I].OnPlayerMissed(nLevel);
            IPPassedArrow[I] = None;
          } else {
            IPPassedArrow[I] = None;
          }
        }
      }
      if ( SpellLessonInterpolationPoint(IPoint).IsActive(nLevel) )
      {
        // I = 0;
        // if ( I < 3 )
		for(I = 0; I < ArrayCount(IPPassedArrow); I++) //for loop -AdamJD
        {
          if ( IPPassedArrow[I] == None )
          {
            IPPassedArrow[I] = SpellLessonInterpolationPoint(IPoint);
			break;
          }
        }
      }
      if ( (nCurrTimesAround % 2 != 0) && (nHitPointsPassed == nHitPointsInLevel / 2) )
      {
        SayEncouragement();
      }
    }
    return True;
  }
}

function InitHitPointRotation()
{
  local SpellLessonInterpolationPoint IP;

  foreach AllActors(Class'SpellLessonInterpolationPoint',IP)
  {
    if ( IP.Tag == GameIPStart.Tag )
    {
      IP.SetRotation(GameShape.Rotation);
    }
  }
}

function HideHitPoints()
{
  local SpellLessonInterpolationPoint IP;

  foreach AllActors(Class'SpellLessonInterpolationPoint',IP)
  {
    if ( IP.Tag == GameIPStart.Tag )
    {
      IP.bHidden = True;
    }
  }
}

function ResetHitPoints()
{
  local SpellLessonInterpolationPoint IP;

  nHitPointsInLevel = 0;
  nHitPointHits = 0;
  nHitPointsPassed = 0;
  foreach AllActors(Class'SpellLessonInterpolationPoint',IP)
  {
    if ( IP.Tag == GameIPStart.Tag )
    {
      IP.Reset(nLevel);
      if ( IP.IsInLevel(nLevel) )
      {
        nHitPointsInLevel++;
      }
    }
  }
}

function DoArrowKeyPressed (ELessonKey LessonKey)
{
  local float fIPPrevDistance;
  local float fIPNextDistance;
  local float fIPClosestDistance;
  local SpellLessonInterpolationPoint IPTemp;
  local SpellLessonInterpolationPoint IPPrev;
  local SpellLessonInterpolationPoint IPNext;
  local SpellLessonInterpolationPoint IPClosest;
  local float fSoundPitch;
  local int nLastPosition;
  local float fAdjustedHitRange;
  local float fAdjustedMissRange;

  fAdjustedHitRange = (fHITPOINT_RANGE + VSize(GameWand.Location - vectLastWandLoc)) + 0.01;
  IPTemp = SpellLessonInterpolationPoint(GameWand.SplineManager.Dest.Prev);
  nLastPosition = IPTemp.Position;
  // if ( IPTemp != None )
  while(IPTemp != None) //while loop -AdamJD
  {
    if ( IPTemp.Position > nLastPosition )
    {
      // goto JL00E8;
	  break;
    }
    if ( IPTemp.IsActive(nLevel) )
    {
      IPPrev = IPTemp;
      // goto JL00E8;
	  break;
    } else {
      nLastPosition = IPTemp.Position;
      IPTemp = SpellLessonInterpolationPoint(IPTemp.Prev);
    }
    // goto JL006A;
  }
  IPTemp = SpellLessonInterpolationPoint(GameWand.SplineManager.Dest);
  nLastPosition = IPTemp.Position;
  // if ( IPTemp != None )
  while(IPTemp != None) //while loop -AdamJD
  {
    if ( IPTemp.Position < nLastPosition )
    {
      // goto JL019C;
	  break;
    }
    if ( IPTemp.IsActive(nLevel) )
    {
      IPNext = IPTemp;
      // goto JL019C;
	  break;
    } else {
      nLastPosition = IPTemp.Position;
      IPTemp = SpellLessonInterpolationPoint(IPTemp.Next);
    }
    // goto JL011E;
  }
  if ( (IPPrev != None) && (IPNext != None) )
  {
    fIPPrevDistance = VSize(IPPrev.Location - GameWand.Location);
    fIPClosestDistance = fIPPrevDistance;
    IPClosest = IPPrev;
  } else //{
    if ( IPPrev != None )
    {
      fIPClosestDistance = VSize(IPPrev.Location - GameWand.Location);
      IPClosest = IPPrev;
    } else //{
      if ( IPNext != None )
      {
        fIPClosestDistance = VSize(IPNext.Location - GameWand.Location);
        IPClosest = IPNext;
      }
    //}
  //}
  if ( IPClosest != None )
  {
    if ( IPClosest == IPNext )
    {
      fAdjustedMissRange = fAdjustedHitRange + (fHITPOINT_NEXT_MISS_RANGE - fHITPOINT_RANGE);
    } else {
      fAdjustedMissRange = fAdjustedHitRange + (fHITPOINT_PREV_MISS_RANGE - fHITPOINT_RANGE);
    }
    if ( KeyMatchesIPArrow(LessonKey,IPClosest) && (fIPClosestDistance <= fAdjustedHitRange) )
    {
      IPClosest.OnPlayerHit(nLevel);
      ++nHitPointHits;
    } else {
      if ( fIPClosestDistance <= fAdjustedHitRange )
      {
        IPClosest.OnPlayerMissed(nLevel);
      } else //{
        if ( (fIPClosestDistance > fAdjustedHitRange) && (fIPClosestDistance < fAdjustedMissRange) )
        {
          IPClosest.OnPlayerMissed(nLevel);
        }
      }
    //}
  }
}

function bool KeyMatchesIPArrow (ELessonKey LessonKey, SpellLessonInterpolationPoint IP)
{
  switch (LessonKey)
  {
    // case 0:
	case(LessonKey_Up):
		return IP.IsDirectionArrowUp(nLevel);
    // case 1:
	case(LessonKey_Down):
		return IP.IsDirectionArrowDown(nLevel);
    // case 2:
	case(LessonKey_Left):
		return IP.IsDirectionArrowLeft(nLevel);
    // case 3:
	case(LessonKey_Right):
		return IP.IsDirectionArrowRight(nLevel);
    default:
		return False;
  }
}

function RenderHudItems (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
{
}

function DrawRoundText (Canvas Canvas)
{
	local float fScale;
	local Font fontSave;
	local Color colorSave;
	local Color colorText;
	local float fTextWidth;
	local float fTextHeight;
  
	// Metallicafan212:	Scale it to the height ratio
	local float HScale;
	
	HScale = class'M212HScale'.static.CanvasGetHeightScale(Canvas);

	fontSave 			= Canvas.Font;
	colorSave 			= Canvas.DrawColor;
	Canvas.Font 		= baseConsole(PlayerHarry.Player.Console).LocalBigFont;
	Canvas.DrawColor.R 	= 255;
	Canvas.DrawColor.G 	= 255;
	Canvas.DrawColor.B 	= 0;
	
	Canvas.TextSize(strCurrRound, fTextWidth, fTextHeight);
	Canvas.SetPos(((Canvas.SizeX / 2) - (fTextWidth / 2)), ((Canvas.SizeY / 2) - (fTextHeight / 2)) * HScale );
	
	Canvas.DrawText(strCurrRound,False);
	Canvas.Font 		= fontSave;
	Canvas.DrawColor 	= colorSave;
}

function StartCutSequence()
{
  PlayerHarry.bIsCaptured = True;
  PlayerHarry.myHUD.StartCutScene();
}

function EndCutSequence()
{
  PlayerHarry.myHUD.EndCutScene();
  PlayerHarry.bIsCaptured = False;
}

function float SayLessonDialog (string strDialogID, bool bDisplayText)
{
	local string strDialog;
	local Sound soundDialog;
	local float fSoundLen;

	strDialog = Localize("all",strDialogID,"HPdialog");
	strDialog = HandleFacialExpression(strDialog,0,True);
	soundDialog = Sound(DynamicLoadObject("AllDialog." $ strDialogID,Class'Sound'));
  
	if ( soundDialog != None )
	{
		fSoundLen = GetSoundDuration(soundDialog);
		fSoundLen += 0.5;
		
		if ( Professor != None )
		{
			
			Professor.PlaySound(soundDialog,,,,10000.0,,True);
		} 
		else 
		{
			Professor.PlaySound(soundDialog,,,,10000.0,,True);
		}
	} 
	else
	{
		fSoundLen = Len(strDialog) * 0.01 + 3.0;
	}
    
	//added from the proto because UTPT didn't decompile this -AdamJD
	// ***************************************************************************
	// Handle emotions
    if (Professor != None)
        strDialog = Professor.HandleFacialExpression( strDialog, fSoundLen);
    else
        strDialog = HandleFacialExpression( strDialog, fSoundLen);
    
    //playerHarry.ClientMessage("SayLessonDialog " $strDialog);

    // Show dialog in cut area for length of sound.
    if (bDisplayText)
	    playerHarry.MyHud.SetSubtitleText(strDialog, fSoundLen);

    // Return the sound length
	return (fSoundLen);
  // ***************************************************************************
}

function SayTryAgain (bool bLastTimeAround)
{
  local int nTryLastTimeEntries;
  local int nTryAgainEntries;
  //local int I;
  local int iSayTryAgain;

  if ( bLastTimeAround )
  {
    // I = 0;
    // if ( I < 2 )
	for(iSayTryAgain = 0; iSayTryAgain < ArrayCount(strTryOneLastTime); iSayTryAgain++) //for loop -AdamJD
    {
      if ( strTryOneLastTime[iSayTryAgain] != "" )
      {
        ++nTryLastTimeEntries;
      }
	  else
	  {
		break;
	  }
    }
  }
  if ( bLastTimeAround && (nTryLastTimeEntries > 0) )
  {
	iSayTryAgain = RandRange(0.0,nTryLastTimeEntries - 1);
	SayLessonDialog(strTryOneLastTime[iSayTryAgain],False);
  } else {
    // I = 0;
    // if ( I < 3 )
	for(iSayTryAgain = 0; iSayTryAgain < ArrayCount(strTryAgain); iSayTryAgain++) //for loop -AdamJD
    {
      if ( strTryAgain[iSayTryAgain] != "" )
      {
        ++nTryAgainEntries;
      }
	  else
	  {
		break;
	  }
    }
    if ( nTryAgainEntries > 0 )
    {
	  iSayTryAgain = RandRange(0.0,nTryAgainEntries - 1);
	  SayLessonDialog(strTryAgain[iSayTryAgain],False);
    }
  }
}

function SayEncouragement()
{
  local int nDoingGoodEntries;
  local int nEncourageAnyEntries;
  local bool bDoingGood;
  //local int I;
  local int iSayEncouragement;

  if ( nHitPointsPassed > 1 )
  {
    if ( nHitPointHits >= nHitPointsPassed - 1 )
    {
      bDoingGood = True;
    }
  }
  if ( bDoingGood )
  {
    // I = 0;
    // if ( I < 2 )
	for(iSayEncouragement = 0; iSayEncouragement < ArrayCount(strEncourageDoingGood); iSayEncouragement++) //for loop -AdamJD
    {
      if ( strEncourageDoingGood[iSayEncouragement] != "" )
      {
        ++nDoingGoodEntries;
      }
	  else
	  {
		break;
	  }
    }
  }
  if ( bDoingGood && (nDoingGoodEntries > 0) )
  {
	iSayEncouragement = RandRange(0.0,nDoingGoodEntries - 1);
	SayLessonDialog(strEncourageDoingGood[iSayEncouragement],False);
  } else {
    // I = 0;
    // if ( I < 2 )
	for(iSayEncouragement = 0; iSayEncouragement < ArrayCount(strEncourageAny); iSayEncouragement++) //for loop -AdamJD
    {
      if ( strEncourageAny[iSayEncouragement] != "" )
      {
        ++nEncourageAnyEntries;
      }
	  else
	  {
		break;
	  }
    }
    if ( nEncourageAnyEntries > 0 )
    {
	  iSayEncouragement = RandRange(0.0,nEncourageAnyEntries - 1); 
	  SayLessonDialog(strEncourageAny[iSayEncouragement],False);
    }
  }
}

function ResetForNextLevel()
{
  ResetHitPoints();
  nCurrTimesAround = 0;
  GameWand.SetLocation(GameIPStart.Location);
  GameWand.bHidden = False;
}

function ResetForNextLoop()
{
	ResetHitPoints();
	GameWand.SetLocation(GameIPStart.Location);
}

function EndLesson()
{
  GameWand.bHidden = True;
  GameShape.bHidden = True;
  HideHitPoints();
  GameWand.Destroy();
  switch (LessonShape)
  {
    // case 0:
	case(LessonShape_Rictusempra):
		PlayerHarry.AddToSpellBook(Class'spellRictusempra');
		break;
    // case 1:
	case(LessonShape_Skurge):
		PlayerHarry.AddToSpellBook(Class'spellSkurge');
		break;
    // case 2:
	case(LessonShape_Diffindo):
		PlayerHarry.AddToSpellBook(Class'spellDiffindo');
		break;
    // case 3:
	case(LessonShape_Spongify):
		PlayerHarry.AddToSpellBook(Class'spellSpongify');
		break;
    default:
		Log("ERROR: Unrecognized lesson shape.  Spell not added to wand " $ string(LessonShape));
		break;
  }
  ForceStasis(False);
  if ( Event == 'None' )
  {
    // SetupCamera(1);
	SetupCamera(CS_BackToNormal);
  }
  PlayerHarry.EndSpellLearning();
  TriggerEvent(Event,None,None);
  GotoState('Idle');
}

function bool IsJoyPressed (ELessonKey LessonKey, float fAxisX, float fAxisY)
{
  local bool bRet;

  switch (LessonKey)
  {
    // case 0:
	case(LessonKey_Up):
		if ( (fAxisY > 0) && (Abs(fAxisY) > Abs(fAxisX)) )
		{
		  bRet = True;
		}
		break;
    // case 1:
	case(LessonKey_Down):
		if ( (fAxisY < 0) && (Abs(fAxisY) > Abs(fAxisX)) )
		{
		  bRet = True;
		}
		break;
    // case 2:
	case(LessonKey_Left):
		if ( (fAxisX < 0) && (Abs(fAxisX) > Abs(fAxisY)) )
		{
		  bRet = True;
		}
		break;
    // case 3:
	case(LessonKey_Right):
		if ( (fAxisX > 0) && (Abs(fAxisX) > Abs(fAxisY)) )
		{
		  bRet = True;
		}
		break;
    default:
		bRet = False;
  }
  return bRet;
}

auto state Idle
{
  event Trigger (Actor Other, Pawn EventInstigator)
  {
    PlayerHarry.ClientMessage("Activate spelllesson trigger");
    Activate(Other,EventInstigator);
  }
}

state GameIntro
{
begin:
  GameShape.bHidden = False;
  // SetupCamera(0);
  SetupCamera(CS_GameShape);
  // Cam.DoFlyTo(GameCutCam.Location,Cam.3,3.0);
  Cam.DoFlyTo(GameCutCam.Location,Cam.enumMoveType.MOVE_TYPE_EASE_TO,3.0);
  Sleep(3.0);
  StartCutSequence();
  Sleep(SayLessonDialog(strIntroDialogId,True));
  GameWand = SpellLessonWand(FancySpawn(Class'SpellLessonWand',,,GameIPStart.Location,GameShape.Rotation));
  GameWand.SetParentLessonTrigger(self);
  Sleep(SayLessonDialog(strTutorial1aId,True));
  ResetHitPoints();
  Sleep(SayLessonDialog(strTutorial1bId,True));
  Sleep(SayLessonDialog(strTutorial1cId,True));
  EndCutSequence();
  ResetForNextLevel();
  GotoState('DeclareNewRound');
}

state DeclareNewRound
{
  function RenderHudItems (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    if ( strCurrRound != "" )
    {
      DrawRoundText(Canvas);
    }
  }
  
  event BeginState()
  {
    strCurrRound = "";
  }
  
 begin: 
  switch (nLevel)
  {
    case 0:
		strCurrRound = Localize("all",strRound1Id,"HPdialog");
		strCurrRound = HandleFacialExpression(strCurrRound,0,True);
		Sleep(SayLessonDialog(strRound1Id,False));
		break;
    case 1:
		strCurrRound = Localize("all",strRound2Id,"HPdialog");
		strCurrRound = HandleFacialExpression(strCurrRound,0,True);
		Sleep(SayLessonDialog(strRound2Id,False));
		break;
    case 2:
		strCurrRound = Localize("all",strRound3Id,"HPdialog");
		strCurrRound = HandleFacialExpression(strCurrRound,0,True);
		Sleep(SayLessonDialog(strRound3Id,False));
		break;
    default:
		PlayerHarry.ClientMessage("ERROR: Unknown spell lesson level");
		break;
  }
  GotoState('PlayGame');
}

state PlayGame
{
  event PlayerInput (float fDeltaTime)
  {
    if ( (PlayerHarry.bSpellLessonUp != 0) || IsJoyPressed(LessonKey_Up,PlayerHarry.aSpellLessonX,PlayerHarry.aSpellLessonY) )
    {
      if ( nKeyNeedsReset[0] == 0 )
      {
        // DoArrowKeyPressed(0);
		DoArrowKeyPressed(LessonKey_Up);
      }
      nKeyNeedsReset[0] = 1;
    } else {
      nKeyNeedsReset[0] = 0;
    }
    if ( (PlayerHarry.bSpellLessonDown) != 0 || IsJoyPressed(LessonKey_Down,PlayerHarry.aSpellLessonX,PlayerHarry.aSpellLessonY) )
    {
      if ( nKeyNeedsReset[1] == 0 )
      {
        // DoArrowKeyPressed(1);
		DoArrowKeyPressed(LessonKey_Down);
      }
      nKeyNeedsReset[1] = 1;
    } else {
      nKeyNeedsReset[1] = 0;
    }
    if ( (PlayerHarry.bSpellLessonLeft) != 0 || IsJoyPressed(LessonKey_Left,PlayerHarry.aSpellLessonX,PlayerHarry.aSpellLessonY) )
    {
      if ( nKeyNeedsReset[2] == 0 )
      {
        // DoArrowKeyPressed(2);
		DoArrowKeyPressed(LessonKey_Left);
      }
      nKeyNeedsReset[2] = 1;
    } else {
      nKeyNeedsReset[2] = 0;
    }
    if ( (PlayerHarry.bSpellLessonRight != 0) || IsJoyPressed(LessonKey_Right,PlayerHarry.aSpellLessonX,PlayerHarry.aSpellLessonY) )
    {
      if ( nKeyNeedsReset[3] == 0 )
      {
        // DoArrowKeyPressed(3);
		DoArrowKeyPressed(LessonKey_Right);
      }
      nKeyNeedsReset[3] = 1;
    } else {
      nKeyNeedsReset[3] = 0;
    }
    CheckForMissedArrows();
    vectLastWandLoc = GameWand.Location;
  }
  
  event EndState()
  {
    PlayerHarry.StopAllMusic(0.5);
    GameWand.StopSound(soundWand,SLOT_Interact);
  }
  
 begin:
  PlayerHarry.StopAllMusic(0.0);
  switch (LessonShape)
  {
    // case 0:
	case(LessonShape_Rictusempra):
	// case 2:
	case(LessonShape_Diffindo):
		PlayerHarry.PlayMusic(strRICTU_DIFF_GAME_MUSIC,0.5);
		break;
	// case 1:
	case(LessonShape_Skurge):
	// case 3:
	case(LessonShape_Spongify):
		PlayerHarry.PlayMusic(strSKURGE_SPONG_GAME_MUSIC,0.5);
		break;
	default:
		break;
  }
  GameWand.PlaySound(soundWand,SLOT_Interact,1.0,True,TransientSoundRadius,1.0,False,True);
  GameWand.StartWand(fWandSpeed + (10 * PlayerHarry.Difficulty));
}

state LevelOver
{
  function RenderHudItems (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    sgHousePts.RenderHudItemManager(Canvas,bMenuMode,bFullCutMode,bHalfCutMode);
  }
  
  event BeginState()
  {
    sgHousePts = PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupHousePoints');
    siGryffPts = sgHousePts.GetStatusItem(Class'StatusItemGryffindorPts');
    sgHousePts.SetCutSceneRenderMode(True);
  }
  
  event EndState()
  {
    sgHousePts.SetCutSceneRenderModeToNormal();
  }
  
 begin:
  GameWand.bHidden = True;
  StartCutSequence();
  if ( nHitPointHits >= nHitPointsInLevel )
  {
    if ( nLevel < nNUM_LEVELS - 1 )
    {
      Sleep(SayLessonDialog(strLevelCompleteId,True));
    } else {
      PlayerHarry.PlayMusic(strWON_MUSIC,0.5);
      fMusicSleep = fWON_MUSIC_LEN;
      fDialogSleep = SayLessonDialog(strAllLevelsCompleteId,True);
      if ( fMusicSleep + fEND_MUSIC_FADE_OUT < fDialogSleep )
      {
        Sleep(fMusicSleep - fEND_MUSIC_FADE_OUT);
        PlayerHarry.StopAllMusic(fEND_MUSIC_FADE_OUT);
        Sleep(fDialogSleep - (fMusicSleep - fEND_MUSIC_FADE_OUT));
      } else {
        Sleep(fDialogSleep);
        PlayerHarry.StopAllMusic(fEND_MUSIC_FADE_OUT);
        Sleep(fEND_MUSIC_FADE_OUT);
      }
    }
    sgHousePts.SetEffectTypeToPermanent();
    switch (nLevel)
    {
      case 0:
		  nAddHousePts = 5;
		  fDialogSleep = SayLessonDialog(str5PointsAwardedId,True);
		  break;
      case 1:
		  nAddHousePts = 10;
		  fDialogSleep = SayLessonDialog(str10PointsAwardedId,True);
		  break;
      case 2:
		  nAddHousePts = 15;
		  fDialogSleep = SayLessonDialog(str15PointsAwardedId,True);
		  break;
      default:
		  fDialogSleep = 0.0;
		  nAddHousePts = 0;
		  break;
    }
    fDialogSleep /= 2.0;
    Sleep(fDialogSleep);
    PlayerHarry.PlaySound(soundAddHousePts,,,,,10000.0,True);
	// if ( (nAddHousePts--) > 0 )
	while((nAddHousePts--) > 0) //while loop -AdamJD
    {
      siGryffPts.IncrementCount(1);
      Sleep(0.01);
      // goto JL01C8;
    }
    PlayerHarry.StopSound(soundAddHousePts);
    Sleep(fDialogSleep);
    EndCutSequence();
    ++nLevel;
    if ( nLevel < nNUM_LEVELS )
    {
// JL01C8:
      ResetForNextLevel();
      GotoState('DeclareNewRound');
    } else {
      EndLesson();
    }
  } else {
    PlayerHarry.PlayMusic(strFAIL_MUSIC,0.5);
    fMusicSleep = fFAIL_MUSIC_LEN;
    fDialogSleep = SayLessonDialog(strMoveOnAnywayId,True);
    if ( fMusicSleep + fEND_MUSIC_FADE_OUT < fDialogSleep )
    {
      Sleep(fMusicSleep - fEND_MUSIC_FADE_OUT);
      PlayerHarry.StopAllMusic(fEND_MUSIC_FADE_OUT);
      Sleep(fDialogSleep - (fMusicSleep - fEND_MUSIC_FADE_OUT));
    } else {
      Sleep(fDialogSleep);
      PlayerHarry.StopAllMusic(fEND_MUSIC_FADE_OUT);
      Sleep(fEND_MUSIC_FADE_OUT);
    }
    EndCutSequence();
    EndLesson();
  }
}

defaultproperties
{
    fWandSpeed=100.00

    nMaxLoops(0)=5

    nMaxLoops(1)=4

    nMaxLoops(2)=3

    soundWand=Sound'HPSounds.Magic_sfx.spell_loop_nl'

    soundAddHousePts=Sound'HPSounds.menu_sfx.score_tally_up'

    bTriggerOnceOnly=True

    bInitiallyActive=False

    InitialState=None

}
