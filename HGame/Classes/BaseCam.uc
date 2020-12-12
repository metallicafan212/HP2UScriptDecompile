//================================================================================
// BaseCam.
//================================================================================

class BaseCam extends HPawn;  

const DISTANCE_SCALAR_MIN= 0.15; 
const PITCH_MOVING_IN_SPREAD= 10000.0;
const PITCH_MOVING_IN_THRESHOLD= 0.0;
const MAX_MOUSE_DELTA_Y=  10000.0;
const MIN_MOUSE_DELTA_Y= -10000.0;
const MAX_MOUSE_DELTA_X=  20000.0;
const MIN_MOUSE_DELTA_X= -20000.0; 
const USE_DEBUG_MODE= true;
const NUM_USER_SETTINGS= 4;
enum ECamMode 
{
	CM_Startup,
	CM_Idle,
	CM_Transition,
	CM_Standard,
	CM_Quidditch,
	CM_FlyingCar,
	CM_Dueling,
	CM_CutScene,
	CM_Boss,
	CM_Free
};
struct CamSettings
{
	var Vector vLookAtOffset;
	var float fLookAtDistance;
	var float fRotTightness;
	var float fRotSpeed;
	var float fMoveTightness;
	var float fMoveSpeed;
};
var float fMouseDeltaX;
var float fMouseDeltaY;
var ECamMode CameraMode;
var ECamMode CameraModeTransition;
var bool bSyncRotationWithTarget;
var bool bSyncPositionWithTarget;
var bool bIgnoreTarget;
var BaseCamTarget CamTarget;
var Vector vForward;
var Rotator rRotationStep;
var Rotator rDestRotation;
var Vector vDestPosition;
var Rotator rCurrRotation;
var Vector vCurrPosition;
var float fDestLookAtDistance;
var float fCurrLookAtDistance;
var float fMoveBackTightness;
var float fCurrentMinPitch;
var float fCurrentMaxPitch;
var CamSettings CurrentSet;
var Rotator rBossRotationOffset;
var Rotator rExtraRotation;
var CamSettings CamSetStandard;
var CamSettings CamSetQuidditch;
var CamSettings CamSetFlyingCar;
var CamSettings CamSetCutScene;
var CamSettings CamSetDueling;
var CamSettings CamSetFree;
var CamSettings CamSetBoss;
var CamSettings UserSettings[4];
var Rotator rSavedRotation;
var Vector vSavedPosition;
var float fPitchMovingInThreshold;
var float fPitchMovingInSpread;
var float fDistanceScalar;
var float fDistanceScalarMin;
var() int MaxBossAimRot;
var ECamMode LastCamMode;
var string cue;

function float ConvertRotToDeg	( int iRot )		
{
	return ((float(iRot & 0xFFFF)) / 65536.0) * 360.0; 
}

function float ConvertDegToRot	( float fDeg )		
{ 
	return (fDeg / 360.0) * 65536.0; 
}

function SetYaw (float fYaw)
{
	rDestRotation.Yaw = fYaw;
}

function SetPitch (float fPitch)
{
	rDestRotation.Pitch = fPitch;
}

function SetRoll (float fRoll)
{
	rDestRotation.Roll = fRoll;
}

function SetMinPitch (float fPitch)
{
	fCurrentMinPitch = fPitch;
}

function SetMaxPitch (float fPitch)
{
	fCurrentMaxPitch = fPitch;
}

function SetRotStep (Rotator Step)
{
	rRotationStep = Step;
}

function SetRotStepYaw (float fYaw)
{
	rRotationStep.Yaw = fYaw;
}

function SetRotStepPitch (float fPitch)
{
	rRotationStep.Pitch = fPitch;
}

function SetRotStepRoll (float fRoll)
{
	rRotationStep.Roll = fRoll;
}

function SetMoveBackTightness (float fTight)
{
	fMoveBackTightness = fTight;
}

function SetRotTightness (float fTight)
{
	CurrentSet.fRotTightness = fTight;
}

function SetRotSpeed (float fSpeed)
{
	CurrentSet.fRotSpeed = fSpeed;
}

function SetMoveTightness (float fTight)
{
	CurrentSet.fMoveTightness = fTight;
}

function SetMoveSpeed (float fSpeed)
{
	CurrentSet.fMoveSpeed = fSpeed;
}

function SetDistance (float fDist)
{
	CurrentSet.fLookAtDistance = fDist;
	fCurrLookAtDistance = fDist;
}

function SetTargetActor (name Target)
{
	CamTarget.SetAttachedToByName(Target);
}

function SetOffset (Vector V)
{
	CamTarget.SetOffset(V);
}

function SetXOffset (float X)
{
	CamTarget.SetXOffset(X);
}

function SetYOffset (float Y)
{
	CamTarget.SetYOffset(Y);
}

function SetZOffset (float Z)
{
	CamTarget.SetZOffset(Z);
}

function SetModeByString (string Str)
{
	SetCameraMode(GetModeFromString(Str));
}

function SetSyncPosWithTarget (bool bSyncPos)
{
	bSyncPositionWithTarget = bSyncPos;
}

function SetSyncRotWithTarget (bool bSyncRot)
{
	bSyncRotationWithTarget = bSyncRot;
}

function SetFOV (float fFOV, optional float fTime, optional bool bEaseTo)
{
	local FOVController FOVControl;

	FOVControl = Spawn(Class'FOVController');
	FOVControl.Init(fFOV,fTime,bEaseTo);
}

function SetPosition (Vector Pos)
{
	if ( bSyncPositionWithTarget )
	{
		CurrentSet.fLookAtDistance = VSize(CamTarget.Location - Location);
		rDestRotation = Rotation;
		rCurrRotation = Rotation;
		vDestPosition = Location;
		vCurrPosition = Location;
		CurrentSet.fLookAtDistance = VSize(CamTarget.Location - Pos);
		rDestRotation = rotator(Normal(CamTarget.Location - Pos));
	} 
	else 
	{
		vDestPosition = Pos;
	}
}

/*
function ECamMode GetModeFromString (string Str)
{
  switch (Str)
  {
    case "Startup":
    return 0;
    case "Idle":
    return 1;
    case "Transition":
    return 2;
    case "Standard":
    return 3;
    case "FlyingCar":
    return 5;
    case "Quidditch":
    return 4;
    case "Dueling":
    return 6;
    case "CutScene":
    return 7;
    case "Boss":
    return 8;
    case "Free":
    return 9;
    default:
  }
  return 3;
}
*/

// convert a string into the CamType enum, used for console commands
function ECamMode GetModeFromString( string str )
{
	switch( str )
	{
		case "Startup":		return CM_Startup;
		case "Idle":		return CM_Idle;
		case "Transition":	return CM_Transition;
		
		case "Standard":	return CM_Standard;
		case "FlyingCar":	return CM_FlyingCar;
		case "Quidditch":	return CM_Quidditch;
		case "Dueling":		return CM_Dueling;
		case "CutScene":	return CM_CutScene;
		case "Boss":		return CM_Boss;
		
		case "Free":		return CM_Free;

		default:			return CM_Standard;
	}
}

