//================================================================================
// OliverWoodCommentMgr.
//================================================================================

class OliverWoodCommentMgr extends Actor;

const fMinTimeBeforeCommentRepeat= 100.0;
const fMaxGapTimeBetweenComments= 4.0;
const fMinGapTimeBetweenComments= 2.0;
const fNoGapTimeBetweenComments= 0.1;
const WC_MAX_COMMENT_VARIANTS= 6;
const MAX_WOOD_COMMENT_NAMES= 8;

enum WoodComment {
  WC_None,
  WC_FlightAdvice,
  WC_QuidAdvice,
  WC_SeekerAdvice,
  WC_ClosingOnSnitch,
  WC_TooOffCenter,
  WC_CatchSnitch,
  WC_CaughtSnitch,
  WC_NumComments
};

struct Candidate
{
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
  var CommentInfo Variant[6];
  var int Variations;
  var bool bHasBeenSaid;
  var float fTimeLastSaid;
};

var BroomHarry harry;
var VarCommentInfo Comments[8];
var Candidate Candidates[6];
var int NumCandidates;
var float fNextTimeACommentCanBeSaid;
var float fGapTime;
var HChar Speaker;
var bool bMute;
var float fVolume;

function PostBeginPlay ()
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
  fVolume = 0.69999999;
  
  InitCommentArray();
}

