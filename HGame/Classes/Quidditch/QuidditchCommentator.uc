//================================================================================
// QuidditchCommentator.
//================================================================================

class QuidditchCommentator extends HChar;

const fMinTimeBeforeCommentRepeat= 45.0;
const fMaxGapTimeBetweenComments= 2.4;
const fMinGapTimeBetweenComments= 1.0;
const fNoGapTimeBetweenComments= 0.1;
const QC_MAX_COMMENT_VARIANTS= 30;
const MAX_QUID_COMMENT_HOUSE_NAMES=6;
const MAX_QUID_COMMENT_NAMES=43;

enum TeamAffiliation {
  TA_Gryffindor,
  TA_Opponent,
  TA_Neutral,
  TA_NumAffiliations
};

enum HouseAffiliation {
  HA_Gryffindor,
  HA_Ravenclaw,
  HA_Hufflepuff,
  HA_Slytherin,
  HA_Neutral,
  HA_Opponent,
  HA_NumHouses
};

enum QuidComment {
  QC_None,
  QC_HasQuaffle,
  QC_Scores,
  QC_WinsSlyth,
  QC_WinsAgain,
  QC_WinsMatch,
  QC_WinsCup,
  QC_TheresTheSnitch,
  QC_HereComesSeeker,
  QC_ClosingOnSnitch,
  QC_ReachingSnitch,
  QC_MissedSnitch,
  QC_CaughtSnitch,
  QC_DontGiveUp,
  QC_SeekerBattle,
  QC_SeekerBattleNeg,
  QC_SeekerBattlePos,
  QC_HarryKickMiss,
  QC_HarryKickHit,
  QC_OppKickMiss,
  QC_OppKickHit,
  QC_BludgerPursuit,
  QC_BludgerPursuit2,
  QC_BludgerMiss,
  QC_BludgerHit,
  QC_Miss,
  QC_Hit,
  QC_HitNearDeath,
  QC_HitDying,
  QC_Dying,
  QC_Dead,
  QC_ReturnToFlight,
  QC_KeeperDives,
  QC_Block,
  QC_Foul,
  QC_Negative,
  QC_Positive,
  QC_SigningOff,
  QC_InTrenchRun,
  QC_IdleClean,
  QC_IdleRough,
  QC_IdleNoFalls,
  QC_IdleTrickySnitch,
  QC_NumComments
};

struct Candidate
{
  var HouseAffiliation eHouse;
  var int Variant;
  var float fWeight;
};

struct CommentInfo
{
  var string DlgName;
  var Sound dlgSound;
  var string DlgText;
  var bool bHasBeenSaid;
  var float fTimeLastSaid;
};

struct VarCommentInfo
{
  var CommentInfo Variant[30];
  var int Variations;
  var bool bHasBeenSaid;
  var float fTimeLastSaid;
};

struct HouseDependentCommentInfo
{
  var VarCommentInfo House[6];
  var bool bHasBeenSaid;
  var float fTimeLastSaid;
};

var BroomHarry harry;
var string QuidCommentNames[43];
var string QuidCommentHouseNames[6];
var HouseDependentCommentInfo Comments[43];
var Candidate Candidates[90];
var int NumCandidates;
var HouseAffiliation eOpponent;
var float fNextTimeACommentCanBeSaid;
var float fGapTime;
var bool bMute;
var float fVolume;

function PostBeginPlay()
{
  local int Variant;

  Super.PostBeginPlay();
  foreach AllActors(Class'BroomHarry',harry)
  {
    // goto JL001A;
	break;
  }
  fNextTimeACommentCanBeSaid = 0.0;
  fGapTime = (FRand() * (fMaxGapTimeBetweenComments - fMinGapTimeBetweenComments)) + fMinGapTimeBetweenComments;
  bMute = False;
  fVolume = 1.0;
  fillCommentArray();
}

function SetOpponent (HouseAffiliation eNewOpponent)
{
  eOpponent = eNewOpponent;
  Log("QuidditchCommentator: Opponent = " $ string(eOpponent) $ ".");
}

function SetMute (bool bNewMute)
{
  bMute = bNewMute;
}

function SetVolume (float fNewVolume)
{
  fVolume = fNewVolume;
}

function float TimeLeftUntilSafeToSayAComment (optional bool bNoGap)
{
  local float fTimeLeft;

  fTimeLeft = (fNextTimeACommentCanBeSaid - Level.TimeSeconds) + fNoGapTimeBetweenComments;
  if ( bNoGap )
  {
    fTimeLeft += fNoGapTimeBetweenComments;
  } else {
    fTimeLeft += fGapTime;
  }
  return fTimeLeft;
}

