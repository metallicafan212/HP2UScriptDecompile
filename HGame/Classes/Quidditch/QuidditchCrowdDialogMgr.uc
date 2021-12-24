//================================================================================
// QuidditchCrowdDialogMgr.
//================================================================================

class QuidditchCrowdDialogMgr extends Actor;

const fMinTimeBeforeLineRepeat= 90.0;
const fMaxGapTimeBetweenLines= 10.0;
const fMinGapTimeBetweenLines= 6.0;
const fNoGapTimeBetweenLines= 0.1;
const QC_MAX_DIALOG_VARIANTS= 30;
const MAX_QUID_DIALOG_SEX_NAMES=2;
const MAX_QUID_DIALOG_HOUSE_NAMES=6;

enum HouseAffiliation {
  HA_Gryffindor,
  HA_Ravenclaw,
  HA_Hufflepuff,
  HA_Slytherin,
  HA_Neutral,
  HA_Opponent,
  HA_NumHouses
};

enum Sex {
  SX_Male,
  SX_Female,
  SX_Neutral
};

enum TeamAffiliation {
  TA_Gryffindor,
  TA_Opponent,
  TA_Neutral,
  TA_NumAffiliations
};

struct Candidate
{
  var HouseAffiliation eHouse;
  var int Variant;
  var float fWeight;
};

struct DialogInfo
{
  var string DlgName;
  var Sound dlgSound;
  var string DlgText;
  var bool bHasBeenSaid;
  var float fTimeLastSaid;
};

struct VarDialogInfo
{
  var DialogInfo Variant[30];
  var int Variations;
  var bool bHasBeenSaid;
  var float fTimeLastSaid;
};

struct HouseDependentDialogInfo
{
  var VarDialogInfo House[6];
  var bool bHasBeenSaid;
  var float fTimeLastSaid;
};

var BroomHarry harry;
var string QuidDialogHouseNames[6];
var string QuidDialogMatchNames[4];
var string QuidDialogSexNames[2];
var HouseDependentDialogInfo Dialog;
var Candidate Candidates[90];
var int NumCandidates;
var HouseAffiliation eOpponent;
var float fNextTimeALineCanBeSaid;
var float fGapTime;
var QuidditchCrowd SpeakingCrowds;
var int NumSpeakingCrowds;
var QuidditchCrowd CurrentSpeakingCrowd;

function PostBeginPlay()
{
  local int Variant;
  local QuidditchCrowd Crowd;

  Super.PostBeginPlay();
  foreach AllActors(Class'BroomHarry',harry)
  {
    // goto JL001A;
	break;
  }
  SpeakingCrowds = None;
  NumSpeakingCrowds = 0;
  foreach AllActors(Class'QuidditchCrowd',Crowd)
  {
    Crowd.NextSpeakingCrowd = SpeakingCrowds;
    SpeakingCrowds = Crowd;
    ++NumSpeakingCrowds;
  }
  CurrentSpeakingCrowd = SpeakingCrowds;
  PickNextSpeakingCrowd();
  fNextTimeALineCanBeSaid = 0.0;
  fGapTime = FRand() * (fMaxGapTimeBetweenLines - fMinGapTimeBetweenLines) + fMinGapTimeBetweenLines;
}

function SetOpponent (HouseAffiliation eNewOpponent)
{
  eOpponent = eNewOpponent;
  Log("QuidditchCrowdDialogMgr: Opponent = " $ string(eOpponent) $ ".");
  fillDialogArray();
}

function StartDialog()
{
  fNextTimeALineCanBeSaid = Level.TimeSeconds + (FRand() * 1.0) + 1.0;
  SetTimer((fNextTimeALineCanBeSaid + fGapTime) - Level.TimeSeconds,False);
}

function StopDialog()
{
  SetTimer(0.0,False);
}

event Timer()
{
  SayADialogLine();
  SetTimer(FMax(fNoGapTimeBetweenLines,(fNextTimeALineCanBeSaid + fGapTime) - Level.TimeSeconds),False);
}