/*
function SetCameraMode (ECamMode eMode)
{
  switch (eMode)
  {
    case 0:
    LastCamMode = CameraMode;
    CameraMode = eMode;
    GotoState('StateStartup');
    break;
    case 1:
    LastCamMode = CameraMode;
    CameraMode = eMode;
    GotoState('stateIdle');
    break;
    case 2:
    LastCamMode = CameraMode;
    TransitionToCameraMode(3);
    break;
    case 3:
    LastCamMode = CameraMode;
    CameraMode = eMode;
    GotoState('StateStandardCam');
    break;
    case 5:
    LastCamMode = CameraMode;
    CameraMode = eMode;
    GotoState('StateFlyingCarCam');
    break;
    case 4:
    LastCamMode = CameraMode;
    CameraMode = eMode;
    GotoState('StateQuidditchCam');
    break;
    case 6:
    LastCamMode = CameraMode;
    CameraMode = eMode;
    GotoState('StateDuelingCam');
    break;
    case 7:
    LastCamMode = CameraMode;
    CameraMode = eMode;
    GotoState('StateCutSceneCam');
    break;
    case 8:
    LastCamMode = CameraMode;
    CameraMode = eMode;
    GotoState('StateBossCam');
    break;
    case 9:
    LastCamMode = CameraMode;
    CameraMode = eMode;
    GotoState('StateFreeCam');
    break;
    default:
    Log("Camera: Trying to set a camera mode that is not supported!!!");
  }
  if ( True )
  {
    PlayerHarry.ClientMessage("CameraMode is: " $ string(CameraMode) $ " with Target:" $ string(CamTarget));
  }
}
*/

function SetCameraMode( ECamMode eMode )
{
	switch( eMode )
	{
		case CM_Startup:	LastCamMode = CameraMode; CameraMode = eMode; GotoState('StateStartup');		break;
		case CM_Idle:		LastCamMode = CameraMode; CameraMode = eMode; GotoState('StateIdle');			break;
		
		// If the user SetCameraMode to Transition, assume the user wants to transition to standard mode
		case CM_Transition:	LastCamMode = CameraMode; TransitionToCameraMode( CM_Standard ); break;
		
		case CM_Standard:	LastCamMode = CameraMode; CameraMode = eMode; GotoState('StateStandardCam');	break;
		case CM_FlyingCar:	LastCamMode = CameraMode; CameraMode = eMode; GotoState('StateFlyingCarCam');	break;
		case CM_Quidditch:	LastCamMode = CameraMode; CameraMode = eMode; GotoState('StateQuidditchCam');	break;
		case CM_Dueling:	LastCamMode = CameraMode; CameraMode = eMode; GotoState('StateDuelingCam');		break;
		case CM_CutScene:	LastCamMode = CameraMode; CameraMode = eMode; GotoState('StateCutSceneCam');	break;
		case CM_Boss:		LastCamMode = CameraMode; CameraMode = eMode; GotoState('StateBossCam');		break;

		case CM_Free:		LastCamMode = CameraMode; CameraMode = eMode; GotoState('StateFreeCam');		break;
		
		
		default: log("Camera: Trying to set a camera mode that is not supported!!!");
	}
	
	//DEBUG
	if(USE_DEBUG_MODE)playerHarry.ClientMessage("CameraMode is: " $CameraMode $" with Target:" $CamTarget );
}

function TransitionToCameraMode (ECamMode eMode)
{
	CameraModeTransition = eMode;
	GotoState('StateTransition');
}

/*
function ShowSettings ()
{
  PlayerHarry.ClientMessage("The current camera settings are:");
  PlayerHarry.ClientMessage("-------------------------------------------");
  PlayerHarry.ClientMessage("LookAtOffset:        " $ string(CurrentSet.vLookAtOffset));
  PlayerHarry.ClientMessage("LookAtDistance:    " $ string(CurrentSet.fLookAtDistance));
  PlayerHarry.ClientMessage("RotTightness:        " $ string(CurrentSet.fRotTightness));
  PlayerHarry.ClientMessage("RotSpeed:             " $ string(CurrentSet.fRotSpeed));
  PlayerHarry.ClientMessage("MoveTightness:     " $ string(CurrentSet.fMoveTightness));
  PlayerHarry.ClientMessage("MoveSpeed:          " $ string(CurrentSet.fMoveSpeed));
  PlayerHarry.ClientMessage("-------------------------------------------");
  PlayerHarry.ClientMessage("Current mode:       " $ string(CameraMode));
  PlayerHarry.ClientMessage("Current pos:          " $ string(vCurrPosition));
  PlayerHarry.ClientMessage("Destination pos:      " $ string(vDestPosition));
  PlayerHarry.ClientMessage("Current rot:           " $ string(rCurrRotation.Yaw) $ " , " $ string(rCurrRotation.Pitch) $ " , " $ string(rCurrRotation.Roll) $ " ");
  PlayerHarry.ClientMessage("Destination rot:      " $ string(rDestRotation.Yaw) $ " , " $ string(rDestRotation.Pitch) $ " , " $ string(rDestRotation.Roll) $ " ");
  PlayerHarry.ClientMessage("fCurrLookAtDistance: " $ string(fCurrLookAtDistance));
  PlayerHarry.ClientMessage("fDestLookAtDistance: " $ string(fDestLookAtDistance));
  PlayerHarry.ClientMessage("SyncRotationWithTarget: " $ string(bSyncRotationWithTarget));
  PlayerHarry.ClientMessage("SyncPositionWithTarget: " $ string(bSyncPositionWithTarget));
  PlayerHarry.ClientMessage("-------------------------------------------");
  PlayerHarry.ClientMessage("CamTarget loc:                   " $ string(CamTarget.Location));
  PlayerHarry.ClientMessage("CamTarget rot:                   " $ string(CamTarget.Rotation));
  PlayerHarry.ClientMessage("CamTarget AttachedTo:       " $ string(CamTarget.aAttachedTo));
  PlayerHarry.ClientMessage("CamTarget Attached loc:     " $ string(CamTarget.aAttachedTo.Location));
  PlayerHarry.ClientMessage("CamTarget attached offset:  " $ string(CamTarget.vOffset));
  PlayerHarry.ClientMessage("CamTarget relative:            " $ string(CamTarget.bRelative));
}

function LoadUserSettings (int I)
{
  if ( I > 4 - 1 )
  {
    if ( True )
    {
      PlayerHarry.ClientMessage("the max user settings index you can have is:" $ string(4 - 1));
    }
    return;
  }
  CurrentSet = UserSettings[I];
  if ( True )
  {
    PlayerHarry.ClientMessage("Loaded user settings from slot " $ string(I));
  }
}

function SaveUserSettings (int I)
{
  if ( I > 4 - 1 )
  {
    if ( True )
    {
      PlayerHarry.ClientMessage("the max user settings index you can have is:" $ string(4 - 1));
    }
    return;
  }
  UserSettings[I] = CurrentSet;
  if ( True )
  {
    PlayerHarry.ClientMessage("Saved user settings into slot " $ string(I));
  }
}
*/

// console command helper function that shows the camera's current settings
function ShowSettings()
{
	playerHarry.ClientMessage("The current camera settings are:");
	playerHarry.ClientMessage("-------------------------------------------");	
	playerHarry.ClientMessage("LookAtOffset:        "	$CurrentSet.vLookAtOffset	);
	playerHarry.ClientMessage("LookAtDistance:    "		$CurrentSet.fLookAtDistance	);
	playerHarry.ClientMessage("RotTightness:        "	$CurrentSet.fRotTightness	);
	playerHarry.ClientMessage("RotSpeed:             "	$CurrentSet.fRotSpeed		);
	playerHarry.ClientMessage("MoveTightness:     "		$CurrentSet.fMoveTightness	);
	playerHarry.ClientMessage("MoveSpeed:          "	$CurrentSet.fMoveSpeed		);
	playerHarry.ClientMessage("-------------------------------------------");
	playerHarry.ClientMessage("Current mode:       "	$CameraMode		);
	playerHarry.ClientMessage("Current pos:          "	$vCurrPosition			);
	playerHarry.ClientMessage("Destination pos:      "	$vDestPosition			);
	playerHarry.ClientMessage("Current rot:           "	
		$(rCurrRotation.Yaw)   $" , "
		$(rCurrRotation.Pitch) $" , "
		$(rCurrRotation.Roll)  $" ");
	playerHarry.ClientMessage("Destination rot:      "	
		$(rDestRotation.Yaw)   $" , "
		$(rDestRotation.Pitch) $" , "
		$(rDestRotation.Roll)  $" ");

	playerHarry.ClientMessage("SyncRotationWithTarget: "	$bSyncRotationWithTarget );
	playerHarry.ClientMessage("SyncPositionWithTarget: "	$bSyncPositionWithTarget );
	
	playerHarry.ClientMessage("-------------------------------------------");
	playerHarry.ClientMessage("CamTarget loc:                   " $CamTarget.location );
	playerHarry.ClientMessage("CamTarget rot:                   " $CamTarget.rotation );
	playerHarry.ClientMessage("CamTarget AttachedTo:       " $CamTarget.aAttachedTo );
	playerHarry.ClientMessage("CamTarget Attached loc:     " $CamTarget.aAttachedTo.location );
	playerHarry.ClientMessage("CamTarget attached offset:  " $CamTarget.vOffset );
	playerHarry.ClientMessage("CamTarget relative:            " $CamTarget.bRelative );
}