function bool CommentHasBeenSaidBefore (QuidComment eComment)
{
  return Comments[eComment].bHasBeenSaid;
}

function bool SayComment (QuidComment eComment, optional TeamAffiliation eTeam, optional bool bNoGap)
{
  local bool bSaid;
  local HouseAffiliation eTeamHouse;
  local HouseAffiliation eHouse;
  local bool bDone;
  local int Variant;
  local int iCandidate;
  local float fAge;
  local float fTotalWeight;
  local float fChoice;
  local Sound dlgSound;

  bSaid = False;
  if ( (eComment == QC_None) || bMute )
  {
    return False;
  }
  if ( bNoGap )
  {
    if ( Level.TimeSeconds < fNextTimeACommentCanBeSaid + fNoGapTimeBetweenComments )
    {
      return False;
    }
  } else {
    if ( Level.TimeSeconds < fNextTimeACommentCanBeSaid + fGapTime )
    {
      return False;
    }
  }
  //
  switch (eTeam)
  {
	case TA_Gryffindor:
	eTeamHouse = HA_Gryffindor;
	break;
	case TA_Opponent:
	eTeamHouse = eOpponent;
	break;
	case TA_Neutral:
	eTeamHouse = HA_Neutral;
	break;
	default:
  }
  eHouse = eTeamHouse;
  iCandidate = 0;
  fTotalWeight = 0.0;
  bDone = False;
  Variant = 0;
  
  //do and while loops -AdamJD
  do
  {
	  while ( Variant < Comments[eComment].House[eHouse].Variations )
	  {
	// JL00DA:
		if (  !Comments[eComment].House[eHouse].Variant[Variant].bHasBeenSaid )
		{
		  fAge = 300.0;
		} else {
		  fAge = Level.TimeSeconds - Comments[eComment].House[eHouse].Variant[Variant].fTimeLastSaid + fMinTimeBeforeCommentRepeat;
		  if ( fAge > 300 )
		  {
			fAge = 300.0;
		  }
		}
		if ( fAge > 0.0 )
		{
		  Candidates[iCandidate].eHouse = eHouse;
		  Candidates[iCandidate].Variant = Variant;
		  Candidates[iCandidate].fWeight = fAge;
		  fTotalWeight += Candidates[iCandidate].fWeight;
		  ++iCandidate;
		}
		++Variant;
		// goto JL00DA;
	  }
	 
	  switch (eHouse)
	  {
		case HA_Neutral:
		bDone = True;
		break;
		case HA_Gryffindor:
		case HA_Opponent:
		eHouse = HA_Neutral;
		break;
		default:
		eHouse = HA_Opponent;
		break;
	  }
  }
  until(bDone);
  
  NumCandidates = iCandidate;
  if ( NumCandidates <= 0 )
  {
    Log("QuidditchCommentator: No viable comment candidates right now for comment type " $ string(eComment) $ " (House=" $ string(eTeamHouse) $ ").");
    return False;
  }
  
  iCandidate = 0;
  fChoice = FRand() * fTotalWeight;
  // if ( iCandidate < NumCandidates - 1 )
  while ( iCandidate < NumCandidates - 1 )
  {
    if ( Candidates[iCandidate].fWeight > fChoice )
    {
	  break;
    } else {
      fChoice -= Candidates[iCandidate].fWeight;
      ++iCandidate;
    }
  }
  eHouse = Candidates[iCandidate].eHouse;
  Variant = Candidates[iCandidate].Variant;
  
  dlgSound = Comments[eComment].House[eHouse].Variant[Variant].dlgSound;
  if ( dlgSound != None )
  {
    PlaySound(dlgSound,SLOT_Talk,fVolume,,20000.0);
	bSaid = True;
  } else {
    Log("QuidditchCommentator: Failed to say dialog for comment type " $ string(eComment) $ "; DlgName = " $ Comments[eComment].House[eHouse].Variant[Variant].DlgName $ ".");
  }

  Comments[eComment].House[eHouse].Variant[Variant].fTimeLastSaid = Level.TimeSeconds;
  Comments[eComment].House[eHouse].fTimeLastSaid = Level.TimeSeconds;
  Comments[eComment].fTimeLastSaid = Level.TimeSeconds;
  Comments[eComment].House[eHouse].Variant[Variant].bHasBeenSaid = True;
  Comments[eComment].House[eHouse].bHasBeenSaid = True;
  Comments[eComment].bHasBeenSaid = True;
  if ( dlgSound != None )
  {
    fNextTimeACommentCanBeSaid = Level.TimeSeconds + GetSoundDuration(dlgSound);
    fGapTime = FRand() * (fMaxGapTimeBetweenComments - fMinGapTimeBetweenComments) + fMinGapTimeBetweenComments;
  }
  
  return bSaid;
}

