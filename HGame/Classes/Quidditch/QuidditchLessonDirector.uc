//================================================================================
// QuidditchLessonDirector.
//================================================================================

class QuidditchLessonDirector extends QuidditchDirector;

struct LessonEvents
{
  var() name Caught;
  var() name End;
};

var OliverWood Wood;
var Keeper FlyingWood;
var(Director) int SnitchLessonTime;
var(Director) LessonEvents SnitchLessonEvents;
var(Director) int MockGameTime;
var OliverWoodCommentMgr CommentMgr;
var float fTimeToComment;
var Sound EndWhistle;
var bool bBlewEndWhistle;

function PreBeginPlay ()
{
  Super.PreBeginPlay();
  CommentMgr = Spawn(Class'OliverWoodCommentMgr');
}

function PostBeginPlay ()
{
  Super.PostBeginPlay();
  foreach AllActors(Class'OliverWood',Wood)
  {
    // goto JL001A;
	break;
  }
  foreach AllActors(Class'Keeper',FlyingWood)
  {
    if ( FlyingWood.Team == TA_Gryffindor )
    {
      // goto JL0046;
	  break;
    }
  }
  harry.SetInvincible(True);
  InitialState = 'GameCutScene';
}

function OnPlayerTravelPostAccept ()
{
  Super(Director).OnPlayerTravelPostAccept();
  // Opponent = 0;
  Opponent = HA_Gryffindor;
  SetHouses();
}