function LoadUserSettings( int i )
{
	if( i > NUM_USER_SETTINGS-1 )
	{
		if(USE_DEBUG_MODE)playerHarry.ClientMessage("the max user settings index you can have is:" $(NUM_USER_SETTINGS-1) );
		return;
	}
	
	// load settings
	CurrentSet = UserSettings[i];

	if(USE_DEBUG_MODE)playerHarry.ClientMessage("Loaded user settings from slot " $i);
}

function SaveUserSettings( int i )
{
	if( i > NUM_USER_SETTINGS-1 )
	{
		if(USE_DEBUG_MODE)playerHarry.ClientMessage("the max user settings index you can have is:" $(NUM_USER_SETTINGS-1) );
		return;
	}

	// save settings
	UserSettings[i] = CurrentSet;

	if(USE_DEBUG_MODE)playerHarry.ClientMessage("Saved user settings into slot " $i);
}

function PreBeginPlay ()
{
	SetCollision(False,False,False);
	bCollideWorld = False;
	fPitchMovingInThreshold = PITCH_MOVING_IN_THRESHOLD;
	fPitchMovingInSpread = PITCH_MOVING_IN_SPREAD;
	fDistanceScalarMin = DISTANCE_SCALAR_MIN;
}

function PostBeginPlay ()
{
	Super.PostBeginPlay();
	PlayerHarry = harry(Level.PlayerHarryActor);
	if ( PlayerHarry == None )
	{
		Log("CAMERA CAN NOT FIND HARRY!!!!!!!! in baseCam::PostBeginPlay()");
	}
	if ( CamTarget == None )
	{
		CamTarget = Spawn(Class'BaseCamTarget');
	}
	SetOwner(CamTarget);
	CamTarget.Cam = self;
	if ( CamTarget == None )
	{
		PlayerHarry.ClientMessage("baseCam could not create the hiddenPawn CamTarget!");
		Log("CutSceneCam could not create the hiddenPawn CamTarget!");
	}
}

function InitRotation (Rotator Rot)
{
	rDestRotation.Yaw = Rot.Yaw; //& 65535;
	rDestRotation.Pitch = Rot.Pitch;// & 65535;
	rDestRotation.Roll = Rot.Roll;// & 65535;
	// vForward = Normal(DesiredRotation);
	vForward = normal(vector(DesiredRotation));
	rCurrRotation = rDestRotation;
	DesiredRotation = rDestRotation;
	SetRotation(DesiredRotation);
}

function InitPosition (Vector Pos)
{
	vDestPosition = Pos;
	CheckCollisionWithWorld();
	vCurrPosition = vDestPosition;
	SetLocation(vDestPosition);
}

function InitSettings (CamSettings CamSet, bool bSyncWithTargetPos, bool bSyncWithTargetRot)
{
	CurrentSet = CamSet;
	fDistanceScalar = 1.0;
	rRotationStep = rot(0,0,0);
	rSavedRotation = Rotation;
	bSyncRotationWithTarget = bSyncWithTargetRot;
	bSyncPositionWithTarget = bSyncWithTargetPos;
	fDistanceScalarMin = DISTANCE_SCALAR_MIN;
	fCurrLookAtDistance = CurrentSet.fLookAtDistance;
}

function InitTarget (Actor A)
{
	CamTarget.SetAttachedTo(A);
	CamTarget.SetOffset(CurrentSet.vLookAtOffset);
}

function InitPositionAndRotation (bool bSnapToNewPosAndRot)
{
	if ( bSnapToNewPosAndRot )
	{
		InitRotation(CamTarget.Rotation);
		InitPosition(CamTarget.Location + ((Vec( -CurrentSet.fLookAtDistance,0.0,0.0)) >> rDestRotation));
	} 
	else 
	{
		SetDestRotation(CamTarget.Rotation);
		vDestPosition = CamTarget.Location + ((Vec( -CurrentSet.fLookAtDistance,0.0,0.0)) >> rDestRotation);
		CheckCollisionWithWorld();
	}
	rDestRotation.Roll = 0;
	rCurrRotation.Roll = 0;
}

function UpdateDistance (float fTimeDelta)
{
	/*if ( byte(rCurrRotation.Pitch) > fPitchMovingInThreshold )
	{
		fDistanceScalar = 1.0 - byte(rCurrRotation.Pitch) / fPitchMovingInSpread;*/
	if( rCurrRotation.Pitch > fPitchMovingInThreshold )
	{
		// Calculate our DistanceScalar
		fDistanceScalar = 1.0 - ( rCurrRotation.Pitch / fPitchMovingInSpread );
		if ( fDistanceScalar < fDistanceScalarMin )
		{
			fDistanceScalar = fDistanceScalarMin;
		}	
		fDestLookAtDistance = CurrentSet.fLookAtDistance * fDistanceScalar;
	} 
	else 
	{
		fDestLookAtDistance = CurrentSet.fLookAtDistance;
	}
	if ( (fMoveBackTightness > 0.0) && (fCurrLookAtDistance != fDestLookAtDistance) )
	{
		fCurrLookAtDistance += (fDestLookAtDistance - fCurrLookAtDistance) * FMin(1.0,fMoveBackTightness * fTimeDelta);
	}
}

function UpdateRotationUsingVectors (float fTimeDelta)
{
	local float fTravelScalar;
	local Vector vDestRotation;
	local Vector vCurrRotation;

	// vDestRotation = Normal(rDestRotation);
	vDestRotation = normal(vector(rDestRotation));
	vCurrRotation = vForward;
	if ( bSyncRotationWithTarget )
	{
		vDestRotation = CamTarget.Location - Location;
		vCurrRotation = vDestRotation;
	} 
	else 
	{
		if ( CurrentSet.fRotTightness > 0.0 )
		{
			fTravelScalar = FMin(1.0,CurrentSet.fRotTightness * fTimeDelta);
		} 
		else 
		{
			fTravelScalar = 1.0;
		}
		vCurrRotation += (vDestRotation - vCurrRotation) * fTravelScalar;
	}
	vCurrRotation = Normal(vCurrRotation);
	rCurrRotation = rotator(vCurrRotation);
	vForward = vCurrRotation;
	SetFinalRotation(rotator(vCurrRotation));
}

