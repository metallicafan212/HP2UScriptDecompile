//================================================================================
// QuidditchPlayer.
//================================================================================

class QuidditchPlayer extends HChar;

const MaxSpeed= 1200;
const SlowdownRadius= 50;
const NUM_OUCH_EMOTES= 8;
const NUM_KICK_EMOTES= 8;
const QP_NUM_MULTISKINS= 8;
const HA_Neutral= 0;
const NUM_WOOSH_SOUNDS= 4;
const NUM_SLOW_WOOSH_SOUNDS= 5;
const NUM_HIT_SOUNDS= 3;

enum Sex {
  SX_Male,
  SX_Female,
  SX_Neutral
};

enum TeamAffiliation {
  TA_Gryffindor,
  TA_Opponent,
  TA_Neutral
};

enum HouseAffiliation {
  HA_Gryffindor,
  HA_Ravenclaw,
  HA_Hufflepuff,
  HA_Slytherin,
  HA_DependsOnMatch
};

struct EmoteInfo
{
  var Sound KickEmotes[8];
  var Sound OuchEmotes[8];
};

struct DisplayInfo
{
  var() Sex Sex;
  var() Mesh Mesh;
  var() Texture MultiSkins[8];
};

var BroomHarry harry;
var Director Director;
var InterpolationManager IM;
var(Quidditch) name Path;
var(Quidditch) name Path_Intro;
var(Quidditch) name Path_Recovery;
var(Quidditch) name Path_Catch;
var name PathToFly;
var float PathSpeed;
var DynamicInterpolationPoint ReturnPath[2];
var int iReturnPoint;
var Actor LookForTarget;
var bool bCatchingTarget;
var bool bCaughtTarget;
var float fTimeForNextOffset;
var float fTargetTrackDist;
var float fTargetTrackHorzOffset;
var float fTargetTrackVertOffset;
var float TrackingOffsetRange_Horz;
var float TrackingOffsetRange_Vert;
var name KickTargetClassName;
var Pawn KickTarget;
var float KickTargetDist;
var float fTimeForNextKickUpdate;
var float fTimeForNextKick;
var float fTimeLastKicked;
var Actor WatchTarget;
var float fTimeForNextWatchUpdate;
var bool bEasingUpToSpeed;
var bool bStunned;
var float fTimeToFallAway;
var float fHealth;
var float HealthRecoveryRate;
var float HealthRecoveryRateWhenStunned;
var float fKickedPenalty;
var float fBumpedPenalty;
var float fPositionChangeIntervalMin;
var float fPositionChangeIntervalMax;
var float fKickIntervalMin;
var float fKickIntervalMax;
var int KickDamage;
var(Quidditch) int Damage;
var bool bHit;
var float fLastDistanceFromCamera;
var float fNextTimeSafeToWoosh;
var(Quidditch) bool bCanWoosh;
var Sound HitSounds[3];
var Sound SlowWooshSounds[5];
var Sound WooshSounds[4];
var bool bCapturedByCutScene;
var Vector vDodgeVel;
var(Quidditch) DisplayInfo HouseDisplayInfo[4];
var(Quidditch) TeamAffiliation Team;
var(Quidditch) HouseAffiliation HouseToDisplayAs;
var EmoteInfo Emotes[2];
var HouseAffiliation eHouse;
var Sex eSex;
var QuidditchPlayer NextSpeakingPlayer;


function PreBeginPlay ()
{
  Super.PreBeginPlay();
  LookForTarget = None;
  bCaughtTarget = False;
  bCatchingTarget = False;
  iReturnPoint = 0;
  bCapturedByCutScene = False;
  bStunned = False;
  fHealth = 25.0;
  PathSpeed = IPSpeed;
  bEasingUpToSpeed = True;
}

function PostBeginPlay ()
{
  Super.PostBeginPlay();
  foreach AllActors(Class'Director',Director)
  {
    // goto JL001A;
	break;
  }
  foreach AllActors(Class'BroomHarry',harry)
  {
    // goto JL002F;
	break;
  }
  if ( Path_Intro != 'None' )
  {
    SplicePaths(Path_Intro,Path);
    PathToFly = Path_Intro;
  } else {
    PathToFly = Path;
  }
  Path_Recovery = Path;
  // SetPhysics(4);
  SetPhysics(PHYS_Flying);
  bHit = False;
  fLastDistanceFromCamera = VSize(Location - harry.Cam.Location);
  fTimeLastKicked = -1.0;
  fNextTimeSafeToWoosh = Level.TimeSeconds;
}

