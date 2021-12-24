//================================================================================
// QuidditchDirector.
//================================================================================

class QuidditchDirector extends Director;

const NUM_PROGRESS_SOUNDS= 15;

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
  HA_Slytherin
};

enum QuidPlayMechanic {
  PM_Hoops,
  PM_Proximity,
  PM_ProximityWithHoops
};

struct RandomSeed
{
  var float SeedA;
  var float SeedB;
  var float SeedC;
  var float SeedD;
};

struct HarryPenalties
{
  var() float Bludgered;
  var() float Bumped;
  var() float Hit;
  var() float Kicked[6];
};

struct HarryParameters
{
  var() float PursuitTime;
  var() float PursuitTime_Nimbus2001;
  var() HarryPenalties Penalties;
};

struct FloatRange
{
  var() float Min;
  var() float Max;
};

struct SeekerPenalties
{
  var() float Bumped;
  var() float Kicked;
};

struct SeekerParameters
{
  var() float PursuitTime;
  var() float RecoveryTime;
  var() SeekerPenalties Penalties;
  var() FloatRange PositionChangeInterval;
  var() FloatRange KickInterval;
  var() int KickDamage;
};

struct QuidEvents_Final
{
  var() name GoingIntoTrench;
  var() name Won;
  var() name Lost;
  var() name Died;
  var() name End;
};

struct QuidEvents
{
  var() name Won;
  var() name Lost;
  var() name Died;
  var() name End;
};

var BroomHarry harry;
var Seeker Seeker;
var Snitch Snitch;
var QuidditchCameraTarget CameraTarget;
var QuidditchBar ProgressBar;
var StatusItemHealth HarryHealth;
var EnemyHealthManager SeekerHealthBar;
var QuidScoreManager ScoreBoard;
var StatusGroupHousePoints HousePointsMgr;
var StatusItemGryffindorPts HousePoints;
var StatusItemNimbus Nimbus2001Status;
var QuidditchCommentator Commentator;
var QuidditchPlayerDialogMgr PlayerDialogMgr;
var QuidditchCrowdDialogMgr CrowdDialogMgr;
var QuidditchTauntMgr TauntMgr;
var(Director) bool bForceFinalMatch;
var(Director) float fTimeBeforeGoingIntoTrench;
var bool bTimeToGoIntoTrench;
var QuidPlayMechanic PlayMechanic;
var(Director) HouseAffiliation Opponent;
var(Director) QuidEvents MatchEvents;
var(Director) QuidEvents_Final MatchEvents_Final;
var(Director) SeekerParameters Tuning_Seeker[6];
var(Director) HarryParameters Tuning_HarryProgress;
var float fHarryProgressKickedPenalty;
var string EndCue;
var float fSnitchTrackingOffset;
var float fSnitchMaxGainRadiusAt0;
var float fSnitchNeutralRadiusAt0;
var float fSnitchNeutralRadiusAt100;
var float fSnitchMaxLossRadiusAt0;
var float fSnitchMaxGainRate;
var float fSnitchMaxLossRate;
var float fSnitchMaxCatchTime;
var int SnitchMaxCatchTries;
var int HoopsToHit;
var float SnitchTrackDistDecay;
var float SnitchTrackDistDecay_Nimbus2001;
var(Director) float SnitchTrackDistMin;
var(Director) float SnitchTrackDistMax;
var float fSnitchTrackDist;
var float CameraTrailDist;
var float fPenaltyGraceExpiration;
var float fProgressPercent;
var int CatchTriesLeft;
var Sound ProgressSounds[15];
var QuidditchCrowd Crowds[3];
var float fTimeToCheer;
var TeamAffiliation CheerCrowd;
var RandomSeed RandSeed;
var bool bNeedsCommentator;
var bool bHasCrowds;
var bool bHousesSet;
var bool bSnitchVisible;
var bool bSeekerJoinedPursuit;
var bool bHarryJoinedPursuit;
var bool bHarryReaching;
var bool bCanReachForSnitch;
var bool bGryffWon;
var bool bHarryDied;
var int OriginalHealth;
var int ScorePhase;
var int GryffScore;
var int OpponentScore;
var bool bWonCup;
var bool bFirstTimeThisMatch;
var bool bFinalMatch;
var bool bInTrench;
var float fWhenToPlayPostMusic;
var float fDelayedEventDelayTime;
var name DelayedEventName;
var name DelayedEventNextState;
var string DelayedEventCue;


function PreBeginPlay()
{
  Super.PreBeginPlay();
  if ( bNeedsCommentator )
  {
    foreach AllActors(Class'QuidditchCommentator',Commentator)
    {
      // goto JL0023;
	  break;
    }
    if ( Commentator == None )
    {
      Log("Couldn't find a commentator; spawning one");
      Commentator = Spawn(Class'QuidditchCommentator');
    } else {
      Log("Found a commentator");
    }
  } else {
    Log("Don't need a commentator");
  }
  PlayerDialogMgr = Spawn(Class'QuidditchPlayerDialogMgr');
  if ( bHasCrowds )
  {
    CrowdDialogMgr = Spawn(Class'QuidditchCrowdDialogMgr');
  }
  bHousesSet = False;
}

function PostBeginPlay()
{
  Super.PostBeginPlay();
  foreach AllActors(Class'BroomHarry',harry)
  {
    // goto JL001A;
	break;
  }
  foreach AllActors(Class'Snitch',Snitch)
  {
    // goto JL002F;
	break;
  }
  foreach AllActors(Class'Seeker',Seeker)
  {
    if ( Seeker.Team == TA_Opponent )
    {
      // goto JL005B;
	  break;
    }
  }
  CameraTarget = Spawn(Class'QuidditchCameraTarget',None,'CameraTarget',Snitch.Location,Snitch.Rotation);
  Log("Spawned camera target '" $ string(CameraTarget.Name) $ "'");
  ProgressBar = Spawn(Class'QuidditchBar');
  ProgressBar.Show(False);
  SeekerHealthBar = Spawn(Class'EnemyHealthManager');
  ScoreBoard = Spawn(Class'QuidScoreManager');
  ScorePhase = 0;
  bSnitchVisible = False;
  bSeekerJoinedPursuit = False;
  bHarryJoinedPursuit = False;
  bHarryReaching = False;
  bCanReachForSnitch = False;
  bGryffWon = False;
  bHarryDied = False;
  bTimeToGoIntoTrench = False;
  bInTrench = False;
  fTimeBeforeGoingIntoTrench = 30.0;
  InitialState = 'GameIntro';
}

function OnPlayerTravelPostAccept()
{
  local string MatchOpponent;
  local int I;
  local float R;

  Super.OnPlayerTravelPostAccept();
  if ( bForceFinalMatch )
  {
    harry.curQuidMatchNum = 5;
  }
  I = harry.curQuidMatchNum;
  // if ( I > 0 )
  while ( I > 0 )
  {
    R = FRand();
    --I;
    // goto JL0034;
  }
  bFinalMatch = harry.curQuidMatchNum >= 5;
  MatchOpponent = harry.quidGameResults[harry.curQuidMatchNum].Opponent;
  if ( MatchOpponent ~= "Gryffindor" )
  {
    // Opponent = 0;
	Opponent = HA_Gryffindor;
  } else //{
    if ( MatchOpponent ~= "Ravenclaw" )
    {
      // Opponent = 1;
	  Opponent = HA_Ravenclaw;
    } else //{
      if ( MatchOpponent ~= "Hufflepuff" )
      {
        // Opponent = 2;
		Opponent = HA_Hufflepuff;
      } else //{
        if ( MatchOpponent ~= "Slytherin" )
        {
          // Opponent = 3;
		  Opponent = HA_Slytherin;
        }
      //}
    //}
  //}
  bFirstTimeThisMatch = (harry.quidGameResults[harry.curQuidMatchNum].myScore == 0) && (harry.quidGameResults[harry.curQuidMatchNum].OpponentScore == 0);
  PlayerHarry.ClientMessage(string(Name) $ ": Start match: " $ string(harry.curQuidMatchNum) $ ", '" $ MatchOpponent $ "'");
  Log(string(Name) $ ": Start match: " $ string(harry.curQuidMatchNum) $ ", '" $ MatchOpponent $ "'");
  SetHouses();
  HarryHealth = StatusItemHealth(harry.managerStatus.GetStatusItem(Class'StatusGroupHealth',Class'StatusItemHealth'));
  HousePointsMgr = StatusGroupHousePoints(harry.managerStatus.GetStatusGroup(Class'StatusGroupHousePoints'));
  HousePoints = StatusItemGryffindorPts(harry.managerStatus.GetStatusItem(Class'StatusGroupHousePoints',Class'StatusItemGryffindorPts'));
  Nimbus2001Status = StatusItemNimbus(harry.managerStatus.GetStatusItem(Class'StatusGroupQGear',Class'StatusItemNimbus'));
  Log("Harry's Health Originally: " $ string(harry.GetHealthCount()));
  OriginalHealth = harry.GetHealthCount();
  if (  !harry.bInvincible )
  {
    Log("Harry's Health: " $ string(harry.GetHealthCount()));
    HarryHealth.SetCountToMaxPotential();
    Log("Harry's Health Primed: " $ string(harry.GetHealthCount()));
  }
}

