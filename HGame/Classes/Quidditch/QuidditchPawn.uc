//================================================================================
// QuidditchPawn.
//================================================================================

class QuidditchPawn extends HPawn;

const NUM_WOOSH_SOUNDS= 4;
const fDefaultLifeSpanAsMine= 10.0;
const fDefaultLifeSpanAsProjectile= 10.0;
const MaxPaths= 8;
var harry PlayerHarry;
var QuidditchCommentator Commentator;
var InterpolationManager IM;
var(Quidditch) name Path[8];
var int CurPath;
var float PathSpeed;
var DynamicInterpolationPoint ReturnPath[2];
var int iReturnPoint;
var bool bGettingBackOnPath;
var(Quidditch) bool bSwitchPathsOnTrigger;
var(Quidditch) bool bUseTransitionPaths;
var(Quidditch) bool bRandomizePaths;
var(Quidditch) float fHideTime;
var(Quidditch) float fSpeedChangeFactor;
var(Quidditch) float fSpeedChangePeriod;
var(Quidditch) float fSpeedChangeFirstTime;
var(Quidditch) int MaxSpeedChanges;
var float fSpeedChangeLastTime;
var float fSpeedChangeNextTime;
var Pawn Target;
var(Quidditch) float fLaunchProximity;
var(Quidditch) float fPursuitAbortDistance;
var(Quidditch) float fPursuitTimeLimit;
var float Dist;
var(Quidditch) float fLaunchSpeed;
var(Quidditch) float fLaunchVelocityCompensation;
var bool bProjectile;
var float fLifeSpanAsProjectile;
var Actor Emitter;
var bool bRecycle;
var bool bMine;
var float fLifeSpanAsMine;
var Vector DeployedLocation;
var(Quidditch) Class<ParticleFX> ParticleTrail;
var ParticleFX Trail;
var(Quidditch) Class<Halo> HaloClass;
var Halo Halo;
var(Quidditch) Class<ParticleFX> ExplosionFX;
var float fLastDistanceFromCamera;
var float fNextTimeSafeToWoosh;
var(Quidditch) bool bCanWoosh;
var(Quidditch) Sound FlyingSound;
var(Quidditch) Sound PursuitSound;
var(Quidditch) Sound ExplosionSound;
var Sound WooshSounds[4];
var bool bCapturedByCutScene;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  foreach AllActors(Class'harry',PlayerHarry)
  {
    // goto JL001A;
	break;
  }
  bCapturedByCutScene = False;
}

function PostBeginPlay()
{
  local InterpolationPoint I;

  Super.PostBeginPlay();
  foreach AllActors(Class'QuidditchCommentator',Commentator)
  {
    // goto JL001A;
	break;
  }
  // SetPhysics(4);
  SetPhysics(PHYS_Flying);
  PathSpeed = IPSpeed;
  bProjectile = False;
  bMine = False;
  bRecycle = False;
  Emitter = None;
  Target = None;
  bGettingBackOnPath = False;
  fSpeedChangeNextTime = fSpeedChangeFirstTime;
  fSpeedChangeLastTime = fSpeedChangePeriod * (MaxSpeedChanges - 1) + fSpeedChangeFirstTime;
  fLastDistanceFromCamera = VSize(Location - PlayerHarry.Cam.Location);
  fNextTimeSafeToWoosh = Level.TimeSeconds;
  if ( ParticleTrail != None )
  {
    Trail = Spawn(ParticleTrail,self,,Location,rot(0,0,0));
    // Trail.SetPhysics(11);
	Trail.SetPhysics(PHYS_Trailer);
  }
  if ( HaloClass != None )
  {
    Halo = Spawn(HaloClass,self,,Location,rot(0,0,0));
  }
  CurPath = -1;
  ChooseNextPath();
  if ( fHideTime > 0.0 )
  {
    Hide();
    SetTimer(fHideTime,False);
  } else {
    FlyOnPath(Path[CurPath]);
    Show();
  }
}