function DoCapture ()
{
  bCapturedByCutScene = True;
  StopFlyingOnPath();
  bStunned = False;
  bCaughtTarget = False;
  bCatchingTarget = False;
  DesiredRotation = Rotation;
  DesiredRotation.Pitch = 0;
  SetRotation(DesiredRotation);
  GotoState('WaitForIntro');
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local bool bResult;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "Capture" )
  {
    if (  !bCatchingTarget )
    {
      DoCapture();
    }
    return Super.CutCommand(Command,cue,bFastFlag);
  } else //{
    if ( sActualCommand ~= "Release" )
    {
      bResult = Super.CutCommand(Command,cue,bFastFlag);
      IPSpeed = PathSpeed;
      bInterpolating_IgnoreRot = False;
      bCollideWorld = True;
      SetCollision(True,False,True);
      bEasingUpToSpeed = True;
      bCapturedByCutScene = False;
      return bResult;
    } else {
      return Super.CutCommand(Command,cue,bFastFlag);
    }
  //}
}

function SetHouse (HouseAffiliation eOpponent)
{
  local int iSkin;

  if ( HouseToDisplayAs == HA_DependsOnMatch )
  {
    switch (Team)
    {
      case TA_Gryffindor:
      eHouse = /*0*/ HA_Gryffindor;
      break;
      case TA_Opponent:
      eHouse = eOpponent;
      break;
      case TA_Neutral:
      eHouse = /*0*/ HA_Gryffindor;
      break;
      default:
    }
  } else {
    eHouse = HouseToDisplayAs;
  }
  if ( HouseDisplayInfo[eHouse].Mesh != None )
  {
    Mesh = HouseDisplayInfo[eHouse].Mesh;
  }
  // iSkin = 0;
  // if ( iSkin < 8 )
  for(iSkin = 0; iSkin < QP_NUM_MULTISKINS; ++iSkin)
  {
    if ( HouseDisplayInfo[eHouse].MultiSkins[iSkin] != None )
    {
      MultiSkins[iSkin] = HouseDisplayInfo[eHouse].MultiSkins[iSkin];
    }
    // ++iSkin;
    // goto JL008E;
  }
  eSex = HouseDisplayInfo[eHouse].Sex;
}

function InterpolationPoint FindPointOnPath (name Path, optional int PointToFind)
{
  local InterpolationPoint IP;
  local InterpolationPoint FoundIP;

  FoundIP = None;
  foreach AllActors(Class'InterpolationPoint',IP,Path)
  {
    if ( IP.Position == PointToFind )
    {
      FoundIP = IP;
      // goto JL008C;
	  break;
    } else //{
      if ( (PointToFind == 0) && ((FoundIP == None) || (IP.Position < FoundIP.Position)) )
      {
        FoundIP = IP;
      }
    //}
  }
  return FoundIP;
}

function FlyOnPath (name Path, optional int StartPoint)
{
  local InterpolationPoint I;

  if ( Path != 'None' )
  {
    I = FindPointOnPath(Path,StartPoint);
    if ( I != None )
    {
      SetLocation(I.Location);
      SetCollision(True,False,True);
      bCollideWorld = False;
      bInterpolating = True;
      // SetPhysics(0);
	  SetPhysics(PHYS_None);
      IM = Spawn(Class'InterpolationManager',self);
      IM.Init(I.Next,1.0,False);
    }
    if ( IM == None )
    {
      Log(string(Name) $ " couldn't find path " $ string(Path));
    }
  } else {
    Log(string(Name) $ " *** No path to fly on ***");
  }
}

function StopFlyingOnPath ()
{
  local InterpolationManager IM_ToStop;

  if ( IM != None )
  {
    IM_ToStop = IM;
    IM = None;
    IM_ToStop.FinishedInterpolation(None);
  }
  bCollideWorld = True;
}

function SplicePaths (name Path1, name Path2, optional int iPath2SplicePointPos)
{
  local InterpolationPoint IP;
  local InterpolationPoint EndPoint;
  local InterpolationPoint SplicePoint;

  foreach AllActors(Class'InterpolationPoint',IP,Path1)
  {
    if ( IP.bEndOfPath )
    {
      EndPoint = IP;
	  break;
    } //else {
    //}
  }
  if ( EndPoint == None )
  {
    Log("Couldn't find end point of path " $ string(Path1));
    return;
  }
  SplicePoint = FindPointOnPath(Path2,iPath2SplicePointPos);
  if ( SplicePoint == None )
  {
    Log("Couldn't find splice point of path " $ string(Path2));
    return;
  }
  EndPoint.SetLocation(SplicePoint.Location);
  EndPoint.SetRotation(SplicePoint.Rotation);
  EndPoint.DesiredSpeed = SplicePoint.DesiredSpeed;
  EndPoint.StartControlPoint = SplicePoint.StartControlPoint;
  EndPoint.EndControlPoint = SplicePoint.EndControlPoint;
}