function bool CutQuestion (string question)
{
  if ( question ~= "OpponentIsGryffindor" )
  {
    return Opponent == HA_Gryffindor;
  } else //{
    if ( question ~= "OpponentIsRavenclaw" )
    {
      return Opponent == HA_Ravenclaw;
    } else //{
      if ( question ~= "OpponentIsHufflepuff" )
      {
        return Opponent == HA_Hufflepuff;
      } else //{
        if ( question ~= "OpponentIsSlytherin" )
        {
          return Opponent == HA_Slytherin;
        } else //{
          if ( question ~= "FirstMatch" )
          {
            return harry.curQuidMatchNum == 0;
          } else //{
            if ( question ~= "FinalMatch" )
            {
              return bFinalMatch;
            } else //{
              if ( question ~= "NotFirstNorFinalMatch" )
              {
                return (harry.curQuidMatchNum != 0) &&  !bFinalMatch;
              } else //{
                if ( question ~= "FirstTimePlayedMatch" )
                {
                  return bFirstTimeThisMatch;
                } else //{
                  if ( question ~= "NotFirstTimePlayedMatch" )
                  {
                    return  !bFirstTimeThisMatch;
                  } else //{
                    if ( question ~= "FirstTimePlayedOpponent" )
                    {
                      return harry.curQuidMatchNum <= 2;
                    } else //{
                      if ( question ~= "SecondTimePlayedOpponent" )
                      {
                        return harry.curQuidMatchNum >= 3;
                      } else //{
                        if ( question ~= "GryffindorWon" )
                        {
                          return bGryffWon;
                        } else //{
                          if ( question ~= "GryffindorLost" )
                          {
                            return  !bGryffWon;
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
          // }
        // }
      // }
    // }
  // }
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local string sAssociation;
  local string sEventName;
  local string sEventCue;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "SetEventCue" )
  {
    sAssociation = ParseDelimitedString(Command," ",2,False);
    if ( sAssociation == "" )
    {
      CutErrorString = "Missing event=cue association";
      CutCue(cue);
      return False;
    } else {
      sEventName = ParseDelimitedString(sAssociation,"=",1,False);
      sEventCue = ParseDelimitedString(sAssociation,"=",2,False);
      if ( sEventName ~= "End" )
      {
        EndCue = sEventCue;
        CutCue(cue);
        return True;
      } else {
        CutErrorString = "Unknown event in association '" $ sAssociation $ "'";
        CutCue(cue);
        return False;
      }
    }
  } else //{
    if ( sActualCommand ~= "MakeSeekerLetGoOfSnitch" )
    {
      MakeSeekerLetGoOfSnitch();
      CutCue(cue);
      return True;
    } else {
      return Super.CutCommand(Command,cue,bFastFlag);
    }
  //}
}

function SetHouses()
{
  local QuidditchCrowd Crowd;
  local TeamAffiliation eTeam;

  if ( bHousesSet )
  {
    Log(string(Name) $ ": *** Warning: Houses already setup for match!");
    return;
  }
  if ( Commentator != None )
  {
    switch (Opponent)
    {
      case HA_Ravenclaw:
		  // Commentator.SetOpponent(1);
		  Commentator.SetOpponent(HA_Ravenclaw);
		  break;
      case HA_Hufflepuff:
		  // Commentator.SetOpponent(2);
		  Commentator.SetOpponent(HA_Hufflepuff);
		  break;
      case HA_Slytherin:
		  // Commentator.SetOpponent(3);
		  Commentator.SetOpponent(HA_Slytherin);
		  break;
      default:
		  Log("QuidditchDirector: Warning: Opponent property not set properly");
    }
  }
  switch (Opponent)
  {
    case HA_Gryffindor:
		// PlayerDialogMgr.SetOpponent(0);
		PlayerDialogMgr.SetOpponent(HA_Gryffindor);
		break;
    case HA_Ravenclaw:
		// PlayerDialogMgr.SetOpponent(1);
		PlayerDialogMgr.SetOpponent(HA_Ravenclaw);
		break;
    case HA_Hufflepuff:
		// PlayerDialogMgr.SetOpponent(2);
		PlayerDialogMgr.SetOpponent(HA_Hufflepuff);
		break;
    case HA_Slytherin:
		// PlayerDialogMgr.SetOpponent(3);
		PlayerDialogMgr.SetOpponent(HA_Slytherin);
		break;
    default:
  }
  if ( CrowdDialogMgr != None )
  {
    switch (Opponent)
    {
      case HA_Gryffindor:
		  // CrowdDialogMgr.SetOpponent(0);
		  CrowdDialogMgr.SetOpponent(HA_Gryffindor);
		  break;
      case HA_Ravenclaw:
		  // CrowdDialogMgr.SetOpponent(1);
		  CrowdDialogMgr.SetOpponent(HA_Ravenclaw);
		  break;
      case HA_Hufflepuff:
		  // CrowdDialogMgr.SetOpponent(2);
		  CrowdDialogMgr.SetOpponent(HA_Hufflepuff);
		  break;
      case HA_Slytherin:
		  // CrowdDialogMgr.SetOpponent(3);
		  CrowdDialogMgr.SetOpponent(HA_Slytherin);
		  break;
      default:
    }
  }
  switch (Opponent)
  {
    case HA_Gryffindor:
		// ScoreBoard.SetOpponent(0);
		ScoreBoard.SetOpponent(Opponent_Gryffindor);
		break;
    case HA_Ravenclaw:
		// ScoreBoard.SetOpponent(1);
		ScoreBoard.SetOpponent(Opponent_Ravenclaw);
		break;
    case HA_Hufflepuff:
		// ScoreBoard.SetOpponent(2);
		ScoreBoard.SetOpponent(Opponent_Hufflepuff);
		break;
    case HA_Slytherin:
		// ScoreBoard.SetOpponent(3);
		ScoreBoard.SetOpponent(Opponent_Slytherin);
		break;
    default:
		Log("QuidditchDirector: Warning: Opponent property not set properly");
  }
  SetPlayerHouses();
  if ( bHasCrowds )
  {
    foreach AllActors(Class'QuidditchCrowd',Crowd)
    {
      if ( Crowd.Affiliation == HA_Gryffindor )
      {
        // eTeam = 0;
		eTeam = TA_Gryffindor;
      } else //{
        if ( Crowd.Affiliation == Opponent )
        {
          // eTeam = 1;
		  eTeam = TA_Opponent;
        } else {
          // eTeam = 2;
		  eTeam = TA_Neutral;
        }
      //}
      Crowd.NextCrowd = Crowds[eTeam];
      Crowds[eTeam] = Crowd;
    }
  }
  if ( Opponent == HA_Slytherin )
  {
    TauntMgr = Spawn(Class'QuidditchTauntMgr');
    // TauntMgr.SetOpponent(3);
	TauntMgr.SetOpponent(HA_Slytherin);
  }
  bHousesSet = True;
}

function SetPlayerHouses()
{
  local QuidditchPlayer OtherPlayer;

  foreach AllActors(Class'QuidditchPlayer',OtherPlayer)
  {
    switch (Opponent)
    {
      case HA_Gryffindor:
		  // OtherPlayer.SetHouse(0);
		  OtherPlayer.SetHouse(HA_Gryffindor);
		  break;
      case HA_Ravenclaw:
		  // OtherPlayer.SetHouse(1);
		  OtherPlayer.SetHouse(HA_Ravenclaw);
		  break;
      case HA_Hufflepuff:
		  // OtherPlayer.SetHouse(2);
		  OtherPlayer.SetHouse(HA_Hufflepuff);
		  break;
      case HA_Slytherin:
		  // OtherPlayer.SetHouse(3);
		  OtherPlayer.SetHouse(HA_Slytherin);
		  break;
      default:
		Log("QuidditchDirector: Warning: Opponent property not set");
    }
  }
}

function SetTuningParameters (int Match)
{
  if ( Seeker != None )
  {
    Seeker.SetPursuitParameters(Tuning_Seeker[Match].PursuitTime,Tuning_Seeker[Match].RecoveryTime,Tuning_Seeker[Match].Penalties.Kicked,Tuning_Seeker[Match].Penalties.Bumped,Tuning_Seeker[Match].PositionChangeInterval.Min,Tuning_Seeker[Match].PositionChangeInterval.Max,Tuning_Seeker[Match].KickInterval.Min,Tuning_Seeker[Match].KickInterval.Max,Tuning_Seeker[Match].KickDamage);
  }
  if ( Tuning_HarryProgress.PursuitTime <= 0.01 )
  {
    SnitchTrackDistDecay = 5.0;
  } else {
    SnitchTrackDistDecay = 100.0 / Tuning_HarryProgress.PursuitTime;
  }
  if ( Tuning_HarryProgress.PursuitTime_Nimbus2001 <= 0.01 )
  {
    SnitchTrackDistDecay_Nimbus2001 = 10.0;
  } else {
    SnitchTrackDistDecay_Nimbus2001 = 100.0 / Tuning_HarryProgress.PursuitTime_Nimbus2001;
  }
  fHarryProgressKickedPenalty = Tuning_HarryProgress.Penalties.Kicked[Match];
}

