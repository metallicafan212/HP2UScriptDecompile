//================================================================================
// FlyingCarHarry.
//================================================================================

//this is an unused file -AdamJD

class FlyingCarHarry extends BroomHarry
  Config(User);

var Vector vCurrentTetherDistance;
var() float strafeSpeed;
var() float updownSpeed;
var() float rollAmount;
var() float pitchAmount;
var() float yawAmount;
var() float MaxDistanceToSide;
var() float MaxDistanceUpDown;
var() float AirSpeedNormal;
var() float AirSpeedBoost;
var() name PathName;
var Rotator guideRotation;
var float sideDistance;
var float upDistance;
var FlyingFordPathGuide guide;
var Vector vTurbulence;
var float fLightningYaw;
var float fLightningPitch;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  foreach AllActors(Class'Director',Director)
  {
    // goto JL001A;
	break;
  }
}

function PostBeginPlay()
{
  Super.PostBeginPlay();
  PrimaryAnim = 'Flying';
  SecondaryAnim = 'None';
  LoopAnim(PrimaryAnim);
  LookForTarget = None;
  bLookingForTarget = False;
  fRotationRateYaw = 20000.0;
  RotationRate.Yaw = 20000;
  RotationRate.Roll = 10000;
  RotationRate.Pitch = 20000;
  vCurrentTetherDistance = Vec(0.0,0.0,0.0);
}

event Possess()
{
  Super.Possess();
  Log("BroomHarry in State " $ string(GetStateName()) $ ".");
  Director.OnPlayerPossessed();
  SetLocation(guide.Location);
  SetRotation(guide.Rotation);
}

function DeterminePrimaryAnim()
{
  local float Speed;

  Speed = VSize(Velocity);
  SetPrimaryAnimation('Flying',,1.0);
  Trail.ParentBlend = Min(Speed / 200, 1);
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
      fPitch = 0.2 * (fSpeedFactor + 1.5);
    } else {
      fSpeedFactor = (fSpeed - AirSpeedNormal) / (AirSpeedBoost - AirSpeedNormal);
      fVolume = 0.41 * (fSpeedFactor + 0.62);
      fPitch = 0.151 * (fSpeedFactor + 1.75);
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
  if (  !ModifySound(SOUND_Volume,fTurnFactor,MainBroomSound,SLOT_Interact) )
  {
    PlaySound(MainBroomSound,SLOT_Interact,fTurnFactor,True,,1.0);
  }
  if (  !ModifySound(SOUND_Volume,fVolume,BroomSound,SLOT_Misc) )
  {
    PlaySound(BroomSound,SLOT_Misc,fVolume,True,,fPitch);
  } else {
    ModifySound(SOUND_Pitch,fPitch,BroomSound,SLOT_Misc);
  }
}

function Vector SideDirection (float fYawControl)
{
  local Vector vGuideDirection;
  local Vector vUp;
  local Vector vDown;
  local Vector vRight;
  local Vector vLeft;

  vGuideDirection = vector(guide.Rotation);
  vUp = Vec(0.0,0.0,1.0);
  vDown = Vec(0.0,0.0,-1.0);
  vLeft = vGuideDirection Cross vDown;
  return vLeft;
}