function Destroyed()
{
  StopFlyingOnPath();
  if ( Trail != None )
  {
    Trail.Shutdown();
  }
  if ( Halo != None )
  {
    Halo.Destroy();
  }
  Super.Destroyed();
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local bool bResult;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "Capture" )
  {
    StopFlyingOnPath();
    bCapturedByCutScene = True;
    return Super.CutCommand(Command,cue,bFastFlag);
  } else //{
    if ( sActualCommand ~= "Release" )
    {
      bResult = Super.CutCommand(Command,cue,bFastFlag);
      IPSpeed = PathSpeed;
      bInterpolating_IgnoreRot = False;
      bCollideWorld = True;
      SetCollision(True,False,False);
      bCapturedByCutScene = False;
      SwitchPaths();
      return bResult;
    } else {
      return Super.CutCommand(Command,cue,bFastFlag);
    }
  //}
}

function Hide()
{
  bHidden = True;
  if ( FlyingSound != None )
  {
    StopSound(FlyingSound,SLOT_Misc);
  }
  if ( PursuitSound != None )
  {
    StopSound(PursuitSound,SLOT_Misc);
  }
  if ( Trail != None )
  {
    Trail.EnableEmission(False);
  }
  if ( Halo != None )
  {
    Halo.bHidden = True;
  }
}

function Show()
{
  bHidden = False;
  if ( FlyingSound != None )
  {
    PlaySound(FlyingSound,SLOT_Misc,1.0,,10000.0);
  }
  if ( Trail != None )
  {
    Trail.EnableEmission(True);
  }
  if ( Halo != None )
  {
    Halo.bHidden = False;
  }
}

function bool TargetCanSeeMe (Pawn Target)
{
  local harry PlayerTarget;
  local bool bCanSee;

  PlayerTarget = harry(Target);
  if ( PlayerTarget != None )
  {
    bCanSee = PlayerTarget.Cam.CanSee(self);
  } else {
    bCanSee = Target.CanSee(self);
  }
  return bCanSee;
}

function ChooseNextPath()
{
  local int Skip;
  local int BailOut;

  if ( bRandomizePaths )
  {
    Skip = FRand() * (MaxPaths - 1) + 1;
  }
  else
  {
	Skip = 1;
  }
  
  //do loops -AdamJD
  do
  {
	  BailOut = MaxPaths;
	  do
	  {
		  CurPath++;
		  if ( CurPath >= MaxPaths )
		  {
			CurPath = 0;
		  }
		  --BailOut;
	  }
	  until( (Path[CurPath] != 'None') || (BailOut <= 0) )
	  --Skip;
  }
  until ( (Skip <= 0) || (BailOut <= 0) )
  
  Log(string(Name) $ " chose new path: " $ string(Path[CurPath]) $ ".");
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
      SetRotation(rotator(I.StartControlPoint));
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
      Log(string(Name) $ " couldn't find path " $ string(Path));
    }
    Log(string(Name) $ " Started interpolation with " $ string(IM.Name) $ ":" $ string(IM));
  }
}

function StopFlyingOnPath()
{
  local InterpolationManager IM_ToStop;

  bCollideWorld = True;
  if ( IM != None )
  {
    IM_ToStop = IM;
    IM = None;
    Log(string(Name) $ " Stopping interpolation with " $ string(IM_ToStop.Name) $ ":" $ string(IM_ToStop));
    IM_ToStop.FinishedInterpolation(None);
    Log(string(Name) $ " Stopped interpolation with " $ string(IM_ToStop.Name) $ ":" $ string(IM_ToStop));
  }
}

function ApplySpeedChange (float fSpeedChange)
{
  local int iPath;
  local InterpolationPoint IP;

  // iPath = 0;
  // if ( iPath < 8 )
  for(iPath = 0; iPath < MaxPaths; ++iPath)
  {
    if ( Path[iPath] != 'None' )
    {
      foreach AllActors(Class'InterpolationPoint',IP,Path[iPath])
      {
        IP.DesiredSpeed *= fSpeedChange;
      }
    }
    // ++iPath;
    // goto JL0007;
  }
  if ( IPSpeed != 0.0 )
  {
    IPSpeed *= fSpeedChange;
  }
  fLaunchSpeed *= fSpeedChange;
}