function ApplyMouseXToDestYaw (float fTimeDelta, optional bool bApplyToBossOffset)
{
	fMouseDeltaX = PlayerHarry.SmoothMouseX * fTimeDelta;
	if ( fMouseDeltaX > MAX_MOUSE_DELTA_X )
	{
		fMouseDeltaX = MAX_MOUSE_DELTA_X;
	} 
	else if ( fMouseDeltaX < MIN_MOUSE_DELTA_X )
    {
		fMouseDeltaX = MIN_MOUSE_DELTA_X;
    }
	
	if (  !bApplyToBossOffset )
	{
		rDestRotation.Yaw  += fMouseDeltaX * CurrentSet.fRotSpeed;
		//rDestRotation.Yaw 	= rDestRotation.Yaw & 65535;
	}
	else
	{
		rBossRotationOffset.Yaw += fMouseDeltaX * CurrentSet.fRotSpeed;
		if( rBossRotationOffset.Yaw >  MaxBossAimRot )
		{
			rBossRotationOffset.Yaw = MaxBossAimRot;
		} 
		else if ( rBossRotationOffset.Yaw <  -MaxBossAimRot )
		{
			rBossRotationOffset.Yaw =  -MaxBossAimRot;
		}
	}
}

function ApplyMouseYToDestPitch (float fTimeDelta, optional bool bApplyToBossOffset)
{
	fMouseDeltaY = PlayerHarry.SmoothMouseY * fTimeDelta;
	if ( PlayerHarry.bInvertMouse )
	{
		fMouseDeltaY =  -fMouseDeltaY;
	}
	if ( fMouseDeltaY > MAX_MOUSE_DELTA_Y )
	{
		fMouseDeltaY = MAX_MOUSE_DELTA_Y;
	} 
	else if ( fMouseDeltaY < MIN_MOUSE_DELTA_Y )
    {
		fMouseDeltaY = MIN_MOUSE_DELTA_Y;
    }
  
  /*
  if (  !bApplyToBossOffset )
  {
    rDestRotation.Pitch += fMouseDeltaY * CurrentSet.fRotSpeed = );
    {
      rDestRotation.Pitch = fCurrentMaxPitch = } else {;
      if ( byte(rDestRotation.Pitch) < fCurrentMinPitch )
      {
        rDestRotation.Pitch = fCurrentMinPitch = goto JL0159;
        // There are 2 jump destination(s) inside the last statement!
      }
    }
  }
  */
  
	//all this is added by me because the original commented out decompiled code above is broken -AdamJD
	if (  !bApplyToBossOffset )
	{
		rDestRotation.Pitch += fMouseDeltaY * CurrentSet.fRotSpeed;
	
		if( rDestRotation.Pitch > fCurrentMaxPitch )	
		{	
			rDestRotation.Pitch  = fCurrentMaxPitch;
		}
		else if( rDestRotation.Pitch < fCurrentMinPitch )
		{	
			rDestRotation.Pitch  = fCurrentMinPitch;
		}
	}
	else
	{
		rBossRotationOffset.Pitch += fMouseDeltaY * CurrentSet.fRotSpeed;
	
		if( rBossRotationOffset.Pitch >  MaxBossAimRot )
		{
			rBossRotationOffset.Pitch = MaxBossAimRot;
		} 
		else if ( rBossRotationOffset.Pitch <  -MaxBossAimRot )
		{
			rBossRotationOffset.Pitch =  -MaxBossAimRot;
		}
	}
}

function SetDestRotation (Rotator NewRot)
{
	rDestRotation = NewRot;
}

function UpdateRotation (float fTimeDelta)
{
	local float fTravelScalar;

	rDestRotation += rRotationStep * fTimeDelta;
	
	// Metallicafan212:	Force to USHORT bounds
	//rDestRotation.Yaw 	= ClampRotVal(rDestRotation.Yaw);
	//rDestRotation.Pitch = ClampRotVal(rDestRotation.Pitch);
	//rDestRotation.Roll 	= ClampRotVal(rDestRotation.Roll);
	
	//rCurrRotation.Yaw 	= ClampRotVal(rCurrRotation.Yaw);
	//rCurrRotation.Pitch = ClampRotVal(rCurrRotation.Pitch);
	//rCurrRotation.Roll 	= ClampRotVal(rCurrRotation.Roll);
	
	if ( bSyncRotationWithTarget )
	{
		rCurrRotation = rotator(CamTarget.Location - Location);
	} 
	else 
	{
		if ( CurrentSet.fRotTightness > 0.0 )
		{
			fTravelScalar = FMin(1.0,CurrentSet.fRotTightness * fTimeDelta);
		} 
		else 
		{
			fTravelScalar = 1.0;
		}
		rCurrRotation += (rDestRotation - rCurrRotation) * fTravelScalar;
	}
	// vForward = Normal(rCurrRotation);
	vForward = normal(vector(rCurrRotation));
	SetFinalRotation(rCurrRotation);
}

function SetFinalRotation (Rotator R)
{
	R += rExtraRotation;
	rExtraRotation = rot(0,0,0);
  
	// Metallicafan212: Test?
	R.Pitch 	= R.Pitch & 65535;
	R.Roll 		= R.Roll & 65535;
	R.Yaw 		= R.Yaw & 65535;
  
	DesiredRotation = R;
	SetRotation(R);
}

function UpdatePosition (float fTimeDelta, optional bool bSkipWorldCheck)
{
	local float fTravelScalar;

	if ( bSyncPositionWithTarget )
	{
		vDestPosition = CamTarget.Location + ((Vec( -fCurrLookAtDistance,0.0,0.0)) >> rCurrRotation);
	}
	if (  !bSkipWorldCheck )
	{
		CheckCollisionWithWorld();
	}
	if ( CurrentSet.fMoveTightness > 0.0 )
	{
		fTravelScalar = FMin(1.0,CurrentSet.fMoveTightness * fTimeDelta);
	} 
	else 
	{
		fTravelScalar = 1.0;
	}
	vCurrPosition += (vDestPosition - vCurrPosition) * fTravelScalar;
	SetLocation(vCurrPosition);
}

function bool CheckCollisionWithWorld ()
{
	local Vector HitLocation;
	local Vector HitNormal;
	//local Actor HitActor;
	local Actor aHitActor;
	local Vector LookAtPoint;
	local Vector LookFromPoint;
	local Vector vCusionFromWorld;

	LookAtPoint = CamTarget.Location;
	// if ( (CamTarget.aAttachedTo != None) && ((CamTarget.vOffset.X != byte(0)) || (CamTarget.vOffset.Y != byte(0)) || (CamTarget.vOffset.Z != byte(0))) )
	if( CamTarget.aAttachedTo != None && (CamTarget.vOffset.x != 0 || CamTarget.vOffset.y != 0 || CamTarget.vOffset.z != 0) )
	{
		aHitActor = Trace(HitLocation,HitNormal,CamTarget.Location,CamTarget.aAttachedTo.Location,False);
		if ( (aHitActor != None) && aHitActor.IsA('LevelInfo') )
		{
			LookAtPoint = HitLocation + (Normal(CamTarget.aAttachedTo.Location - HitLocation) * 5.0) + HitNormal;
			PlayerHarry.ClientMessage("CamTarget HitLoc:" $ string(HitLocation) $ " HitNorm: " $ string(HitNormal));
		}
	}
	vCusionFromWorld = Normal(LookAtPoint - vDestPosition) * 10.0;
	LookFromPoint = vDestPosition - vCusionFromWorld;
	foreach TraceActors(Class'Actor',aHitActor,HitLocation,HitNormal,LookFromPoint,LookAtPoint)
	{
		if ( aHitActor == Owner )
		{
			continue;
		} //else {
		if ( aHitActor.IsA('LevelInfo') || aHitActor.bBlockCamera )
		{
			vDestPosition = HitLocation + vCusionFromWorld;
			fDestLookAtDistance = VSize(vDestPosition - LookAtPoint);
			fCurrLookAtDistance = fDestLookAtDistance;
			return True;
		}
		//}
	}
	return False;
}
 