event FinishedInterpolation (InterpolationPoint Other)
{
  PathToFly = Path;
  if ( IM != None )
  {
    IM = None;
    FlyOnPath(PathToFly);
  }
}

function SetPursuitParameters (float fNewPursuitTime, float fNewRecoveryTime, float fNewKickedPenalty, float fNewBumpedPenalty, float fNewPositionChangeIntervalMin, float fNewPositionChangeIntervalMax, float fNewKickIntervalMin, float fNewKickIntervalMax, int NewKickDamage)
{
  if ( fNewPursuitTime <= 0.01 )
  {
    HealthRecoveryRate = 10.0;
  } else {
    HealthRecoveryRate = 75.0 / fNewPursuitTime;
  }
  if ( fNewRecoveryTime <= 0.01 )
  {
    HealthRecoveryRateWhenStunned = 10.0;
  } else {
    HealthRecoveryRateWhenStunned = 25.0 / fNewRecoveryTime;
  }
  fKickedPenalty = fNewKickedPenalty;
  fBumpedPenalty = fNewBumpedPenalty;
  fPositionChangeIntervalMin = fNewPositionChangeIntervalMin;
  fPositionChangeIntervalMax = fNewPositionChangeIntervalMax;
  fKickIntervalMin = fNewKickIntervalMin;
  fKickIntervalMax = fNewKickIntervalMax;
  KickDamage = NewKickDamage;
}

function SetLookForTarget (Actor NewLookForTarget, optional name NewCatchPath)
{
  if ( WatchTarget == LookForTarget )
  {
    StopHeadLook();
    WatchTarget = None;
  }
  LookForTarget = NewLookForTarget;
  bEasingUpToSpeed = True;
  Path_Catch = NewCatchPath;
  TickParent = LookForTarget;
}

function SetTargetTrackDist (float fNewTargetTrackDist)
{
  fTargetTrackDist = fNewTargetTrackDist;
}

function SetKickTargetClass (name NewKickTargetClassName)
{
  if ( WatchTarget == KickTarget )
  {
    StopHeadLook();
    WatchTarget = None;
  }
  KickTargetClassName = NewKickTargetClassName;
}

function UpdateKickTarget ()
{
  local Pawn Target;
  local Vector Dir;
  local float Dist;

  KickTarget = None;
  if ( KickTargetClassName == 'None' )
  {
    return;
  }
  foreach AllActors(Class'Pawn',Target)
  {
    if ( Target.IsA(KickTargetClassName) )
    {
      Dir = Target.Location - Location;
      Dist = VSize(Dir);
      if ( (KickTarget == None) || (Dist < KickTargetDist) )
      {
        KickTarget = Target;
        KickTargetDist = Dist;
      }
    }
  }
  return;
}

function DoKick (Pawn KickTarget)
{
  local Vector X;
  local Vector Y;
  local Vector Z;
  local Vector TargetDir;
  local float TargetDist;
  local bool bOnLeft;
  local bool bKick;

  TargetDir = KickTarget.Location - Location;
  TargetDist = VSize(TargetDir);
  GetAxes(Rotation,X,Y,Z);
  bOnLeft = TargetDir Dot Y < 0.0;
  if ( TargetDir.Z <=  -KickTarget.CollisionHeight / 3.0 )
  {
    bKick = True;
  } else //{
    if ( TargetDir.Z >= KickTarget.CollisionHeight / 3.0 )
    {
      bKick = False;
    } else //{
      if ( FRand() < 0.5 )
      {
        bKick = True;
      } else {
        bKick = False;
      }
    //}
  //}
  if ( bKick )
  {
    if ( bOnLeft )
    {
      PlayAnim('KickLeft',1.0,0.2);
    } else {
      PlayAnim('KickRight',1.0,0.2);
    }
  } else {
    if ( bOnLeft )
    {
      PlayAnim('PushLeft',1.0,0.2);
    } else {
      PlayAnim('PushRight',1.0,0.2);
    }
  }
  PlaySound(Emotes[eSex].KickEmotes[Rand(8)],/*5*/SLOT_Talk,,True);
  if ( TargetDist < CollisionRadius * 3.0 )
  {
    KickTarget.TakeDamage(KickDamage,self,Location,100 * Normal(TargetDir),'Kicked');
  }
  fTimeLastKicked = Level.TimeSeconds;
}