function CheckIfTimeForSpeedChange()
{
  if ( (fSpeedChangeFactor != 1.0) && (MaxSpeedChanges > 0) && (fSpeedChangeNextTime <= fSpeedChangeLastTime) && (Level.TimeSeconds >= fSpeedChangeNextTime) )
  {
    ApplySpeedChange(fSpeedChangeFactor);
    fSpeedChangeNextTime += fSpeedChangePeriod;
    PlayerHarry.ClientMessage(string(Name) $ ": Speeds changed.");
    Log(string(Name) $ ": Speeds changed.");
  }
}

function UpdateWoosh (float DeltaTime)
{
  local float fDistanceFromCamera;
  local Sound Woosh;

  fDistanceFromCamera = VSize(Location - PlayerHarry.Cam.Location);
  if ( bCanWoosh && (Level.TimeSeconds > fNextTimeSafeToWoosh) && (fLastDistanceFromCamera >= 180) && (fDistanceFromCamera < 180) && (VSize(Velocity) > 75) )
  {
    Woosh = WooshSounds[Rand(NUM_WOOSH_SOUNDS)];
    PlaySound(Woosh,SLOT_Interface,0.8,,500.0,RandRange(0.80,1.20));
    fNextTimeSafeToWoosh = Level.TimeSeconds + GetSoundDuration(Woosh);
  }
  fLastDistanceFromCamera = fDistanceFromCamera;
}

event Tick (float DeltaTime)
{
  Super.Tick(DeltaTime);
  CheckIfTimeForSpeedChange();
  UpdateWoosh(DeltaTime);
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  if ( bSwitchPathsOnTrigger )
  {
    IM.FinishedInterpolation(None);
  }
}

event FinishedInterpolation (InterpolationPoint Other)
{
  if (  !bCollideWorld &&  !bCapturedByCutScene )
  {
    SwitchPaths();
  }
}

function SwitchPaths()
{
  ChooseNextPath();
  if ( fHideTime > 0.0 )
  {
    Hide();
    SetTimer(fHideTime,False);
  } else //{
    if ( bUseTransitionPaths )
    {
      GotoState('GetBackOnPath');
    } else {
      FlyOnPath(Path[CurPath]);
    }
  //}
}

function Timer()
{
  FlyOnPath(Path[CurPath]);
  Show();
}

function SeekTarget (Pawn NewTarget, optional float fNewLaunchProximity)
{
  Target = NewTarget;
  if ( fNewLaunchProximity > 0 )
  {
    fLaunchProximity = fNewLaunchProximity;
  }
  if ( IsInState('Pursue') )
  {
    GotoState('GetBackOnPath');
  } else //{
    if (  !(IsInState('Seeking') || IsInState('GetBackOnPath')) ) //UTPT forgot to add brackets -AdamJD
    {
      GotoState('Seeking');
    }
  //}
}

function SetLaunchParameters (float fSpeed, float fVelocityCompensation)
{
  fLaunchSpeed = fSpeed;
  fLaunchVelocityCompensation = fVelocityCompensation;
}

function LaunchAtTarget (Pawn NewTarget, optional Actor NewEmitter, optional float fLife)
{
  local Vector TargetingVelocity;

  TargetingVelocity = NewTarget.Location - Location;
  TargetingVelocity = Normal(TargetingVelocity);
  TargetingVelocity *= fLaunchSpeed;
  TargetingVelocity += fLaunchVelocityCompensation * NewTarget.Velocity;
  ConvertIntoProjectile(NewEmitter,TargetingVelocity,fLife);
  GotoState('Targeting');
}

function ConvertIntoProjectile (Actor NewEmitter, Vector NewVelocity, optional float fLife)
{
  StopFlyingOnPath();
  // SetPhysics(6);
  SetPhysics(PHYS_Projectile);
  Emitter = NewEmitter;
  Velocity = NewVelocity;
  Acceleration = vect(0.00,0.00,0.00);
  bProjectile = True;
  SetCollision(,[NewBlockActors]False,[NewBlockPlayers]False);
  if ( fLife == 0 )
  {
    fLifeSpanAsProjectile = fDefaultLifeSpanAsProjectile;
  } else {
    fLifeSpanAsProjectile = fLife;
  }
}