auto state StateStartup
{
	function BeginState ()
	{
	}
  
	begin:
  
		InitSettings(CamSetStandard,True,False);
		InitTarget(PlayerHarry);
		InitPositionAndRotation(True);
		// SetCameraMode(3);
		SetCameraMode( CM_Standard );
}

state stateIdle //extends stateIdle
{
}

state StateTransition
{
	function BeginState ()
	{
		CamTarget.SetAttachedTo(None);
		// CamTarget.DoFlyTo(PlayerHarry.Location + CamSetStandard.vLookAtOffset,3,1.0);
		CamTarget.DoFlyTo( playerHarry.location + CamSetStandard.vLookAtOffset, MOVE_TYPE_EASE_TO, 1.0);
		InitSettings(CamSetStandard,False,True);
		InitRotation(PlayerHarry.Rotation);
		CurrentSet.fMoveTightness = 0.1;
		vDestPosition = PlayerHarry.Location + CamSetStandard.vLookAtOffset + ((Vec( -CurrentSet.fLookAtDistance,0.0,0.0)) >> rDestRotation);
		PlayerHarry.ClientMessage(" 1 DestRot = " $ string(rDestRotation) $ " CurRot = " $ string(rCurrRotation));
	}
  
	function CutBypass ()
	{
		PlayerHarry.ClientMessage(" Transition DestRot = " $ string(rDestRotation) $ " CurRot = " $ string(rCurrRotation) $ "TargetLoc = " $ string(CamTarget.Location));
		CamTarget.SetAttachedTo(PlayerHarry);
		CamTarget.SetOffset(CamSetStandard.vLookAtOffset);
		DoCutCueNotify();
		SetCameraMode(CameraModeTransition);
		Super.CutBypass();
	}
  
	function Tick (float fTimeDelta)
	{
		CurrentSet.fMoveTightness += fTimeDelta * 4.0;
		UpdateRotation(fTimeDelta);
		UpdatePosition(fTimeDelta);
		if ( VSize(vCurrPosition - vDestPosition) <= 0.01 )
		{
			CutBypass();
		}
	}
}

state StateStandardCam
{
	//ignores  LongFall, Died, WarnTarget, KilledBy, TakeDamage;
	ignores TakeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer; //UTPT left all these out... -AdamJD
  
	function BeginState ()
	{
		if ( /*True*/USE_DEBUG_MODE )
		{
			PlayerHarry.ClientMessage("Camera: BeginState -> StandardCam");
		}
		InitSettings(CamSetStandard,True,False);
		InitTarget(PlayerHarry);
		InitPositionAndRotation(True);
	}
  
	function EndState ()
	{
		rSavedRotation = rCurrRotation;
	}
  
	function Tick (float fTimeDelta)
	{
		ApplyMouseXToDestYaw(fTimeDelta);
		ApplyMouseYToDestPitch(fTimeDelta);
		UpdateDistance(fTimeDelta);
		UpdateRotation(fTimeDelta);
		UpdatePosition(fTimeDelta);
	}
}

state StateQuidditchCam
{
	function BeginState ()
	{
		if ( /*True*/USE_DEBUG_MODE )
		{
			PlayerHarry.ClientMessage("Camera: BeginState -> QuidditchCam");
		}
		Log(string(Name) $ " Entered " $ string(GetStateName()) $ " State");
		InitSettings(CamSetQuidditch,True,False);
		InitTarget(PlayerHarry);
		InitPositionAndRotation(True);
	}
  
	function Tick (float fTimeDelta)
	{
		local Vector lookDir;
		local Rotator rSavedCurrRotation;
  
		rSavedCurrRotation = rCurrRotation;
		rCurrRotation = rotator(CamTarget.Location - vCurrPosition);
		UpdatePosition(fTimeDelta,True);
		rCurrRotation = rSavedCurrRotation;
		lookDir = 0.5 * (PlayerHarry.Location - vCurrPosition) + 0.5 * (CamTarget.Location - vCurrPosition);
		rDestRotation = rotator(lookDir);
		UpdateRotationUsingVectors(fTimeDelta);
	}
	
	//force camera to focus on Harry before going to the cutscene cam -AdamJD
	function EndState()
	{
		Log("AdamJD:	Ended quidditch cam");
		InitTarget(PlayerHarry);
		InitPositionAndRotation(True);
	}
}

state StateFlyingCarCam
{
	function BeginState ()
	{
		if ( /*True*/USE_DEBUG_MODE )
		{
			PlayerHarry.ClientMessage("Camera: BeginState -> FlyingCarCam");
		}
		InitSettings(CamSetFlyingCar,True,False);
		InitTarget(PlayerHarry);
		InitPositionAndRotation(True);
	}
  
	function Tick (float fTimeDelta)
	{
		local Rotator Rot;
  
		Rot.Yaw = PlayerHarry.Rotation.Yaw & 65535;
		Rot.Pitch = PlayerHarry.Rotation.Pitch & 65535;
		SetDestRotation(Rot);
		UpdateRotationUsingVectors(fTimeDelta);
		UpdatePosition(fTimeDelta);
	}
}

state StateDuelingCam
{
	//ignores  LongFall, Died, WarnTarget, KilledBy, TakeDamage;
	ignores TakeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer; //UTPT left all these out... -AdamJD
  
	function BeginState ()
	{
		local Rotator Rot;
  
		if ( /*True*/USE_DEBUG_MODE )
		{
			PlayerHarry.ClientMessage("Camera: BeginState -> StandardCam");
		}
		InitSettings(CamSetDueling,True,False);
		InitTarget(PlayerHarry);
		InitPositionAndRotation(True);
	}
  
	function Tick (float fTimeDelta)
	{
		UpdateDistance(fTimeDelta);
		UpdateRotation(fTimeDelta);
		UpdatePosition(fTimeDelta);
	}
}

state StateCutSceneCam
{
	function BeginState ()
	{
		if ( /*True*/USE_DEBUG_MODE )
		{
			PlayerHarry.ClientMessage("Camera: BeginState -> StateCutSceneCam");
		}
		fDistanceScalar = 1.0;
		rRotationStep = rot(0,0,0);
		CamTarget.SetLocation(CamTarget.aAttachedTo.Location + CamTarget.vOffset);
		CamTarget.aAttachedTo = None;
		CurrentSet = CamSetCutScene;
		CamTarget.SetOffset(CurrentSet.vLookAtOffset);
		rDestRotation.Roll = 0;
		rCurrRotation.Roll = 0;
		bSyncPositionWithTarget = False;
		bSyncRotationWithTarget = True;
	}
  
	function Tick (float fTimeDelta)
	{
		Super.Tick(fTimeDelta);
		UpdateRotation(fTimeDelta);
		if ( bSyncPositionWithTarget )
		{
			UpdatePosition(fTimeDelta);
		}
	}
}

state StateBossCam
{
	function BeginState ()
	{
		if ( /*True*/USE_DEBUG_MODE )
		{
			PlayerHarry.ClientMessage("Camera: BeginState -> BossCam");
		}
		InitSettings(CamSetBoss,True,False);
		InitTarget(PlayerHarry);
		InitPositionAndRotation(False);
	}
  
	function Tick (float fTimeDelta)
	{
		local Vector V;
  
		ApplyMouseXToDestYaw(fTimeDelta,True);
		ApplyMouseYToDestPitch(fTimeDelta,True);
		if ( baseBoss(PlayerHarry.BossTarget) != None )
		{
			V = baseBoss(PlayerHarry.BossTarget).GetCamTargetLoc();
		} 
		else 
		{
			V = PlayerHarry.BossTarget.Location;
		}
		rDestRotation = rotator(Normal(V - Location));
		rDestRotation += rBossRotationOffset;
		UpdateRotationUsingVectors(fTimeDelta);
		UpdatePosition(fTimeDelta);
	}
}

