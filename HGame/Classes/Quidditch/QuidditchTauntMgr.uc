//================================================================================
// QuidditchTauntMgr.
//================================================================================

class QuidditchTauntMgr extends Actor;

const fMinTimeBeforeLineRepeat= 120.0;
const fMaxGapTimeBetweenLines= 10.0;
const fMinGapTimeBetweenLines= 4.0;
const fNoGapTimeBetweenLines= 0.1;
const QT_MAX_TAUNT_VARIANTS= 5;
const MAX_QUID_TAUNT_HOUSE_NAMES=6;
const MAX_QUID_TAUNT_NAMES= 4;

enum QuidTaunt {
  QT_None,
  QT_Idle,
  QT_Kicked,
  QT_Potion,
  QT_NumTaunts
};

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

struct Candidate
{
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
  var DialogInfo Variant[5];
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
var Seeker Seeker;
var QuidditchCommentator Commentator;
var HouseDependentDialogInfo Taunts[4];
var Candidate Candidates[6];
var int NumCandidates;
var HouseAffiliation eOpponent;
var float fNextTimeALineCanBeSaid;
var float fGapTime;
var bool bSeekersInRange;
var float fTimeInRange;

function PostBeginPlay()
{
  local int Variant;
  local QuidditchPlayer Player;

  Super.PostBeginPlay();
  foreach AllActors(Class'BroomHarry',harry)
  {
	break;
  }
  foreach AllActors(Class'Seeker',Seeker)
  {
    if ( Seeker.Team == TA_Opponent)
    {
	  break;
    }
  }
  foreach AllActors(Class'QuidditchCommentator',Commentator)
  {
	break;
  }
  fNextTimeALineCanBeSaid = 0.0;
  fGapTime = (FRand() * (fMaxGapTimeBetweenLines - fMinGapTimeBetweenLines)) + fMinGapTimeBetweenLines;
  bSeekersInRange = False;
  fTimeInRange = -1.0;
  InitTauntArray();
}

function SetOpponent (HouseAffiliation eNewOpponent)
{
  eOpponent = eNewOpponent;
  Log("QuidditchTauntMgr: Opponent = " $ string(eOpponent) $ ".");
}

function StartTaunts()
{
  bSeekersInRange = False;
  fTimeInRange = -1.0;
  fNextTimeALineCanBeSaid = Level.TimeSeconds + (FRand() * 2.0);
  SetTimer(FMax(0.2,TimeLeftUntilSafeToSayALine(True)),False);
}

function StopTaunts()
{
  SetTimer(0.0,False);
  if ( (Commentator != None) && (Commentator.fVolume > 0.62) )
  {
    Commentator.SetVolume(1.0);
  }
}

event Timer()
{
  SayATaunt();
  SetTimer(FMax(0.2,TimeLeftUntilSafeToSayALine(True)),False);
}

function bool SayATaunt()
{
  local bool bSaid;
  local float fTimeSinceDrank;
  local float fHarryTimeSinceKicked;
  local float fSeekerTimeSinceKicked;
  local float fTimeLeft;

  bSaid = False;
  if ( VSize(harry.Location - Seeker.Location) < harry.TrackingOffsetRange_Horz * 2.0 )
  {
    if (  !bSeekersInRange )
    {
      bSeekersInRange = True;
      fTimeInRange = Level.TimeSeconds;
      if ( (Commentator != None) && (Commentator.fVolume > 0.62) )
      {
        Commentator.SetVolume(0.64999998);
      }
    }
  } else {
    if ( bSeekersInRange )
    {
      bSeekersInRange = False;
      if ( (Commentator != None) && (Commentator.fVolume > 0.62) )
      {
        Commentator.SetVolume(1.0);
      }
      fTimeLeft = Commentator.TimeLeftUntilSafeToSayAComment(True);
      if ( fTimeLeft > fNoGapTimeBetweenLines )
      {
        fNextTimeALineCanBeSaid = Level.TimeSeconds + fTimeLeft;
        return False;
      }
    }
  }
  if (  (!bSeekersInRange || fTimeInRange < 2.0) || (Seeker.bStunned || Seeker.fHealth < 25) || (Seeker.fHealth > 95 || harry.Health <= 10) )
  {
    return False;
  }
  fTimeSinceDrank = Level.TimeSeconds - harry.fTimeLastDrank;
  if ( (fTimeSinceDrank > 0.75) && (fTimeSinceDrank < 3.0) )
  {
    bSaid = SayTaunt(QT_Potion,TA_Opponent,True);
    if ( bSaid )
    {
	  //Log("AdamJD:	Said potion taunt(opponent)");
      harry.fTimeLastDrank = -1.0;
    }
  }
  if (  !bSaid && (Level.TimeSeconds - fNextTimeALineCanBeSaid) > fMinGapTimeBetweenLines )
  {
    fHarryTimeSinceKicked = Level.TimeSeconds - harry.fTimeLastKicked;
    fSeekerTimeSinceKicked = Level.TimeSeconds - Seeker.fTimeLastKicked;
    if ( (fHarryTimeSinceKicked > 0.75 && fHarryTimeSinceKicked < 3.0) || (fSeekerTimeSinceKicked > 0.75 && fSeekerTimeSinceKicked < 3.0) )
    {
      if ( fHarryTimeSinceKicked <= fSeekerTimeSinceKicked )
      {
        bSaid = SayTaunt(QT_Kicked,TA_Opponent,True);
        if ( bSaid )
        {
		  //Log("AdamJD:	Said kick taunt(opponent)");
          harry.fTimeLastKicked = -1.0;
        }
      } else {
        bSaid = SayTaunt(QT_Kicked,TA_Gryffindor,True);
        if ( bSaid )
        {
		  //Log("AdamJD:    Said kick taunt(harry)");
          Seeker.fTimeLastKicked = -1.0;
        }
      }
    }
  }
  if (  !bSaid && (TimeLeftUntilSafeToSayALine(False) <= 0.0) )
  {
    if ( Rand(2) == 0 )
    {
      bSaid = SayTaunt(QT_Idle,TA_Opponent,True);
	  //Log("AdamJD:     Said idle taunt(opponent)");
    } else {
      bSaid = SayTaunt(QT_Idle,TA_Gryffindor,True);
	  //Log("AdamJD:     Said idle taunt(harry)");
    }
  }
  return bSaid;
}

function float TimeLeftUntilSafeToSayALine (optional bool bNoGap)
{
  local float fTimeLeft;

  fTimeLeft = (fNextTimeALineCanBeSaid - Level.TimeSeconds) + fNoGapTimeBetweenLines;
  if ( bNoGap )
  {
    fTimeLeft += fNoGapTimeBetweenLines;
  } else {
    fTimeLeft += fGapTime;
  }
  return fTimeLeft;
}

function bool TauntHasBeenSaidBefore (QuidTaunt eTaunt)
{
  return Taunts[eTaunt].bHasBeenSaid;
}

function bool SayTaunt (QuidTaunt eTaunt, optional TeamAffiliation eTeam, optional bool bNoGap)
{
  local bool bSaid;
  local HouseAffiliation eHouse;
  local int Variant;
  local int iCandidate;
  local float fAge;
  local float fTotalWeight;
  local float fChoice;
  local Sound dlgSound;
  local Pawn Speaker;

  bSaid = False;
  if ( bNoGap )
  {
    if ( Level.TimeSeconds < fNextTimeALineCanBeSaid + fNoGapTimeBetweenLines )
    {
      return False;
    }
  } else //{
    if ( Level.TimeSeconds < fNextTimeALineCanBeSaid + fGapTime )
    {
      return False;
    }
  //}
  switch (eTeam)
  {
    // case 0:
	case TA_Gryffindor:
    eHouse =  HA_Gryffindor;
    Speaker = harry;
    break;
    // case 1:
	case TA_Opponent:
    eHouse = eOpponent;
    Speaker = Seeker;
    break;
    // case 2:
	case TA_Neutral:
    eHouse =  HA_Neutral;
    Speaker = None;
    break;
    default:
  }
  iCandidate = 0;
  fTotalWeight = 0.0;
  Variant = 0;
  while ( Variant < Taunts[eTaunt].House[eHouse].Variations )
  {
    if (  !Taunts[eTaunt].House[eHouse].Variant[Variant].bHasBeenSaid )
    {
      fAge = 300.0;
    } else {
      fAge = Level.TimeSeconds - Taunts[eTaunt].House[eHouse].Variant[Variant].fTimeLastSaid + 120.0;
      if ( fAge > 300 )
      {
        fAge = 300.0;
      }
    }
    if ( fAge > 0.0 )
    {
      Candidates[iCandidate].Variant = Variant;
      Candidates[iCandidate].fWeight = fAge;
      fTotalWeight += Candidates[iCandidate].fWeight;
      ++iCandidate;
    }
    ++Variant;
  }
  NumCandidates = iCandidate;
  if ( NumCandidates <= 0 )
  {
    Log("QuidditchTauntMgr: No viable taunt candidates for player right now (Taunt=" $ string(eTaunt) $ ", House=" $ string(eHouse) $ ").");
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
  Variant = Candidates[iCandidate].Variant;
  dlgSound = Taunts[eTaunt].House[eHouse].Variant[Variant].dlgSound;
  if ( dlgSound != None )
  {
    Speaker.PlaySound(dlgSound,SLOT_Talk,1.0);
    bSaid = True;
  } else {
    Log("QuidditchTauntMgr: Failed to say dialog for dialog line; DlgName = " $ Taunts[eTaunt].House[eHouse].Variant[Variant].DlgName $ ".");
  }
  Taunts[eTaunt].House[eHouse].Variant[Variant].fTimeLastSaid = Level.TimeSeconds;
  Taunts[eTaunt].House[eHouse].fTimeLastSaid = Level.TimeSeconds;
  Taunts[eTaunt].fTimeLastSaid = Level.TimeSeconds;
  Taunts[eTaunt].House[eHouse].Variant[Variant].bHasBeenSaid = True;
  Taunts[eTaunt].House[eHouse].bHasBeenSaid = True;
  Taunts[eTaunt].bHasBeenSaid = True;
  if ( dlgSound != None )
  {
    fNextTimeALineCanBeSaid = Level.TimeSeconds + GetSoundDuration(dlgSound);
    fGapTime = FRand() * (fMaxGapTimeBetweenLines - fMinGapTimeBetweenLines) + fMinGapTimeBetweenLines;
  }
  return bSaid;
}

function InitTauntArray()
{
  local int C;
  local int H;
  local int V;

  for(H = 0; H < MAX_QUID_TAUNT_HOUSE_NAMES; H++)
  {
    Taunts[0].House[H].Variations = 0;
  }
  C = 1;
  for(C = 1; C < MAX_QUID_TAUNT_NAMES; C++)
  {
	for(H = 0; H < MAX_QUID_TAUNT_HOUSE_NAMES; H++)
    {
      Taunts[C].House[H].Variations = QT_MAX_TAUNT_VARIANTS;
	  for(V = 0; V < QT_MAX_TAUNT_VARIANTS; V++)
      {
        if ( Taunts[C].House[H].Variant[V].DlgName != "" )
        {
          Taunts[C].House[H].Variant[V].dlgSound = Sound(DynamicLoadObject("AllDialog." $Taunts[C].House[H].Variant[V].DlgName,Class'Sound'));
          if ( Taunts[C].House[H].Variant[V].dlgSound == None )
          {
            Log("QuidditchTauntMgr: InitArray: Could not load sound for taunt type=" $ string(C) $ ", v=" $ string(V) $ ".");
          }
        } else {
          Taunts[C].House[H].Variations = V;
		  break;
        }
      }
    }
  }
}

//the taunt names taken from the editor(added here for ease of access) -AdamJD
// ===========================================================================================================================
// Harry(Idle): PC_Hry_QuidTaunts_16
// Draco(Idle): PC_Drc_QuidTaunts_03, PC_Drc_QuidTaunts_05, PC_Drc_QuidTaunts_07, PC_Drc_QuidTaunts_10, PC_Drc_QuidTaunts_11
// ---------------------------------------------------------------------------------------------------------------------------
// Harry(Kick): PC_Hry_QuidTaunts_13, PC_Hry_QuidTaunts_14
// Draco(Kick): PC_Drc_QuidTaunts_12, PC_Drc_QuidTaunts_15
// ---------------------------------------------------------------------------------------------------------------------------
// Harry(Potion): N/A
// Draco(Potion): PC_Drc_QuidTaunts_01, PC_Drc_QuidTaunts_08
//============================================================================================================================
defaultproperties 
{
    // Taunts(1)=(House=(Variant=(DlgName="PC_Hry_QuidTaunts_16",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),,Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),,bHasBeenSaid=False,fTimeLastSaid=0.00),

    // Taunts(2)=(House=(Variant=(DlgName="PC_Hry_QuidTaunts_13",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),,Variations=1598246933,bHasBeenSaid=True,fTimeLastSaid=59988451328.00),,bHasBeenSaid=True,fTimeLastSaid=2.44871566118923272E20),

    // Taunts(3)=(House=(Variant=(DlgName="",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),,Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),,bHasBeenSaid=False,fTimeLastSaid=0.00),
	//
	//
	//UTPT decompiled the taunt arrays wrong so I had to write them out by hand...(starts at 1 because that's what the InitTauntArray function wants) -AdamJD
	Taunts(1)=(House[0]=(Variant[0]=(DlgName="PC_Hry_QuidTaunts_16",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),House[3]=(Variant[0]=(DlgName="PC_Drc_QuidTaunts_03",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[1]=(DlgName="PC_Drc_QuidTaunts_05",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[2]=(DlgName="PC_Drc_QuidTaunts_07",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[3]=(DlgName="PC_Drc_QuidTaunts_10",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[4]=(DlgName="PC_Drc_QuidTaunts_11",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),bHasBeenSaid=False,fTimeLastSaid=0.00)
	
	Taunts(2)=(House[0]=(Variant[0]=(DlgName="PC_Hry_QuidTaunts_13",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[1]=(DlgName="PC_Hry_QuidTaunts_14",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),House[3]=(Variant[0]=(DlgName="PC_Drc_QuidTaunts_12",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[1]=(DlgName="PC_Drc_QuidTaunts_15",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),bHasBeenSaid=False,fTimeLastSaid=0.00)

    Taunts(3)=(House[0]=(Variant[0]=(DlgName="",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),House[3]=(Variant[0]=(DlgName="PC_Drc_QuidTaunts_01",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[1]=(DlgName="PC_Drc_QuidTaunts_08",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),bHasBeenSaid=False,fTimeLastSaid=0.00)

    // eOpponent=3
	eOpponent=HA_Slytherin

    bHidden=True

    Texture=Texture'Engine.S_Flag'
}