function FinishProjectile()
{
  PlayerHarry.ClientMessage(string(Name) $ " done targeting");
  Log(string(Name) $ " done targeting");
  if ( bRecycle )
  {
    // SetPhysics(4);
	SetPhysics(PHYS_Flying);
    bProjectile = False;
    Emitter = None;
    SwitchPaths();
    if ( IsInState('Targeting') )
    {
      GotoState('Seeking');
    }
  } else {
    Destroy();
  }
}

function Touch (Actor Other)
{
  if ( bProjectile && (Other != Emitter) )
  {
    FinishProjectile();
  } else //{
    if ( bMine && (Other == Target) )
    {
      ExplodeMine();
    }
  //}
}

function HitWall (Vector HitNormal, Actor Wall)
{
  if ( bProjectile )
  {
    FinishProjectile();
  }
}

function TakeDamage (int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, name DamageType)
{
}

function DeployAsMine (Pawn NewTarget, optional Actor NewEmitter, optional float fLife)
{
  StopFlyingOnPath();
  // SetPhysics(0);
  SetPhysics(PHYS_None);
  Emitter = NewEmitter;
  Target = NewTarget;
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  DeployedLocation = Location;
  bMine = True;
  SetCollision(,[NewBlockActors]False,[NewBlockPlayers]False);
  if ( fLife == 0 )
  {
    fLifeSpanAsMine = fDefaultLifeSpanAsMine;
  } else {
    fLifeSpanAsMine = fLife;
  }
  GotoState('LyingInWait');
}

function ExplodeMine()
{
  if ( ExplosionSound != None )
  {
    PlaySound(ExplosionSound,SLOT_Interact,1.0,,10000.0);
  }
  if ( ExplosionFX != None )
  {
    Spawn(ExplosionFX);
  }
  FinishMine();
}

function FinishMine()
{
  PlayerHarry.ClientMessage(string(Name) $ " done lying in wait");
  Log(string(Name) $ " done lying in wait");
  if ( bRecycle )
  {
    // SetPhysics(4);
	SetPhysics(PHYS_Flying);
    bMine = False;
    Emitter = None;
    SwitchPaths();
    GotoState('Cruising');
  } else {
    Destroy();
  }
}

state() Cruising
{
begin:
  PlayerHarry.ClientMessage(string(Name) $ " now cruising");
  Log(string(Name) $ " now cruising");
loop:
  Sleep(0.1);
  goto ('Loop');
}

state() Seeking
{
Begin:
  PlayerHarry.ClientMessage(string(Name) $ " now seeking " $ string(Target.Name));
  Log(string(Name) $ " now seeking " $ string(Target.Name));
Loop:
  if ( Target != None )
  {
    Dist = VSize(Location - Target.Location);
    if ( (Dist <= fLaunchProximity) && TargetCanSeeMe(Target) )
    {
      Log(string(Name) $ " IPSpeed, Velocity: " $ string(IPSpeed) $ ", " $ string(VSize(Velocity)));
      StopFlyingOnPath();
      GotoState('Pursue');
    }
  }
  Sleep(0.1);
  goto ('Loop');
}

state() Targeting
{
  function EndState()
  {
    if ( fLifeSpanAsProjectile != 0 )
    {
      SetTimer(0.0,False);
    }
  }
  
  function Timer()
  {
    if ( bProjectile )
    {
      FinishProjectile();
    }
  }
  
begin:
  PlayerHarry.ClientMessage(string(Name) $ " now targeting " $ string(Target.Name));
  Log(string(Name) $ " now targeting " $ string(Target.Name));
  if ( fLifeSpanAsProjectile != 0 )
  {
    SetTimer(fLifeSpanAsProjectile,False);
  }
loop:
  Sleep(0.1);
  goto ('Loop');
}