state StateFreeCam
{
	//ignores  LongFall, Died, WarnTarget, KilledBy, TakeDamage;
	ignores TakeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer; //UTPT left all these out... -AdamJD
  
	function BeginState ()
	{
		if ( USE_DEBUG_MODE )
		{
			PlayerHarry.ClientMessage("Camera: BeginState -> FreeCam");
		}
		CurrentSet = CamSetFree;
		fDistanceScalar = 1.0;
		rRotationStep = rot(0,0,0);
		rSavedRotation = Rotation;
		bSyncPositionWithTarget = False;
		bSyncRotationWithTarget = False;
	}
  
	function Tick (float fTimeDelta)
	{
		fMouseDeltaX = PlayerHarry.SmoothMouseX * fTimeDelta;
		fMouseDeltaY = PlayerHarry.SmoothMouseY * fTimeDelta;
		if ( fMouseDeltaX > MAX_MOUSE_DELTA_X )
		{
			fMouseDeltaX = MAX_MOUSE_DELTA_X;
		}
		else if ( fMouseDeltaX < MIN_MOUSE_DELTA_X )
		{
			fMouseDeltaX = MIN_MOUSE_DELTA_X;
		}
		if ( fMouseDeltaY > MAX_MOUSE_DELTA_Y )
		{
			fMouseDeltaY = MAX_MOUSE_DELTA_Y;
		} 
		else
		if ( fMouseDeltaY < MIN_MOUSE_DELTA_Y )
		{
			fMouseDeltaY = MIN_MOUSE_DELTA_Y;
		}
		if ( baseConsole(PlayerHarry.Player.Console).bForwardKeyDown )
		{
			vDestPosition += (vect(1.00,0.00,0.00) >> Rotation) * CurrentSet.fMoveSpeed * fTimeDelta;
		} 
		else if ( baseConsole(PlayerHarry.Player.Console).bBackKeyDown )
		{
			vDestPosition += (vect(-1.00,0.00,0.00) >> Rotation) * CurrentSet.fMoveSpeed * fTimeDelta;
		}
		if ( baseConsole(PlayerHarry.Player.Console).bRightKeyDown )
		{
			vDestPosition += (vect(0.00,1.00,0.00) >> Rotation) * CurrentSet.fMoveSpeed * fTimeDelta;
		} 
		else if ( baseConsole(PlayerHarry.Player.Console).bLeftKeyDown )
		{
			vDestPosition += (vect(0.00,-1.00,0.00) >> Rotation) * CurrentSet.fMoveSpeed * fTimeDelta;
		}
		if ( baseConsole(PlayerHarry.Player.Console).bUpKeyDown )
		{
			vDestPosition += (vect(0.00,0.00,1.00) >> Rotation) * CurrentSet.fMoveSpeed * fTimeDelta;
		} 
		else if ( baseConsole(PlayerHarry.Player.Console).bDownKeyDown )
		{
			vDestPosition += (vect(0.00,0.00,-1.00) >> Rotation) * CurrentSet.fMoveSpeed * fTimeDelta;
		}
		vCurrPosition += (vDestPosition - vCurrPosition) * FMin(1.0,CurrentSet.fMoveTightness * fTimeDelta);
		SetLocation(vCurrPosition);
		if ( baseConsole(PlayerHarry.Player.Console).bRotateRightKeyDown )
		{
			rDestRotation.Yaw += CurrentSet.fRotSpeed * fTimeDelta;
		}
		else if ( baseConsole(PlayerHarry.Player.Console).bRotateLeftKeyDown )
		{
			rDestRotation.Yaw -= CurrentSet.fRotSpeed * fTimeDelta;
		}
		if( baseconsole(playerHarry.player.console).bRotateUpKeyDown)
		{
			rDestRotation.Pitch += CurrentSet.fRotSpeed * fTimeDelta;
		}
		else if ( baseConsole(PlayerHarry.Player.Console).bRotateDownKeyDown )
		{
			rDestRotation.Pitch -= CurrentSet.fRotSpeed * fTimeDelta;
		}

		//these 2 lines weren't added for some reason which stopped freecam working -AdamJD
		rDestRotation.Yaw   += fMouseDeltaX * CurrentSet.fRotSpeed;
		rDestRotation.Pitch += fMouseDeltaY * CurrentSet.fRotSpeed;
	
		rCurrRotation += (rDestRotation - rCurrRotation ) * FMin( 1.0, CurrentSet.fRotTightness * fTimeDelta );
		DesiredRotation = rCurrRotation;
		SetRotation(DesiredRotation);
	}
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
	local string sActualCommand;
	local string sString;
	local int I;
	local bool B;

	sActualCommand = ParseDelimitedString(Command," ",1,False);
	if ( sActualCommand ~= "Capture" )
	{
		PlayerHarry.ClientMessage("Camera Captured");
		// SetCameraMode(7);
		SetCameraMode( CM_CutScene );
		return True;
	} 
	else if ( sActualCommand ~= "Release" )
    {
		PlayerHarry.ClientMessage("Camera Released");
		CamTarget.CutCommand("Release","",False);
		// SetCameraMode(3);
		SetCameraMode( CM_Standard );
	} 
	else if ( sActualCommand ~= "GoHome" )
	{
		Log("*** GoHome CALLED!!!!  loc = " $ string(Location) $ " rot = " $ string(Rotation));
        bSyncPositionWithTarget = True;
        SetPosition(Location);
        // SetCameraMode(2);
		SetCameraMode( CM_Transition );
        sCutNotifyCue = cue;
        if ( bFastFlag )
        {
			InitSettings(CamSetStandard,False,True);
			InitRotation(PlayerHarry.Rotation);
			InitPosition(PlayerHarry.Location + CamSetStandard.vLookAtOffset + (Vec( -CurrentSet.fLookAtDistance,0.0,0.0) >> rDestRotation));
			CamTarget.SetAttachedTo(PlayerHarry);
			CamTarget.SetOffset(CamSetStandard.vLookAtOffset);
			SetCameraMode(CameraModeTransition);
			DoCutCueNotify();
        }
        return True;
	} 
	else if ( sActualCommand ~= "FlyTo" )
	{
		bSyncPositionWithTarget = False;
        if (  !bIgnoreTarget )
		{
			bSyncRotationWithTarget = True;
        }
	} 
	else if ( sActualCommand ~= "Target" )
	{
		return CutCommand_ProcessTarget(Command,cue,bFastFlag);
	} 
	else if ( sActualCommand ~= "IgnoreTargetOn" )
	{
		bIgnoreTarget = True;
        bSyncPositionWithTarget = False;
		bSyncRotationWithTarget = False;
		sCutNotifyCue = cue;
		DoCutCueNotify();
		return True;
	} 
	else if ( sActualCommand ~= "IgnoreTargetOff" )
	{
		bIgnoreTarget = False;
		sCutNotifyCue = cue;
		DoCutCueNotify();
		return True;
	} 
	else if ( sActualCommand ~= "Locked" )
	{
		bSyncPositionWithTarget = True;
		bSyncRotationWithTarget = True;
        return CutCommand_ProcessLocked(Command,cue,bFastFlag);
	} 
	else if ( sActualCommand ~= "UnLock" )
	{
		bSyncPositionWithTarget = False;
		bSyncRotationWithTarget = True;
		sCutNotifyCue = cue;
		DoCutCueNotify();
		return True;
	} 
	else if ( sActualCommand ~= "FOV" )
	{
		return CutCommand_ProcessFOV(Command,cue,bFastFlag);
	} 
	else if ( sActualCommand ~= "Shake" )
	{
		return CutCommand_ProcessShake(Command,cue,bFastFlag);
	} 
	else if ( sActualCommand ~= "Flash" )
	{
		return CutCommand_ProcessFlash(Command,cue,bFastFlag);
	} 
	else if ( sActualCommand ~= "FadeOut" )
	{
		return CutCommand_ProcessFade(True,Command,cue,bFastFlag);
	} 
	else if ( sActualCommand ~= "FadeIn" )
	{
		return CutCommand_ProcessFade(False,Command,cue,bFastFlag);
	}
	return Super.CutCommand(Command,cue,bFastFlag);
}