function UpdateWatchTarget ()
{
  local bool bLookAtKickTarget;
  local Vector WatchOffset;

  if ( KickTarget != None )
  {
    bLookAtKickTarget = FRand() < 0.75;
  } else {
    bLookAtKickTarget = False;
  }
  if ( bLookAtKickTarget )
  {
    if ( WatchTarget != KickTarget )
    {
      WatchTarget = KickTarget;
      WatchOffset = vect(0.00,0.00,0.00);
      WatchOffset.Z = KickTarget.CollisionHeight * 0.25;
      MakeHeadWatchActor(WatchTarget,WatchOffset);
    }
  } else //{
    if ( LookForTarget != None )
    {
      if ( WatchTarget != LookForTarget )
      {
        WatchTarget = LookForTarget;
        MakeHeadWatchActor(WatchTarget);
      }
    } else {
      StopHeadLook();
      WatchTarget = None;
    }
  //}
}

function UpdateWoosh (float DeltaTime)
{
  local float fDistanceFromCamera;
  local Sound Woosh;

  fDistanceFromCamera = VSize(Location - harry.Cam.Location);
  if ( bCanWoosh && (Level.TimeSeconds > fNextTimeSafeToWoosh) && (fLastDistanceFromCamera >= 180) && (fDistanceFromCamera < 180) && (VSize(Velocity) > 200) )
  {
    Woosh = WooshSounds[Rand(4)];
    PlaySound(Woosh,/*1*/SLOT_Misc,0.69999999,,500.0,RandRange(0.81,1.25));
    fNextTimeSafeToWoosh = Level.TimeSeconds + GetSoundDuration(Woosh);
  }
  fLastDistanceFromCamera = fDistanceFromCamera;
}

function float GetHealth ()
{
  return fHealth / 100.0;
}

event Tick (float DeltaTime)
{
  if ( bStunned )
  {
    fHealth += HealthRecoveryRateWhenStunned * DeltaTime;
  } else {
    if ( IsInState('Pursue') )
    {
      if ( (LookForTarget != None) && (VSize(Location - LookForTarget.Location) < 500) )
      {
        fHealth += HealthRecoveryRate * DeltaTime;
      }
    }
  }
  if ( fHealth > 100.0 )
  {
    fHealth = 100.0;
  }
  if ( bStunned && (fHealth >= 25.0) )
  {
    bStunned = False;
  }
  if ( IsInState('Pursue') || IsInState('GetBackOnPath') )
  {
    Destination = Location + vector(Rotation) * 100;
    if ( vDodgeVel != vect(0.00,0.00,0.00) )
    {
      Velocity += vDodgeVel * 175;
      vDodgeVel = vect(0.00,0.00,0.00);
    }
  }
  UpdateWoosh(DeltaTime);
  Super.Tick(DeltaTime);
}

function Bump (Actor Other)
{
  local Pawn Target;

  Target = Pawn(Other);
  if (  !bHit &&  !bCatchingTarget && (Other != LookForTarget) && (Target != None) &&  !Target.bHidden )
  {
    if ( FRand() < 0.81 )
    {
      PlayAnim('React');
    } else {
      PlayAnim('Bump');
    }
    PlaySound(HitSounds[Rand(3)],/*3*/SLOT_Interact,0.69999999,,1000.0,RandRange(0.81,1.25));
    Target.TakeDamage(Damage,self,Location,100 * Normal(Velocity),'Collided');
    Velocity = vect(0.00,0.00,1.00);
    bHit = True;
  }
}

function TakeDamage (int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, name DamageType)
{
  local bool bIgnoredDamage;

  if (  !bStunned &&  !bCatchingTarget )
  {
    bIgnoredDamage = InstigatedBy.IsA('BroomHarry') && (DamageType != 'Kicked');
    StopHeadLook();
    WatchTarget = None;
    PlayAnim('Bump',,0.2);
    if (  !bIgnoredDamage && IsInState('Pursue') )
    {
      if ( DamageType == 'Kicked' )
      {
        fHealth -= fKickedPenalty;
      } else //{
        if ( DamageType == 'Collided' )
        {
          fHealth -= fBumpedPenalty;
        }
      //}
      PlaySound(Emotes[eSex].OuchEmotes[Rand(8)],/*5*/SLOT_Talk,,True);
    } else {
      Damage = 0;
    }
    if ( fHealth <= 1.0 )
    {
      fHealth = 0.1;
      bStunned = True;
      fTimeToFallAway = Level.TimeSeconds + 3.0;
    }
    if ( DamageType != 'Collided' )
    {
      PlaySound(HitSounds[Rand(3)],/*3*/SLOT_Interact,0.69999999,,1000.0,RandRange(0.81,1.25));
    }
    Super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
  }
}

function HitWall (Vector HitNormal, Actor Wall)
{
  local Vector V;

  if (  !bHit &&  !bCatchingTarget )
  {
    if ( FRand() < 0.81 )
    {
      PlayAnim('React');
    } else {
      PlayAnim('Bump');
    }
    bHit = True;
  }
  vDodgeVel = BroomHarry(PlayerHarry).GetDodgeVelFromHitwall(self,HitNormal,LookForTarget);
}