state GameCutScene
{
  function BeginState ()
  {
    PlayerHarry.ClientMessage(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
    Log(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
  }
  
  function EndState ()
  {
    PlayerHarry.ClientMessage(string(Name) $ " Exited " $ string(GetStateName()) $ " State");
    Log(string(Name) $ " Exited " $ string(GetStateName()) $ " State");
  }
  
  function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
  {
    local string sActualCommand;
  
    sActualCommand = ParseDelimitedString(Command," ",1,False);
    if ( sActualCommand ~= "StartSnitchLesson" )
    {
      SetTuningParameters(0);
      GotoState('GameSnitchLesson');
      CutCue(cue);
      return True;
    } else //{
      if ( sActualCommand ~= "StartMockGame" )
      {
        SetTuningParameters(0);
        GotoState('GameMockGame');
        CutCue(cue);
        return True;
      } else {
        return Super.CutCommand(Command,cue,bFastFlag);
      }
    //}
  }
  
}

state GameSnitchLesson extends GamePlay
{
  function BeginState ()
  {
    Wood.PlaySound(Sound'Q_whistle_short',/*3*/SLOT_Interact,1.0,,20000.0);
    bBlewEndWhistle = False;
    ScorePhase = 0;
    Super.BeginState();
    Wood.MakeHeadWatchActor(harry);
    CommentMgr.SetSpeaker(Wood);
    fTimeToComment = Level.TimeSeconds + 1.0;
    SetTimer(SnitchLessonTime,False);
  }
  
  function EndState ()
  {
    SetTimer(0.0,False);
    Wood.StopHeadLook();
    Super.EndState();
  }
  
  function Tick (float DeltaTime)
  {
    local bool bSaid;
    local int I;
    local float R;
  
    Super.Tick(DeltaTime);
    if ( Level.TimeSeconds > fTimeToComment )
    {
      bSaid = False;
      I = harry.Location.X & 7;
	  // if ( I > 0 )
	  while ( I > 0 )
      {
        R = FRand();
        --I;
        // goto JL0049;
      }
      if ( fProgressPercent > 98 )
      {
        bSaid = CommentMgr.SayComment(/*6*/WC_CatchSnitch);
      }
      if (  !bSaid && (fProgressPercent > 97) &&  !bCanReachForSnitch )
      {
        bSaid = CommentMgr.SayComment(/*5*/WC_TooOffCenter);
      }
      if (  !bSaid && (fProgressPercent > 80) )
      {
        bSaid = CommentMgr.SayComment(/*4*/WC_ClosingOnSnitch);
      }
      if (  !bSaid &&  !CommentMgr.CommentHasBeenSaidBefore(/*1*/WC_FlightAdvice) )
      {
        bSaid = CommentMgr.SayComment(/*1*/WC_FlightAdvice);
      }
      if (  !bSaid )
      {
        bSaid = CommentMgr.SayComment(/*2*/WC_QuidAdvice);
      }
      if ( bSaid )
      {
        fTimeToComment = Level.TimeSeconds + CommentMgr.TimeLeftUntilSafeToSayAComment() + 0.1;
      } else {
        fTimeToComment = Level.TimeSeconds + 1.0;
      }
    }
  }
  
  function OnActionKeyPressed ()
  {
    local float fProximity;
    local Bludger Bludger;
    local Pawn HarryAsPawn;
  
    Super(Director).OnActionKeyPressed();
    if ( bCanReachForSnitch )
    {
      fProximity = VSize(harry.Location - Snitch.Location);
      if ( fProgressPercent > 98.0 )
      {
        fTimeToComment += 1000.0;
        bCanReachForSnitch = False;
        harry.SetReaching(False);
        harry.CatchTarget(Snitch,'IP_HarryWin_Loop');
        HarryAsPawn = harry;
        harry.Cam.SetTargetActor(HarryAsPawn.Name);
        foreach AllActors(Class'Bludger',Bludger)
        {
          Bludger.SeekTarget(None);
        }
        if ( SnitchLessonEvents.Caught != 'None' )
        {
          TriggerEvent(SnitchLessonEvents.Caught,self,None);
        }
        TriggerEventDelayed(FMax(5.0,CommentMgr.TimeLeftUntilSafeToSayAComment(True)),SnitchLessonEvents.End,'GameCutScene');
      } else {
        harry.PlayAnim('Miss',,0.1);
      }
    }
  }
  
  function Timer ()
  {
    local Bludger Bludger;
    local float fTimeLeft;
  
    fTimeToComment += 1000.0;
    fTimeLeft = CommentMgr.TimeLeftUntilSafeToSayAComment(True);
    if ( fTimeLeft > 0.0 )
    {
      SetTimer(fTimeLeft,False);
    } else {
      if (  !bBlewEndWhistle )
      {
        Wood.PlaySound(EndWhistle,/*3*/SLOT_Interact,1.0,,20000.0);
        bBlewEndWhistle = True;
        SetTimer(GetSoundDuration(EndWhistle),False);
      } else {
        Snitch.ClearAllEffects();
        Snitch.ResetAllEffects();
        bSnitchVisible = False;
        bSeekerJoinedPursuit = False;
        bHarryJoinedPursuit = False;
        bHarryReaching = False;
        bCanReachForSnitch = False;
        harry.SetReaching(False);
        harry.SetLookForTarget(None);
        foreach AllActors(Class'Bludger',Bludger)
        {
          Bludger.SeekTarget(None);
        }
        if ( SnitchLessonEvents.End != 'None' )
        {
          TriggerEvent(SnitchLessonEvents.End,self,None);
        }
        GotoState('GameCutScene');
      }
    }
  }
  
}

state GameMockGame extends GamePlay
{
  function BeginState ()
  {
    local QuidditchPlayer OtherPlayer;
  
    Wood.PlaySound(Sound'Q_whistle_short',/*3*/SLOT_Interact,1.0,,20000.0);
    bBlewEndWhistle = False;
    foreach AllActors(Class'QuidditchPlayer',OtherPlayer)
    {
      if ( (OtherPlayer.Team != TA_Neutral) &&  !OtherPlayer.bHidden )
      {
        OtherPlayer.Trigger(self,None);
      }
    }
    if ( Seeker != None )
    {
      Seeker.SetLookForTarget(Snitch);
    }
    Seeker.SetKickTargetClass('BroomHarry');
    SeekerHealthBar.Start(Seeker);
    ScorePhase = 0;
    PlayerDialogMgr.StartDialog();
    Super.BeginState();
    CommentMgr.SetSpeaker(FlyingWood);
    fTimeToComment = Level.TimeSeconds + 2.0;
    SetTimer(MockGameTime,False);
  }
  
  function EndState ()
  {
    SetTimer(0.0,False);
    Super.EndState();
  }
  
  function Tick (float DeltaTime)
  {
    local bool bSaid;
  
    Super.Tick(DeltaTime);
    if ( Level.TimeSeconds > fTimeToComment )
    {
      bSaid = False;
      if ( fProgressPercent > 98 )
      {
        bSaid = CommentMgr.SayComment(/*6*/WC_CatchSnitch);
      }
      if (  !bSaid && (fProgressPercent > 97) &&  !bCanReachForSnitch && SeekerIsOutOfWay() )
      {
        bSaid = CommentMgr.SayComment(/*5*/WC_TooOffCenter);
      }
      if (  !bSaid &&  !SeekerIsOutOfWay() )
      {
        bSaid = CommentMgr.SayComment(/*3*/WC_SeekerAdvice);
      }
      if (  !bSaid && (fProgressPercent > 80) )
      {
        bSaid = CommentMgr.SayComment(/*4*/WC_ClosingOnSnitch);
      }
      if (  !bSaid )
      {
        bSaid = CommentMgr.SayComment(/*2*/WC_QuidAdvice);
      }
      if ( bSaid )
      {
        fTimeToComment = Level.TimeSeconds + CommentMgr.TimeLeftUntilSafeToSayAComment() + 0.1;
      } else {
        fTimeToComment = Level.TimeSeconds + 1.0;
      }
    }
  }
  
  function OnTriggerEvent (Actor Other, Pawn EventInstigator)
  {
    local Bludger Bludger;
  
    if ( Other == Seeker )
    {
      fTimeToComment += 1000.0;
      bCanReachForSnitch = False;
      harry.SetReaching(False);
      harry.SetKickTargetClass('None');
      harry.Cam.SetTargetActor(Seeker.Name);
      foreach AllActors(Class'Bludger',Bludger)
      {
        Bludger.SeekTarget(None);
      }
      if ( MatchEvents.Lost != 'None' )
      {
        TriggerEvent(MatchEvents.Lost,self,None);
      }
      TriggerEventDelayed(FMax(5.0,CommentMgr.TimeLeftUntilSafeToSayAComment(True)),MatchEvents.End,'GameCutScene');
    } else {
      Trigger(Other,EventInstigator);
    }
  }
  
  function OnActionKeyPressed ()
  {
    local float fProximity;
    local Bludger Bludger;
    local Pawn HarryAsPawn;
  
    Super(Director).OnActionKeyPressed();
    if ( bCanReachForSnitch )
    {
      fProximity = VSize(harry.Location - Snitch.Location);
      if ( fProgressPercent > 98.0 )
      {
        Log("T=" $ string(Level.TimeSeconds) $ ": Caught Snitch");
        fTimeToComment += 1000.0;
        bCanReachForSnitch = False;
        harry.SetReaching(False);
        harry.CatchTarget(Snitch,'IP_HarryWin_Loop');
        HarryAsPawn = harry;
        harry.Cam.SetTargetActor(HarryAsPawn.Name);
        if ( Seeker != None )
        {
          Seeker.SetLookForTarget(None);
          Seeker.SetKickTargetClass('None');
        }
        foreach AllActors(Class'Bludger',Bludger)
        {
          Bludger.SeekTarget(None);
        }
        if ( MatchEvents.Won != 'None' )
        {
          TriggerEvent(MatchEvents.Won,self,None);
        }
        TriggerEventDelayed(FMax(5.0,CommentMgr.TimeLeftUntilSafeToSayAComment(True)),MatchEvents.End,'GameCutScene');
      } else {
        harry.PlayAnim('Miss',,0.1);
      }
    }
  }
  
  function Timer ()
  {
    local Bludger Bludger;
    local float fTimeLeft;
  
    fTimeToComment += 1000.0;
    fTimeLeft = CommentMgr.TimeLeftUntilSafeToSayAComment(True);
    if ( fTimeLeft > 0.0 )
    {
      SetTimer(fTimeLeft,False);
    } else {
      if (  !bBlewEndWhistle )
      {
        Wood.PlaySound(EndWhistle,/*3*/SLOT_Interact,1.0,,20000.0);
        bBlewEndWhistle = True;
        SetTimer(GetSoundDuration(EndWhistle),False);
      } else {
        Snitch.ClearAllEffects();
        Snitch.ResetAllEffects();
        bSnitchVisible = False;
        bSeekerJoinedPursuit = False;
        bHarryJoinedPursuit = False;
        bHarryReaching = False;
        bCanReachForSnitch = False;
        harry.SetReaching(False);
        harry.SetKickTargetClass('None');
        harry.SetLookForTarget(None);
        if ( Seeker != None )
        {
          Seeker.SetLookForTarget(None);
          Seeker.SetKickTargetClass('None');
        }
        foreach AllActors(Class'Bludger',Bludger)
        {
          Bludger.SeekTarget(None);
        }
        if ( MatchEvents.End != 'None' )
        {
          TriggerEvent(MatchEvents.End,self,None);
        }
        GotoState('GameCutScene');
      }
    }
  }
  
}

state PendingEvent //extends PendingEvent
{
  function BeginState ()
  {
    SetTimer(FMax(1.0,CommentMgr.TimeLeftUntilSafeToSayAComment(True)),False);
  }
  
  function EndState ()
  {
    SetTimer(0.0,False);
  }
  
  function Timer ()
  {
    Wood.PlaySound(EndWhistle,/*3*/SLOT_Interact,1.0,,20000.0);
    bBlewEndWhistle = True;
  }
  
  function TriggerPendingEvent ()
  {
    MakeSeekerLetGoOfSnitch();
    bSnitchVisible = False;
    bSeekerJoinedPursuit = False;
    bHarryJoinedPursuit = False;
    bHarryReaching = False;
    harry.SetKickTargetClass('None');
    harry.SetLookForTarget(None);
    Super.TriggerPendingEvent();
  }
  
}

defaultproperties
{
    SnitchLessonTime=90

    MockGameTime=120

    EndWhistle=Sound'HPSounds.Quidditch_sfx.Q_whistle_long'

    bNeedsCommentator=False

    bHasCrowds=False

    InitialState=GameCutScene
}