function PickNextSpeakingCrowd()
{
  local int nSkip;

  if ( (CurrentSpeakingCrowd == None) || (NumSpeakingCrowds <= 1) )
  {
    return;
  }
  nSkip = Rand(NumSpeakingCrowds - 1) + 1;
  while ( nSkip > 0 )
  {
    CurrentSpeakingCrowd = CurrentSpeakingCrowd.NextSpeakingCrowd;
    if ( CurrentSpeakingCrowd == None )
    {
      CurrentSpeakingCrowd = SpeakingCrowds;
    }
    --nSkip;
  }
}

function SayADialogLine()
{
  PickNextSpeakingCrowd();
  if (  !SayDialogLine(True) )
  {
    Log("QuidditchCrowdDialogMgr: Dialog not said.");
  }
}

function float TimeLeftUntilSafeToSayALine (optional bool bNoGap)
{
  local float fTimeLeft;

  fTimeLeft = fNextTimeALineCanBeSaid - Level.TimeSeconds + fNoGapTimeBetweenLines;
  if ( bNoGap )
  {
    fTimeLeft += fNoGapTimeBetweenLines;
  } else {
    fTimeLeft += fGapTime;
  }
  return fTimeLeft;
}

function bool DialogLineHasBeenSaidBefore()
{
  return Dialog.bHasBeenSaid;
}