event AnimEnd ()
{
  bHit = False;
}

auto state() WaitForIntro
{
  function BeginState ()
  {
    LoopAnim('hover',RandRange(0.922,1.084));
    PlayerHarry.ClientMessage(string(Name) $ string(' Waiting for Intro'));
    Log(string(Name) $ string(' Waiting for Intro'));
  }
  
  function EndState ()
  {
    PlayerHarry.ClientMessage(string(Name) $ string(' Done waiting for Intro'));
    Log(string(Name) $ string(' Done waiting for Intro'));
  }
  
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    PlayerHarry.ClientMessage("QuidditchPlayer " $ string(Name) $ " Triggered");
    PathToFly = Path;
    GotoState('GetBackOnPath');
  }
  
begin:
loop:
  FinishAnim();
  if ( VSize(Velocity) < 50.0 )
  {
    LoopAnim('hover',RandRange(0.922,1.084),0.5);
  } else {
    if ( FRand() < 0.12 )
    {
      LoopAnim('Look',RandRange(0.922,1.084),0.5);
    } else {
      LoopAnim('Fly_forward',RandRange(0.922,1.084),0.5);
    }
  }
  goto ('Loop');
}

state() Fly
{
  function BeginState ()
  {
    LoopAnim('Fly_forward',RandRange(0.922,1.084));
    if (  !bCapturedByCutScene )
    {
      FlyOnPath(PathToFly);
    }
    PlayerHarry.ClientMessage(string(Name) $ string(' Begin Flying'));
    Log(string(Name) $ string(' Begin Flying'));
  }
  
  function EndState ()
  {
    StopFlyingOnPath();
    LoopAnim('hover',RandRange(0.922,1.084),0.5);
    PlayerHarry.ClientMessage(string(Name) $ string(' End Flying'));
    Log(string(Name) $ string(' End Flying'));
  }
  
begin:
loop:
  FinishAnim();
  if ( bCapturedByCutScene )
  {
    if ( bCaughtTarget )
    {
      LoopAnim('Hold',,0.1);
    } else {
      if ( VSize(Velocity) < 50.0 )
      {
        LoopAnim('hover',RandRange(0.922,1.084),0.5);
      } else {
        LoopAnim('Fly_forward',RandRange(0.922,1.084),0.5);
      }
    }
  } else {
    if ( bCaughtTarget )
    {
      LoopAnim('Hold',,0.1);
    } else //{
      if ( bStunned )
      {
        LoopAnim('Stunned',,0.5);
      } else //{
        if ( FRand() < 0.41 )
        {
          LoopAnim('Fly_forward',RandRange(0.922,1.084),0.5);
        } else //{
          if ( FRand() < 0.81 )
          {
            LoopAnim('Look',RandRange(0.922,1.084),0.5);
          } else {
            LoopAnim('hover',RandRange(0.922,1.084),0.5);
          }
        //}
      //}
    //}
  }
  goto ('Loop');
}