function bool CutCommand_ProcessFOV (string Command, optional string cue, optional bool bFastFlag)
{
	local FOVController FOVControl;
	local TimedCue tcue;
	local string sString;
	local bool bEaseTo;
	local float fAngle;
	local float fTime;
	local int I;

	fAngle = 90.0;
	fTime = 0.0;

	for( I = 2; I < 8; I++ )
	{
		sString = ParseDelimitedString(Command," ",I,False);
		if ( sString ~= "EaseTo" )
		{
			bEaseTo = True;
		} 
		else if ( Left(sString,6) ~= "Angle=" )
		{
			fAngle = float(Mid(sString,6));
		} 
		else if ( Left(sString,5) ~= "Time=" )
        {
			fTime = float(Mid(sString,5));
        }
		if ( sString == "" )
		{
			break;
		}
	}
	if ( bFastFlag )
	{
		fTime = 0.0;
	}
	FOVControl = Spawn(Class'FOVController');
	FOVControl.Init(fAngle,fTime,bEaseTo);
	tcue = Spawn(Class'TimedCue');
	tcue.CutNotifyActor = self;
	tcue.SetupTimer(fTime,cue);
	return True;
}

function bool CutCommand_ProcessFlash (string Command, optional string cue, optional bool bFastFlag)
{
	local FadeViewController FadeController;
	local TimedCue tcue;
	local string sString;
	local bool bUseDefault;
	local float A;
	local float R;
	local float G;
	local float B;
	local float fTime;
	local int I;

	A = 255.0;
	bUseDefault = True;
	fTime = 0.25;
	for( I = 2; I < 8; I++ )
	{
		sString = ParseDelimitedString(Command," ",I,False);
		if ( Left(sString,2) ~= "A=" )
		{
			A = float(Mid(sString,2));
			bUseDefault = False;
		} 
		else if ( Left(sString,2) ~= "R=" )
		{
			R = float(Mid(sString,2));
			bUseDefault = False;
		} 
		else if ( Left(sString,2) ~= "G=" )
        {
			G = float(Mid(sString,2));
			bUseDefault = False;
        } 
		else if ( Left(sString,2) ~= "B=" )
		{
			B = float(Mid(sString,2));
			bUseDefault = False;
		} 
		else if ( Left(sString,5) ~= "Time=" )
		{
			fTime = float(Mid(sString,5));
		} 
		else if ( sString == "" )
		{
			break;
		}
	}
	A = FClamp(A / 255,0.0,1.0);
	R = FClamp(R / 255,0.0,1.0);
	G = FClamp(G / 255,0.0,1.0);
	B = FClamp(B / 255,0.0,1.0);
	FadeController = Spawn(Class'FadeViewController');
	if ( bUseDefault )
	{
		R = 1.0;
		G = 1.0;
		B = 1.0;
	}
	if ( bFastFlag )
	{
		FadeController.Init(A,R,G,B,0.0,True);
		CutCue(cue);
		return True;
	}
	FadeController.Init(A,R,G,B,fTime,True);
	tcue = Spawn(Class'TimedCue');
	tcue.CutNotifyActor = self;
	tcue.SetupTimer(fTime,cue);
	return True;
}

function bool CutCommand_ProcessShake (string Command, optional string cue, optional bool bFastFlag)
{
	local TimedCue tcue;
	local string sString;
	local float fMagnitude;
	local float fTime;
	local int I;

	fMagnitude = 100.0;
	fTime = 0.5;
	for( I = 2; I < 8; I++ )
	{
		sString = ParseDelimitedString(Command," ",I,False);
		if ( Left(sString,10) ~= "Magnitude=" )
		{
			fMagnitude = float(Mid(sString,10));
		} 
		else if ( Left(sString,5) ~= "Time=" )
		{
			fTime = float(Mid(sString,5));
		} 
		else if ( sString == "" )
        {
			break;
        }
	}
	if ( bFastFlag )
	{
		CutCue(cue);
	} 
	else 
	{
		tcue = Spawn(Class'TimedCue');
		tcue.CutNotifyActor = self;
		tcue.SetupTimer(fTime,cue);
	}
	PlayerHarry.ShakeView(fTime,fMagnitude,fMagnitude);
	return True;
}

function DoSimpleFade (bool bFadeIn)
{
	local FadeViewController FadeController;
	
	//IDK how I didn't notice this... -AdamJD
	// return;
	FadeController = Spawn(Class'FadeViewController');
	if ( bFadeIn )
	{
		FadeController.Init(0.0,0.0,0.0,0.0,1.0,False);
	} 
	else 
	{
		FadeController.Init(1.0,0.0,0.0,0.0,1.0,False);
	}
}

function bool CutCommand_ProcessFade (bool bFadeOut, string Command, optional string cue, optional bool bFastFlag)
{
	local FadeViewController FadeController;
	local TimedCue tcue;
	local string sString;
	local float A;
	local float R;
	local float G;
	local float B;
	local float fTime;
	local int I;

	if ( bFadeOut )
	{
		A = 255.0;
	}
	fTime = 1.0;
	for( I = 2; I < 8; I++ )
	{
		sString = ParseDelimitedString(Command," ",I,False);
		if ( (Left(sString,2) ~= "A=") && bFadeOut )
		{
			A = float(Mid(sString,2));
		} 
		else if ( (Left(sString,2) ~= "R=") && bFadeOut )
		{
			R = float(Mid(sString,2));
		} 
		else if ( (Left(sString,2) ~= "G=") && bFadeOut )
        {
			G = float(Mid(sString,2));
        } 
		else if ( (Left(sString,2) ~= "B=") && bFadeOut )
		{
			B = float(Mid(sString,2));
		} 
		else if ( Left(sString,5) ~= "Time=" )
		{
			fTime = float(Mid(sString,5));
		} 
		else if ( sString == "" )
		{
			break;
		}
	}
	A = FClamp(A / 255,0.0,1.0);
	R = FClamp(R / 255,0.0,1.0);
	G = FClamp(G / 255,0.0,1.0);
	B = FClamp(B / 255,0.0,1.0);
	FadeController = Spawn(Class'FadeViewController');
	if ( bFastFlag )
	{
		FadeController.Init(A,R,G,B,0.0,False);
		CutCue(cue);
		return True;
	}
	FadeController.Init(A,R,G,B,fTime,False);
	tcue = Spawn(Class'TimedCue');
	tcue.CutNotifyActor = self;
	tcue.SetupTimer(fTime,cue);
	return True;
}

