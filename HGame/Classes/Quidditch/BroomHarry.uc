//================================================================================
// BroomHarry.
//================================================================================

class BroomHarry extends harry
  Config(User);

const MaxSpeed= 1200;
const SlowdownRadius= 50;
const fReversalsStatPeriod= 2.5;
const MAX_REVERSAL_STATS= 20;
const NUM_WOOSH_SOUNDS= 4;
const NUM_SLOW_WOOSH_SOUNDS= 5;
const NUM_HIT_SOUNDS= 3;
const fMaxTimeSameAvoidDir= 1.0;
enum EControlDevice {
  DEVICE_Button,
  DEVICE_Mouse,
  DEVICE_Joystick,
  DEVICE_Gamepad
};

var float fPitchControl;
var float fYawControl;
var float fRotationRateYaw;
var(Movement) int AirSpeedNormal;
var(Movement) int AirSpeedBoost;
var(Movement) int PitchLimitUp;
var(Movement) int PitchLimitDown;
var(Movement) int WallDamage;
var(Movement) float ArmorDamageScale;
var StatusItemQArmor QuidArmorStatus;
var bool bInvincible;
var bool bAuxBoost;
var int Deceleration;
var bool bHasEverBoosted;
var bool bHasEverBraked;
var bool bActioned;
var bool bWasActioning;
var float fMousePitch;
var float fMouseYaw;
var float fBroomSensitivity;
var float fJoyBroomSensitivity;
var EControlDevice eYawControlDevice;
var EControlDevice ePitchControlDevice;
var bool bLastYawNeg;
var bool bLastPitchNeg;
var bool bHit;
var bool bHitWall;
var bool bHittingWall;
var int WallAvoidanceYaw;
var float fWallAvoidanceRate;
var float fLastTimeAvoidedWall;
var bool bLastAvoidanceRight;
var float fTimeForNextError;
var Vector TargetError;
var float fTargetTrackDist;
var float fTargetTrackHorzOffset;
var float fTargetTrackVertOffset;
var float TrackingOffsetRange_Horz;
var float TrackingOffsetRange_Vert;
var float fNextTimeSafeToWoosh;
var bool bEasingUpToSpeed;
var Vector vDodgeVel;
var name PrimaryAnim;
var name SecondaryAnim;
var Sound BroomSound;
var Sound MainBroomSound;
var Sound HitSounds[3];
var Sound SlowWooshSounds[5];
var Sound WooshSounds[4];
var InterpolationManager IM;
var DynamicInterpolationPoint TransPath[2];
var int iTransPoint;
var string CutCommandCue;
var ParticleFX Trail;
var Actor LookForTarget;
var bool bLookingForTarget;
var bool bCaughtTarget;
var bool bReaching;
var Actor TargetToCatch;
var name PathAfterCatch;
var float PathSpeed;
var name KickTargetClassName;
var Pawn KickTarget;
var float KickTargetDist;
var float fTimeForNextKickUpdate;
var float fTimeLastKicked;
var Actor WatchTarget;
var float fTimeForNextWatchUpdate;
var float fTimesOfLastReversals[20];
var int iNextReversalStat;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  bInvincible = False;
  bAuxBoost = False;
  Deceleration = 0;
  bHasEverBoosted = False;
  bHasEverBraked = False;
  bActioned = False;
  bWasActioning = False;
  PathSpeed = IPSpeed;
}

function PostBeginPlay()
{
  local int iStat;

  Super.PostBeginPlay();
  // SetPhysics(4);
  SetPhysics(PHYS_Flying);
  PrimaryAnim = 'hover';
  SecondaryAnim = 'None';
  LoopAnim(PrimaryAnim);
  LookForTarget = None;
  bLookingForTarget = False;
  bCaughtTarget = False;
  BroomSound = Sound'flying_broom_loop';
  fRotationRateYaw = 20000.0;
  RotationRate.Yaw = 50000;
  RotationRate.Roll = 6000;
  RotationRate.Pitch = 24000;
  fBroomSensitivity = 1.0 / 16384.0;
  fJoyBroomSensitivity = 1.0 / 13312.0;
  fMouseYaw = 0.0;
  fMousePitch = 0.0;
  // eYawControlDevice = 0;
  // ePitchControlDevice = 0;
  eYawControlDevice = DEVICE_Button;
  eYawControlDevice = DEVICE_Button;
  bLastYawNeg = False;
  bLastPitchNeg = False;
  bEasingUpToSpeed = True;
  bHit = False;
  bHitWall = False;
  bHittingWall = False;
  fLastTimeAvoidedWall = -1.0;
  bReaching = False;
  fTargetTrackDist = 200.0;
  fTargetTrackHorzOffset = RandRange( -TrackingOffsetRange_Horz,TrackingOffsetRange_Horz);
  fTargetTrackVertOffset = RandRange( -TrackingOffsetRange_Vert,TrackingOffsetRange_Vert);
  fTimeLastKicked = -1.0;
  fNextTimeSafeToWoosh = Level.TimeSeconds;
  // iStat = 0;
  // if ( iStat < 20 )
  for(iStat = 0; iStat < MAX_REVERSAL_STATS; ++iStat)
  {
    fTimesOfLastReversals[iStat] = -9999.93963;
    // ++iStat;
    // goto JL016E;
  }
  iNextReversalStat = 0;
}

event Possess()
{
  Super.Possess();
  Log("BroomHarry in State " $ string(GetStateName()) $ ".");
  if ( IsInState('BroomDying') )
  {
    // SetPhysics(2);
	SetPhysics(PHYS_Falling);
  } else {
    // SetPhysics(4);
	SetPhysics(PHYS_Flying);
  }
}

event TravelPostAccept()
{
  Super.TravelPostAccept();
  QuidArmorStatus = StatusItemQArmor(managerStatus.GetStatusItem(Class'StatusGroupQGear',Class'StatusItemQArmor'));
}

event PlayerInput (float DeltaTime)
{
  Super.PlayerInput(DeltaTime);
  bActioned = False;
  if ( bBroomAction != 0 )
  {
    if (  !bWasActioning )
    {
      bActioned = True;
      if ( IsInState('PlayerWalking') )
      {
        UpdateKickTarget();
        fTimeForNextKickUpdate = Level.TimeSeconds + 1.0;
        if ( (KickTarget != None) && (KickTargetDist < TrackingOffsetRange_Horz * 2.0) )
        {
          DoKick(KickTarget);
        } else {
          Director.OnActionKeyPressed();
        }
      } else {
        Director.OnActionKeyPressed();
      }
    }
    bWasActioning = True;
  } else {
    bWasActioning = False;
  }
  if ( bBroomBoost != 0 )
  {
    bHasEverBoosted = True;
  }
  if ( bBroomBrake != 0 )
  {
    bHasEverBraked = True;
  }
}