state() LyingInWait
{
  function EndState()
  {
    if ( fLifeSpanAsMine != 0 )
    {
      SetTimer(0.0,False);
    }
  }
  
  function Timer()
  {
    if ( bMine )
    {
      FinishMine();
    }
  }
  
  event Tick (float DeltaTime)
  {
    local Vector BobOffset;
  
    Super.Tick(DeltaTime);
    BobOffset.X = 2.5 * Sin(4.5 * Level.TimeSeconds);
    BobOffset.Y = 2.5 * Sin(3.5 * Level.TimeSeconds);
    BobOffset.Z = 11.0 * Sin(8.0 * Level.TimeSeconds);
    SetLocation(DeployedLocation + BobOffset);
  }
  
begin:
  PlayerHarry.ClientMessage(string(Name) $ " now lying in wait for " $ string(Target.Name));
  Log(string(Name) $ " now lying in wait for " $ string(Target.Name));
  if ( fLifeSpanAsMine != 0 )
  {
    SetTimer(fLifeSpanAsMine,False);
  }
loop:
  Sleep(0.1);
  goto ('Loop');
}

state Pursue
{
  //UTPT added this for some reason -AdamJD
  // ignores  Tick;
  
  function BeginState()
  {
    PlayerHarry.ClientMessage(string(Name) $ string(' Begin Pursue'));
    Log(string(Name) $ string(' Begin Pursue at speed ') $ string(fLaunchSpeed));
    // SetPhysics(4);
	SetPhysics(PHYS_Flying);
    if ( (PursuitSound == None) || (PursuitSound == FlyingSound) )
    {
      if ( FlyingSound != None )
      {
        PlaySound(FlyingSound,SLOT_Misc,2.0,,10000.0,1.5);
      }
    } else {
      PlaySound(PursuitSound,SLOT_Misc,1.0,,10000.0);
    }
    if ( Commentator != None )
    {
      Commentator.SayComment(QC_BludgerPursuit,,True);
    }
    if ( fPursuitTimeLimit != 0 )
    {
      SetTimer(fPursuitTimeLimit,False);
    }
  }
  
  function EndState()
  {
    PlayerHarry.ClientMessage(string(Name) $ string(' End Pursue'));
    if ( fPursuitTimeLimit != 0 )
    {
      SetTimer(0.0,False);
    }
    if ( FlyingSound != None )
    {
      PlaySound(FlyingSound,SLOT_Misc,1.0,,10000.0);
    } else //{
      if ( PursuitSound != None )
      {
        StopSound(PursuitSound,SLOT_Misc);
      }
    //}
  }
  
  //UTPT didn't add this for some reason -AdamJD
  event Tick( float DeltaTime )
  {
	local vector	TargetDir;
	local vector	X,Y,Z;

	Global.Tick( DeltaTime );

	if ( Target == None || Target.bHidden )
	{
		GotoState( 'GetBackOnPath' );
	}

	Dist = VSize( Location - Target.Location );
	if ( Dist > fPursuitAbortDistance )
	{
		PlayerHarry.ClientMessage( Name$" aborted pursuit" );
		Log( Name$" aborted pursuit" );
		if ( Commentator != None )
		{
			Commentator.SayComment( QC_BludgerMiss, ,True );
		}
		GotoState( 'GetBackOnPath' );
	}
	TargetDir = Target.Location - Location;
	DesiredRotation = Rotator( TargetDir );
	GetAxes( Rotation, X, Y, Z );
	AccelRate = 5000.0;
	Acceleration = AccelRate * X;	
	Velocity = fLaunchSpeed * X;
	AirSpeed = fLaunchSpeed;
	DesiredSpeed = AirSpeed;
  }
  
  function Touch (Actor Other)
  {
    if ( Other == Target )
    {
      if ( Commentator != None )
      {
        Commentator.SayComment(QC_BludgerHit,,True);
      }
    } else {
      if ( Commentator != None )
      {
        Commentator.SayComment(QC_BludgerMiss,,True);
      }
    }
    GotoState('GetBackOnPath');
  }
  
  function Timer()
  {
    if ( Commentator != None )
    {
      Commentator.SayComment(QC_BludgerMiss,,True);
    }
    GotoState('GetBackOnPath');
  }
  
}