function bool CutCommand_ProcessLocked (string Command, optional string cue, optional bool bFastFlag)
{
	local string sString;
	local int I;
	local bool B;

	CurrentSet.fLookAtDistance = VSize(CamTarget.Location - Location);
	rDestRotation = Rotation;
	rCurrRotation = Rotation;
	vDestPosition = Location;
	vCurrPosition = Location;

	for( I = 2; I < 15; I++ )
	{
		sString = ParseDelimitedString(Command," ",I,False);
		if ( Left(sString,9) ~= "distance=" )
		{
			SetDistance(float(Mid(sString,9)));
		} 
		else if ( Left(sString,4) ~= "yaw=" )
		{
			SetYaw(ConvertDegToRot(float(Mid(sString,4))));
		} 
		else if ( Left(sString,6) ~= "pitch=" )
        {
			SetPitch(ConvertDegToRot(float(Mid(sString,6))));
        } 
		else if ( Left(sString,5) ~= "roll=" )
		{
			SetRoll(ConvertDegToRot(float(Mid(sString,5))));
		} 
		else if ( Left(sString,8) ~= "yawStep=" )
		{
			// rRotationStep.Yaw = ConvertDegToRot(float(Mid(sString,8))) = bSyncRotationWithTarget = False;
			rRotationStep.yaw = ConvertDegToRot( float(Mid(sString,8))); 
			bSyncRotationWithTarget = false;
		} 
		else if ( Left(sString,10) ~= "pitchStep=" )
		{
			// rRotationStep.Pitch = ConvertDegToRot(float(Mid(sString,10))) = bSyncRotationWithTarget = False;
			rRotationStep.pitch = ConvertDegToRot( float(Mid(sString,10))); 
			bSyncRotationWithTarget = false;
		} 
		else if ( Left(sString,9) ~= "rollStep=" )
		{
			// rRotationStep.Roll = ConvertDegToRot(float(Mid(sString,9))) = bSyncRotationWithTarget = False;
			rRotationStep.roll = ConvertDegToRot( float(Mid(sString,9))); 
			bSyncRotationWithTarget = false;
		} 
		else if ( Left(sString,13) ~= "rotTightness=" )
		{
			SetRotTightness(float(Mid(sString,13)));
		} 
		else if ( Left(sString,14) ~= "moveTightness=" )
		{
			SetMoveTightness(float(Mid(sString,14)));
		} 
		else if ( sString == "" )
		{
			break;
		}
	}
	sCutNotifyCue = cue;
	DoCutCueNotify();
	return True;
}

function bool CutCommand_ProcessTarget (string Command, optional string cue, optional bool bFastFlag)
{
	local string sActualCommand;
	local string sString;
	local int I;
	local bool B;
	local bool bPassToTarget;

	bPassToTarget = True;
	sString = ParseDelimitedString(Command," ",2,False);
	if ( sString ~= "flyto" )
	{
		CamTarget.aAttachedTo = None;
	} 
	else if ( sString ~= "teleport" )
    {
		CamTarget.aAttachedTo = None;
    } 
	else 
	{
		for( I = 2; I < 20; I++ )
		{
			sString = ParseDelimitedString(Command," ",I,False);
			if ( Left(sString,11) ~= "attachedto=" )
			{
				bPassToTarget = False;
				if (  !CamTarget.SetAttachedToByCutName(Mid(sString,11)) )
				{
					PlayerHarry.ClientMessage("!*!*!* COULD NOT ATTACH TARGET TO: " $ Mid(sString,11));
					return False;
				}
			} 
			else if ( Left(sString,2) ~= "x=" )
			{
				CamTarget.vOffset.X = float(Mid(sString,2));
				SetZOffset(CamTarget.vOffset.X);
				bPassToTarget = False;
			} 
			else if ( Left(sString,2) ~= "y=" )
            {
				CamTarget.vOffset.Y = float(Mid(sString,2));
				SetZOffset(CamTarget.vOffset.Y);
				bPassToTarget = False;
            } 
			else if ( Left(sString,2) ~= "z=" )
			{
				CamTarget.vOffset.Z = float(Mid(sString,2));
				SetZOffset(CamTarget.vOffset.Z);
				bPassToTarget = False;
			} 
			else if ( sString ~= "relative" )
			{
				CamTarget.bRelative = True;
				bPassToTarget = False;
			} 
			else if ( sString ~= "fixed" )
			{
				CamTarget.bRelative = False;
				bPassToTarget = False;
			} 
			else
			if ( sString == "" )
			{
				break;
			}
		}
	}
	if ( bPassToTarget )
	{
		CamTarget.CutNotifyActor = CutNotifyActor;
		B = CamTarget.CutCommand(ParseDelimitedString(Command," ",2,True),cue,bFastFlag);
		if (  !B )
		{
			CutErrorString = CamTarget.CutErrorString;
		}
		return B;
	}
	sCutNotifyCue = cue;
	DoCutCueNotify();
	return True;
}

function CutBypass ()
{
	cm("******** baseCam CutBypass.");
	Super.CutBypass();
	CamTarget.CutBypass();
}

function GlobalCutBypass ()
{
	cm("******** baseCam GlobalCutBypass.");
	Super.GlobalCutBypass();
	CamTarget.GlobalCutBypass();
}

/*
function bool CameraCanSeeYou (Vector Pos)
{
  local Vector Normal;
  local float dotpr;

  Normal = Rotation;
  dotpr = Normal.X * (Pos.X - Location.X) + Normal.Y * (Pos.Y - Location.Y) + Normal.Z * (Pos.Z - Location.Z);
  if ( dotpr > byte(0) )
  {
    return True;
  }
  return False;
}
*/

function bool CameraCanSeeYou(Vector Pos)
{
	//local vector normal;
	local Vector vNormal;
	local Float dotpr;

	vNormal = Vector(Rotation);

	dotpr = vNormal.X * (Pos.X - Location.X) + vNormal.Y * (Pos.Y - Location.Y) + vNormal.Z * (Pos.Z - Location.Z);
	
	if(dotpr > 0)
	{
		return True;
	}

	return False;
}

defaultproperties
{
    bSyncPositionWithTarget=True

    fMoveBackTightness=4.00

    fCurrentMinPitch=-14000.00

    fCurrentMaxPitch=14000.00

    CamSetStandard=(vLookAtOffset=(X=0.00,Y=0.00,Z=55.00),fLookAtDistance=128.00,fRotTightness=8.00,fRotSpeed=4.00,fMoveTightness=0.00,fMoveSpeed=0.00)

    CamSetQuidditch=(vLookAtOffset=(X=0.00,Y=0.00,Z=65.00),fLookAtDistance=175.00,fRotTightness=2.00,fRotSpeed=0.00,fMoveTightness=7.00,fMoveSpeed=0.00)

    CamSetFlyingCar=(vLookAtOffset=(X=0.00,Y=0.00,Z=175.00),fLookAtDistance=400.00,fRotTightness=4.00,fRotSpeed=0.00,fMoveTightness=4.00,fMoveSpeed=0.00)

    CamSetCutScene=(vLookAtOffset=(X=0.00,Y=0.00,Z=0.00),fLookAtDistance=128.00,fRotTightness=2.00,fRotSpeed=5.00,fMoveTightness=0.00,fMoveSpeed=0.00)

    CamSetDueling=(vLookAtOffset=(X=0.00,Y=0.00,Z=45.00),fLookAtDistance=200.00,fRotTightness=8.00,fRotSpeed=4.00,fMoveTightness=3.50,fMoveSpeed=0.00)

    CamSetFree=(vLookAtOffset=(X=0.00,Y=0.00,Z=0.00),fLookAtDistance=0.00,fRotTightness=10.00,fRotSpeed=5.00,fMoveTightness=7.00,fMoveSpeed=600.00)

    CamSetBoss=(vLookAtOffset=(X=0.00,Y=0.00,Z=100.00),fLookAtDistance=170.00,fRotTightness=8.00,fRotSpeed=4.00,fMoveTightness=0.00,fMoveSpeed=0.00)

    fDistanceScalar=1.00

    MaxBossAimRot=4000

    bIgnoreZonePainDamage=True

    bHidden=True

    bCanMoveInSpecialPause=True

    bBlockActors=False

    bBlockPlayers=False

    bRotateToDesired=False

    CutName="baseCam"
}