function DoCapture()
{
  StopFlyingOnPath();
  SetSecondaryAnimation('None');
  bCaughtTarget = False;
  DesiredRotation = Rotation;
  DesiredRotation.Pitch = 0;
  SetRotation(DesiredRotation);
  GotoState('stateCutIdle');
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local bool bResult;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "Capture" )
  {
    if ( IsInState('Catching') )
    {
      bIsCaptured = True;
      myHUD.StartCutScene();
      SendPlayerCaptureMessages(True);
      return True;
    } else {
      DoCapture();
      return Super.CutCommand(Command,cue,bFastFlag);
    }
  } else //{
    if ( sActualCommand ~= "Release" )
    {
      bResult = Super.CutCommand(Command,cue,bFastFlag);
      IPSpeed = PathSpeed;
      bInterpolating_IgnoreRot = False;
      bCollideWorld = True;
      SetCollision(True,True,True);
      bEasingUpToSpeed = True;
      return bResult;
    } else //{
      if ( sActualCommand ~= "FlyOnPath" )
      {
        return CutCommand_FlyOnPath(Command,cue,bFastFlag);
      } else {
        return Super.CutCommand(Command,cue,bFastFlag);
      }
    //}
  //}
}

function bool CutCommand_FlyOnPath (string Command, optional string cue, optional bool bFastFlag)
{
  local InterpolationPoint IP;
  local string Token;
  local int I;
  local name PathName;
  local int StartPoint;

  PathName = name(ParseDelimitedString(Command," ",2,False));
// JL0027:
  StartPoint = 0;
  I = 2;
  do
  {
	  ++I;
	  Token = ParseDelimitedString(Command," ",I,False);
	  if ( Token != "" )
	  {
		if ( Left(Token,Len("Start=")) ~= "Start=" )
		{
		  Token = Mid(Token,Len("start="));
		  StartPoint = -1;
		  foreach AllActors(Class'InterpolationPoint',IP,PathName)
		  {
			if ( IP.CutName ~= Token )
			{
			  StartPoint = IP.Position;
			  break;
			} //else {
			//}
		  }
		  if ( StartPoint == -1 )
		  {
			CutErrorString = "No Spline Point on path '" $ string(PathName) $ "' with CutName '" $ Token $ "'";
			CutCue(cue);
			return False;
		  }
		} else {
		  ClientMessage("**** Warning:" $ string(self) $ ":FlyOnPath option '" $ Token $ "' not recognized.  Ignoring.");
		  Log("**** Warning:" $ string(self) $ ":FlyOnPath option '" $ Token $ "' not recognized.  Ignoring.");
		}
	  }
  }
  until(Token == "");
  // if (! Token == "" ) goto JL0027;
  
  if ( bFastFlag )
  {
    foreach AllActors(Class'InterpolationPoint',IP,PathName)
    {
      if ( IP.bEndOfPath )
      {
        SetLocation(IP.Location);
        SetRotation(IP.Rotation);
		break;
      } //else {
      //}
    }
    CutCue(cue);
  } else {
    CutCommandCue = cue;
    FlyOnPath(PathName,StartPoint);
  }
  return True;
}

function SetPrimaryAnimation (name NewPrimaryAnim, optional float Rate, optional float TweenTime, optional float MinRate, optional EAnimType Type, optional name RootBone)
{
  if ( NewPrimaryAnim != PrimaryAnim )
  {
    PrimaryAnim = NewPrimaryAnim;
    if ( PrimaryAnim != 'None' )
    {
      LoopAnim(PrimaryAnim,,TweenTime,MinRate);
    }
    if ( SecondaryAnim != 'None' )
    {
      LoopAnim(SecondaryAnim,,TweenTime);
    }
  }
}

function SetSecondaryAnimation (name NewSecondaryAnim, optional float Rate, optional float TweenTime, optional float MinRate, optional EAnimType Type, optional name RootBone)
{
  if ( NewSecondaryAnim != SecondaryAnim )
  {
    SecondaryAnim = NewSecondaryAnim;
    if ( PrimaryAnim != 'None' )
    {
      LoopAnim(PrimaryAnim,,TweenTime);
    }
    if ( SecondaryAnim != 'None' )
    {
      LoopAnim(SecondaryAnim,,TweenTime,MinRate);
    }
  }
}

function DeterminePrimaryAnim()
{
  local float Speed;

  Speed = VSize(Velocity);
  if (  !bHitWall &&  !bHit )
  {
    if ( (Rotation.Roll > 1000) && (Rotation.Roll < 32768) )
    {
      SetPrimaryAnimation('Turn_Right',,1.0);
    } else //{
      if ( (Rotation.Roll < 65536 - 1000) && (Rotation.Roll > 32768) )
      {
        SetPrimaryAnimation('Turn_Left',,1.0);
      } else //{
        if ( (Rotation.Pitch > 1000) && (Rotation.Pitch < 32768) )
        {
          SetPrimaryAnimation('Pull_Up',,1.0);
        } else //{
          if ( (Rotation.Pitch < 65536 - 1000) && (Rotation.Pitch > 32768) )
          {
            SetPrimaryAnimation('Dive',,1.0);
          } else //{
            if ( (bBroomBrake != 0) && (Deceleration < AirSpeedNormal * 0.47999999) )
            {
              SetPrimaryAnimation('Brake',,1.0);
            } else //{
              if ( ((bBroomBoost != 0) || bAuxBoost) && (bBroomBrake == 0) )
              {
                SetPrimaryAnimation('Boost',,1.0);
              } else //{
                if ( Speed < 50 )
                {
                  SetPrimaryAnimation('hover',,0.41);
                } else {
                  SetPrimaryAnimation('Fly_forward',,1.0);
                }
              //}
            //}
          //}
        //}
      //}
    //}
  }
  Trail.ParentBlend = Min(Speed / 200, 1);
}

function SetInvincible (bool bOn)
{
  bInvincible = bOn;
}

function SetLookForTarget (Actor NewLookForTarget)
{
  LookForTarget = NewLookForTarget;
  bEasingUpToSpeed = True;
  TickParent = LookForTarget;
}

function SetTargetTrackDist (float fNewTargetTrackDist)
{
  fTargetTrackDist = fNewTargetTrackDist;
}

function SetReaching (bool bOn)
{
  if ( bReaching != bOn )
  {
    bReaching = bOn;
    if ( bReaching )
    {
      SetSecondaryAnimation('GrabAttemptRight',,1.0);
    } else {
      SetSecondaryAnimation('None',,1.0);
    }
  }
}