function bool SayDialogLine (optional bool bNoGap)
{
  local bool bSaid;
  local HouseAffiliation eCrowdHouse;
  local HouseAffiliation eHouse;
  local bool bDone;
  local int Variant;
  local int iCandidate;
  local float fAge;
  local float fTotalWeight;
  local float fChoice;
  local Sound dlgSound;

  bSaid = False;
  if ( bNoGap )
  {
    if ( Level.TimeSeconds < fNextTimeALineCanBeSaid + fNoGapTimeBetweenLines )
    {
      return False;
    }
  } else {
    if ( Level.TimeSeconds < fNextTimeALineCanBeSaid + fGapTime )
    {
      return False;
    }
  }
  switch (CurrentSpeakingCrowd.Affiliation)
  {
    // case 0:
	case HA_Gryffindor:
    eCrowdHouse =  HA_Gryffindor;
    break;
    // case 1:
	case HA_Ravenclaw:
    eCrowdHouse =  HA_Ravenclaw;
    break;
    // case 2:
	case HA_Hufflepuff:
    eCrowdHouse =  HA_Hufflepuff;
    break;
    // case 3:
	case HA_Slytherin:
    eCrowdHouse =  HA_Slytherin;
    break;
    default:
  }
  eHouse = eCrowdHouse;
  iCandidate = 0;
  fTotalWeight = 0.0;
  bDone = False;
  Variant = 0;
  
  //do and while loops -AdamJD
  do
  {
	  while ( Variant < Dialog.House[eHouse].Variations )
	  {
		if (  !Dialog.House[eHouse].Variant[Variant].bHasBeenSaid )
		{
		  fAge = 300.0;
		} else {
		  fAge = Level.TimeSeconds - (Dialog.House[eHouse].Variant[Variant].fTimeLastSaid + fMinTimeBeforeLineRepeat);
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
	  }
	  switch (eHouse)
	  {
		// case 4:
		case HA_Neutral:
		bDone = True;
		break;
		// case 0:
		case HA_Gryffindor:
		// case 5:
		case HA_Opponent:
		eHouse =  HA_Neutral;
		break;
		default:
		if ( eHouse == eOpponent )
		{
		  // eHouse = 5;
		  eHouse = HA_Opponent;
		} else {
		  // eHouse = 4;
		  eHouse = HA_Neutral;
		}
	  }
  }
  until(bDone)
  
  NumCandidates = iCandidate;
  if ( NumCandidates <= 0 )
  {
    Log("QuidditchCrowdDialogMgr: No viable dialog candidates for crowd right now (House=" $ string(eCrowdHouse) $ ").");
    return False;
  }
  iCandidate = 0;
  fChoice = FRand() * fTotalWeight;
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
  
  dlgSound = Dialog.House[eHouse].Variant[Variant].dlgSound;
  if ( dlgSound != None )
  {
    CurrentSpeakingCrowd.PlaySound(dlgSound,SLOT_Talk,0.28,,5000.0);
    bSaid = True;
  } else {
    Log("QuidditchCrowdDialogMgr: Failed to say dialog for dialog line; DlgName = " $ Dialog.House[eHouse].Variant[Variant].DlgName $ ".");
  }
  Dialog.House[eHouse].Variant[Variant].fTimeLastSaid = Level.TimeSeconds;
  Dialog.House[eHouse].fTimeLastSaid = Level.TimeSeconds;
  Dialog.fTimeLastSaid = Level.TimeSeconds;
  Dialog.House[eHouse].Variant[Variant].bHasBeenSaid = True;
  Dialog.House[eHouse].bHasBeenSaid = True;
  Dialog.bHasBeenSaid = True;
  if ( dlgSound != None )
  {
    fNextTimeALineCanBeSaid = Level.TimeSeconds + GetSoundDuration(dlgSound);
    fGapTime = FRand() * (fMaxGapTimeBetweenLines - fMinGapTimeBetweenLines) + fMinGapTimeBetweenLines;
  }
  return bSaid;
}

function string GetDialogLineId (int Sex, int House, int Variant, bool bMatchSpecific)
{
  local string Key;
  local string Id;

  if ( bMatchSpecific )
  {
    Key = "G"$QuidDialogSexNames[Sex]$QuidDialogHouseNames[House]$"_QuidCrowd"$QuidDialogMatchNames[eOpponent]$"Mat";
  } else {
    Key = "G"$ QuidDialogSexNames[Sex]$QuidDialogHouseNames[House]$"_QuidCrowd";
  }
  Id = Localize(Key,"line" $Variant,"QuidSet");
  if ( InStr(Id,"<") > -1 )
  {
    return "";
  } else {
    return Id;
  }
}

function fillDialogArray()
{
  local int S;
  local int H;
  local int L;
  local int V;
  local bool B;
  local string sndId;

  for(H = 0; H < MAX_QUID_DIALOG_HOUSE_NAMES; H++)
  {
    V = 0;
    B = True;
	
	//do and for loops -AdamJD
	do
	{
		for(S = 0; S < MAX_QUID_DIALOG_SEX_NAMES; S++)
		{
		  for(L = 0; L < QC_MAX_DIALOG_VARIANTS; L++)
		  {
			sndId = GetDialogLineId(S,H,L,B);
			if ( sndId != "" )
			{
			  Dialog.House[H].Variant[V].DlgName = sndId;
			  Dialog.House[H].Variant[V].dlgSound = Sound(DynamicLoadObject("AllDialog." $ sndId,Class'Sound'));
			  ++V;
			} else {
			  break;
			}
		  }
		}
		B =  !B;
	}
	until(B);
    Dialog.House[H].Variations = V;
  }
}

defaultproperties
{
    QuidDialogHouseNames(0)="G"

    QuidDialogHouseNames(1)="R"

    QuidDialogHouseNames(2)="H"

    QuidDialogHouseNames(3)="S"

    QuidDialogHouseNames(4)="N"

    QuidDialogHouseNames(5)="O"

    QuidDialogMatchNames(0)="Gry"

    QuidDialogMatchNames(1)="Rav"

    QuidDialogMatchNames(2)="Huf"

    QuidDialogMatchNames(3)="Sly"

    QuidDialogSexNames(0)="M"

    QuidDialogSexNames(1)="F"

    // eOpponent=1
	eOpponent=HA_Ravenclaw

    bHidden=True

    Texture=Texture'Engine.S_Flag'
}