function StartGame()
{
  local QuidditchPlayer OtherPlayer;

  SetTuningParameters(harry.curQuidMatchNum);
  if ( Commentator != None )
  {
    Commentator.PlaySound(Sound'Q_whistle_short',SLOT_Interact,1.0,,20000.0);
  }
  foreach AllActors(Class'QuidditchPlayer',OtherPlayer)
  {
    if ( (OtherPlayer.Team != TA_Neutral) &&  !OtherPlayer.bHidden )
    {
      OtherPlayer.Trigger(self,None);
    }
  }
  if ( Seeker != None )
  {
    Seeker.SetLookForTarget(Snitch,'IP_HarryWin_Loop');
  }
  Seeker.SetKickTargetClass('BroomHarry');
  ScorePhase = 1;
  GryffScore = 0;
  OpponentScore = 0;
  SeekerHealthBar.Start(Seeker);
  ScoreBoard.StartQuidScore();
  fTimeToCheer = Level.TimeSeconds;
  PlayerDialogMgr.StartDialog();
  if ( CrowdDialogMgr != None )
  {
    CrowdDialogMgr.StartDialog();
  }
  if ( TauntMgr != None )
  {
    TauntMgr.StartTaunts();
  }
  if ( bFinalMatch )
  {
    Log("Starting final match at " $ string(Level.TimeSeconds));
    SetTimer(fTimeBeforeGoingIntoTrench,False);
  }
  GotoState('GamePlay');
}

function SetSeekersToFollowSnitch()
{
  local Vector TargetX;
  local Vector TargetY;
  local Vector TargetZ;
  local Vector HarryTargetTrackPoint;
  local Vector SeekerTargetTrackPoint;

  GetAxes(Snitch.Rotation,TargetX,TargetY,TargetZ);
  HarryTargetTrackPoint = Snitch.Location + TargetY * (7.0 + harry.CollisionRadius) + TargetZ * -16;
  SeekerTargetTrackPoint = Snitch.Location + (TargetY * 5.0) + TargetZ * -16;
  harry.SetLocation(HarryTargetTrackPoint - TargetX * (SnitchTrackDistMax + 60));
  harry.DesiredRotation = rotator(HarryTargetTrackPoint - harry.Location);
  harry.SetRotation(harry.DesiredRotation);
  Seeker.SetLocation(HarryTargetTrackPoint - TargetX * (SnitchTrackDistMax - 60));
  Seeker.DesiredRotation = rotator(SeekerTargetTrackPoint - Seeker.Location);
  Seeker.SetRotation(Seeker.DesiredRotation);
}

function SetCameraTargetToFollowSnitch()
{
  CameraTarget.SetLocation(harry.Location);
  CameraTarget.SetRotation(harry.Rotation);
  CameraTarget.SetLookForTarget(Snitch);
}

function SetCameraToFollowSnitch()
{
  // harry.Cam.SetCameraMode(4);
  harry.Cam.SetCameraMode(CM_Quidditch);
  harry.Cam.SetTargetActor(CameraTarget.Name);
  harry.Cam.SetZOffset(25.0);
  harry.Cam.CamTarget.bRelative = True;
  harry.Cam.SetDistance(CameraTrailDist);
  harry.Cam.SetRotTightness(10.0);
  harry.Cam.SetMoveTightness(10.0);
  harry.Cam.SetMoveSpeed(1200.0);
}

function MakeSeekerLetGoOfSnitch()
{
  Snitch.DisposeCatchProxy();
  Seeker.DoCapture();
  harry.DoCapture();
}

function bool SeekerIsOutOfWay()
{
  local float fSeekerProximity;

  fSeekerProximity = VSize(harry.Location - Seeker.Location);
  return fSeekerProximity > harry.TrackingOffsetRange_Horz * 2.79999995;
}

function ComputeScore()
{
  if ( bGryffWon )
  {
    GryffScore += 150;
    ScoreBoard.SetGryffindorScore(GryffScore);
  } else {
    OpponentScore += 150;
    if (  !bHarryDied )
    {
      ScoreBoard.SetOpponentScore(OpponentScore);
    }
  }
  bWonCup = bFinalMatch && bGryffWon;
}

function TriggerEventDelayed (float fDelayTime, name EventName, optional name NextState, optional string cue)
{
  fDelayedEventDelayTime = fDelayTime;
  DelayedEventName = EventName;
  DelayedEventNextState = NextState;
  DelayedEventCue = cue;
  GotoState('PendingEvent');
}