function CatchTarget (Actor Target, optional name PathToFlyAfterCatch)
{
  TargetToCatch = Target;
  PathAfterCatch = PathToFlyAfterCatch;
  GotoState('Catching');
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

function UpdateKickTarget()
{
  //local Pawn Target;
  local Pawn pTarget;
  local Vector Dir;
  local float Dist;

  KickTarget = None;
  if ( KickTargetClassName == 'None' )
  {
    return;
  }
  foreach AllActors(Class'Pawn',pTarget)
  {
    if ( pTarget.IsA(KickTargetClassName) &&  !pTarget.bHidden )
    {
      Dir = pTarget.Location - Location;
      Dist = VSize(Dir);
      if ( (KickTarget == None) || (Dist < KickTargetDist) )
      {
        KickTarget = pTarget;
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
  if ( TargetDir.Z <= (-KickTarget.CollisionHeight / 3.0) )
  {
    bKick = True;
  } else //{
    if ( TargetDir.Z >= (KickTarget.CollisionHeight / 3.0) )
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
  if ( TargetDist < CollisionRadius * 3.0 )
  {
    KickTarget.TakeDamage(0,self,Location,100 * Normal(TargetDir),'Kicked');
  }
  fTimeLastKicked = Level.TimeSeconds;
}

function UpdateWatchTarget()
{
  local bool bLookAtKickTarget;
  local Vector WatchOffset;
  local float fWatchWeight;

  if ( bHit || bHitWall || HarryAnimChannel.IsInState('stateDrinkWiggenwell') )
  {
    return;
  }
  if ( KickTarget != None )
  {
    if ( KickTargetDist < 100 )
    {
      bLookAtKickTarget = FRand() < 0.75;
    } else {
      fWatchWeight = 0.75 * (400 + 100 - KickTargetDist) / 400;
    }
    bLookAtKickTarget = FRand() < fWatchWeight;
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

function PlayFastWhooshSound()
{
  switch (Rand(3))
  {
	//KW left this empty? -AdamJD
    default:
  }
}

function PlaySlowWhooshSound()
{
  switch (Rand(3))
  {
	//KW left this empty? -AdamJD
    default:
  }
}

function UpdateBroomSound()
{
  local float fSpeed;
  local float fSpeedFactor;
  local float fTurnFactor;
  local float fVolume;
  local float fPitch;

  fSpeed = VSize(Velocity);
  if ( fSpeed < 50 )
  {
    fVolume = 0.0;
    fPitch = 1.5;
  } else //{
    if ( fSpeed <= AirSpeedNormal )
    {
      fSpeedFactor = (fSpeed - 50) / (AirSpeedNormal - 50);
      fVolume = 0.62 * fSpeedFactor;
      fPitch = 0.2 * fSpeedFactor + 1.5;
    } else {
      fSpeedFactor = (fSpeed - AirSpeedNormal) / (AirSpeedBoost - AirSpeedNormal);
      fVolume = 0.41 * fSpeedFactor + 0.62;
      fPitch = 0.151 * fSpeedFactor + 1.75;
    }
  //}
  if ( Rotation.Roll <= 32768 )
  {
    fTurnFactor = Rotation.Roll / 4096.0;
  } else //{
    if ( Rotation.Roll > 32768 )
    {
      fTurnFactor = (65536.0 - Rotation.Roll) / 4096.0;
    }
  //}
  if ( Rotation.Pitch <= 32768 )
  {
    fTurnFactor += Rotation.Pitch / 8192.0;
  } else //{
    if ( Rotation.Pitch > 32768 )
    {
      fTurnFactor += (65536 - Rotation.Pitch) / 8192.0;
    }
  //}
  fTurnFactor *= 0.5;
  if ( fTurnFactor > 1.0 )
  {
    fTurnFactor = 1.0;
  }
  fVolume *= 1.0 + (2.0 * fTurnFactor);
  fPitch *= 1.0 + (1.0 * fTurnFactor);
  if ( (fTurnFactor > 0.0) && (fTurnFactor < 0.1) )
  {
    if ( fSpeedFactor > 0.69999999 )
    {
      PlayFastWhooshSound();
    } else {
      PlaySlowWhooshSound();
    }
  }
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

function FlyOnPath (name CutScenePath, optional int StartPoint)
{
  local InterpolationPoint I;

  if ( CutScenePath != 'None' )
  {
    I = FindPointOnPath(CutScenePath,StartPoint);
    if ( I != None )
    {
      SetLocation(I.Location);
      SetRotation(I.Rotation);
      SetCollision(True,False,False);
      bCollideWorld = False;
      bInterpolating = True;
      // SetPhysics(0);
	  SetPhysics(PHYS_None);
      IM = Spawn(Class'InterpolationManager',self);
      IM.Init(I.Next,1.0,False);
    }
    if ( IM == None )
    {
      Log("Harry couldn't find path " $ string(CutScenePath));
    } //else {
    //}
  }
}

function StopFlyingOnPath()
{
  local InterpolationManager IM_ToStop;

  if ( IM != None )
  {
    IM_ToStop = IM;
    IM = None;
    IM_ToStop.FinishedInterpolation(None);
  }
  bCollideWorld = True;
  SetCollision(True,True,True);
  if ( IsInState('FlyingOnPath') )
  {
    GotoState('PlayerWalking');
  }
}

function bool GetOnPath (name Path, optional int StartPoint)
{
  local float fDistance;
  local InterpolationPoint I;
  local Vector X;
  local Vector Y;
  local Vector Z;
  local float fClosestDistance;
  local InterpolationPoint ClosestPoint;
  local int iClosestPoint;
  local float fTransDistance;
  local InterpolationPoint TransPoint;

  if ( Path == 'None' )
  {
    return False;
  }
  if ( StartPoint != 0 )
  {
    foreach AllActors(Class'InterpolationPoint',I,Path)
    {
      if ( I.Position == StartPoint )
      {
        TransPoint = I;
        fTransDistance = fDistance;
        iTransPoint = I.Position;
		break;
      } //else {
      //}
    }
  } else {
    ClosestPoint = None;
    fClosestDistance = 999999.0;
    iClosestPoint = 0;
    TransPoint = None;
    fTransDistance = 999999.0;
    foreach AllActors(Class'InterpolationPoint',I,Path)
    {
      fDistance = VSize(Location - I.Location);
      if ( fDistance < fClosestDistance )
      {
        fTransDistance = fClosestDistance;
        TransPoint = ClosestPoint;
        iTransPoint = iClosestPoint;
        ClosestPoint = I;
        fClosestDistance = fDistance;
        iClosestPoint = I.Position;
      } else //{
        if ( fDistance < fTransDistance )
        {
          TransPoint = I;
          fTransDistance = fDistance;
          iTransPoint = I.Position;
        }
      //}
    }
    if ( TransPoint == None )
    {
      fTransDistance = fClosestDistance;
      TransPoint = ClosestPoint;
      iTransPoint = iClosestPoint;
    }
  }
  if ( TransPoint == None )
  {
    Log("BroomHarry could not find an interpolation point on path to go to");
    return False;
  }
  if ( TransPath[1] == None )
  {
    TransPath[1] = Spawn(Class'DynamicInterpolationPoint');
    TransPath[1].Tag = TransPath[1].Name;
    TransPath[1].Position = 1;
    TransPath[1].bEndOfPath = True;
  }
  TransPath[1].SetLocation(TransPoint.Location);
  TransPath[1].SetRotation(TransPoint.Rotation);
  TransPath[1].DesiredSpeed = 900.0;
  TransPath[1].StartControlPoint = TransPoint.StartControlPoint;
  TransPath[1].EndControlPoint = TransPoint.EndControlPoint;
  if ( TransPath[0] == None )
  {
    TransPath[0] = Spawn(Class'DynamicInterpolationPoint',,TransPath[1].Tag);
    TransPath[0].Position = 0;
    TransPath[0].bEndOfPath = False;
    TransPath[0].Next = TransPath[1];
    TransPath[0].Prev = TransPath[1];
    TransPath[1].Next = TransPath[0];
    TransPath[1].Prev = TransPath[0];
  }
  TransPath[0].SetLocation(Location);
  TransPath[0].SetRotation(Rotation);
  TransPath[0].DesiredSpeed = VSize(Velocity);
  GetAxes(Rotation,X,Y,Z);
  TransPath[0].StartControlPoint = 1000.0 * X;
  TransPath[0].EndControlPoint = -1000.0 * X;
  SetCollision(True,False,False);
  bCollideWorld = False;
  bInterpolating = True;
  // SetPhysics(0);
  SetPhysics(PHYS_None);
  IM = Spawn(Class'InterpolationManager',self);
  IM.Init(TransPath[1],1.0,False);
  return True;
}

function PlayerTrack (float DeltaTime)
{
  local Vector X;
  local Vector Y;
  local Vector Z;
  local Vector TargetX;
  local Vector TargetY;
  local Vector TargetZ;
  local Vector TargetTrackPoint;
  local float fLastHorzOffset;
  local float fLastVertOffset;
  local Vector TargetDir;
  local float TargetDist;
  local float TargetSpeed;
  local float fDeltaPitch;
  local float CurrentSpeed;
  local Sound Woosh;
  local float fPitch;

  fLastHorzOffset = fTargetTrackHorzOffset;
  fTargetTrackHorzOffset += (bBroomYawRight - bBroomYawLeft) * 350.0 * DeltaTime;
  fTargetTrackHorzOffset += aBroomYaw * fBroomSensitivity * TrackingOffsetRange_Horz;
  fTargetTrackHorzOffset += aJoyBroomYaw * fJoyBroomSensitivity * 350.0 * DeltaTime;
  if ( fTargetTrackHorzOffset > TrackingOffsetRange_Horz )
  {
    fTargetTrackHorzOffset = TrackingOffsetRange_Horz;
  } else //{
    if ( fTargetTrackHorzOffset <  -TrackingOffsetRange_Horz )
    {
      fTargetTrackHorzOffset =  -TrackingOffsetRange_Horz;
    }
  //}
  fLastVertOffset = fTargetTrackVertOffset;
  fDeltaPitch = (bBroomPitchUp - bBroomPitchDown) * 350.0 * DeltaTime;
  fDeltaPitch -= aBroomPitch * fBroomSensitivity * TrackingOffsetRange_Vert;
  fDeltaPitch -= aJoyBroomPitch * fJoyBroomSensitivity * 350.0 * DeltaTime;
  if ( bInvertBroomPitch )
  {
    fDeltaPitch =  -fDeltaPitch;
  }
  fTargetTrackVertOffset += fDeltaPitch;
  if ( fTargetTrackVertOffset > TrackingOffsetRange_Vert )
  {
    fTargetTrackVertOffset = TrackingOffsetRange_Vert;
  } else //{
    if ( fTargetTrackVertOffset <  -TrackingOffsetRange_Vert )
    {
      fTargetTrackVertOffset =  -TrackingOffsetRange_Vert;
    }
  //}
  GetAxes(LookForTarget.Rotation,TargetX,TargetY,TargetZ);
  TargetTrackPoint = (LookForTarget.Location + (TargetY * fTargetTrackHorzOffset)) + (TargetZ * (fTargetTrackVertOffset - CollisionHeight));
  TargetDir = TargetTrackPoint - Location;
  DesiredRotation = rotator(TargetDir);
  GetAxes(Rotation,X,Y,Z);
  if ( bEasingUpToSpeed )
  {
    AccelRate = 1100.0;
  } else {
    AccelRate = 5000.0;
  }
  Acceleration = AccelRate * X;
  DesiredSpeed = 1.0;
  if ( vDodgeVel != vect(0.00,0.00,0.00) )
  {
    Velocity += vDodgeVel * 175;
    vDodgeVel = vect(0.00,0.00,0.00);
  }
  TargetDist = VSize(TargetDir) - fTargetTrackDist;
  if ( TargetDist > 50 )
  {
    AirSpeed = MaxSpeed;
  } else {
    TargetSpeed = VSize(LookForTarget.Velocity);
    AirSpeed = TargetDist / 50 * (MaxSpeed - TargetSpeed) + TargetSpeed;
    if ( AirSpeed < 0 )
    {
      AirSpeed = 0.0;
    }
  }
  CurrentSpeed = VSize(Velocity);
  if ( (CurrentSpeed >= 200) || (Abs(CurrentSpeed - AirSpeed) < 75) )
  {
    bEasingUpToSpeed = False;
  }
  if ( (Level.TimeSeconds > fNextTimeSafeToWoosh) && (CurrentSpeed > 75) && ((Abs(fTargetTrackHorzOffset - fLastHorzOffset) / DeltaTime > 150) || (Abs(fTargetTrackVertOffset - fLastVertOffset) / DeltaTime > 150)) )
  {
    Woosh = SlowWooshSounds[Rand(5)];
    fPitch = RandRange(1.0,1.5);
    PlaySound(Woosh,SLOT_Misc,1.0,,1000.0,fPitch);
    fNextTimeSafeToWoosh = (Level.TimeSeconds + (GetSoundDuration(Woosh) / fPitch)) + 0.1;
  }
  UpdateBroomSound();
}

function TakeDamage (int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, name DamageType)
{
  local int EffectiveDamage;

  if ( IsInState('PlayerWalking') )
  {
    StopHeadLook();
    WatchTarget = None;
    PlayAnim('Bump',,0.2);
    bHit = True;
	
	//UTPT didn't seem to decompile this function right, no health used to be taken off BroomHarry when getting kicked the seeker -AdamJD
	/*
    if ( !InstigatedBy.IsA('Seeker') && DamageType != 'Kicked' )
    {
      PlaySound(HurtSound[Rand(15)],SLOT_Talk,,True);
      if ( (DamageType == 'Kicked') || (DamageType == 'Bludgered') )
      {
        if ( Director != None )
        {
          Director.OnTakeDamage(self,Damage,InstigatedBy,DamageType);
        }
      }
	  if ( !bInvincible )
      {
        if ( QuidArmorStatus.GetCount() > 0 )
        {
          EffectiveDamage = (Damage * 0.5) * ArmorDamageScale;
        }
		else
		{
		  EffectiveDamage = Damage * 0.5;
		}
		ClientMessage("BroomHarry Damage=" $ string(Damage) $ ", EffectiveDamage=" $ string(EffectiveDamage));
		AddHealth(-EffectiveDamage);
        if ( GetHealthCount() <= 0.0 )
        {
          KillHarry(True);
        }
      }
    }
	*/
	
    if ( (DamageType == 'Kicked') || (DamageType == 'Bludgered') )
    {
      if ( Director != None )
      {
        Director.OnTakeDamage(self,Damage,InstigatedBy,DamageType);
      }
    }
	if ( !bInvincible && DamageType != 'Collided' ) //Collided is used by the seeker when bumping into BroomHarry but not kicking him -AdamJD  
    {
      if ( QuidArmorStatus.GetCount() > 0 )
      {
        EffectiveDamage = (Damage * 0.5) * ArmorDamageScale;
      }
	  else
	  {
		 EffectiveDamage = Damage * 0.5;
	  }
	  ClientMessage("BroomHarry Damage=" $ string(Damage) $ ", EffectiveDamage=" $ string(EffectiveDamage));
	  PlaySound(HurtSound[Rand(15)],SLOT_Talk,,True); //only play the hurt sound if he's actually hitting something or kicked by the seeker -AdamJD
	  AddHealth(-EffectiveDamage);
      if ( GetHealthCount() <= 0.0 )
      {
        KillHarry(True);
      }
    }
  }
}

function KillHarry (bool bImmediateDeath)
{
  ClientMessage("I can't go on!!!!");
  GotoState('BroomDying');
}

function DoDrinkWiggenwell()
{
  if (  !IsInState('PlayerWalking') || bHit || bHitWall )
  {
    return;
  }
  StopHeadLook();
  WatchTarget = None;
  Super.DoDrinkWiggenwell();
}

function PlayInAir()
{
}

function PlayWaiting()
{
}

function NoteAnotherReversal()
{
  fTimesOfLastReversals[iNextReversalStat] = Level.TimeSeconds;
  ++iNextReversalStat;
  if ( iNextReversalStat >= MAX_REVERSAL_STATS )
  {
    iNextReversalStat = 0;
  }
}

function float GetReversalsPerSecond()
{
  local int iStat;
  local int iReversals;
  local float fReversalRate;

  iReversals = 0;
  iStat = iNextReversalStat;
  do
  {
	  if ( iStat == 0 )
	  {
		iStat = MAX_REVERSAL_STATS;
	  }
	  --iStat;
	  if ( Level.TimeSeconds - fTimesOfLastReversals[iStat] > fReversalsStatPeriod )
	  {
		// goto JL0067;
		break;
	  }
	  ++iReversals;
  }
  until(iReversals >= MAX_REVERSAL_STATS);
  // if (! iReversals >= 20 ) goto JL0012;
  
  fReversalRate = iReversals / fReversalsStatPeriod;
  return fReversalRate;
}

state PlayerWalking
{
  ignores  Mount, AltFire;
  
  function BeginState()
  {
    local BaseCam Camera;
    //local Seeker WatchTarget;
  
    ClientMessage("BroomHarry: Entered " $ string(GetStateName()) $ " State");
    Log("BroomHarry: Entered " $ string(GetStateName()) $ " State");
    Super.BeginState();
    // SetPhysics(4);
	SetPhysics(PHYS_Flying);
    bCollideWorld = True;
    SetCollision(True,True,True);
    if ( Director == None )
    {
      foreach AllActors(Class'BaseCam',Camera)
      {
        // Camera.SetCameraMode(4);
		Camera.SetCameraMode(CM_Quidditch);
  // JL009D:
        // goto JL009D;
		break;
      }
    }
    fTimeForNextKickUpdate = Level.TimeSeconds;
    fTimeForNextWatchUpdate = Level.TimeSeconds;
  }
  
  function EndState()
  {
    ClientMessage("BroomHarry: Exited " $ string(GetStateName()) $ " State");
    Log("BroomHarry: Exited " $ string(GetStateName()) $ " State");
    StopHeadLook();
    WatchTarget = None;
    Super.EndState();
  }
    
  event PlayerTick (float DeltaTime)
  {
    if ( LookForTarget != None )
    {
      PlayerTrack(DeltaTime);
    } else {
      PlayerMove(DeltaTime);
    }
    Destination = Location + (vector(Rotation) * 100);
    DeterminePrimaryAnim();
    if ( (LookForTarget != None) && (LookForTarget.bHidden ||  !CanSee(LookForTarget)) )
    {
      if (  !bLookingForTarget )
      {
        bLookingForTarget = True;
        SetTimer(FRand() * 3.0 + 1.0,False);
      }
    } else {
      if ( bLookingForTarget )
      {
        bLookingForTarget = False;
        SetTimer(0.0,False);
      }
    }
    if ( Level.TimeSeconds > fTimeForNextKickUpdate )
    {
      UpdateKickTarget();
      fTimeForNextKickUpdate = Level.TimeSeconds + 1.0;
    }
    if ( Level.TimeSeconds > fTimeForNextWatchUpdate )
    {
      UpdateWatchTarget();
      fTimeForNextWatchUpdate = Level.TimeSeconds + RandRange(1.0,1.25);
    }
  }
  
  function PlayerMove (float DeltaTime)
  {
    local Vector X;
    local Vector Y;
    local Vector Z;
    local Vector NewAccel;
    local float DecelRate;
    local float HiDecelRate;
  
    HiDecelRate = 0.2;
    DecelRate = 2.5;
    if ( (Abs(bBroomPitchUp) > 0.05) || (Abs(bBroomPitchDown) > 0.05) )
    {
      if ( ePitchControlDevice == DEVICE_Mouse )
      {
        fMousePitch = 0.0;
      }
      // ePitchControlDevice = 0;
	  ePitchControlDevice = DEVICE_Button;
    } else //{
      if ( Abs(aJoyBroomPitch) > 0.05 )
      {
        if ( ePitchControlDevice == DEVICE_Mouse )
        {
          fMousePitch = 0.0;
        }
        // ePitchControlDevice = 2;
		ePitchControlDevice = DEVICE_Joystick;
      } else //{
        if ( bAllowBroomMouse && (Abs(aBroomPitch) > 0.05) )
        {
          // ePitchControlDevice = 1;
		  ePitchControlDevice = DEVICE_Mouse;
        }
      //}
    //}
    if ( (Abs(bBroomYawLeft) > 0.05) || (Abs(bBroomYawRight) > 0.05) )
    {
      if ( eYawControlDevice == DEVICE_Mouse )
      {
        fMouseYaw = 0.0;
      }
      // eYawControlDevice = 0;
	  eYawControlDevice = DEVICE_Button;
    } else //{
      if ( Abs(aJoyBroomYaw) > 0.05 )
      {
        if ( eYawControlDevice == DEVICE_Mouse )
        {
          fMouseYaw = 0.0;
        }
        // eYawControlDevice = 2;
		eYawControlDevice = DEVICE_Joystick;
      } else //{
        if ( bAllowBroomMouse && (Abs(aBroomYaw) > 0.05) )
        {
          // eYawControlDevice = 1;
		  eYawControlDevice = DEVICE_Mouse;
        }
      //}
    //}
    switch (ePitchControlDevice)
    {
      // case 1:
	  case DEVICE_Mouse:
		  if ( bInvertBroomPitch )
		  {
			fMousePitch += aBroomPitch * fBroomSensitivity;
		  } else {
			fMousePitch -= aBroomPitch * fBroomSensitivity;
		  }
		  if ( fMousePitch > 1.5 )
		  {
			fMousePitch = 1.5;
		  } else //{
			if ( fMousePitch < -1.5 )
			{
			  fMousePitch = -1.5;
			}
		  //}
		  break;
      // case 2:
	  case DEVICE_Joystick:
		  if ( bInvertBroomPitch )
		  {
			fPitchControl = aJoyBroomPitch * fJoyBroomSensitivity;
		  } else {
			fPitchControl =  -aJoyBroomPitch * fJoyBroomSensitivity;
		  }
		  break;
      // case 0:
	  case DEVICE_Button:
		  fPitchControl = 1.0 * bBroomPitchUp - 1.0 * bBroomPitchDown;
		  if ( bInvertBroomPitch )
		  {
			fPitchControl =  -fPitchControl;
		  }
		  break;
      default:
		  fPitchControl = 0.0;
		  break;
    }
    switch (eYawControlDevice)
    {
      // case 1:
	  case DEVICE_Mouse:
		  fMouseYaw += aBroomYaw * fBroomSensitivity;
		  //KW left this if statement empty? -AdamJD
		  // if (! Abs(aBroomYaw) > 0.05 ) goto JL028F;
		  if ( fMouseYaw > 1.5 )
		  {
			fMouseYaw = 1.5;
		  } else //{
			if ( fMouseYaw < -1.5 )
			{
			  fMouseYaw = -1.5;
			}
		  //}
		  if ( fMouseYaw > 0.5 )
		  {
			fYawControl = fMouseYaw - 0.31;
		  } else //{
			if ( fMouseYaw < -0.5 )
			{
			  fYawControl = fMouseYaw + 0.31;
			} else {
			  fYawControl = 0.0;
			}
		  //}
		  break;
      // case 2:
	  case DEVICE_Joystick:
		  fYawControl = aJoyBroomYaw * fJoyBroomSensitivity;
		  break;
      // case 0:
	  case DEVICE_Button:
		  fYawControl = 1.0 * bBroomYawRight - 1.0 * bBroomYawLeft;
		  break;
      default:
		  fYawControl = 0.0;
		  break;
    }
    UpdateRotation(DeltaTime,1.0);
    GetAxes(Rotation,X,Y,Z);
    Acceleration = 200000.0 * X;
    if ( (bBroomBoost != 0 || bAuxBoost) && (bBroomBrake == 0) )
    {
      AirSpeed = AirSpeedBoost;
    } else {
      if ( (Abs(fYawControl) > 0.2) || (bBroomBrake != 0) )
      {
        if ( Deceleration < AirSpeedNormal / 2 )
        {
          Deceleration += ((AirSpeedNormal / 2) / DecelRate) * DeltaTime;
        }
      }
	  else
	  {
		  if ( Deceleration > 0 )
		  {
			if ( Deceleration > 0.41 * AirSpeedNormal )
			{
			  Deceleration -= ((AirSpeedNormal / 2) / HiDecelRate) * DeltaTime;
			}
			else
			{
			  Deceleration -= ((AirSpeedNormal / 2) / DecelRate) * DeltaTime;
			}		
			if ( Deceleration < 0 )
			{
			  Deceleration = 0;
			}
		  }
	  }
      AirSpeed = AirSpeedNormal - Deceleration;
    }
    UpdateBroomSound();
  }
  
  function UpdateRotation (float DeltaTime, float maxPitch)
  {
    local Rotator NewRotation;
    local float YawVal;
    local float DeltaYaw;
    local int nDeltaYaw;
    local float DeltaPitch;
    local float fPitchLimitHi;
    local float fPitchLimitLo;
    local float fEffectiveMousePitch;
  
    NewRotation = Rotation;
    fPitchLimitHi = PitchLimitUp * (16384 / 90.0);
    fPitchLimitLo = 65536.0 - (PitchLimitDown * 16384 / 90.0);
    switch (ePitchControlDevice)
    {
      // case 1:
	  case DEVICE_Mouse:
		  if ( fMousePitch > 0.151 )
		  {
			fEffectiveMousePitch = fMousePitch - 0.151;
			if ( fEffectiveMousePitch > 1.0 )
			{
			  fEffectiveMousePitch = 1.0;
			}
		  } else //{
			if ( fMousePitch < -0.151 )
			{
			  fEffectiveMousePitch = fMousePitch + 0.151;
			  if ( fEffectiveMousePitch < -1.0 )
			  {
				fEffectiveMousePitch = -1.0;
			  }
			} else {
			  fEffectiveMousePitch = 0.0;
			}
		  //}
		  if ( (fEffectiveMousePitch < 0.0) &&  !bLastPitchNeg )
		  {
			NoteAnotherReversal();
			bLastPitchNeg = True;
		  } else //{
			if ( (fEffectiveMousePitch > 0.0) && bLastPitchNeg )
			{
			  NoteAnotherReversal();
			  bLastPitchNeg = False;
			}
		  //}
		  NewRotation.Pitch = fEffectiveMousePitch * fPitchLimitHi;
		  NewRotation.Pitch = NewRotation.Pitch & 65535;
		  break;
      // case 2:
	  case DEVICE_Joystick:
		  if ( (fPitchControl < 0.0) &&  !bLastPitchNeg )
		  {
			NoteAnotherReversal();
			bLastPitchNeg = True;
		  } else //{
			if ( (fPitchControl > 0.0) && bLastPitchNeg )
			{
			  NoteAnotherReversal();
			  bLastPitchNeg = False;
			}
		  //}
		  NewRotation.Pitch += RotationRate.Pitch * DeltaTime * fPitchControl;
		  NewRotation.Pitch = NewRotation.Pitch & 65535;
		  if ( (NewRotation.Pitch > fPitchLimitHi) && (NewRotation.Pitch < fPitchLimitLo) )
		  {
			if ( fPitchControl > 0 )
			{
			  NewRotation.Pitch = fPitchLimitHi;
			}
			else
			{
			  NewRotation.Pitch = fPitchLimitLo;
			}
		  }
		  break;
      // case 0:
	  case DEVICE_Button:
		  if ( (fPitchControl < 0.0) &&  !bLastPitchNeg )
		  {
			NoteAnotherReversal();
			bLastPitchNeg = True;
		  } else //{
			if ( (fPitchControl > 0.0) && bLastPitchNeg )
			{
			  NoteAnotherReversal();
			  bLastPitchNeg = False;
			}
		  //}
		  if ( Abs(fPitchControl) < 0.05 )
		  {
			if ( Rotation.Pitch >= 32768 )
			{
			  DeltaPitch = 65536.0 - Rotation.Pitch;
			} else {
			  DeltaPitch = Rotation.Pitch;
			}
			fPitchControl = DeltaPitch / (RotationRate.Pitch * DeltaTime);
			if ( fPitchControl > 1.0 )
			{
			  fPitchControl = 1.0;
			}
			if ( Rotation.Pitch < 32768 )
			{
			  fPitchControl =  -fPitchControl;
			}
		  }
		  NewRotation.Pitch += RotationRate.Pitch * DeltaTime * fPitchControl;
		  NewRotation.Pitch = NewRotation.Pitch & 65535;
		  if ( (NewRotation.Pitch > fPitchLimitHi) && (NewRotation.Pitch < fPitchLimitLo) )
		  {
			if ( fPitchControl > 0 )
			{
			  NewRotation.Pitch = fPitchLimitHi;
			}
			else
			{
			  NewRotation.Pitch = fPitchLimitLo;
			}
		  }
		  break;
      default:
    }
    if ( (fYawControl < 0.0) &&  !bLastYawNeg )
    {
      NoteAnotherReversal();
      bLastYawNeg = True;
    } else //{
      if ( (fYawControl > 0.0) && bLastYawNeg )
      {
        NoteAnotherReversal();
        bLastYawNeg = False;
      }
    //}
    if ( Abs(fYawControl) < 0.05 )
    {
      if ( bHittingWall )
      {
        fYawControl = WallAvoidanceYaw * fWallAvoidanceRate / (fRotationRateYaw * DeltaTime);
        fLastTimeAvoidedWall = Level.TimeSeconds;
      }
    } else {
      fLastTimeAvoidedWall = -1.0;
    }
    bHittingWall = False;
    if ( fYawControl > 1.0 )
    {
      fYawControl = 1.0;
    } else //{
      if ( fYawControl < -1.0 )
      {
        fYawControl = -1.0;
      }
    //}
    YawVal = fRotationRateYaw * DeltaTime * fYawControl;
    if ( Acceleration == vect(0.00,0.00,0.00) )
    {
      YawVal = 4.0 / 3.0 * YawVal;
    }
    ViewRotation.Yaw += YawVal;
	ViewShake(DeltaTime);
    NewRotation.Yaw = ViewRotation.Yaw;
    SetRotation(NewRotation);
    DesiredRotation = Rotation;
  }
  
  function HitWall (Vector HitNormal, Actor Wall)
  {
    local Vector WallFaceDir;
    local Rotator WallFaceRot;
    local Vector Up;
    local Vector FlightDir;
    local float fSpeed;
    local int EffectiveDamage;
    local float fVolume;
    local bool bTurnToRight;
  
    if ( HitNormal.Z < -0.99989998 )
    {
      return;
    }
    if (  !bHitWall )
    {
      bHitWall = True;
      fSpeed = VSize(Velocity);
      fVolume = fSpeed / AirSpeedNormal;
      PlaySound(HitSounds[Rand(3)],SLOT_Interact,fVolume,,,RandRange(0.81,1.25));
      if ( WallDamage > 0 )
      {
        EffectiveDamage = (WallDamage * fSpeed) / AirSpeedNormal;
		if ( !bInvincible && (EffectiveDamage > 0) )
        {
          PlaySound(HurtSound[Rand(15)],SLOT_Talk,,True);
          AddHealth(-EffectiveDamage);
          if ( GetHealthCount() <= 0.0 )
          {
            KillHarry(True);
          }
        }
      }
      StopHeadLook();
      WatchTarget = None;
      PlayAnim('Bump',,0.1);
      if ( Director != None )
      {
        Director.OnHitEvent(self);
      }
    }
    if ( Abs(HitNormal.Z) >= 0.9851 )
    {
      return;
    } else {
      fWallAvoidanceRate = 1.0 - Abs(HitNormal.Z) / 0.9851;
    }
    vDodgeVel = GetDodgeVelFromHitwall(self,HitNormal,LookForTarget);
    bHittingWall = True;
  }
  
  function Bump (Actor Other)
  {
    //local Pawn Target;
	local Pawn pTarget;
  
    pTarget = Pawn(Other);
    if ( (!bHit && !pTarget.IsA('QuidditchPlayer')) && !pTarget.IsA('Bludger') )
    {
      PlayAnim('React');
      if ( pTarget.IsA('QuidGoal') )
      {
        PlaySound(Sound'Q_BRM_HitPole_01',SLOT_Interact,0.69999999,,1000.0,RandRange(0.81,1.25));
      } else {
        PlaySound(HitSounds[Rand(3)],SLOT_Interact,0.69999999,,1000.0,RandRange(0.81,1.25));
      }
      Velocity = vect(0.00,0.00,1.00);
      bHit = True;
      if ( !bInvincible )
      {
        AddHealth(-WallDamage);
      }
      if ( Director != None )
      {
        Director.OnBumpEvent(self,Other);
      }
    }
  }
  
  event Timer()
  {
    PlayAnim('Look',,1.0);
    SetTimer(FRand() * 4.0 + 1.5,False);
  }
  
  function AnimEnd()
  {
    if ( PrimaryAnim != 'None' )
    {
      LoopAnim(PrimaryAnim,,1.0);
    }
    if ( SecondaryAnim != 'None' )
    {
      LoopAnim(SecondaryAnim,,1.0);
    }
    bHitWall = False;
    bHit = False;
  }
  
}

function Vector GetDodgeVelFromHitwall (Actor aSelf, Vector vHitNormal, Actor LFT)
{
  local Vector vVel;
  local Vector V;

  if ( LFT.IsA('Snitch') )
  {
    V = Snitch(LFT).GetTargetVector(aSelf.Location,300.0);
  } else {
    V = LFT.Location;
  }
  V = Normal(V - aSelf.Location);
  vVel = (V + vHitNormal * 0.81) / 2;
  if ( vVel.Z > 0 )
  {
    vVel.Z = Abs(vVel.X) + Abs(vVel.Y) / 2;
  } else {
    vVel.Z =  -Abs(vVel.X) + Abs(vVel.Y) / 2;
  }
  vVel = Normal(vVel);
  return vVel;
}

state stateCutIdle
{
  ignores  Mount, AltFire;
  
  function BeginState()
  {
    ClientMessage("BroomHarry: Entered " $ string(GetStateName()) $ " State");
    Log("BroomHarry: Entered " $ string(GetStateName()) $ " State");
    AirSpeed = 0.0;
  }
  
  event PlayerTick (float DeltaTime)
  {
    Super.PlayerTick(DeltaTime);
    DeterminePrimaryAnim();
    UpdateBroomSound();
  }
  
  function AnimEnd()
  {
    if ( PrimaryAnim != 'None' )
    {
      LoopAnim(PrimaryAnim,,1.0);
    }
    if ( SecondaryAnim != 'None' )
    {
      LoopAnim(SecondaryAnim,,1.0);
    }
  }
  
}

state FlyingOnPath
{
  ignores  Mount, AltFire;
  
  function BeginState()
  {
    ClientMessage("BroomHarry: Entered " $ string(GetStateName()) $ " State");
    Log("BroomHarry: Entered " $ string(GetStateName()) $ " State");
  }
  
  event PlayerTick (float DeltaTime)
  {
    Super.PlayerTick(DeltaTime);
    ViewRotation = Rotation;
    DeterminePrimaryAnim();
    UpdateBroomSound();
  }
  
  function AnimEnd()
  {
    if ( PrimaryAnim != 'None' )
    {
      LoopAnim(PrimaryAnim,,1.0);
    }
    if ( SecondaryAnim != 'None' )
    {
      LoopAnim(SecondaryAnim,,1.0);
    }
  }
  
  event FinishedInterpolation (InterpolationPoint Other)
  {
    if ( IM != None )
    {
      IM = None;
      if ( CutCommandCue != "" )
      {
        CutCue(CutCommandCue);
        CutCommandCue = "";
        GotoState('stateCutIdle');
      }
    }
  }
  
}

state Pursue
{
  ignores  Mount, AltFire;
  
  function BeginState()
  {
    ClientMessage("BroomHarry: Entered " $ string(GetStateName()) $ " State");
    Log("BroomHarry: Entered " $ string(GetStateName()) $ " State");
  }
  
  event PlayerTick (float DeltaTime)
  {
    local Vector TargetDir;
    local Vector X;
    local Vector Y;
    local Vector Z;
  
    Super.PlayerTick(DeltaTime);
    if ( (LookForTarget == None) || LookForTarget.bHidden )
    {
      GotoState('PlayerWalking');
    }
    TargetDir = LookForTarget.Location - Location;
    DesiredRotation = rotator(TargetDir);
    GetAxes(Rotation,X,Y,Z);
    Acceleration = 200000.0 * X;
    if ( VSize(TargetDir) < 150.0 )
    {
      AirSpeed = VSize(LookForTarget.Velocity) * 1.0;
    } else //{
      if ( VSize(TargetDir) < 300.0 )
      {
        AirSpeed = VSize(LookForTarget.Velocity) * 1.25;
      } else {
        AirSpeed = VSize(LookForTarget.Velocity) * 1.89999998;
      }
    //}
    DesiredSpeed = AirSpeed;
    ViewRotation = Rotation;
    DeterminePrimaryAnim();
    UpdateBroomSound();
  }
  
  function EndState()
  {
    ClientMessage("BroomHarry: End Pursue");
    Log("BroomHarry: End Pursue");
  }
  
}

state Hit
{
  ignores  Mount, AltFire;
  
  function BeginState()
  {
    ClientMessage("BroomHarry: Entered " $ string(GetStateName()) $ " State");
    Log("BroomHarry: Entered " $ string(GetStateName()) $ " State");
  }
  
  event PlayerTick (float DeltaTime)
  {
    Super.PlayerTick(DeltaTime);
    UpdateBroomSound();
  }
  
begin:
  PlayAnim('Bump');
  FinishAnim();
  bHitWall = False;
  GotoState('PlayerWalking');
}

state BroomDying
{
  ignores  Mount, AltFire;
  
  function BeginState()
  {
    ClientMessage("BroomHarry: Entered " $ string(GetStateName()) $ " State");
    Log("BroomHarry: Entered " $ string(GetStateName()) $ " State");
  }
  
  event PlayerTick (float DeltaTime)
  {
    Super.PlayerTick(DeltaTime);
    UpdateBroomSound();
  }
  
  function Landed (Vector HitNormal)
  {
    Director.OnPlayersDeath();
    SetTimer(0.0,False);
  }
  
  function Timer()
  {
    Director.OnPlayersDeath();
  }
  
  function AnimEnd()
  {
  }
  
begin:
  PlayAnim('Fall');
  FinishAnim();
  Director.OnPlayerDying();
  LoopAnim('Hang');
  // SetPhysics(2);
  SetPhysics(PHYS_Falling);
  SetTimer(10.0,False);
loop:
  Sleep(0.1);
  goto ('Loop');
}

state Catching
{
  ignores  Mount, AltFire;
  
  function BeginState()
  {
    ClientMessage("BroomHarry: Entered " $ string(GetStateName()) $ " State");
    Log("BroomHarry: Entered " $ string(GetStateName()) $ " State");
    fTargetTrackHorzOffset = 0.0;
    fTargetTrackVertOffset = 0.0;
  }
  
  event PlayerTick (float DeltaTime)
  {
    local Vector X;
    local Vector Y;
    local Vector Z;
  
    if (  !bCaughtTarget || (PathAfterCatch == 'None') )
    {
      PlayerTrack(DeltaTime);
    }
  }
  
  function EndState()
  {
    ClientMessage("BroomHarry: Exited " $ string(GetStateName()) $ " State");
    Log("BroomHarry: Exited " $ string(GetStateName()) $ " State");
    SetSecondaryAnimation('None');
  }
  
  event FinishedInterpolation (InterpolationPoint Other)
  {
    if ( IM != None )
    {
      IM = None;
      IPSpeed = 900.0;
      FlyOnPath(PathAfterCatch,iTransPoint);
    }
  }
  
  function DoCatch()
  {
    local Actor ActualTarget;
  
    if ( LookForTarget.IsA('Snitch') )
    {
      ActualTarget = Snitch(TargetToCatch).CreateCatchProxy();
    } else {
      ActualTarget = LookForTarget;
    }
    // ActualTarget.SetPhysics(11);
	ActualTarget.SetPhysics(PHYS_Trailer);
    ActualTarget.SetOwner(self);
    ActualTarget.AttachToOwner('RightHand');
    ActualTarget.bTrailerPrePivot = True;
    ActualTarget.PrePivot = vect(3.00,-3.00,0.00);
    bCaughtTarget = True;
  }
  
begin:
  PlayAnim('Catch',,0.1);
  PlaySound(Sound'Q_snitch_catch',SLOT_Interact);
  Sleep(25.0 / 30.0);
  DoCatch();
  if ( PathAfterCatch != 'None' )
  {
    if (  !GetOnPath(PathAfterCatch) )
    {
      Log("BroomHarry failed to get on path " $ string(PathAfterCatch) $ " after catch");
    }
  }
  FinishAnim();
  SetSecondaryAnimation('Hold',,0.1);
loop:
  Sleep(0.1);
  goto ('Loop');
}

defaultproperties
{
    AirSpeedNormal=400

    AirSpeedBoost=800

    PitchLimitUp=60

    PitchLimitDown=60

    WallDamage=5

    ArmorDamageScale=0.50

    TrackingOffsetRange_Horz=100.00

    TrackingOffsetRange_Vert=75.00

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

    ShadowClass=Class'HPModels.BroomShadow'

    MaxMountHeight=0.00

    Mesh=SkeletalMesh'HPModels.skharryquidMesh'

    CollisionRadius=18.00

    CollisionHeight=32.00

    bAlignBottomAlways=True

    RotationRate=(Pitch=24000,Yaw=50000,Roll=6000)
}