state GetBackOnPath
{
  //UTPT added this for some reason -AdamJD
  // ignores  Tick;
  
  function BeginState()
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
    if ( Path[CurPath] == 'None' )
    {
      if ( Target != None )
      {
        GotoState('Seeking');
      } else {
        GotoState('Cruising');
      }
    } else {
      ClosestPoint = None;
      fClosestDistance = 999999.0;
      iClosestPoint = 0;
      SecondClosestPoint = None;
      fSecondClosestDistance = 999999.0;
      foreach AllActors(Class'InterpolationPoint',I,Path[CurPath])
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
        Log(string(Name) $ string(' Could not find an interpolation point to get back to'));
        FlyOnPath(Path[CurPath]);
        if ( Target != None )
        {
          GotoState('Seeking');
        } else {
          GotoState('Cruising');
        }
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
        GetAxes(Rotation,X,Y,Z);
        ReturnPath[0].StartControlPoint = 1000.0 * X;
        ReturnPath[0].EndControlPoint = -1000.0 * X;
        SetCollision(True,False,False);
        bCollideWorld = False;
        bInterpolating = True;
        // SetPhysics(0);
		SetPhysics(PHYS_None);
        Log(string(Name) $ " return path speeds: " $ string(ReturnPath[0].DesiredSpeed) $ ", " $ string(ReturnPath[1].DesiredSpeed));
        Log(string(Name) $ " IPSpeed, Velocity: " $ string(IPSpeed) $ ", " $ string(VSize(Velocity)));
        bGettingBackOnPath = True;
        IM = Spawn(Class'InterpolationManager',self);
        Log(string(Name) $ " Starting GBOP interpolation with " $ string(IM.Name) $ ":" $ string(IM));
        IM.Init(ReturnPath[1],1.0,False);
      }
    }
  }
  
  function EndState()
  {
    PlayerHarry.ClientMessage(string(Name) $ string(' End GetBackOnPath'));
    Log(string(Name) $ string(' End GetBackOnPath'));
    if ( bGettingBackOnPath )
    {
      bGettingBackOnPath = False;
      StopFlyingOnPath();
    }
  }
  
  //UTPT didn't add this for some reason -AdamJD
  event Tick( float DeltaTime )
  {
	Global.Tick( DeltaTime );
  }
  
  event FinishedInterpolation (InterpolationPoint Other)
  {
    if ( IM != None )
    {
      Log(string(Name) $ " Finished interpolation with " $ string(IM.Name) $ ":" $ string(IM));
      IM = None;
      bGettingBackOnPath = False;
      FlyOnPath(Path[CurPath],iReturnPoint);
      if ( Target != None )
      {
        GotoState('Seeking');
      } else {
        GotoState('Cruising');
      }
      Log(string(Name) $ " Finished interpolation event with " $ string(IM.Name) $ ":" $ string(IM));
    }
  }
  
}

defaultproperties
{
    fSpeedChangeFactor=1.00

    fSpeedChangePeriod=60.00

    fSpeedChangeFirstTime=180.00

    fLaunchProximity=1200.00

    fPursuitAbortDistance=1300.00

    fPursuitTimeLimit=4.00

    fLaunchSpeed=700.00

    fLaunchVelocityCompensation=0.30

    bCanWoosh=True

    WooshSounds(0)=Sound'HPSounds.Quidditch_sfx.broom01'

    WooshSounds(1)=Sound'HPSounds.Quidditch_sfx.broom02'

    WooshSounds(2)=Sound'HPSounds.Quidditch_sfx.broom04'

    WooshSounds(3)=Sound'HPSounds.Quidditch_sfx.broom06'

    InitialState=Cruising

    bBlockActors=False

    bBlockPlayers=False

    bAlignBottom=False

    RotationRate=(Pitch=24000,Yaw=50000,Roll=2000)
}