state Pursue
{
  //UTPT added these for some reason -AdamJD
  // ignores  HitWall, Tick;
  
  function BeginState ()
  {
    PlayerHarry.ClientMessage(string(Name) $ string(' Begin Pursue'));
    Log(string(Name) $ string(' Begin Pursue'));
    LoopAnim('Fly_forward',RandRange(0.922,1.084),0.5);
    // SetPhysics(4);
	SetPhysics(PHYS_Flying);
    fTargetTrackHorzOffset = RandRange( -TrackingOffsetRange_Horz,TrackingOffsetRange_Horz);
    fTargetTrackVertOffset = RandRange( -TrackingOffsetRange_Vert,TrackingOffsetRange_Vert);
    fTimeForNextOffset = Level.TimeSeconds;
    fTimeForNextKick = Level.TimeSeconds;
    fTimeForNextKickUpdate = Level.TimeSeconds;
    fTimeForNextWatchUpdate = Level.TimeSeconds;
  }
  
  //UTPT didn't add this for some reason -AdamJD
  event Tick( float DeltaTime )
  {
	local vector	X,Y,Z;
	local vector	TargetX, TargetY, TargetZ;	
	local vector	TargetTrackPoint;			
	local vector	TargetDir;
	local float		TargetDist;
	local float		TargetSpeed;
	local float		fPitch;
	local sound		Woosh;

	if ( !bStunned )
	{
		Global.Tick( DeltaTime );
	}
	else
	{
		Super.Tick( DeltaTime );
	}

	if ( bStunned && Level.TimeSeconds >= fTimeToFallAway )
	{
		PathToFly = Path_Recovery;
		GotoState( 'GetBackOnPath' );
	}

	if ( LookForTarget == None || LookForTarget.bHidden )
	{
		PathToFly = Path_Recovery;
		GotoState( 'GetBackOnPath' );
	}

	if ( Level.TimeSeconds > fTimeForNextOffset )
	{
		fTargetTrackHorzOffset = RandRange( -TrackingOffsetRange_Horz, TrackingOffsetRange_Horz );
		fTargetTrackVertOffset = RandRange( -TrackingOffsetRange_Vert, TrackingOffsetRange_Vert );
		fTimeForNextOffset = Level.TimeSeconds + RandRange( 2.0, 4.0 );
	}
	
	GetAxes( LookForTarget.Rotation, TargetX, TargetY, TargetZ );	
	TargetTrackPoint = LookForTarget.Location + TargetY * fTargetTrackHorzOffset + TargetZ * (fTargetTrackVertOffset - CollisionHeight);

	TargetDir = TargetTrackPoint - Location;
	DesiredRotation = Rotator( TargetDir );

	GetAxes( Rotation, X, Y, Z );
	
	if ( bEasingUpToSpeed )
	{
		AccelRate = 500.0;
	}
	if ( bStunned )
	{
		AccelRate = 1100.0;
	}
	else
	{
		AccelRate = 5000.0;
	}
	Acceleration = AccelRate * X;	
	DesiredSpeed = 1.0;				

	TargetDist = VSize( TargetDir ) - fTargetTrackDist;
	if ( TargetDist > SlowdownRadius )
	{
		AirSpeed = MaxSpeed;
	}
	else
	{
		TargetSpeed = VSize( LookForTarget.Velocity );
		AirSpeed = TargetDist / SlowdownRadius * (MaxSpeed - TargetSpeed) + TargetSpeed;
		if ( AirSpeed < 0 )
		{
			AirSpeed = 0;
		}
	}

	if ( !bStunned )
	{
		if ( (Level.TimeSeconds > fNextTimeSafeToWoosh) )
		{
			Woosh = SlowWooshSounds[Rand(5)];
			fPitch = RandRange(1.0,1.5);
			PlaySound(Woosh,SLOT_Misc,1.0,,1000.0,fPitch);
			fNextTimeSafeToWoosh = Level.TimeSeconds + (GetSoundDuration(Woosh) / fPitch) + 0.1;
		}
		if ( Level.TimeSeconds > fTimeForNextKickUpdate || Level.TimeSeconds > fTimeForNextKick )
		{
			UpdateKickTarget();
			fTimeForNextKickUpdate = Level.TimeSeconds + 1.0;
		}
		if ( Level.TimeSeconds > fTimeForNextKick )
		{
			if ( KickTarget != None && KickTargetDist <= CollisionRadius * 3.0 )
			{
				DoKick( KickTarget );
			}
			fTimeForNextKick = Level.TimeSeconds + RandRange( 1.5, 3.0 );
		}
		if ( Level.TimeSeconds > fTimeForNextWatchUpdate )
		{
			UpdateWatchTarget();
			fTimeForNextWatchUpdate = Level.TimeSeconds + RandRange( 1.0, 1.2 );
		}
	}
  }
  
  event AnimEnd ()
  {
    bHit = False;
    if ( bStunned && (Level.TimeSeconds > fTimeToFallAway - (3.0 + 0.1)) )
    {
      LoopAnim('Stunned',,0.41);
    }
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function HitWall(Vector HitNormal, Actor Wall)
  {
	Global.HitWall(HitNormal, Wall);
  }
  
  function CatchTarget ()
  {
    local Actor TargetToCatch;
  
    if ( LookForTarget.IsA('Snitch') )
    {
      TargetToCatch = Snitch(LookForTarget).CreateCatchProxy();
    } else {
      TargetToCatch = LookForTarget;
    }
    // TargetToCatch.SetPhysics(11);
	TargetToCatch.SetPhysics(PHYS_Trailer);
    TargetToCatch.SetOwner(self);
    TargetToCatch.AttachToOwner('RightHand');
    TargetToCatch.bTrailerPrePivot = True;
    TargetToCatch.PrePivot = vect(3.00,-3.00,0.00);
    bCaughtTarget = True;
  }
  
Begin:
  Sleep(0.5);
  if ( fHealth < 100.0 )
  {
    goto ('Begin');
  }
  bCatchingTarget = True;
  Director.Trigger(self,None);
  fTargetTrackHorzOffset = 0.0;
  fTargetTrackVertOffset = 0.0;
  fTimeForNextOffset = Level.TimeSeconds + 20.0;
  PlayAnim('Catch',,0.1);
  PlaySound(Sound'Q_snitch_catch',/*3*/SLOT_Interact);
  Sleep(25.0 / 30.0);
  CatchTarget();
  if ( Path_Catch != 'None' )
  {
    PathToFly = Path_Catch;
    GotoState('GetBackOnPath');
  }
}

state GetBackOnPath extends Fly
{
  //UTPT added this for some reason -AdamJD
  // ignores  HitWall, Tick;
  
  function BeginState ()
  {
    local float fDistance;
    local InterpolationPoint I;
    local Vector X;
    local Vector Y;
    local Vector Z;
    local float fClosestDistance;
    local InterpolationPoint ClosestPoint;
    local int iClosestPoint;
    local float fSecondClosestDistance;
    local InterpolationPoint SecondClosestPoint;
    local int iSecondClosestPoint;
  
    PlayerHarry.ClientMessage(string(Name) $ string(' Begin GetBackOnPath'));
    Log(string(Name) $ string(' Begin GetBackOnPath'));
    if ( PathToFly == 'None' )
    {
      Log(string(Name) $ " No path to get back to");
      GotoState('Fly');
    } else {
      ClosestPoint = None;
      fClosestDistance = 999999.0;
      iClosestPoint = 0;
      SecondClosestPoint = None;
      fSecondClosestDistance = 999999.0;
      foreach AllActors(Class'InterpolationPoint',I,PathToFly)
      {
        fDistance = VSize(Location - I.Location);
        if ( fDistance < fClosestDistance )
        {
          fSecondClosestDistance = fClosestDistance;
          SecondClosestPoint = ClosestPoint;
          iSecondClosestPoint = iClosestPoint;
          ClosestPoint = I;
          fClosestDistance = fDistance;
          iClosestPoint = I.Position;
        } else //{
          if ( fDistance < fSecondClosestDistance )
          {
            SecondClosestPoint = I;
            fSecondClosestDistance = fDistance;
            iSecondClosestPoint = I.Position;
          }
        //}
      }
      if ( SecondClosestPoint == None )
      {
        fSecondClosestDistance = fClosestDistance;
        SecondClosestPoint = ClosestPoint;
        iSecondClosestPoint = iClosestPoint;
      }
      iReturnPoint = iSecondClosestPoint;
      if ( SecondClosestPoint == None )
      {
        Log(string(Name) $ " Could not find an interpolation point on path '" $ string(PathToFly) $ "' to get back to");
        GotoState('Fly');
      } else {
        if ( ReturnPath[1] == None )
        {
          ReturnPath[1] = Spawn(Class'DynamicInterpolationPoint');
          ReturnPath[1].Tag = ReturnPath[1].Name;
          ReturnPath[1].Position = 1;
          ReturnPath[1].bEndOfPath = True;
        }
        ReturnPath[1].SetLocation(SecondClosestPoint.Location);
        ReturnPath[1].SetRotation(SecondClosestPoint.Rotation);
        ReturnPath[1].DesiredSpeed = SecondClosestPoint.DesiredSpeed;
        ReturnPath[1].StartControlPoint = SecondClosestPoint.StartControlPoint;
        ReturnPath[1].EndControlPoint = SecondClosestPoint.EndControlPoint;
        if ( ReturnPath[0] == None )
        {
          ReturnPath[0] = Spawn(Class'DynamicInterpolationPoint',,ReturnPath[1].Tag);
          ReturnPath[0].Position = 0;
          ReturnPath[0].bEndOfPath = False;
          ReturnPath[0].Next = ReturnPath[1];
          ReturnPath[0].Prev = ReturnPath[1];
          ReturnPath[1].Next = ReturnPath[0];
          ReturnPath[1].Prev = ReturnPath[0];
        }
        ReturnPath[0].SetLocation(Location);
        ReturnPath[0].SetRotation(Rotation);
        ReturnPath[0].DesiredSpeed = VSize(Velocity);
        if ( ReturnPath[0].DesiredSpeed < 50 )
        {
          ReturnPath[0].DesiredSpeed = 50.0;
        }
        GetAxes(Rotation,X,Y,Z);
        ReturnPath[0].StartControlPoint = 1000.0 * X;
        ReturnPath[0].EndControlPoint = -1000.0 * X;
        SetCollision(True,False,True);
        bCollideWorld = False;
        bInterpolating = True;
        // SetPhysics(0);
		SetPhysics(PHYS_None);
        IM = Spawn(Class'InterpolationManager',self);
        IM.Init(ReturnPath[1],1.0,False);
      }
    }
  }
  
  //UTPT didn't add this for some reason -AdamJD
  event Tick( float DeltaTime )
  {
	Super.Tick( DeltaTime );
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function HitWall(Vector HitNormal, Actor Wall)
  {
	Super.HitWall(HitNormal, Wall);
  }
  
  function EndState ()
  {
    PlayerHarry.ClientMessage(string(Name) $ string(' End GetBackOnPath'));
    Log(string(Name) $ string(' End GetBackOnPath'));
    StopFlyingOnPath();
  }
  
  event FinishedInterpolation (InterpolationPoint Other)
  {
    Log(string(Name) $ " Got onto path '" $ string(PathToFly) $ "'");
    if ( IM != None )
    {
      IM = None;
      GotoState('Fly');
    }
  }
  
}

defaultproperties
{
    fTargetTrackDist=200.00

    TrackingOffsetRange_Horz=100.00

    TrackingOffsetRange_Vert=75.00

    HealthRecoveryRate=2.50

    HealthRecoveryRateWhenStunned=2.00

    fKickedPenalty=33.33

    fBumpedPenalty=9.00

    fPositionChangeIntervalMin=2.00

    fPositionChangeIntervalMax=4.00

    fKickIntervalMin=1.50

    fKickIntervalMax=3.00

    KickDamage=5

    Damage=5

    bCanWoosh=True

    HitSounds(0)=Sound'HPSounds.Quidditch_sfx.Q_collision1'

    HitSounds(1)=Sound'HPSounds.Quidditch_sfx.Q_collision2'

    HitSounds(2)=Sound'HPSounds.Quidditch_sfx.Q_collision3'

    SlowWooshSounds(0)=Sound'HPSounds.Quidditch_sfx.Q_BRM_Swish_01'

    SlowWooshSounds(1)=Sound'HPSounds.Quidditch_sfx.Q_BRM_Swish_02'

    SlowWooshSounds(2)=Sound'HPSounds.Quidditch_sfx.Q_BRM_Swish_03'

    SlowWooshSounds(3)=Sound'HPSounds.Quidditch_sfx.Q_BRM_Swish_04'

    SlowWooshSounds(4)=Sound'HPSounds.Quidditch_sfx.Q_BRM_Swish_06'

    WooshSounds(0)=Sound'HPSounds.Quidditch_sfx.broom01'

    WooshSounds(1)=Sound'HPSounds.Quidditch_sfx.broom02'

    WooshSounds(2)=Sound'HPSounds.Quidditch_sfx.broom04'

    WooshSounds(3)=Sound'HPSounds.Quidditch_sfx.broom06'

    // HouseToDisplayAs=4
	HouseToDisplayAs=HA_DependsOnMatch

    // Emotes(0)=(KickEmotes=Sound'HPSounds.Quidditch_sfx.Q_mseeker_kick01',OuchEmotes=Sound'HPSounds.Quidditch_sfx.Q_mseeker_kick02')

    // Emotes(1)=(KickEmotes=Sound'HPSounds.Quidditch_sfx.Q_fseeker_kick01',OuchEmotes=Sound'HPSounds.Quidditch_sfx.Q_fseeker_kick02')
	//
	//UTPT didn't decompile the emote arrays correctly -AdamJD
    Emotes(0)=(KickEmotes[0]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_kick01',KickEmotes[1]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_kick02',KickEmotes[2]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_kick03',KickEmotes[3]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_kick04',KickEmotes[4]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_kick05',KickEmotes[5]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_kick06',KickEmotes[6]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_kick07',KickEmotes[7]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_kick08',OuchEmotes[0]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_ouch01',OuchEmotes[1]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_ouch02',OuchEmotes[2]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_ouch03',OuchEmotes[3]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_ouch04',OuchEmotes[4]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_ouch05',OuchEmotes[5]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_ouch06',OuchEmotes[6]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_ouch07',OuchEmotes[7]=Sound'HPSounds.Quidditch_sfx.Q_mseeker_ouch08')

    Emotes(1)=(KickEmotes[0]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_kick01',KickEmotes[1]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_kick02',KickEmotes[2]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_kick03',KickEmotes[3]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_kick04',KickEmotes[4]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_kick05',KickEmotes[5]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_kick06',KickEmotes[6]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_kick07',KickEmotes[7]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_kick08'),OuchEmotes[0]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_ouch01',OuchEmotes[1]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_ouch02',OuchEmotes[2]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_ouch03',OuchEmotes[3]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_ouch04',OuchEmotes[4]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_ouch05',OuchEmotes[5]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_ouch06',OuchEmotes[6]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_ouch07',OuchEmotes[7]=Sound'HPSounds.Quidditch_sfx.Q_fseeker_ouch08')

    // eSex=2
	eSex=SX_Neutral

    ShadowClass=Class'HPModels.BroomShadow'

    Mesh=SkeletalMesh'HPModels.skQuidPlayerFMesh'

    CollisionRadius=18.00

    CollisionHeight=32.00

    bBlockActors=False

    bAlignBottomAlways=True

    RotationRate=(Pitch=24000,Yaw=50000,Roll=2000)
}