state GameIntro
{
  function BeginState()
  {
    PlayerHarry.ClientMessage(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
    Log(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
  }
  
  function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
  {
    local string sActualCommand;
    local QuidditchPlayer OtherPlayer;
  
    sActualCommand = ParseDelimitedString(Command," ",1,False);
    if ( sActualCommand ~= "LaunchPlayers" )
    {
      foreach AllActors(Class'QuidditchPlayer',OtherPlayer)
      {
        if ( (OtherPlayer.Team != TA_Neutral) &&  !OtherPlayer.bHidden )
        {
          OtherPlayer.Trigger(self,None);
        }
      }
      CutCue(cue);
      return True;
    } else //{
      if ( sActualCommand ~= "StartGame" )
      {
        StartGame();
        CutCue(cue);
        return True;
      } else {
        return Super.CutCommand(Command,cue,bFastFlag);
      }
    //}
  }
  
begin:
loop:
  Sleep(0.1);
  goto ('Loop');
}

state GamePlay
{
  //UTPT added this for some reason -AdamJD
  // ignores  CutCommand;
  
  function BeginState()
  {
    local Bludger Bludger;
    local int PercentDone;
  
    EndCue = "";
    PlayerHarry.ClientMessage(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
    Log(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
    harry.StopFlyingOnPath();
    harry.AirSpeed = 10.0;
    harry.Deceleration = harry.AirSpeedNormal - harry.AirSpeed;
	harry.SetLookForTarget(Snitch);
    foreach AllActors(Class'Bludger',Bludger)
    {
      Bludger.SeekTarget(harry);
    }
    harry.SetKickTargetClass('QuidditchPlayer');
    SetCameraTargetToFollowSnitch();
    SetCameraToFollowSnitch();
    switch (PlayMechanic)
    {
      case PM_Hoops:
		  Snitch.HoopTrail.SetHoopsToHit(HoopsToHit);
		  ProgressBar.SetProgress(100 * (Snitch.HoopTrail.HoopsToHit - Snitch.HoopTrail.HoopsToGo) / Snitch.HoopTrail.HoopsToHit);
		  break;
      case PM_Proximity:
      case PM_ProximityWithHoops:
		  fProgressPercent = 0.0;
		  PercentDone = fProgressPercent;
		  ProgressBar.SetProgress(PercentDone);
		  break;
      default:
    }
    ProgressBar.Show(True);
    fSnitchTrackDist = SnitchTrackDistMax;
    fPenaltyGraceExpiration = Level.TimeSeconds;
  }
  
  function Tick (float DeltaTime)
  {
    local Vector SnitchDir;
    local Vector ProximityTestPoint;
    local float fProximity;
    local float fTrackingOffset;
    local float fCompression;
    local float fMaxGainRadius;
    local float fNeutralRadius;
    local float fMaxLossRadius;
    local float fProgressRate;
    local int PercentDone;
    local int LastPercentDone;
    local int ProgressTier;
    local int NewStage;
    local TeamAffiliation eTeam;
    local TeamAffiliation eOtherTeam;
    local Vector HarryHeading;
    local Vector SnitchFromHarry;
    local bool bSnitchInFront;
    local int I;
    local float R;
    local float fLimit;
  
    if ( (PlayMechanic == PM_Proximity) || (PlayMechanic == PM_ProximityWithHoops) )
    {
      if ( Nimbus2001Status.GetCount() > 0 )
      {
        fSnitchTrackDist -= SnitchTrackDistDecay_Nimbus2001 * DeltaTime;
      } else {
        fSnitchTrackDist -= SnitchTrackDistDecay * DeltaTime;
      }
      if ( ScorePhase == 1 )
      {
        if ( OpponentScore >= 90 )
        {
          fLimit = 90.0 / 100.0;
        } else {
          fLimit = OpponentScore / 100.0;
        }
        if ( (SnitchTrackDistMax - fSnitchTrackDist) / (SnitchTrackDistMax - SnitchTrackDistMin) > fLimit )
        {
          fSnitchTrackDist = SnitchTrackDistMax - fLimit * (SnitchTrackDistMax - SnitchTrackDistMin);
        }
      }
      if ( fSnitchTrackDist < SnitchTrackDistMin )
      {
        fSnitchTrackDist = SnitchTrackDistMin;
      }
      Snitch.SetApparentScale(1.5 * (SnitchTrackDistMax - fSnitchTrackDist) / (SnitchTrackDistMax - SnitchTrackDistMin) + 0.5);
      harry.SetTargetTrackDist(SnitchTrackDistMax);
      if ( Seeker != None )
      {
        Seeker.SetTargetTrackDist(SnitchTrackDistMax);
      }
      CameraTarget.SetTargetTrackDist(SnitchTrackDistMax);
      fTrackingOffset = (1.0 - (fProgressPercent / 100.0)) * fSnitchTrackingOffset;
      fCompression = 1.0 - (fProgressPercent / 100.0) * ((fSnitchNeutralRadiusAt0 - fSnitchNeutralRadiusAt100) / fSnitchNeutralRadiusAt0);
      fMaxGainRadius = fCompression * fSnitchMaxGainRadiusAt0;
      fNeutralRadius = fCompression * fSnitchNeutralRadiusAt0;
      fMaxLossRadius = fCompression * fSnitchMaxLossRadiusAt0;
      SnitchDir = vector(harry.Rotation);
      ProximityTestPoint =  -fTrackingOffset * SnitchDir + Snitch.Location;
      fProximity = VSize(harry.Location - ProximityTestPoint);
      if ( Snitch.bHidden )
      {
        fProgressRate =  -fSnitchMaxLossRate;
      } else //{
        if ( fProximity >= fMaxLossRadius )
        {
          fProgressRate =  -fSnitchMaxLossRate;
        } else //{
          if ( fProximity <= fMaxGainRadius )
          {
            fProgressRate = fSnitchMaxGainRate;
          } else //{
            if ( fProximity > fNeutralRadius )
            {
              fProgressRate =  -fSnitchMaxLossRate * (fProximity - fNeutralRadius) / (fMaxLossRadius - fNeutralRadius);
            } else {
              fProgressRate = fSnitchMaxGainRate * (fProximity - fNeutralRadius) / (fMaxGainRadius - fNeutralRadius);
            }
          //}
        //}
      //}
      LastPercentDone = fProgressPercent;
	  fProgressPercent = 100.0 * (SnitchTrackDistMax - fSnitchTrackDist) / (SnitchTrackDistMax - SnitchTrackDistMin);
      if ( fProgressPercent < 0.0 )
      {
        fProgressPercent = 0.0;
      } else //{
        if ( fProgressPercent > 100.0 )
        {
          fProgressPercent = 100.0;
        }
      //}
      HarryHeading = vector(harry.Rotation);
      SnitchFromHarry = Snitch.Location - harry.Location;
      bSnitchInFront = (SnitchFromHarry Dot HarryHeading) > 0.0;
      if (  !Snitch.bHidden && bSnitchInFront && fProximity < 300 && SeekerIsOutOfWay() )
      {
        if (  !bCanReachForSnitch )
        {
          bCanReachForSnitch = True;
          harry.SetReaching(True);
          harry.SetKickTargetClass('None');
        }
      } else {
        if ( bCanReachForSnitch )
        {
          bCanReachForSnitch = False;
          harry.SetReaching(False);
          harry.SetKickTargetClass('QuidditchPlayer');
        }
      }
      if (  !bCanReachForSnitch || (bFinalMatch &&  !bInTrench) )
      {
        if ( fProgressPercent > 98.0 )
        {
          fProgressPercent = 98.0;
        }
      }
      PercentDone = fProgressPercent;
	  if ( (PercentDone < LastPercentDone) &&  !(PercentDone == 98.0 && (LastPercentDone > 98.0)) ) //UTPT forgot to add brackets -AdamJD
      {
        ProgressBar.SetProgress(PercentDone,True,1.0);
      } else {
        ProgressBar.SetProgress(PercentDone);
      }
      ProgressTier = PercentDone / (100.0 / NUM_PROGRESS_SOUNDS);
	  if ( ProgressTier > (LastPercentDone / (100.0 / NUM_PROGRESS_SOUNDS)) )
	  {
		//KW left this empty? -AdamJD
		// goto JL055E;
	  }
      if ( bCanReachForSnitch && fProgressPercent > 98.0 &&  !(bFinalMatch &&  !bInTrench) ) //UTPT forgot to add brackets -AdamJD 
      {
        Snitch.SetAltTrail(True);
        ProgressBar.SetFlashing(True);
      } else {
        Snitch.SetAltTrail(False);
        ProgressBar.SetFlashing(False);
      }
      if ( PlayMechanic == PM_ProximityWithHoops )
      {
        NewStage = (5 * fProgressPercent / 105.0) + 1;
		if ( Snitch.HoopTrail.CurrentStage != NewStage )
        {
          Snitch.HoopTrail.CurrentStage = NewStage;
        }
        if ( fProximity < 480 )
        {
          if ( Snitch.HoopTrail.IsInState('TrailOn') )
          {
            Snitch.HoopTrail.GotoState('TrailOff');
          }
        } else {
          if ( Snitch.HoopTrail.IsInState('TrailOff') )
          {
            Snitch.HoopTrail.GotoState('TrailOn');
          }
        }
      }
      if ( Snitch.bHidden )
      {
        bSnitchVisible = False;
      } else {
        if (  !bSnitchVisible && (Commentator == None || Commentator.SayComment(QC_TheresTheSnitch)) )
        {
          bSnitchVisible = True;
        }
      }
      if (  !bHarryJoinedPursuit )
      {
        if (  !Snitch.bHidden && (fProximity < fSnitchNeutralRadiusAt0) )
        {
          if ( (Commentator == None) || Commentator.SayComment(QC_HereComesSeeker,TA_Gryffindor) )
          {
            bHarryJoinedPursuit = True;
          }
        }
      } else {
        if (  !bInTrench )
        {
          if ( bCanReachForSnitch &&  !bHarryReaching )
          {
            if ( Commentator != None )
			{
			  //KW left this empty? -AdamJD
			  // goto JL0798;
			}
            bHarryReaching = True;
          } else //{
            if (  !bCanReachForSnitch && bHarryReaching )
            {
              bHarryReaching = False;
            }
            if ( fProgressPercent > 75.0 )
            {
              if ( (Commentator != None) && ((fProgressPercent < 98.0) || bSeekerJoinedPursuit) )
              {
                if ( bHarryJoinedPursuit && bSeekerJoinedPursuit )
                {
                  switch (Rand(3))
                  {
                    case 0:
                    Commentator.SayComment(QC_ClosingOnSnitch);
                    break;
                    case 1:
                    Commentator.SayComment(QC_ClosingOnSnitch,TA_Opponent);
                    break;
                    case 2:
                    Commentator.SayComment(QC_SeekerBattle);
                    break;
                    default:
                  }
                } else {
                  Commentator.SayComment(QC_ClosingOnSnitch);
                }
              }
            }
          //}
        } else {
          if ( (Commentator != None) && ((fProgressPercent < 98.0) || bSeekerJoinedPursuit) )
          {
            Commentator.SayComment(QC_InTrenchRun);
          }
        }
      }
    }
    if ( Level.TimeSeconds > fTimeToCheer )
    {
      I = harry.Location.X & 7;
	  while (I > 0)
      {
        R = FRand();
        --I;
        // goto JL08E4;
      }
      switch (ScorePhase)
      {
        case 1:
			if ( (GryffScore >= 20) || (FRand() < 0.94999999) )
			{
			  // eTeam = 1;
			  eTeam = TA_Opponent;
			} else {
			  // eTeam = 0;
			  eTeam = TA_Gryffindor;
			}
			fTimeToCheer = Level.TimeSeconds + 4.0 + 1.0 * FRand();
			if ( OpponentScore - GryffScore >= 100 )
			{
			  ScorePhase = 2;
			}
			break;
        case 2:
			if ( (OpponentScore - GryffScore <= 100) || (GryffScore >= 30) || (FRand() < 0.94999999) )
			{
			  // eTeam = 1;
			  eTeam = TA_Opponent;
			} else {
			  // eTeam = 0;
			  eTeam = TA_Gryffindor;
			}
			fTimeToCheer = Level.TimeSeconds + 4.0 + 2.0 * FRand();
			if ( OpponentScore - GryffScore >= 140 )
			{
			  ScorePhase = 3;
			}
			break;
        default:
			if ( OpponentScore - GryffScore < 140 )
			{
			  // eTeam = 1;
			  eTeam = TA_Opponent;
			} else {
			  // eTeam = 0;
			  eTeam = TA_Gryffindor;
			}
			fTimeToCheer = Level.TimeSeconds + 6.0 + 3.0 * FRand();
      }
      switch (eTeam)
      {
        case TA_Gryffindor:
			GryffScore += 10;
			ScoreBoard.SetGryffindorScore(GryffScore);
			// eOtherTeam = 1;
			eOtherTeam = TA_Opponent;
			break;
		case TA_Opponent:
			OpponentScore += 10;
			ScoreBoard.SetOpponentScore(OpponentScore);
			// eOtherTeam = 0;
			eOtherTeam = TA_Gryffindor;
			break;
        default:
      }
      if ( bHasCrowds )
      {
        if ( fProgressPercent > 98 )
        {
          // CheerCrowd = 0;
		  CheerCrowd = TA_Gryffindor;
          if ( Crowds[CheerCrowd] != None )
          {
            Crowds[CheerCrowd].Cheer(CT_Coax);
          }
          // CheerCrowd = 2;
		  CheerCrowd = TA_Neutral;
          if ( Crowds[CheerCrowd] != None )
          {
            Crowds[CheerCrowd].Cheer(CT_Coax);
          }
        } else {
          if ( Crowds[eTeam] != None )
          {
            Crowds[eTeam].Cheer(CT_Cheer);
          }
          // CheerCrowd = 2;
		  CheerCrowd = TA_Neutral;
          if ( Crowds[CheerCrowd] != None )
          {
            Crowds[CheerCrowd].Cheer(CT_Cheer);
          }
          if ( Crowds[eOtherTeam] != None )
          {
            Crowds[eOtherTeam].Cheer(CT_Boo);
          }
        }
      }
      if ( (Commentator != None) && ((fProgressPercent < 98.0) || bSeekerJoinedPursuit) )
      {
        switch (Rand(4))
        {
          case 0:
			  switch (eTeam)
			  {
				case TA_Gryffindor:
					Commentator.SayComment(QC_HasQuaffle,TA_Gryffindor);
					break;
				case TA_Opponent:
					Commentator.SayComment(QC_HasQuaffle,TA_Opponent);
					break;
				default:
			  }
			  break;
          case 1:
			  if ( Commentator.CommentHasBeenSaidBefore(QC_HasQuaffle) )
			  {
				switch (eTeam)
				{
				  case TA_Gryffindor:
					  Commentator.SayComment(QC_Scores,TA_Gryffindor);
					  break;
				  case TA_Opponent:
					  Commentator.SayComment(QC_Scores,TA_Opponent);
					  break;
				  default:
				}
			  }
			  break;
          case 2:
			  switch (Rand(2))
			  {
				case 0:
					Commentator.SayComment(QC_KeeperDives);
					break;
				case 1:
					Commentator.SayComment(QC_Block);
					break;
				default:
			  }
			  break;
          case 3:
			  if ( ScorePhase > 1 )
			  {
				switch (Rand(4))
				{
				  case 0:
					  Commentator.SayComment(QC_IdleClean);
					  break;
				  case 1:
					  Commentator.SayComment(QC_IdleRough);
					  break;
				  case 2:
					  Commentator.SayComment(QC_IdleNoFalls);
					  break;
				  case 3:
					  Commentator.SayComment(QC_IdleTrickySnitch);
					  break;
				  default:
				}
			  }
			  break;
          default:
        }
      }
    }
    if ( Snitch.bHidden || (Seeker == None) )
    {
      bSeekerJoinedPursuit = False;
    } else {
      fProximity = VSize(Seeker.Location - Snitch.Location);
      if (  !bSeekerJoinedPursuit )
      {
        if ( fProximity < 500 )
        {
          if ( (Commentator == None) || bInTrench || Commentator.SayComment(QC_HereComesSeeker,TA_Opponent) )
          {
            bSeekerJoinedPursuit = True;
          }
        }
      } else {
        if ( fProximity > 1200 )
        {
          bSeekerJoinedPursuit = False;
        }
      }
    }
  }
  
  function OnTouchEvent (Pawn Subject, Actor Object)
  {
    local BroomHoop Hoop;
  
    if ( Subject == harry )
    {
      switch (PlayMechanic)
      {
        case PM_Hoops:
			Hoop = BroomHoop(Object);
			if ( Hoop != None )
			{
			  Snitch.HoopTrail.OnHoopTouch(Hoop);
			} else //{
			  if ( Object == Snitch )
			  {
				if (  !Snitch.bHidden && (Snitch.HoopTrail.HoopsToGo > 0) )
				{
				  harry.PlayAnim('Miss');
				}
			  } else {
				PlayerHarry.ClientMessage("Touched " $ string(Object.Tag));
			  }
			//}
			break;
        case PM_Proximity:
        case PM_ProximityWithHoops:
			if ( Object == Snitch )
			{
			  if ( !Snitch.bHidden && (fProgressPercent < 90.0) ) 
			  {
				//KW left this empty? -AdamJD
				// goto JL0117;
			  }
			} else {
			  PlayerHarry.ClientMessage("Touched " $ string(Object.Tag));
			}
			break;
        default:
      }
    } else {
      Super.OnTouchEvent(Subject,Object);
    }
  }
  
  function OnBumpEvent (Pawn Subject, Actor Object)
  {
    if ( Subject == harry )
    {
      Super.OnBumpEvent(Subject,Object);
      if ( Level.TimeSeconds > fPenaltyGraceExpiration )
      {
        fSnitchTrackDist += Tuning_HarryProgress.Penalties.Bumped / 100.0 * (SnitchTrackDistMax - SnitchTrackDistMin);
        if ( fSnitchTrackDist > SnitchTrackDistMax )
        {
          fSnitchTrackDist = SnitchTrackDistMax;
        }
        fPenaltyGraceExpiration = Level.TimeSeconds + 1.0;
      }
    } else {
      Super.OnBumpEvent(Subject,Object);
    }
  }
  
  function OnHitEvent (Pawn Subject)
  {
    if ( Subject == harry )
    {
      Super.OnHitEvent(Subject);
      if ( Level.TimeSeconds > fPenaltyGraceExpiration )
      {
        fSnitchTrackDist += Tuning_HarryProgress.Penalties.Hit / 100.0 * (SnitchTrackDistMax - SnitchTrackDistMin);
        if ( fSnitchTrackDist > SnitchTrackDistMax )
        {
          fSnitchTrackDist = SnitchTrackDistMax;
        }
        fPenaltyGraceExpiration = Level.TimeSeconds + 1.0;
      }
    } else {
      Super.OnHitEvent(Subject);
    }
  }
  
  function OnTakeDamage (Pawn Subject, int Damage, Pawn InstigatedBy, name DamageType)
  {
    if ( (Subject == harry) && ((DamageType == 'Kicked') || (DamageType == 'Bludgered')) )
    {
      Super.OnTakeDamage(Subject,Damage,InstigatedBy,DamageType);
      if ( Level.TimeSeconds > fPenaltyGraceExpiration )
      {
        if ( DamageType == 'Kicked' )
        {
          fSnitchTrackDist += fHarryProgressKickedPenalty / 100.0 * (SnitchTrackDistMax - SnitchTrackDistMin);
        } else //{
          if ( DamageType == 'Bludgered' )
          {
            fSnitchTrackDist += Tuning_HarryProgress.Penalties.Bludgered / 100.0 * (SnitchTrackDistMax - SnitchTrackDistMin);
          }
        //}
        if ( fSnitchTrackDist > SnitchTrackDistMax )
        {
          fSnitchTrackDist = SnitchTrackDistMax;
        }
        fPenaltyGraceExpiration = Level.TimeSeconds + 1.0;
      }
    } else {
      Super.OnTakeDamage(Subject,Damage,InstigatedBy,DamageType);
    }
  }
  
  function OnTriggerEvent (Actor Other, Pawn EventInstigator)
  {
    local Bludger Bludger;
  
    if ( (PlayMechanic == PM_Hoops) && (Other == Snitch.HoopTrail) )
    {
      ProgressBar.SetProgress(100 * (Snitch.HoopTrail.HoopsToHit - Snitch.HoopTrail.HoopsToGo) / Snitch.HoopTrail.HoopsToHit);
      if ( Snitch.HoopTrail.HoopsToGo <= 0 )
      {
        harry.bAuxBoost = False;
        harry.SetLookForTarget(None);
        harry.SecondaryAnim = 'Hold';
        harry.PlayAnim('Catch');
        Snitch.StopFlyingOnPath();
        Snitch.ClearAllEffects();
        Snitch.HoopTrail.GotoState('TrailOff');
        Snitch.SetLocation(harry.WeaponLoc);
        Snitch.SetOwner(harry);
        // Snitch.SetPhysics(11);
		Snitch.SetPhysics(PHYS_Trailer);
        GotoState('GameWon');
      }
      harry.bAuxBoost = Snitch.HoopTrail.bSpeedBoostSuggested;
    } else //{
      if ( Other == Seeker )
      {
        bCanReachForSnitch = False;
        harry.SetReaching(False);
        harry.SetKickTargetClass('None');
        harry.Cam.SetTargetActor(Seeker.Name);
        foreach AllActors(Class'Bludger',Bludger)
        {
          Bludger.SeekTarget(None);
        }
        GotoState('GameLost');
      } else {
        Super.Trigger(Other,EventInstigator);
      }
    //}
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function bool CutCommand( string Command, optional string Cue, optional bool bFastFlag )
  {
	local string sActualCommand;

	sActualCommand = ParseDelimitedString(Command," ",1,False);
	if ( sActualCommand ~= "ContinueGame" )
	{
		bInTrench = True;
		Snitch.StopFlyingOnPath();
		Snitch.FlyOnPath('IPSnitchTrench',20);
		fSnitchTrackDist = SnitchTrackDistMax;
		Seeker.SetLookForTarget(Snitch);
		SetSeekersToFollowSnitch();
		Seeker.fHealth = 25.0;
		Seeker.bStunned = False;
		Seeker.Path_Recovery = 'IPSnitchTrench';
		Seeker.GotoState('Pursue');
		SetCameraTargetToFollowSnitch();
		SetCameraToFollowSnitch();
		if ( Commentator != None )
		{
		  Commentator.SetVolume(0.5);
		  Commentator.SetMute(False);
		}
		if ( TauntMgr != None )
		{
		  TauntMgr.StartTaunts();
		}
		CutCue(cue);
		return True;
	}
	else
	{
		return Global.CutCommand( Command, Cue, bFastFlag );
	}
  }
  
  function OnActionKeyPressed()
  {
    local float fProximity;
    local Bludger Bludger;
    local Pawn HarryAsPawn;
  
    Super.OnActionKeyPressed();
    if ( bCanReachForSnitch )
    {
      fProximity = VSize(harry.Location - Snitch.Location);
      if ( (fProgressPercent > 98.0) &&  !(bFinalMatch &&  !bInTrench) ) //UTPT forgot to add brackets -AdamJD
      {
        bCanReachForSnitch = False;
        harry.SetReaching(False);
        if ( bInTrench )
        {
          harry.CatchTarget(Snitch);
        } else {
          harry.CatchTarget(Snitch,'IP_HarryWin_Loop');
        }
        HarryAsPawn = harry;
        harry.Cam.SetTargetActor(HarryAsPawn.Name);
        if ( Seeker != None )
        {
          Seeker.SetLookForTarget(None);
          Seeker.SetKickTargetClass('None');
          if (  !bInTrench )
          {
            Seeker.PathToFly = 'LoserIPSpot';
            Seeker.GotoState('GetBackOnPath');
          }
        }
        foreach AllActors(Class'Bludger',Bludger)
        {
          Bludger.SeekTarget(None);
        }
        GotoState('GameWon');
      } else {
        harry.PlayAnim('Miss',,0.1);
        if ( (Commentator != None) &&  !bInTrench )
        {
          Commentator.SayComment(QC_MissedSnitch,,True);
        }
      }
    }
  }
  
  event Timer()
  {
    local float fTimeLeft;
    local float fTauntTimeLeft;
    local bool bGoNow;
  
    if (  !bTimeToGoIntoTrench )
    {
      bTimeToGoIntoTrench = True;
      if ( Commentator != None )
      {
        Commentator.SetMute(True);
        fTimeLeft = Commentator.TimeLeftUntilSafeToSayAComment(True);
      } else {
        fTimeLeft = 0.0;
      }
      if ( TauntMgr != None )
      {
        TauntMgr.StopTaunts();
        fTauntTimeLeft = TauntMgr.TimeLeftUntilSafeToSayALine(True);
      } else {
        fTauntTimeLeft = 0.0;
      }
      if ( (fTimeLeft > 0) || (fTauntTimeLeft > 0) )
      {
        SetTimer(FMax(fTimeLeft,fTauntTimeLeft),False);
      } else {
        TriggerEvent(MatchEvents_Final.GoingIntoTrench,self,None);
      }
    } else //{
      if (  !bInTrench )
      {
        Log(string(Name) $ ": (T=" $ string(Level.TimeSeconds) $ ") Going into trench now.");
        TriggerEvent(MatchEvents_Final.GoingIntoTrench,self,None);
      }
    //}
  }
  
  function OnPlayerDying()
  {
    PlayerHarry.ClientMessage("Player dying...");
    GotoState('GameLosing');
  }
  
  function OnPlayersDeath()
  {
    PlayerHarry.ClientMessage("Player died.");
    GotoState('GameLost');
  }
  
  function EndState()
  {
    PlayerHarry.ClientMessage(string(Name) $ " Exited " $ string(GetStateName()) $ " State");
    Log(string(Name) $ " Exited " $ string(GetStateName()) $ " State");
    if ( bFinalMatch )
    {
      SetTimer(0.0,False);
    }
    ProgressBar.Show(False);
    SeekerHealthBar.End();
    PlayerDialogMgr.StopDialog();
    if ( CrowdDialogMgr != None )
    {
      CrowdDialogMgr.StopDialog();
    }
    if ( TauntMgr != None )
    {
      TauntMgr.StopTaunts();
    }
  }
  
}

state GameCatch
{
  function BeginState()
  {
    local Bludger Bludger;
  
    PlayerHarry.ClientMessage(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
    Log(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
    CatchTriesLeft = SnitchMaxCatchTries;
    SetTimer(10.0,False);
    harry.SetReaching(True);
    foreach AllActors(Class'Bludger',Bludger)
    {
      Bludger.SeekTarget(None);
    }
    harry.SetKickTargetClass('None');
  }
  
  function Tick (float DeltaTime)
  {
    local TeamAffiliation eTeam;
  
    if ( Commentator != None )
    {
	  // Commentator.SayComment(9);
      Commentator.SayComment(QC_ClosingOnSnitch);
    }
    if ( Level.TimeSeconds > fTimeToCheer )
    {
      if ( Rand(2) == 0 )
      {
        // eTeam = 0;
		eTeam = TA_Gryffindor;
      } else {
        // eTeam = 1;
		eTeam = TA_Opponent;
      }
      Log("Playing " $ string(eTeam) $ " crowd hurrah at " $ string(Level.TimeSeconds));
      fTimeToCheer = Level.TimeSeconds + 8.0 + 3.0 * FRand();
    }
  }
  
  function OnActionKeyPressed()
  {
    Super.OnActionKeyPressed();
    if ( True )
    {
      if ( bFinalMatch )
      {
        harry.CatchTarget(Snitch);
      } else {
        harry.CatchTarget(Snitch,'IP_HarryWin_Loop');
      }
      if ( Seeker != None )
      {
        Seeker.SetLookForTarget(None);
        Seeker.SetKickTargetClass('None');
      }
      GotoState('GameWon');
    } else {
      --CatchTriesLeft;
      if ( CatchTriesLeft <= 0 )
      {
        SetCameraToFollowSnitch();
        harry.SetReaching(False);
        GotoState('GamePlay');
      }
    }
  }
  
  function Timer()
  {
    SetCameraToFollowSnitch();
    harry.SetReaching(False);
    GotoState('GamePlay');
  }
  
  function EndState()
  {
    PlayerHarry.ClientMessage("Exited GameCatch State");
    Log("Exited GameCatch State");
    SetTimer(0.0,False);
    fProgressPercent = 75.0;
  }
  
}

state GameWon
{
  event Timer()
  {
    Log("Harry's Health: " $ string(harry.GetHealthCount()));
    HarryHealth.SetCount(OriginalHealth);
    Log("Harry's Health Restored: " $ string(harry.GetHealthCount()));
    if ( bFinalMatch )
    {
      PlayerHarry.ClientMessage(string(Name) $ " triggering event '" $ string(MatchEvents_Final.Won) $ "'");
      Log(string(Name) $ " triggering event '" $ string(MatchEvents_Final.Won) $ "'");
      TriggerEvent(MatchEvents_Final.Won,self,None);
    } else {
      PlayerHarry.ClientMessage(string(Name) $ " triggering event '" $ string(MatchEvents.Won) $ "'");
      Log(string(Name) $ " triggering event '" $ string(MatchEvents.Won) $ "'");
      TriggerEvent(MatchEvents.Won,self,None);
    }
  }
  
begin:
  bGryffWon = True;
  ComputeScore();
  SetTimer(FMax(3.0,Commentator.TimeLeftUntilSafeToSayAComment(True)),False);
  Sleep(1.0);
  if (  !bFinalMatch )
  {
    if ( Commentator != None )
    {
      Commentator.PlaySound(Sound'Q_whistle_long',SLOT_Interact,1.0,,20000.0);
    }
    if ( bHasCrowds )
    {
      // CheerCrowd = 0;
	  CheerCrowd = TA_Gryffindor;
      if ( Crowds[CheerCrowd] != None )
      {
        Crowds[CheerCrowd].Cheer(CT_CheerLong);
      }
      // CheerCrowd = 2;
	  CheerCrowd = TA_Neutral;
      if ( Crowds[CheerCrowd] != None )
      {
        Crowds[CheerCrowd].Cheer(CT_CheerLong);
      }
      // CheerCrowd = 1;
	  CheerCrowd = TA_Opponent;
      if ( Crowds[CheerCrowd] != None )
      {
        Crowds[CheerCrowd].Cheer(CT_BooLong);
      }
    }
    Sleep(0.25);
    TriggerEvent('Silence',self,None);
    TriggerEvent('Fanfare_Win',self,None);
    fWhenToPlayPostMusic = Level.TimeSeconds + GetSoundDuration(Sound'sm_dia_DiagonFail_01');
  }
  HousePoints.IncrementCount( -harry.quidGameResults[harry.curQuidMatchNum].HousePoints);
  harry.quidGameResults[harry.curQuidMatchNum].myScore = GryffScore;
  harry.quidGameResults[harry.curQuidMatchNum].OpponentScore = OpponentScore;
  harry.quidGameResults[harry.curQuidMatchNum].HousePoints = Max(GryffScore - OpponentScore,0);
  harry.quidGameResults[harry.curQuidMatchNum].bWon = True;
  HousePoints.IncrementCount(harry.quidGameResults[harry.curQuidMatchNum].HousePoints);
  if ( (Commentator != None) &&  !bFinalMatch )
  {
    Sleep(Commentator.TimeLeftUntilSafeToSayAComment(True));
    Commentator.SayComment(QC_Positive,,True);
    Sleep(Commentator.TimeLeftUntilSafeToSayAComment(True));
    Commentator.SayComment(QC_CaughtSnitch,,True);
  }
  if (  !bFinalMatch )
  {
    if ( Level.TimeSeconds < fWhenToPlayPostMusic )
    {
      Sleep(fWhenToPlayPostMusic - Level.TimeSeconds);
    }
    TriggerEvent('PostFanfare_Win',self,None);
  }
  if ( (Commentator != None) &&  !bFinalMatch )
  {
    Sleep(Commentator.TimeLeftUntilSafeToSayAComment(True));
    if ( bWonCup )
    {
      Commentator.SayComment(QC_WinsCup,TA_Gryffindor,True);
      Sleep(Commentator.TimeLeftUntilSafeToSayAComment(True));
      Commentator.SayComment(QC_Positive,,True);
    } else {
      Commentator.SayComment(QC_WinsMatch,TA_Gryffindor,True);
    }
    Sleep(Commentator.TimeLeftUntilSafeToSayAComment());
    Commentator.SayComment(QC_SigningOff);
    Sleep(Commentator.TimeLeftUntilSafeToSayAComment(True));
  } else {
    Sleep(0.2);
  }
  Sleep(2.0);
  // if ( EndCue == "" )
  while ( EndCue == "" )
  {
    Sleep(0.1);
    // goto JL03CC;
  }
  CutCue(EndCue);
  if ( bFinalMatch )
  {
    PlayerHarry.ClientMessage(string(Name) $ " triggering event '" $ string(MatchEvents_Final.End) $ "'");
    Log(string(Name) $ " triggering event '" $ string(MatchEvents_Final.End) $ "'");
    TriggerEvent(MatchEvents_Final.End,self,None);
  } else {
    PlayerHarry.ClientMessage(string(Name) $ " triggering event '" $ string(MatchEvents.End) $ "'");
    Log(string(Name) $ " triggering event '" $ string(MatchEvents.End) $ "'");
    TriggerEvent(MatchEvents.End,self,None);
  }
}

state GameLosing
{
  function BeginState()
  {
    local Bludger Bludger;
    local Actor CamTarget;
  
    PlayerHarry.ClientMessage(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
    Log(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
    foreach AllActors(Class'Bludger',Bludger)
    {
      Bludger.SeekTarget(None);
    }
    harry.SetKickTargetClass('None');
    CamTarget = harry;
    harry.Cam.SetTargetActor(CamTarget.Name);
  }
  
  function OnPlayersDeath()
  {
    PlayerHarry.ClientMessage("Player died");
    bHarryDied = True;
    GotoState('GameLost');
  }
  
 begin:
  if ( bHasCrowds )
  {
    // CheerCrowd = 0;
	CheerCrowd = TA_Gryffindor;
    if ( Crowds[CheerCrowd] != None )
    {
      Crowds[CheerCrowd].Cheer(CT_Aw);
    }
    // CheerCrowd = 2;
	CheerCrowd = TA_Neutral;
    if ( Crowds[CheerCrowd] != None )
    {
      Crowds[CheerCrowd].Cheer(CT_Aw);
    }
  }
  if ( Commentator != None )
  {
    Sleep(Commentator.TimeLeftUntilSafeToSayAComment(True));
    Commentator.SayComment(QC_Dying,,True);
  }
 loop:
  Sleep(0.1);
  goto ('Loop');
}

state GameLost
{
  event Timer()
  {
    Log("Harry's Health: " $ string(harry.GetHealthCount()));
    HarryHealth.SetCount(OriginalHealth);
    Log("Harry's Health Restored: " $ string(harry.GetHealthCount()));
    if ( bHarryDied )
    {
      if ( bInTrench )
      {
        PlayerHarry.ClientMessage(string(Name) $ " triggering event '" $ string(MatchEvents_Final.Died) $ "'");
        Log(string(Name) $ " triggering event '" $ string(MatchEvents_Final.Died) $ "'");
        TriggerEvent(MatchEvents_Final.Died,self,None);
      } else {
        PlayerHarry.ClientMessage(string(Name) $ " triggering event '" $ string(MatchEvents.Died) $ "'");
        Log(string(Name) $ " triggering event '" $ string(MatchEvents.Died) $ "'");
        TriggerEvent(MatchEvents.Died,self,None);
      }
    } else {
      if ( bInTrench )
      {
        PlayerHarry.ClientMessage(string(Name) $ " triggering event '" $ string(MatchEvents_Final.Lost) $ "'");
        Log(string(Name) $ " triggering event '" $ string(MatchEvents_Final.Lost) $ "'");
        harry.StopFlyingOnPath();
        Seeker.StopFlyingOnPath();
        TriggerEvent(MatchEvents_Final.Lost,self,None);
      } else {
        PlayerHarry.ClientMessage(string(Name) $ " triggering event '" $ string(MatchEvents.Lost) $ "'");
        Log(string(Name) $ " triggering event '" $ string(MatchEvents.Lost) $ "'");
        TriggerEvent(MatchEvents.Lost,self,None);
      }
    }
  }
  
begin:
  ComputeScore();
  if ( bHarryDied )
  {
    SetTimer(0.1,False);
  } else {
    SetTimer(FMax(3.0,Commentator.TimeLeftUntilSafeToSayAComment(True)),False);
  }
  Sleep(1.0);
  if (  !bHarryDied &&  !bInTrench )
  {
    if ( (Commentator != None) &&  !bInTrench )
    {
      Commentator.PlaySound(Sound'Q_whistle_long',SLOT_Interact,1.0,,20000.0);
    }
    if ( bHasCrowds )
    {
      // CheerCrowd = 0;
	  CheerCrowd = TA_Gryffindor;
      if ( Crowds[CheerCrowd] != None )
      {
        Crowds[CheerCrowd].Cheer(CT_BooLong);
      }
      // CheerCrowd = 2;
	  CheerCrowd = TA_Neutral;
      if ( (Crowds[CheerCrowd] != None) && (Opponent == HA_Slytherin) )
      {
        Crowds[CheerCrowd].Cheer(CT_BooLong);
      }
      // CheerCrowd = 1;
	  CheerCrowd = TA_Opponent;
      if ( Crowds[CheerCrowd] != None )
      {
        Crowds[CheerCrowd].Cheer(CT_CheerLong);
      }
    }
    Sleep(0.25);
    TriggerEvent('Silence',self,None);
    TriggerEvent('FanFare_Lose',self,None);
    fWhenToPlayPostMusic = Level.TimeSeconds + GetSoundDuration(Sound'sm_dia_DiagonFail_01');
  }
  HousePoints.IncrementCount( -harry.quidGameResults[harry.curQuidMatchNum].HousePoints);
  harry.quidGameResults[harry.curQuidMatchNum].myScore = GryffScore;
  harry.quidGameResults[harry.curQuidMatchNum].OpponentScore = OpponentScore;
  harry.quidGameResults[harry.curQuidMatchNum].HousePoints = Max(GryffScore - OpponentScore,0);
  harry.quidGameResults[harry.curQuidMatchNum].bWon = False;
  if ( Commentator != None )
  {
    Sleep(Commentator.TimeLeftUntilSafeToSayAComment(True));
    if ( bHarryDied )
    {
      Commentator.SayComment(QC_Dead,,True);
      Sleep(Commentator.TimeLeftUntilSafeToSayAComment(True));
    } else { 
      if (  !bInTrench )
      {
        Commentator.SayComment(QC_CaughtSnitch,TA_Opponent,True);
        Sleep(Commentator.TimeLeftUntilSafeToSayAComment(True));
        if ( Level.TimeSeconds < fWhenToPlayPostMusic )
        {
          Sleep(fWhenToPlayPostMusic - Level.TimeSeconds);
        }
        TriggerEvent('PostFanfare_Lose',self,None);
        Commentator.SayComment(QC_WinsMatch,TA_Opponent,True);
        Sleep(Commentator.TimeLeftUntilSafeToSayAComment());
        Commentator.SayComment(QC_SigningOff);
        Sleep(Commentator.TimeLeftUntilSafeToSayAComment(True));
      }
    }
  } else {
    Sleep(0.2);
  }
  if (  !bHarryDied )
  {
    Sleep(2.0);
  }
  // if ( EndCue == "" )
  while ( EndCue == "" )
  {
    Sleep(0.1);
    // goto JL037F;
  }
  CutCue(EndCue);
  if ( bInTrench )
  {
    PlayerHarry.ClientMessage(string(Name) $ " triggering event '" $ string(MatchEvents_Final.End) $ "'");
    Log(string(Name) $ " triggering event '" $ string(MatchEvents_Final.End) $ "'");
    TriggerEvent(MatchEvents_Final.End,self,None);
  } else {
    PlayerHarry.ClientMessage(string(Name) $ " triggering event '" $ string(MatchEvents.End) $ "'");
    Log(string(Name) $ " triggering event '" $ string(MatchEvents.End) $ "'");
    TriggerEvent(MatchEvents.End,self,None);
  }
}

state PendingEvent
{
  function TriggerPendingEvent()
  {
    Log("Triggering Pending Event; Cue=" $ DelayedEventCue $ ", Event=" $ string(DelayedEventName) $ ", State=" $ string(DelayedEventNextState) $ ".");
    if ( DelayedEventCue != "" )
    {
      CutCue(DelayedEventCue);
    }
    if ( DelayedEventName != 'None' )
    {
      TriggerEvent(DelayedEventName,self,None);
    }
    if ( DelayedEventNextState != 'None' )
    {
      GotoState(DelayedEventNextState);
    }
  }
 begin:
  PlayerHarry.ClientMessage(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
  Log(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
  Sleep(fDelayedEventDelayTime);
  TriggerPendingEvent();
}

defaultproperties
{
    fTimeBeforeGoingIntoTrench=30.00

    // PlayMechanic=2
	PlayMechanic=PM_ProximityWithHoops
	
	//UTPT decompiled these wrong -AdamJD
	// Tuning_Seeker(0)=(PursuitTime=20.00,RecoveryTime=5.00,Penalties=5.00(Bumped=20.00,Kicked=5.00),,PositionChangeInterval=5.00(Bumped=20.00,Kicked=5.00),(Min=20.00,Max=5.00),,KickInterval=5.00(Bumped=20.00,Kicked=5.00),(Min=20.00,Max=5.00),(Min=20.00,Max=5.00),,KickDamage=1092616192),

    // Tuning_Seeker(1)=(PursuitTime=18.20,RecoveryTime=5.00,Penalties=5.00(Bumped=18.20,Kicked=5.00),,PositionChangeInterval=5.00(Bumped=18.20,Kicked=5.00),(Min=18.20,Max=5.00),,KickInterval=5.00(Bumped=18.20,Kicked=5.00),(Min=18.20,Max=5.00),(Min=18.20,Max=5.00),,KickDamage=1092616192),

    // Tuning_Seeker(2)=(PursuitTime=17.00,RecoveryTime=3.00,Penalties=3.00(Bumped=17.00,Kicked=3.00),,PositionChangeInterval=3.00(Bumped=17.00,Kicked=3.00),(Min=17.00,Max=3.00),,KickInterval=3.00(Bumped=17.00,Kicked=3.00),(Min=17.00,Max=3.00),(Min=17.00,Max=3.00),,KickDamage=1092616192),

    // Tuning_Seeker(3)=(PursuitTime=15.50,RecoveryTime=2.00,Penalties=2.00(Bumped=15.50,Kicked=2.00),,PositionChangeInterval=2.00(Bumped=15.50,Kicked=2.00),(Min=15.50,Max=2.00),,KickInterval=2.00(Bumped=15.50,Kicked=2.00),(Min=15.50,Max=2.00),(Min=15.50,Max=2.00),,KickDamage=1092616192),

    // Tuning_Seeker(4)=(PursuitTime=14.00,RecoveryTime=2.00,Penalties=2.00(Bumped=14.00,Kicked=2.00),,PositionChangeInterval=2.00(Bumped=14.00,Kicked=2.00),(Min=14.00,Max=2.00),,KickInterval=2.00(Bumped=14.00,Kicked=2.00),(Min=14.00,Max=2.00),(Min=14.00,Max=2.00),,KickDamage=1092616192),

    // Tuning_Seeker(5)=(PursuitTime=12.00,RecoveryTime=2.00,Penalties=2.00(Bumped=12.00,Kicked=2.00),,PositionChangeInterval=2.00(Bumped=12.00,Kicked=2.00),(Min=12.00,Max=2.00),,KickInterval=2.00(Bumped=12.00,Kicked=2.00),(Min=12.00,Max=2.00),(Min=12.00,Max=2.00),,KickDamage=1092616192),

    // Tuning_HarryProgress=(PursuitTime=25.00,PursuitTime_Nimbus2001=12.00,Penalties=12.00(Bludgered=25.00,Bumped=12.00,Hit=5.00,Kicked=10.00),),
	//
	//all these are taken from the editor using a retail HGame because KW set up all the correct values in the editor -AdamJD
	Tuning_Seeker(0)=(PursuitTime=20.00,RecoveryTime=5.00,Penalties=(Bumped=10.00,Kicked=10.00),PositionChangeInterval=(Min=2.00,Max=4.00),KickInterval=(Min=2.00,Max=3.00),KickDamage=5)

    Tuning_Seeker(1)=(PursuitTime=18.20,RecoveryTime=5.00,Penalties=(Bumped=10.00,Kicked=10.00),PositionChangeInterval=(Min=1.50,Max=2.50),KickInterval=(Min=1.50,Max=3.00),KickDamage=5)

    Tuning_Seeker(2)=(PursuitTime=17.00,RecoveryTime=3.00,Penalties=(Bumped=10.00,Kicked=10.00),PositionChangeInterval=(Min=1.00,Max=2.20),KickInterval=(Min=1.00,Max=2.00),KickDamage=10)

    Tuning_Seeker(3)=(PursuitTime=15.50,RecoveryTime=2.00,Penalties=(Bumped=10.00,Kicked=10.00),PositionChangeInterval=(Min=1.00,Max=2.00),KickInterval=(Min=0.80,Max=1.00),KickDamage=15)

    Tuning_Seeker(4)=(PursuitTime=14.00,RecoveryTime=2.00,Penalties=(Bumped=10.00,Kicked=10.00),PositionChangeInterval=(Min=0.80,Max=1.50),KickInterval=(Min=0.50,Max=0.80),KickDamage=20)

    Tuning_Seeker(5)=(PursuitTime=12.00,RecoveryTime=2.00,Penalties=(Bumped=10.00,Kicked=10.00),PositionChangeInterval=(Min=0.80,Max=1.20),KickInterval=(Min=0.40,Max=0.60),KickDamage=30)

    Tuning_HarryProgress=(PursuitTime=25.00,PursuitTime_Nimbus2001=12.00,Penalties=(Bludgered=5.00,Bumped=10.00,Hit=10.00,Kicked[0]=10.00,Kicked[1]=13.00,Kicked[2]=15.00,Kicked[3]=18.00,Kicked[4]=20.00,Kicked[5]=25.00))

    fSnitchTrackingOffset=150.00

    fSnitchMaxGainRadiusAt0=100.00

    fSnitchNeutralRadiusAt0=500.00

    fSnitchNeutralRadiusAt100=150.00

    fSnitchMaxLossRadiusAt0=1200.00

    fSnitchMaxGainRate=20.00

    fSnitchMaxLossRate=10.00

    fSnitchMaxCatchTime=20.00

    SnitchMaxCatchTries=3

    HoopsToHit=3

    SnitchTrackDistMin=200.00

    SnitchTrackDistMax=300.00

    CameraTrailDist=175.00

    RandSeed=(SeedA=1.1422397692371322E33,SeedB=14991598592E10,SeedC=4.569592902248643E33,SeedD=1.7181077547278926E19)

    bNeedsCommentator=True

    bHasCrowds=True

    InitialState=GameIntro
}