function string EventNumToEventName (int Num)
{
  return QuidCommentNames[Num];
}

function string GetCommentId (int eventNum, int House, int Variant)
{
  local string Key;
  //local string EventName;
  local string sEventName;
  local string Id;

  sEventName = EventNumToEventName(eventNum);
  Key = QuidCommentHouseNames[House]$"_"$sEventName;
  Id = Localize(Key,"line" $Variant,"QuidSet");
  if ( InStr(Id,"<") > -1 )
  {
	return "";
  } else {
	return Id;
  }
}

function fillCommentArray()
{
  local int C;
  local int H;
  local int V;
  local string sndId;
  local QuidComment vvv;

  for(H = 0; H < MAX_QUID_COMMENT_HOUSE_NAMES; H++)
  {
    Comments[0].House[H].Variations = 0;
  }
  C = 1;

  for(C = 1; C < MAX_QUID_COMMENT_NAMES; C++)
  {
	for(H = 0; H < MAX_QUID_COMMENT_HOUSE_NAMES; H++)
    {
      Comments[C].House[H].Variations = QC_MAX_COMMENT_VARIANTS;
      V = 0;
	  for(V = 0; V < QC_MAX_COMMENT_VARIANTS; V++)
      {
        sndId = GetCommentId(C,H,V);
        if ( sndId != "" )
        {
          Comments[C].House[H].Variant[V].DlgName = sndId;
          Comments[C].House[H].Variant[V].dlgSound = Sound(DynamicLoadObject("AllDialog." $sndId,Class'Sound'));
        } else {
          Comments[C].House[H].Variations = V;
		  break;
        }
      }
    }
  }
}

defaultproperties
{
    QuidCommentNames(0)="None"

    QuidCommentNames(1)="HasQuaffle"

    QuidCommentNames(2)="Scores"

    QuidCommentNames(3)="WinsSlyth"

    QuidCommentNames(4)="WinsAgain"

    QuidCommentNames(5)="WinsMatch"

    QuidCommentNames(6)="WinsCup"

    QuidCommentNames(7)="TheresTheSnitch"

    QuidCommentNames(8)="HereComesSeeker"

    QuidCommentNames(9)="ClosingOnSnitch"

    QuidCommentNames(10)="ReachingSnitch"

    QuidCommentNames(11)="MissedSnitch"

    QuidCommentNames(12)="CaughtSnitch"

    QuidCommentNames(13)="DontGiveUp"

    QuidCommentNames(14)="SeekerBattle"

    QuidCommentNames(15)="SeekerBattleNeg"

    QuidCommentNames(16)="SeekerBattlePos"

    QuidCommentNames(17)="HarryKickMiss"

    QuidCommentNames(18)="HarryKickHit"

    QuidCommentNames(19)="OppKickMiss"

    QuidCommentNames(20)="OppKickHit"

    QuidCommentNames(21)="BludgerPursuit"

    QuidCommentNames(22)="BludgerPursuit2"

    QuidCommentNames(23)="BludgerMiss"

    QuidCommentNames(24)="BludgerHit"

    QuidCommentNames(25)="Miss"

    QuidCommentNames(26)="Hit"

    QuidCommentNames(27)="HitNearDeath"

    QuidCommentNames(28)="HitDying"

    QuidCommentNames(29)="Dying"

    QuidCommentNames(30)="Dead"

    QuidCommentNames(31)="ReturnToFlight"

    QuidCommentNames(32)="KeeperDives"

    QuidCommentNames(33)="Block"

    QuidCommentNames(34)="Foul"

    QuidCommentNames(35)="Negative"

    QuidCommentNames(36)="Positive"

    QuidCommentNames(37)="SigningOff"

    QuidCommentNames(38)="InTrenchRun"

    QuidCommentNames(39)="IdleClean"

    QuidCommentNames(40)="IdleRough"

    QuidCommentNames(41)="IdleNoFalls"

    QuidCommentNames(42)="IdleTrickySnitch"

    QuidCommentHouseNames(0)="QCG"

    QuidCommentHouseNames(1)="QCR"

    QuidCommentHouseNames(2)="QCH"

    QuidCommentHouseNames(3)="QCS"

    QuidCommentHouseNames(4)="QCN"

    QuidCommentHouseNames(5)="QCO"

    // eOpponent=1
	eOpponent=HA_Ravenclaw

    bHidden=True

    Texture=Texture'Engine.S_Flag'
}
