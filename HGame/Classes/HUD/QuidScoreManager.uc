//================================================================================
// QuidScoreManager.
//================================================================================

class QuidScoreManager extends HudItemManager;

const nTALLY_DISPLAY_Y= 20;
const nTALLY_POINTS_MIDY= 87;
const nTALLY_POINTS_MIDX= 65;
const nTALLY_POINTS_HEIGHT= 128;
const nTALLY_POINTS_WIDTH= 128;
const strTALLY_POINTS_ICON= "HP2_Menu.Icons.HP2BigChallengeScore";
const nCREST_MIDY= 50;
const nCREST_MIDX= 45;
const fOPPONENT_X= 578.0;
const fGRYFF_Y=   4.0;
const fGRYFF_X= 520.0;
const nCREST_WIDTH= 48;

enum OpponentHouse {
  Opponent_Gryffindor,
  Opponent_Ravenclaw,
  Opponent_Hufflepuff,
  Opponent_Slytherin
};

var harry PlayerHarry;
var int nGryffindorScore;
var int nOpponentScore;
var Texture textureOpponent;
var Texture textureHuff;
var Texture textureSlyth;
var Texture textureRaven;
var Texture textureGryff;
var Texture textureTallyPointsIcon;
var int nAwardGryffPoints;
var StatusItem siGryffHousePoints;
var string strTallyCue;
var Sound soundTally;
var float fTallySoundDuration;
var int nTallyPointsPerTick;
var float fTickDelta;
var float fTicksPerSec;


event PostBeginPlay()
{
  Super.PostBeginPlay();
  textureHuff = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2HufflepuffCrestSm",Class'Texture'));
  textureRaven = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2RavenclawCrestSm",Class'Texture'));
  textureSlyth = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2SlytherinCrestSm",Class'Texture'));
  textureGryff = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2GriffindorCrestSm",Class'Texture'));
  textureTallyPointsIcon = Texture(DynamicLoadObject(strTALLY_POINTS_ICON,Class'Texture'));
  textureOpponent = textureHuff;
}

function Timer()
{
  foreach AllActors(Class'harry',PlayerHarry)
  {
    // goto JL0014;
	break;
  }
  if ( PlayerHarry.myHUD != None )
  {
    HPHud(PlayerHarry.myHUD).RegisterQuidScoreManager(self);
    SetTimer(0.0,False);
  }
}

function StartQuidScore()
{
  SetTimer(0.2,True);
  nGryffindorScore = 0;
  nOpponentScore = 0;
  GotoState('QuidScoreDisplay');
}

function PauseQuidScore()
{
  GotoState('Idle');
}

function ResumeQuidScore()
{
  GotoState('QuidScoreDisplay');
}

function TallyQuidScore()
{
  GotoState('Tally');
}

function SetOpponent (OpponentHouse Opponent)
{
  switch (Opponent)
  {
    // case 0:
	case Opponent_Gryffindor:
		textureOpponent = textureGryff;
		break;
    // case 1:
	case Opponent_Ravenclaw:
		textureOpponent = textureRaven;
		break;
    // case 2:
	case Opponent_Hufflepuff:
		textureOpponent = textureHuff;
		break;
    // case 3:
	case Opponent_Slytherin:
		textureOpponent = textureSlyth;
		break;
    default:
		Log("ERROR: Invalid opponent in QuidScoreManager");
		textureOpponent = textureHuff;
		break;
  }
}

function SetGryffindorScore (int nScore)
{
  nGryffindorScore = nScore;
  if ( nGryffindorScore < 0 )
  {
    nGryffindorScore = 0;
  }
}

function SetOpponentScore (int nScore)
{
  nOpponentScore = nScore;
  if ( nOpponentScore < 0 )
  {
    nOpponentScore = 0;
  }
}

function IncrementGryffindorScore (int nScore)
{
  SetGryffindorScore(nGryffindorScore + nScore);
}