function SetSpeaker (HChar NewSpeaker)
{
  Speaker = NewSpeaker;
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

function bool CommentHasBeenSaidBefore (WoodComment eComment)
{
  return Comments[eComment].bHasBeenSaid;
}

function bool SayComment (WoodComment eComment, optional bool bNoGap)
{
  local bool bSaid;
  local bool bDone;
  local int Variant;
  local int iCandidate;
  local float fAge;
  local float fTotalWeight;
  local float fChoice;
  local Sound dlgSound;

  bSaid = False;
  // if ( (bool(eComment) == bool(0)) || bMute || (Speaker == None) )
  if ( (eComment == WC_None) || bMute || (Speaker == None) )
  {
    return False;
  }
  if ( bNoGap )
  {
    if ( Level.TimeSeconds < fNextTimeACommentCanBeSaid + fNoGapTimeBetweenComments )
    {
      return False;
    }
  } else //{
    if ( Level.TimeSeconds < fNextTimeACommentCanBeSaid + fGapTime )
    {
      return False;
    }
  //}
  iCandidate = 0;
  fTotalWeight = 0.0;
  bDone = False;
  Variant = 0;
  while ( Variant < Comments[eComment].Variations )
  {
    if (  !Comments[eComment].Variant[Variant].bHasBeenSaid )
    {
      fAge = 300.0;
    } else //{
      if ( eComment == WC_QuidAdvice )
      {
        fAge = -1.0;
      } else {
        fAge = Level.TimeSeconds - Comments[eComment].Variant[Variant].fTimeLastSaid + fMinTimeBeforeCommentRepeat;
        if ( fAge > 300 )
        {
          fAge = 300.0;
        }
      }
    //}
    if ( fAge > 0.0 )
    {
      Candidates[iCandidate].Variant = Variant;
      Candidates[iCandidate].fWeight = fAge;
      fTotalWeight += Candidates[iCandidate].fWeight;
      ++iCandidate;
    }
    ++Variant;
    // goto JL009F;
  }
  NumCandidates = iCandidate;
  if ( NumCandidates <= 0 )
  {
    Log("OliverWoodCommentMgr: No viable comment candidates right now for comment type " $ string(eComment) $ ".");
    return False;
  }
  iCandidate = 0;
  fChoice = FRand() * fTotalWeight;
  // if ( iCandidate < NumCandidates - 1 )
  while ( iCandidate < NumCandidates - 1 )
  {
    if ( Candidates[iCandidate].fWeight > fChoice )
    {
      // goto JL029D;
	  break;
    } else {
      fChoice -= Candidates[iCandidate].fWeight;
      ++iCandidate;
    }
    // goto JL024A;
  }
  Variant = Candidates[iCandidate].Variant;
  
  dlgSound = Comments[eComment].Variant[Variant].dlgSound;
  if ( dlgSound != None )
  {
    Speaker.PlaySound(dlgSound,SLOT_Talk,fVolume,,8200.0);
    bSaid = True;
  } else {
    Log("OliverWoodCommentMgr: Failed to say dialog for comment type " $ string(eComment) $ "; DlgName = " $ Comments[eComment].Variant[Variant].DlgName $ ".");
  }
  Comments[eComment].Variant[Variant].fTimeLastSaid = Level.TimeSeconds;
  Comments[eComment].fTimeLastSaid = Level.TimeSeconds;
  Comments[eComment].Variant[Variant].bHasBeenSaid = True;
  Comments[eComment].bHasBeenSaid = True;
  if ( dlgSound != None )
  {
    fNextTimeACommentCanBeSaid = Level.TimeSeconds + GetSoundDuration(dlgSound);
    fGapTime = FRand() * (fMaxGapTimeBetweenComments - fMinGapTimeBetweenComments) + fMinGapTimeBetweenComments;
  }
  return bSaid;
}

function InitCommentArray ()
{
  local int C;
  local int V;

  Comments[0].Variations = 0;
  
  C = 1;
  // if ( C < 8 )
  for(C = 1; C < MAX_WOOD_COMMENT_NAMES; C++)
  {
    Comments[C].Variations = MAX_WOOD_COMMENT_NAMES;
    // V = 0;
    // if ( V < 6 )
	for(V = 0; V < WC_MAX_COMMENT_VARIANTS; V++)
    {
      if ( Comments[C].Variant[V].DlgName != "" )
      {
        Comments[C].Variant[V].dlgSound = Sound(DynamicLoadObject("AllDialog." $Comments[C].Variant[V].DlgName,Class'Sound'));
        if ( Comments[C].Variant[V].dlgSound == None )
        {
          Log("OliverWoodCommentMgr: InitArray: Could not load sound for comment type=" $ string(C) $ ", v=" $ string(V) $ ".");
        }
      } else {
        Comments[C].Variations = V;
        // goto JL016D;
		break;
      }
      // V++;
      // goto JL003B;
    }
    // C++;
    // goto JL0015;
  }
}

defaultproperties
{
    // Comments(1)=(Variant=(DlgName="PC_OWd_QuidIntro_06",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),,Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),

    // Comments(2)=(Variant=(DlgName="PC_OWd_QuidIntro_22",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),,Variations=1598246931,bHasBeenSaid=True,fTimeLastSaid=59966320640.00),

    // Comments(3)=(Variant=(DlgName="PC_OWd_QuidIntro_21",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),,Variations=1598246932,bHasBeenSaid=True,fTimeLastSaid=59966320640.00),

    // Comments(4)=(Variant=(DlgName="PC_OWd_QuidIntro_13",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),,Variations=1598246932,bHasBeenSaid=True,fTimeLastSaid=59966320640.00),

    // Comments(5)=(Variant=(DlgName="PC_OWd_QuidTut1_35",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),,Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),

    // Comments(6)=(Variant=(DlgName="PC_OWd_QuidTut1_34",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),,Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00),

    // Comments(7)=(Variant=(DlgName="PC_OWd_QuidIntro_11",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),,Variations=1598246932,bHasBeenSaid=True,fTimeLastSaid=59966320640.00),
	//
    //
	//UTPT decompiled the comment arrays wrong so I had to write them out by hand...(starts at 1 because that's what the InitCommentArray function wants, DlgNames are taken from the editor) -AdamJD
	Comments(1)=(Variant[0]=(DlgName="PC_OWd_QuidIntro_06",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00)

    Comments(2)=(Variant[0]=(DlgName="PC_OWd_QuidIntro_22",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[1]=(DlgName="PC_OWd_QuidTut1_28",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[2]=(DlgName="PC_OWd_QuidTut1_29",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[3]=(DlgName="PC_OWd_QuidTut1_31",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[4]=(DlgName="PC_OWd_QuidTut1_32",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[5]=(DlgName="PC_OWd_QuidTut1_33",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00)

    Comments(3)=(Variant[0]=(DlgName="PC_OWd_QuidIntro_21",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[1]=(DlgName="PC_OWd_QuidIntro_25",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[2]=(DlgName="PC_OWd_QuidIntro_24",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00)

    Comments(4)=(Variant[0]=(DlgName="PC_OWd_QuidIntro_13",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variant[1]=(DlgName="PC_OWd_QuidIntro_14",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00)

    Comments(5)=(Variant[0]=(DlgName="PC_OWd_QuidTut1_35",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00)

    Comments(6)=(Variant[0]=(DlgName="PC_OWd_QuidTut1_34",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00)

    Comments(7)=(Variant[0]=(DlgName="PC_OWd_QuidIntro_11",dlgSound=None,DlgText="",bHasBeenSaid=False,fTimeLastSaid=0.00),Variations=0,bHasBeenSaid=False,fTimeLastSaid=0.00)
	
	bHidden=True

    Texture=Texture'Engine.S_Flag'
}