state PlayerWalking
{
  ignores  Mount, AltFire;
  
  function BeginState()
  {
    Super.BeginState();
    // SetPhysics(4);
	SetPhysics(PHYS_Flying);
    // Cam.SetCameraMode(5);
	Cam.SetCameraMode(CM_FlyingCar);
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
    local Vector MovementDirection;
    local float CarYawVal;
  
    NewRotation = Rotation;
    fPitchLimitHi = PitchLimitUp * (16384 / 90.0);
    fPitchLimitLo = 65536.0 - (PitchLimitDown * (16384 / 90.0));
    if ( False )
    {
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
    } else {
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
        fPitchControl = (DeltaPitch / RotationRate.Pitch) * DeltaTime;
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
      if ( (NewRotation.Pitch > fPitchLimitHi) && (NewRotation.Pitch < fPitchLimitLo) )
	  {
        if ( fPitchControl > 0 )
        {
          NewRotation.Pitch = fPitchLimitHi;
		} else {
		  NewRotation.Pitch = fPitchLimitLo;
		}
      }
    }
	if ( (fYawControl < 0.0) &&  !bLastYawNeg )
    {
        NoteAnotherReversal();
        bLastYawNeg = True;
    }   else //{
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
        fYawControl = WallAvoidanceYaw * (fWallAvoidanceRate / fRotationRateYaw) * DeltaTime;
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
      YawVal = (4.0 / 3.0) * YawVal;
    }
    CarYawVal = 4096.0 * fYawControl;
    sideDistance += YawVal / strafeSpeed;
    if ( NewRotation.Pitch != 0 )
    {
      if ( NewRotation.Pitch > 32768 )
      {
        upDistance += (NewRotation.Pitch - 65535) / updownSpeed;
      } else {
        upDistance += NewRotation.Pitch / updownSpeed;
      }
    }
    if ( sideDistance > MaxDistanceToSide )
    {
      sideDistance = MaxDistanceToSide;
      CarYawVal = 0.0;
    }
    if ( sideDistance <  -MaxDistanceToSide )
    {
      sideDistance =  -MaxDistanceToSide;
      CarYawVal = 0.0;
    }
    if ( upDistance > MaxDistanceUpDown )
    {
      upDistance = MaxDistanceUpDown;
    }
    if ( upDistance <  -MaxDistanceUpDown )
    {
      upDistance =  -MaxDistanceUpDown;
    }
    MovementDirection = SideDirection(fYawControl);
    vCurrentTetherDistance.X = sideDistance * MovementDirection.X;
    vCurrentTetherDistance.Y = sideDistance * MovementDirection.Y;
    vCurrentTetherDistance.Z = upDistance;
    vCurrentTetherDistance += vTurbulence;
    SetLocation(guide.Location + vCurrentTetherDistance);
    NewRotation.Pitch += (pitchAmount * fPitchControl);
    guideRotation = guide.Rotation;
    guideRotation.Yaw += CarYawVal;
    guideRotation.Yaw += fLightningYaw;
    if ( AirSpeed == AirSpeedNormal )
    {
      guide.IPSpeed = 0.0;
    } else {
      guide.IPSpeed = AirSpeedBoost;
    }
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
      if (WallDamage > 0 )
	  {
		//KW left this empty? -AdamJD
	  }
      Director.OnHitEvent(self);
    }
    if ( Abs(HitNormal.Z) >= 0.9851 )
    {
      return;
    } else {
      fWallAvoidanceRate = 1.0 - (Abs(HitNormal.Z) / 0.9851);
    }
    Up.X = 0.0;
    Up.Y = 0.0;
    Up.Z = 1.0;
    WallFaceDir = HitNormal Cross Up;
    WallFaceRot = rotator(WallFaceDir);
    FlightDir = vector(Rotation);
    if ( (fLastTimeAvoidedWall != -1.0) && (Level.TimeSeconds - fLastTimeAvoidedWall < 1.0) )
    {
      bTurnToRight = bLastAvoidanceRight;
    } else {
      bTurnToRight = (FlightDir Dot WallFaceDir) >= 0.0;
      bLastAvoidanceRight = bTurnToRight;
    }
    if ( bTurnToRight )
    {
      WallAvoidanceYaw = (WallFaceRot.Yaw + 1000 - Rotation.Yaw) & 65535;
      if ( WallAvoidanceYaw > 24576 )
      {
        WallAvoidanceYaw = 24576;
      }
    } else {
      WallAvoidanceYaw = (WallFaceRot.Yaw + 32768 - 1000 - Rotation.Yaw) & 65535;
      if ( WallAvoidanceYaw < 40960 )
      {
        WallAvoidanceYaw = 40960;
      }
      WallAvoidanceYaw -= 65536;
    }
    bHittingWall = True;
  }
  
  event Timer()
  {
  }
  
}

defaultproperties
{
    strafeSpeed=100.00

    updownSpeed=150.00

    rollAmount=3.00

    pitchAmount=9.00

    yawAmount=8.00

    MaxDistanceToSide=1000.00

    MaxDistanceUpDown=75.00

    AirSpeedNormal=800.00

    AirSpeedBoost=800.00

    PitchLimitUp=45

    PitchLimitDown=45

    WallDamage=1

    IdleAnimName=''

    Mesh=SkeletalMesh'HPModels.skFordFlyingMesh'

    bAlignBottom=False

    RotationRate=(Pitch=24000,Yaw=150000,Roll=6000)
}