function IncrementOpponentScore (int nScore)
{
  SetOpponentScore(nOpponentScore + nScore);
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
      if ( sActualCommand ~= "StartQuidScore" )
      {
        StartQuidScore();
        CutNotifyActor.CutCue(cue);
        return True;
      } else //{
        if ( sActualCommand ~= "TallyQuidScore" )
        {
          strTallyCue = cue;
          TallyQuidScore();
          return True;
        } else {
          return False;
        }
      //}
    //}
  //}
}

function DrawQuidScore (Canvas Canvas)
{
  local float fScaleFactor;
  local int nGryffIconX;
  local int nGryffIconY;
  local int nOpponIconX;
  local int nOpponIconY;
  local int nMidX;
  local int nMidY;
  local Color colorOffWhite;
  local Color colorBlack;
  local Font fontSave;
  local string strGryffScore;
  local string strOpponentScore;
  local float nXTextLen;
  local float nYTextLen;

  fontSave = Canvas.Font;
  fScaleFactor = GetScaleFactor(Canvas);
  nGryffIconX = fGRYFF_X * fScaleFactor;
  nGryffIconY = fGRYFF_Y * fScaleFactor;
  Canvas.SetPos(nGryffIconX,nGryffIconY);
  Canvas.DrawIcon(textureGryff,fScaleFactor);
  nOpponIconX = fOPPONENT_X * fScaleFactor;
  nOpponIconY = 4 * fScaleFactor;
  Canvas.SetPos(nOpponIconX,nOpponIconY);
  Canvas.DrawIcon(textureOpponent,fScaleFactor);
  nXTextLen = 0.0;
  nYTextLen = 0.0;
  strGryffScore = string(nGryffindorScore);
  strOpponentScore = string(nOpponentScore);
  colorBlack.R = 0;
  colorBlack.G = 0;
  colorBlack.B = 0;
  colorOffWhite.R = 206;
  colorOffWhite.G = 200;
  colorOffWhite.B = 190;
  if ( Canvas.SizeX <= 512 )
  {
    Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalSmallFont;
  } else //{
    if ( Canvas.SizeX <= 640 )
    {
      Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalMedFont;
    } else {
      Canvas.Font = baseConsole(PlayerHarry.Player.Console).LocalBigFont;
    }
  //}
  Canvas.TextSize(strGryffScore,nXTextLen,nYTextLen);
  Canvas.SetPos(nGryffIconX + (nCREST_MIDX * fScaleFactor) - nXTextLen / 2,nGryffIconY + (nCREST_MIDY * fScaleFactor) - nYTextLen / 2);
  Canvas.DrawShadowText(strGryffScore,colorOffWhite,colorBlack);
  Canvas.TextSize(strOpponentScore,nXTextLen,nYTextLen);
  Canvas.SetPos(nOpponIconX + (nCREST_MIDX * fScaleFactor) - nXTextLen / 2,nOpponIconY + (nCREST_MIDY * fScaleFactor) - nYTextLen / 2);
  Canvas.DrawText(strOpponentScore,False);
  Canvas.Font = fontSave;
}

function DrawTallyHousepoints (Canvas Canvas)
{
  local string strPoints;
  local float fScaleFactor;
  local int nPointsIconX;
  local int nPointsIconY;
  local Color colorSave;
  local Font fontSave;
  local float nXTextLen;
  local float nYTextLen;

  colorSave = Canvas.DrawColor;
  fontSave = Canvas.Font;
  fScaleFactor = GetScaleFactor(Canvas);
  nPointsIconX = Canvas.SizeX / 2 - ((nTALLY_POINTS_WIDTH / 2) * fScaleFactor);
  nPointsIconY = nTALLY_DISPLAY_Y * fScaleFactor;
  Canvas.SetPos(nPointsIconX,nPointsIconY);
  Canvas.DrawIcon(textureTallyPointsIcon,fScaleFactor);
  nXTextLen = 0.0;
  nYTextLen = 0.0;
  strPoints = string(siGryffHousePoints.nCount);
  Canvas.DrawColor.R = 0;
  Canvas.DrawColor.G = 0;
  Canvas.DrawColor.B = 0;
  Canvas.TextSize(strPoints,nXTextLen,nYTextLen);
  Canvas.SetPos(nPointsIconX + (nTALLY_POINTS_MIDX * fScaleFactor) - nXTextLen / 2,nPointsIconY + (nTALLY_POINTS_MIDY * fScaleFactor) - nYTextLen / 2);
  Canvas.DrawText(strPoints,False);
  Canvas.DrawColor = colorSave;
  Canvas.Font = fontSave;
}

auto state Idle
{
}

state QuidScoreDisplay
{
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    if (  !bFullCutMode &&  !bMenuMode )
    {
      DrawQuidScore(Canvas);
    }
  }
  
}

state Tally
{
  function Tick (float fDeltaTime)
  {
    if ( fTickDelta > 0.0 )
    {
      if ( nAwardGryffPoints > 0 )
      {
        if ( nTallyPointsPerTick <= nAwardGryffPoints )
        {
          siGryffHousePoints.IncrementCount(nTallyPointsPerTick);
          nAwardGryffPoints -= nTallyPointsPerTick;
        } else {
          siGryffHousePoints.IncrementCount(nAwardGryffPoints);
          nAwardGryffPoints = 0;
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
    if (  !bMenuMode )
    {
      DrawQuidScore(Canvas);
      DrawTallyHousepoints(Canvas);
    }
  }
  
  function BeginState()
  {
    local StatusGroup sgHousePoints;
    local float fTallyPointsPerSec;
  
    fTickDelta = 0.0;
    if ( nGryffindorScore < nOpponentScore )
    {
      nAwardGryffPoints = 0;
      GotoState('PostTallyHold');
    } else {
      nAwardGryffPoints = nGryffindorScore - nOpponentScore;
    }
    siGryffHousePoints = PlayerHarry.managerStatus.GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemGryffindorPts');
  }
  
  function EndState()
  {
    StopSound(soundTally,SLOT_Interact);
  }
  
begin:
  // if ( fTickDelta <= 0.0 )
  while ( fTickDelta <= 0.0 )
  {
    Sleep(0.1);
    // goto JL0000;
  }
  fTicksPerSec = 1.0 / fTickDelta;
  
  /*
  if ( byte(nAwardGryffPoints) / 3.0 * fTicksPerSec > byte(1) )
  {
    nTallyPointsPerTick = byte(nAwardGryffPoints) / 3.0 * fTicksPerSec = } else {;
    nTallyPointsPerTick = 1;
  }
  */
  
  if ( nAwardGryffPoints / (3.0 * fTicksPerSec) > 1 )
  {
    nTallyPointsPerTick = nAwardGryffPoints / (3.0 * fTicksPerSec);
  }
  else
  {
	nTallyPointsPerTick = 1;
  }
  
  PlayerHarry.ClientMessage("start tally " $ string(nAwardGryffPoints) $ " " $ string(nTallyPointsPerTick) $ " " $ string(fTickDelta) $ " " $ string(fTicksPerSec));
  fTallySoundDuration = GetSoundDuration(soundTally);
loop:
  PlayerHarry.PlaySound(soundTally,SLOT_Interact);
  Sleep(fTallySoundDuration);
  goto ('Loop');
}

state PostTallyHold
{
  function Timer()
  {
    GotoState('Idle');
  }
  
  function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
  {
    if (  !bMenuMode )
    {
      DrawQuidScore(Canvas);
      DrawTallyHousepoints(Canvas);
    }
  }
  
  function BeginState()
  {
    SetTimer(4.0,False);
  }
  
  function EndState()
  {
    CutNotifyActor.CutCue(strTallyCue);
    HPHud(PlayerHarry.myHUD).RegisterQuidScoreManager(None);
  }
  
}

defaultproperties
{
    soundTally=Sound'HPSounds.menu_sfx.score_tally_up'

    bHidden=True

    // DrawType=1
	DrawType=DT_Sprite

    CutName="QuidScoreManager"
}
