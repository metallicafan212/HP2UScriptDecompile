//================================================================================
// HPawn.
//================================================================================

class HPawn extends Pawn;

const NUM_ATTACHED_PARTICLE_FX= 2;
const EaseFromB= -0.171573;
const EaseFromM=  1.171573;
const EaseFromY=  0.171573;
const EaseFromX=  0.2928932188;
enum enumPatrolType {
  PATROLTYPE_PATROL_POINTS,
  PATROLTYPE_PATH_SEARCH,
  PATROLTYPE_SPLINE_FOLLOW
};

var harry PlayerHarry;
var BaseCam Camera;
var() bool bDespawnable;
var bool bDespawned;
var float fCurrTime;
var Class<Decal> ShadowClass;
var() float ShadowScale;
var(SpellEffects) bool bCanLevitate;
var(SpellEffects) float levHeight;
var bool bIsLevitating;
var float levDestZ;
var(SpellEffects) bool bCanTransform;
var(SpellEffects) Class<Actor> transformInto;
var bool hasTransformed;
var(SpellEffects) Class<Actor> classRepairInto;
var(SpellEffects) Class<ParticleFX> classRepairParticalFX;
var(SpellEffects) bool bSpellCausesTrigger;
var bool bDoesntDestroySpell;
var bool bStopLevitating;
var bool lockSpell;
var(Display) Class<ParticleFX> attachedParticleClass[2];
var(Display) Vector attachedParticleOffset[2];
var ParticleFX attachedParticleFX[2];
var bool bThrownObjectDamage;
var() bool bPlayRunAnim;
var(patrol) enumPatrolType ePatrolType;
var NavigationPoint navP;
var NavigationPoint tempNavP;
var NavigationPoint LastNavP;
var NavigationPoint NextPathPoint;
var NavigationPoint SavedFirstNavP;
var NavigationPoint destP;
var(patrol) name FirstObjectName;
var(patrol) name DestinationObjectName;
var(patrol) bool bLoopPath;
var(patrol) bool bIgnoreStationRotations;
var(patrol) float fPatrolAnimRate;
var(PatrolPoints) name firstPatrolPointObjectName;
var(PatrolPoints) bool bGoToClosestPatrolPoint;
var(PatrolPoints) bool bUseFraySplines;
var bool bUseFrayMoveTo;
var name PatrolPointLinkTag;
var bool bSnapToPatrolPoint;
var bool bMoveRequest;
var Vector vMoveRequest;
var Vector vLastLocation;
var float LastLevelTime;
var float fTimeOnPath;
var bool bGoBackToLastNavPoint;
var PatrolPoint LastPatrolPoint;
var Actor LeadingActor;
var(LeadActor) name LeadAnim;
var bool bLeadActorDone;
var string LeadSpeechBumpSet;
var FlyToController _FlyToController;
var enumMoveType eFlyMoveType;
var Vector vFlyToStart;
var Vector vFlyToDest;
var Vector vFlyToDestOffset;
var float fFlyToTime;
var float fFlyToTimeSpan;
var float fEaseBetweenLinearness;
var bool bFlyToFixedToDestActor;
var Actor aFlyToActor;
var bool bFlyToStayLockedToActor;
var() bool bObjectCanBePickedUp;
var() float fThrowVelocity;
var() name ObjectPickupState;
var() bool bAccurateThrowing;
var() bool bCantStandOnMe;
var() bool bIgnoreZonePainDamage;
var Actor ActorToLinkToWeapBone;


function PreBeginPlay ()
{
  Super.PreBeginPlay();
  PlayerHarry = harry(Level.PlayerHarryActor);
  if ( PlayerHarry == None )
  {
    Log("No Harry in Map!");
  }
  DesiredRotation.Yaw = Rotation.Yaw;
  if ( ShadowClass != None )
  {
    Shadow = Spawn(ShadowClass,self);
    if ( ActorShadow(Shadow) != None )
    {
      ActorShadow(Shadow).ShadowSizeFactor *= ShadowScale;
    }
  }
  CreateAttachedParticleFX();
}

function PostBeginPlay ()
{
  Super.PostBeginPlay();
  if ( CutName == "" )
  {
    CutName = string(Name);
  }
  foreach AllActors(Class'BaseCam',Camera)
  {
    // goto JL0032;
	break;
  }
}

function TakeDamage (int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, name DamageType)
{
  if ( (DamageType == 'ZonePain') &&  !bIgnoreZonePainDamage )
  {
    Destroy();
  }
}

function bool PawnCantStandOnMe ()
{
  return bCantStandOnMe;
}

event OnResolveGameState ()
{
  if (  !bInCurrentGameState )
  {
    bHidden = True;
    SetCollision(False,False,False);
  }
}

function ColObjTouch (Actor Other, GenericColObj ColObj)
{
}

function bool ShouldPlayIdleOnRelease ()
{
  return True;
}

event Destroyed ()
{
  local int I;

  // I = 0;
  // if ( I < 2 )
  for(I = 0; I < NUM_ATTACHED_PARTICLE_FX; I++)
  {
    if ( attachedParticleFX[I] != None )
    {
      attachedParticleFX[I].Shutdown();
    }
    // I++;
    // goto JL0007;
  }
  if ( _FlyToController != None )
  {
    _FlyToController.Destroy();
  }
  Super.Destroyed();
}

function CreateAttachedParticleFX ()
{
  local int I;

  // I = 0;
  // if ( I < 2 )
  for(I = 0; I < NUM_ATTACHED_PARTICLE_FX; I++)
  {
    if ( attachedParticleClass[I] != None )
    {
      attachedParticleFX[I] = ParticleFX(FancySpawn(attachedParticleClass[I],self,,Location + attachedParticleOffset[I]));
      attachedParticleFX[I].SetRotation(attachedParticleClass[I].Default.Rotation);
      attachedParticleFX[I].SetPhysics(PHYS_Trailer);
      if ( attachedParticleOffset[I] != vect(0.00,0.00,0.00) )
      {
        attachedParticleFX[I].bTrailerPrePivot = True;
        attachedParticleFX[I].PrePivot = attachedParticleOffset[I];
      }
    }
    // I++;
    // goto JL0007;
  }
}

function killAttachedParticleFX (float Time)
{
  local int I;

  // I = 0;
  // if ( I < 2 )
  for(I = 0; I < NUM_ATTACHED_PARTICLE_FX; I++)
  {
    if ( attachedParticleFX[I] != None )
    {
      attachedParticleFX[I].ParticlesPerSec.Base = 0.0;
      attachedParticleFX[I].Lifetime.Base = 0.0;
      if ( Time == 0.0 )
      {
        attachedParticleFX[I].Destroy();
      } else {
        attachedParticleFX[I].LifeSpan = Time;
      }
    }
    // I++;
    // goto JL0007;
  }
}

auto state() stateIdle
{
}

state() stateInfoPrint
{
}

function ThrownLanded (Vector HitNormal)
{
}

state stateBeingThrown
{
  function Landed (Vector HitNormal)
  {
    ThrownLanded(HitNormal);
  }
  
  function Touch (Actor Other)
  {
    PlayerHarry.ClientMessage("HPawn: Touch:" $ string(Other));
  }
  
  function Bump (Actor Other)
  {
    PlayerHarry.ClientMessage("HPawn: Bump:" $ string(Other));
  }
  
  function HitWall (Vector HitNormal, Actor HitWall)
  {
    PlayerHarry.ClientMessage("HPawn: Hitwall:" $ string(HitWall));
  }
  
 begin:
  Sleep(5.0);
  goto ('Begin');
}

function PawnHearHarryNoise ()
{
}

function Tick (float dtime)
{
  Super.Tick(dtime);
  fCurrTime += dtime;
  if ( fCurrTime < 1.0 )
  {
    return;
  }
  fCurrTime = 0.0;
  if ( bDespawnable && bDespawned )
  {
    if (  !Camera.CameraCanSeeYou(Location) )
    {
      Destroy();
    }
  }
}

function AttachActorToWeaponBone (Actor A)
{
  ActorToLinkToWeapBone = A;
  A.SetPhysics(PHYS_None);
}

function UnAttachActorFromWeaponBone ()
{
  ActorToLinkToWeapBone = None;
}

function DestroyControllers ()
{
  if ( _FlyToController != None )
  {
    _FlyToController.DisableController();
  }
  Super.DestroyControllers();
}

function GlobalCutBypass ()
{
  Super.GlobalCutBypass();
  if ( (_FlyToController != None) && _FlyToController.bEnabled )
  {
    SetLocation2(_FlyToController.GetVDest());
    DoCutCueNotify();
    _FlyToController.DisableController();
  }
}

function bool FollowPatrolPoints (name StartPointName, optional name EndPointName, optional bool bSnapToStartLoc, optional float Speed)
{
  local PatrolPoint dp;

  foreach AllActors(Class'PatrolPoint',dp)
  {
    if ( dp.Name == StartPointName )
    {
      // goto JL002C;
	  break;
    }
  }
  if ( dp == None )
  {
    Log("FollowPatrolPoints: Couldn't find start point");
    return False;
  }
  if ( bSnapToStartLoc )
  {
    SetLocation(dp.Location);
  }
  if ( Speed != 0 )
  {
    GroundSpeed = Speed;
  } else //{
    if ( Characters(self) != None )
    {
      if ( bPlayRunAnim )
      {
        GroundSpeed = GroundRunSpeed;
      } else {
        GroundSpeed = GroundWalkSpeed;
      }
    }
  //}
  firstPatrolPointObjectName = StartPointName;
  DestinationObjectName = EndPointName;
  ePatrolType = PATROLTYPE_PATROL_POINTS;
  bGoBackToLastNavPoint = False;
  navP = None;
  tempNavP = None;
  LastNavP = None;
  GotoState('patrol');
  return True;
}

function bool NavigateToPathNode (name StartPointName, name EndPointName, optional bool bSnapToStartLoc, optional float Speed)
{
  local NavigationPoint sp;
  local NavigationPoint dp;

  foreach AllActors(Class'NavigationPoint',dp)
  {
    if ( dp.Name == EndPointName )
    {
      // goto JL002C;
	  break;
    }
  }
  if ( dp == None )
  {
    Log("NavigateToPathNode: Couldn't find end point named:" $ string(EndPointName));
    return False;
  }
  if ( StartPointName != 'None' )
  {
    foreach AllActors(Class'NavigationPoint',sp)
    {
      if ( sp.Name == StartPointName )
      {
        // goto JL00B3;
		break;
      }
    }
  }
  if ( sp == None )
  {
    sp = FindClosestNavigationPoint(dp.Tag);
  }
  if ( bSnapToStartLoc )
  {
    SetLocation(dp.Location);
  }
  if ( Speed != 0 )
  {
    GroundSpeed = Speed;
  } else //{
    if ( Characters(self) != None )
    {
      if ( bPlayRunAnim )
      {
        GroundSpeed = GroundRunSpeed;
      } else {
        GroundSpeed = GroundWalkSpeed;
      }
    }
  //}
  FirstObjectName = sp.Name;
  DestinationObjectName = EndPointName;
  ePatrolType = PATROLTYPE_PATH_SEARCH;
  navP = None;
  tempNavP = None;
  LastNavP = None;
  GotoState('patrol');
  return True;
}

state() patrol
{
  //UTPT added this for some reason -AdamJD
  //ignores  Tick;
  
  function bool ShouldPlayIdleOnRelease ()
  {
    return False;
  }
  
  function startup ()
  {
    if ( ePatrolType == PATROLTYPE_PATROL_POINTS )
    {
      if ( navP == None )
      {
        foreach AllActors(Class'NavigationPoint',navP)
        {
          if ( navP.Name == firstPatrolPointObjectName )
          {
            // goto JL0045;
			break;
          }
        }
        if ( navP == None )
        {
          GotoState('stateIdle');
          return;
        }
        PatrolPointLinkTag = PatrolPoint(navP).PatrolPointLinkTag;
        LastNavP = navP;
        SavedFirstNavP = navP;
      }
    } else {
      if ( DestinationObjectName != 'None' )
      {
        foreach AllActors(Class'NavigationPoint',navP)
        {
          destP = navP;
          if ( (destP != None) && (destP.Name == DestinationObjectName) )
          {
            // goto JL00DF;
			break;
          }
        }
      }
      if ( FirstObjectName != 'None' )
      {
        foreach AllActors(Class'NavigationPoint',navP)
        {
          if ( navP.Name == FirstObjectName )
          {
            // goto JL011B;
			break;
          }
        }
      }
    }
  }
  
  //UTPT didn't add this for some reason -AdamJD
  function Tick(float dtime)
  {
	Global.Tick(dtime);

	if( bMoveRequest )
	{
		bMoveRequest = False;
		vLastLocation = Location;
		MoveSmooth( vMoveRequest );
	}
  }
  
  function EndState ()
  {
    LastLevelTime = 0.0;
    bMoveRequest = False;
    bNoZoneFriction = False;
  }
  
begin:
  Enable('Tick');
  if ( ePatrolType == PATROLTYPE_SPLINE_FOLLOW )
  {
    GotoState('patrolFollowSpline');
  }
  startup();
  bNoZoneFriction = True;
  if ( (ePatrolType == PATROLTYPE_PATH_SEARCH) && (FirstObjectName == 'None') )
  {
    goto ('idleloop');
  }
  if ( bPlayRunAnim )
  {
    patrolPlayRunAnim();
  } else {
    patrolPlayWalkAnim();
  }
moveLoop:
  if ( ePatrolType == PATROLTYPE_PATH_SEARCH )
  {
    NextPathPoint = FindPath(navP,DestinationObjectName);
  }
  if ( (ePatrolType == PATROLTYPE_PATROL_POINTS) && bUseFraySplines &&  !bGoBackToLastNavPoint && PatrolPoint(navP).bHasSplineInfo )
  {
    // if (  !MoveTo_FraySpline() )
	while (  !MoveTo_FraySpline() )
    {
      Sleep(0.05);
      // goto JL00C7;
    }
  } else {
    if ( (ePatrolType == PATROLTYPE_PATROL_POINTS) && bGoBackToLastNavPoint )
    {
      navP = LastNavP;
      bGoBackToLastNavPoint = False;
    }
    if ( (ePatrolType == PATROLTYPE_PATROL_POINTS) && bUseFrayMoveTo )
    {
      // if (  !MoveTo_Fray() )
	  while (  !MoveTo_Fray() )
      {
        Sleep(0.05);
        // goto JL0125;
      }
    } else {
      if ( VSize2D(navP.Location - Location) > 1 )
      {
        MoveTo(navP.Location);
      }
    }
  }
  if ( ePatrolType == PATROLTYPE_PATROL_POINTS )
  {
    _PawnAtPatrolPoint(PatrolPoint(navP));
  } else {
    if ( navP == destP )
    {
      PawnAtDestination();
    }
    PawnAtStation();
  }
  if ( ePatrolType == PATROLTYPE_PATROL_POINTS )
  {
    tempNavP = navP;
    if ( PatrolPoint(navP).NextPatrolPoint == None )
    {
      if ( bGoToClosestPatrolPoint )
      {
        navP = FindClosestPatrolPoint(LastNavP,navP);
      } else {
        navP = None;
      }
    } else {
      navP = PatrolPoint(navP).NextPatrolPoint;
    }
    LastNavP = tempNavP;
    _PostPawnAtPatrolPoint(PatrolPoint(LastNavP),PatrolPoint(navP));
  } else {
    navP = NextPathPoint;
  }
  if ( navP == None )
  {
idleloop:
    // if ( True )
	while ( True )
    {
      LoopAnim(IdleAnimName,1.0,0.75);
      Sleep(SpeechTime);
      SpeechTime = 0.0;
      Sleep(0.5);
      if ( bLoopPath )
      {
        if ( ePatrolType == PATROLTYPE_PATROL_POINTS )
        {
          foreach AllActors(Class'NavigationPoint',navP)
          {
            if ( navP.Name == firstPatrolPointObjectName )
            {
              // goto JL02D6;
			  break;
            }
          }
        } else {
          foreach AllActors(Class'NavigationPoint',navP)
          {
            if ( navP.Name == FirstObjectName )
            {
              // goto JL0306;
			  break;
            }
          }
        }
		break;
      } //else {
        // goto JL0262;
      //}
    }
  }
  NextPathPoint = None;
  goto ('moveLoop');
}

function RestartPatrol ()
{
  SetLocation2(SavedFirstNavP.Location);
  bPlayRunAnim = False;
  FollowPatrolPoints(SavedFirstNavP.Name,'None',True);
  cm("******* " $ string(Name) $ " RestartPatrol");
}

state statePatrolPointPause
{
  function bool ShouldPlayIdleOnRelease ()
  {
    return False;
  }
  
 begin:
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  LoopAnim(PatrolPoint(LastNavP).PauseAnim,1.0,0.5);
  if ( PatrolPoint(LastNavP).bUseLookDir )
  {
    TurnTo(Location + PatrolPoint(LastNavP).lookDir);
  }
  Sleep(PatrolPoint(LastNavP).PauseTime);
  GotoState('patrol');
}

function bool MoveTo_FraySpline ()
{
  local float dtime;
  local float D;
  local float speed2;
  local float fScale;
  local float t;
  local float NewTimeOnPath;
  local Vector V;
  local Vector v1;
  local Vector v2;
  local Vector vMove;
  local PatrolPoint p;

  if ( LastLevelTime == 0 )
  {
    LastLevelTime = Level.TimeSeconds;
  }
  dtime = Level.TimeSeconds - LastLevelTime;
  LastLevelTime = Level.TimeSeconds;
  dtime = FMin(dtime,0.1);
  D = GroundSpeed * dtime;
  t = D / PatrolPoint(navP).GetTanLenIn();
  NewTimeOnPath = fTimeOnPath + t;
  if ( NewTimeOnPath > 1 )
  {
    NewTimeOnPath = 1.0;
  }
  p = PatrolPoint(navP).PrevPatrolPoint;
  if ( p == None )
  {
    vMove = (navP.Location - Location) * vect(1.00,1.00,0.00);
    if ( vMove != vect(0.00,0.00,0.00) )
    {
      if ( D < VSize(vMove) )
      {
        vMove = Normal(vMove) * D;
      }
    }
  } else {
    v2 = navP.Location + (PatrolPoint(navP).vFraySplineTangent *  -PatrolPoint(navP).GetTanLenIn() * (1 - NewTimeOnPath));
    v1 = p.Location + p.vFraySplineTangent * p.GetTanLenOut() * NewTimeOnPath;
    V = v1 + (v2 - v1) * EaseBetween(NewTimeOnPath);
    vMove = V - Location;
    vMove.Z = 0.0;
    speed2 = VSize(vMove) / dtime;
    if ( speed2 > GroundSpeed * 1.5 )
    {
      vMove *= GroundSpeed * 1.5 / speed2;
    }
  }
  v1 = Location - vLastLocation;
  if ( (v1.X != 0) || (v1.Y != 0) )
  {
    DesiredRotation = rotator(v1 * vect(1.00,1.00,0.00));
  }
  fTimeOnPath = NewTimeOnPath;
  bMoveRequest = True;
  vMoveRequest = vMove;
  if ( VSize2D(Location - navP.Location) < 1 )
  {
    fTimeOnPath = 0.0;
    LastLevelTime = 0.0;
    return True;
  } else {
    return False;
  }
}

function bool MoveTo_Fray ()
{
  local float dtime;
  local float D;
  local float speed2;
  local float fScale;
  local float t;
  local Vector V;
  local Vector v1;
  local Vector v2;
  local Vector vMove;
  local PatrolPoint p;

  if ( LastLevelTime == 0 )
  {
    LastLevelTime = Level.TimeSeconds;
  }
  dtime = Level.TimeSeconds - LastLevelTime;
  LastLevelTime = Level.TimeSeconds;
  dtime = FMin(dtime,0.1);
  D = GroundSpeed * dtime;
  vMove = Normal((navP.Location - Location) * vect(1.00,1.00,0.00)) * D;
  V = vLastLocation;
  v1 = Location - vLastLocation;
  if ( (v1.X != 0) || (v1.Y != 0) )
  {
    DesiredRotation = rotator(v1 * vect(1.00,1.00,0.00));
  }
  bMoveRequest = True;
  vMoveRequest = vMove;
  v1 = navP.Location - V;
  v2 = navP.Location - Location;
  v1.Z = 0.0;
  v2.Z = 0.0;
  t = v1 Dot v2;
  if ( t <= 0 )
  {
    LastLevelTime = 0.0;
    return True;
  } else {
    return False;
  }
}

function patrolPlayRunAnim ()
{
  LoopAnim(RunAnimName,fPatrolAnimRate,0.75);
}

function patrolPlayWalkAnim ()
{
  LoopAnim(WalkAnimName,fPatrolAnimRate,0.75);
}

function PatrolPoint FindClosestPatrolPoint (Actor ExclusionActor1, Actor ExclusionActor2)
{
  local PatrolPoint tempPatrolPoint;
  local float fDist;
  local float fClosestDist;
  local PatrolPoint ClosestActor;

  fClosestDist = 100000.0;
  foreach AllActors(Class'PatrolPoint',tempPatrolPoint)
  {
    if ( (PatrolPointLinkTag != 'None') && (PatrolPointLinkTag != tempPatrolPoint.PatrolPointLinkTag) )
    {
      continue;
    } //else {
      fDist = VSize(Location - tempPatrolPoint.Location);
      if ( (tempPatrolPoint != ExclusionActor1) && (tempPatrolPoint != ExclusionActor2) && (fDist < fClosestDist) )
      {
        fClosestDist = fDist;
        ClosestActor = tempPatrolPoint;
      }
    }
  //}
  return ClosestActor;
}

function NavigationPoint FindClosestNavigationPoint (name PathTag)
{
  local NavigationPoint tempPatrolPoint;
  local float fDist;
  local float fClosestDist;
  local NavigationPoint ClosestActor;

  fClosestDist = 100000.0;
  foreach AllActors(Class'NavigationPoint',tempPatrolPoint,PathTag)
  {
    fDist = VSize(Location - tempPatrolPoint.Location);
    if ( fDist < fClosestDist )
    {
      fClosestDist = fDist;
      ClosestActor = tempPatrolPoint;
    }
  }
  return ClosestActor;
}

function PawnAtStation ()
{
}

function PawnAtDestination ()
{
  OnEvent('ActionDone');
}

function _PawnAtPatrolPoint (PatrolPoint pP)
{
  if ( pP.ActionKeyword != 'None' )
  {
    OnEvent(pP.ActionKeyword);
  }
  PawnAtPatrolPoint(pP);
  if ( pP.EventToSend != 'None' )
  {
    TriggerEvent(pP.EventToSend,None,self);
  }
}

function PawnAtPatrolPoint (PatrolPoint pP)
{
  if ( pP.Name == DestinationObjectName )
  {
    OnEvent('ActionDone');
  }
}

function _PostPawnAtPatrolPoint (PatrolPoint CurrentP, PatrolPoint NextP)
{
  PostPawnAtPatrolPoint(CurrentP,NextP);
  if ( CurrentP.bDestroyPawn )
  {
    Destroy();
  }
  if ( CurrentP.PauseTime > 0 )
  {
    GotoState('statePatrolPointPause');
  }
  if ( CurrentP.PatrolSound != None )
  {
    PlaySound(CurrentP.PatrolSound);
  }
}

function PostPawnAtPatrolPoint (PatrolPoint CurrentP, PatrolPoint NextP)
{
}

function DoFlyTo (Vector DestLoc, enumMoveType MoveType, float TimeSpan)
{
  DoFlyToSetup();
  aFlyToActor = None;
  eFlyMoveType = MoveType;
  vFlyToStart = Location;
  vFlyToDest = DestLoc;
  fFlyToTimeSpan = TimeSpan;
  fFlyToTime = 0.0;
}

function DoFlyTo_Actor (Actor A, Vector vOffset, enumMoveType MoveType, float TimeSpan, bool bFixedToChar, bool bStayLockedToActor)
{
  DoFlyToSetup();
  aFlyToActor = A;
  bFlyToFixedToDestActor = bFixedToChar;
  bFlyToStayLockedToActor = bStayLockedToActor;
  eFlyMoveType = MoveType;
  vFlyToStart = Location;
  vFlyToDest = A.Location;
  vFlyToDestOffset = vOffset;
  fFlyToTimeSpan = TimeSpan;
  fFlyToTime = 0.0;
  _FlyToController.TickParent = A;
}

function DoFlyToSetup ()
{
  if ( _FlyToController == None )
  {
    _FlyToController = FlyToController(FancySpawn(Class'FlyToController',self));
    _FlyToController.SetOwner(self);
  }
  TickParent = _FlyToController;
  _FlyToController.EnableController();
  PlayerHarry.ClientMessage("DoFlyTo:" $ string(CutNotifyActor) $ " " $ sCutNotifyCue);
  if ( _FlyToController == None )
  {
    Log("************* _FlyToController wasnt' made");
    PlayerHarry.ClientMessage("*****FLYTO ERROR: _FlyToController wasnt' made");
  }
}

function OnFlyToDone ()
{
  PlayerHarry.ClientMessage("Flew to:" $ string(vFlyToDest) $ "  Location:" $ string(Location) $ " cue:" $ sCutNotifyCue);
  OnEvent('ActionDone');
  DoCutCueNotify();
}

function LeadActor (Actor Other, name StartPatrolPoint, name EndPatrolPoint, name Anim, string in_LeadSpeechBumpSet)
{
  FollowPatrolPoints(StartPatrolPoint,EndPatrolPoint);
  LeadingActor = Other;
  if ( Anim != 'None' )
  {
    LeadAnim = Anim;
  }
  LeadSpeechBumpSet = in_LeadSpeechBumpSet;
  bLeadActorDone = False;
  GotoState('stateLeadingActor');
}

state stateLeadingActor extends patrol
{
  function bool ShouldPlayIdleOnRelease ()
  {
    return False;
  }
  
  function PostPawnAtPatrolPoint (PatrolPoint CurrentP, PatrolPoint NextP)
  {
    Super.PostPawnAtPatrolPoint(CurrentP,NextP);
    if ( (CurrentP.Name == DestinationObjectName) || CurrentP.bLeadActorWaitPoint &&  !LeadActor_ShouldMoveToNextPatrolPoint(LeadingActor) )
    {
      GotoState('stateLeadingActorPause');
    }
  }
  
}

state stateLeadingActorPause
{
  function Tick (float dtime)
  {
    DesiredRotation.Yaw = rotator(LeadingActor.Location - Location).Yaw;
  }
  
  function bool ShouldPlayIdleOnRelease ()
  {
    return False;
  }
  
  function AnimEnd ()
  {
    if ( AnimSequence == LeadAnim )
    {
      LoopAnim(IdleAnimName,,0.75);
    }
  }
  
begin:
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  if ( LeadAnim != 'None' )
  {
    PlayAnim(LeadAnim,1.0,0.5);
  } else {
    LoopAnim(IdleAnimName,1.0,0.5);
  }
  if ( (LastNavP.Name == DestinationObjectName) || bLeadActorDone )
  {
	bLeadActorDone = True;
	cm("************ LeadActor " $ string(Name) $ " got to dest.  TurningTo forever!!!");
	// if ( True )
	while ( True )
	{
		Sleep(100.0);
		// goto JL00D5;
	}
  }
  do
  {
	if ( (LastNavP.Name != DestinationObjectName) && LeadActor_ShouldMoveToNextPatrolPoint(LeadingActor) )
	{
		if ( (HChar(self) != None) && (LeadSpeechBumpSet != "") )
		{
			HChar(self).DoBumpLine(True,LeadSpeechBumpSet);
		}
		GotoState('stateLeadingActor');
	}
	Sleep(0.2);
  }
  // if (! False ) goto JL00E4;
  until(False);
}

function bool LeadActor_ShouldMoveToNextPatrolPoint (Actor Other)
{
  local PatrolPoint pP;

  if ( VSize(Other.Location - Location) < 300 )
  {
    return True;
  }
  pP = PatrolPoint(navP);
  do
  {
	  if ( pP == None )
	  {
		// goto JL0099;
		break;
	  }
	  if ( VSize(Other.Location - pP.Location) < 300 )
	  {
		return True;
	  }
	  pP = pP.NextPatrolPoint;
	  if ( pP == navP )
	  {
		// goto JL0099;
		break;
	  }
  }
  // if (! False ) goto JL0034;
  until(False);
  
  return False;
}

function HitByThrownObject (int Damage, HPawn InstigatedBy, Vector HitLocation, Vector Momentum, name ObjectType)
{
  PlayerHarry.ClientMessage(string(Name) $ " In HitByThrownObject from: " $ string(InstigatedBy));
  if ( InstigatedBy.bThrownObjectDamage == True )
  {
    PlayerHarry.ClientMessage(" This actor has been damaged by a thrown object ");
    CallHandleSpellBySpellType(InstigatedBy.eVulnerableToSpell,HitLocation);
  }
}

function CallHandleSpellBySpellType (ESpellType SType, Vector HitLocation)
{
  switch (SType)
  {
    case SPELL_Rictusempra:
    HandleSpellRictusempra(None,HitLocation);
    break;
    case SPELL_Alohomora:
    HandleSpellAlohomora(None,HitLocation);
    break;
    case SPELL_Diffindo:
    HandleSpellDiffindo(None,HitLocation);
    break;
    case SPELL_Ecto:
    HandleSpellEcto(None,HitLocation);
    break;
    case SPELL_Flipendo:
    HandleSpellFlipendo(None,HitLocation);
    break;
    case SPELL_Lumos:
    HandleSpellLumos(None,HitLocation);
    break;
    case SPELL_Rictusempra:
    HandleSpellRictusempra(None,HitLocation);
    break;
    case SPELL_Skurge:
    HandleSpellSkurge(None,HitLocation);
    break;
    case SPELL_Spongify:
    HandleSpellSpongify(None,HitLocation);
    break;
    case SPELL_None:
    Log("HPawn is vulnerable to SPELL_None. Change eVulnerableToSpell or overwrite HitByThrownObject");
    break;
    default:
    Log("HPawn is not vulnerable to a known spell. Update HPawn's HitByThrownObject OR overwrite HitByThrownObject OR change eVulnerableToSpell");
    break;
  }
}

function baseSpell SpawnSpell (Class<baseSpell> spellClass, optional Actor aTarget)
{
  local baseSpell spell;

  PlayerHarry.ClientMessage("SpawnSpell called with spellClass:" $ string(spellClass) $ " and Target:" $ string(aTarget));
  if ( (spellClass == None) && (aTarget != None) && (aTarget.eVulnerableToSpell != SPELL_None) )
  {
    spellClass = baseWand(PlayerHarry.Weapon).GetClassFromSpellType(aTarget.eVulnerableToSpell);
  }
  spell = Spawn(spellClass);
  spell.InitSpell(self,aTarget);
  if ( aTarget.IsA('harry') || (aTarget == PlayerHarry) )
  {
    if ( PlayerHarry.Difficulty == DifficultyMedium )
    {
      spell.Speed *= 2;
      spell.Velocity = vector(spell.Rotation) * spell.Speed;
    } else //{
      if ( PlayerHarry.Difficulty == DifficultyHard )
      {
        spell.Speed *= 3;
        spell.Velocity = vector(spell.Rotation) * spell.Speed;
      }
    //}
  }
  return spell;
}

function baseSpell SpawnSpellEx (Class<baseSpell> spellClass, Vector Loc, Rotator Rot, optional Actor aTarget)
{
  local baseSpell spell;

  spell = Spawn(spellClass,,,Loc,Rot);
  spell.InitSpell(self,aTarget);
  return spell;
}

function OnSpellHit (optional baseSpell spell, optional Vector vHitLocation)
{
  if ( bSpellCausesTrigger )
  {
    PlayerHarry.ClientMessage("OnSpellHit: SentTrigger:" $ string(Event));
    TriggerEvent(Event,self,self);
  }
}

function bool HandleSpellAlohomora (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellDiffindo (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellEcto (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellLumos (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellSkurge (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellSpongify (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellDuelRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellDuelMimblewimble (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellDuelExpelliarmus (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function HandleSpellIncantationSound (ESpellType SpellType)
{
  local string SpellIncantation;
  local Sound SpellSound;

  switch (SpellType)
  {
    case SPELL_DuelRictusempra:
    SpellSound = Sound'cast_Rictusempra';
    break;
    case SPELL_DuelMimblewimble:
    SpellSound = Sound'cast_Mimblewimble';
    break;
    case SPELL_DuelExpelliarmus:
    SpellSound = None;
    break;
    default:
  }
  if ( SpellIncantation != "" )
  {
    PlaySound(Sound(DynamicLoadObject("AllDialog." $ SpellIncantation,Class'Sound')),/*5*/SLOT_Talk,,True);
  }
  if ( SpellSound != None )
  {
    PlaySound(SpellSound,/*0*/SLOT_None,,True);
  }
}

function OnEvent (name EventName)
{
  if ( EventName == 'ActionDone' ) 
  {
	//KW left this empty? -AdamJD
  }
}

state stateDestroy
{
begin:
  Sleep(0.01);
  Sleep(0.01);
  Sleep(0.01);
  Destroy();
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local Actor TempActor;
  local string targetName;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "Capture" )
  {
    Acceleration = vect(0.00,0.00,0.00);
    Velocity = vect(0.00,0.00,0.00);
    if ( HasAnim(IdleAnimName) )
    {
      LoopAnim(IdleAnimName,RandRange(0.81,1.25),0.75);
      AnimFrame = RandRange(0.0,0.69999999);
    }
    return True;
  } else //{
    if ( sActualCommand ~= "Release" )
    {
      if ( ShouldPlayIdleOnRelease() )
      {
        LoopAnim(IdleAnimName,1.0,0.75);
      }
      DestroyControllers();
      return True;
    } else //{
      if ( sActualCommand ~= "Say" )
      {
        return CutCommand_Say(Command,cue,bFastFlag);
      } else //{
        if ( sActualCommand ~= "FlyTo" )
        {
          return CutCommand_FlyTo(Command,cue,bFastFlag);
        } else //{
          if ( (sActualCommand ~= "FlyToUnLocked") || (sActualCommand ~= "FrayUnlocked") || (sActualCommand ~= "Funckled") || (sActualCommand ~= "Fuct") )
          {
            _FlyToController.DisableController();
          } else //{
            if ( sActualCommand ~= "MatchRot" )
            {
              return CutCommand_MatchRot(Command,cue,bFastFlag);
            } else //{
              if ( sActualCommand ~= "LeadActor" )
              {
                return CutCommand_LeadActor(Command,cue,bFastFlag);
              } else //{
                if ( sActualCommand ~= "EaseBetweenLinearness" )
                {
                  fEaseBetweenLinearness = float(ParseDelimitedString(Command," ",2,False));
                  return True;
                } else //{
                  if ( sActualCommand ~= "SetOnPatrolPointPath" )
                  {
                    return CutCommand_SetOnPatrolPointPath(Command,cue,bFastFlag);
                  } else //{
                    if ( sActualCommand ~= "GotoState" )
                    {
                      GotoState(name(ParseDelimitedString(Command," ",2,False)));
                      CutCue(cue);
                      return True;
                    } else //{
                      if ( sActualCommand ~= "VisibleInSoftware" )
                      {
                        bRelevantInSoftwareRenderer = True;
                        CutCue(cue);
                        return True;
                      } else //{
                        if ( sActualCommand ~= "InVisibleInSoftware" )
                        {
                          bRelevantInSoftwareRenderer = False;
                          CutCue(cue);
                          return True;
                        } else //{
                          if ( sActualCommand ~= "FadeTo" )
                          {
                            return CutCommand_FadeTo(Command,cue,bFastFlag);
                          } else //{
                            if ( sActualCommand ~= "CastSpell" )
                            {
                              return CutCommand_CastSpell(Command,cue,bFastFlag);
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
  //}
  return Super.CutCommand(Command,cue,bFastFlag);
}

function bool CutCommand_CastSpell (string Command, optional string cue, optional bool bFastFlag)
{
  local baseSpell CastedSpell;
  local string sString;
  local string SpellName;
  local string SpellTarget;
  local Actor aTarget;
  local bool bFoundTarget;
  local int I;

  // I = 1;
  // if ( I < 4 )
  for(I = 1; I < 4; I++)
  {
    sString = ParseDelimitedString(Command," ",I,False);
    if ( Left(sString,12) ~= "SpellTarget=" )
    {
      SpellTarget = Mid(sString,12);
    } else //{
      if ( Left(sString,10) ~= "SpellName=" )
      {
        SpellName = Mid(sString,10);
      } else //{
        if ( sString == "" )
        {
          // goto JL00A0;
		  break;
        }
      //}
    //}
    // I++;
    // goto JL0007;
  }
  if ( SpellTarget == "" )
  {
    CutErrorString = "CastSpell Command is Missing SpellTarget paramater";
    CutNotifyActor.CutCue(cue);
    return False;
  }
  foreach AllActors(Class'Actor',aTarget)
  {
    if ( (aTarget.Name == name(SpellTarget)) || (aTarget.CutName == SpellTarget) )
    {
      bFoundTarget = True;
	  break;
    } //else {
    //}
  }
  if (  !bFoundTarget )
  {
    CutErrorString = "Could not find Actor in level with name: " $ SpellTarget;
    CutNotifyActor.CutCue(cue);
    return False;
  }
  CastedSpell = SpawnSpell(baseWand(PlayerHarry.Weapon).GetClassFromSpellName(SpellName),aTarget);
  CastedSpell.SetLocation(Location + Vec(0.0,0.0,EyeHeight));
  if ( CastedSpell == None )
  {
    CutErrorString = "Could not Cast spell on target:" $ string(aTarget) $ " using spellName:" $ SpellName;
    CutNotifyActor.CutCue(cue);
    return False;
  }
  if ( baseWand(Weapon) != None )
  {
    CastedSpell.SetLocation(baseWand(Weapon).GetWandEndPoint());
  }
  CutNotifyActor.CutCue(cue);
  return True;
}

function bool CutCommand_Template (string Command, optional string cue, optional bool bFastFlag)
{
  local Actor A;
  local string sString;
  local int I;

  I = 2;
  if ( False )
  {
    sString = ParseDelimitedString(Command," ",I,False);
    foreach AllActors(Class'Actor',A)
    {
      if ( A.CutName ~= sString )
      {
        // goto JL0052;
		break;
      }
// JL0052:
    }
    if ( A == None )
    {
      CutErrorString = "No Actor with CutName '" $ sString $ "'";
      CutCue(cue);
      return False;
    }
    I++;
  }
  if ( bFastFlag )
  {
    CutCue(cue);
    return True;
  }
  // I = I;
  // if ( I < 20 )
  for(I = I; I < 20; I++)
  {
    sString = ParseDelimitedString(Command," ",I,False);
    if ( sString == "" )
    {
      // goto JL00FD;
	  break;
    }
    // I++;
    // goto JL00BE;
  }
  sCutNotifyCue = cue;
  return True;
}

function bool CutCommand_LeadActor (string Command, optional string cue, optional bool bFastFlag)
{
  local Actor A;
  local Actor ActorToLead;
  local name StartPatrolPoint;
  local name DestPatrolPoint;
  local string sString;
  local int I;
  local name Anim;
  local string Speech;

  I = 2;
  sString = ParseDelimitedString(Command," ",I,False);
  foreach AllActors(Class'Actor',ActorToLead)
  {
    if ( ActorToLead.CutName ~= sString )
    {
      // goto JL004E;
	  break;
    }
// JL004E:
  }
  if ( ActorToLead == None )
  {
    CutErrorString = "No Actor with CutName '" $ sString $ "'";
    CutNotifyActor.CutCue(cue);
    return False;
  }
  I++;
  sString = ParseDelimitedString(Command," ",I,False);
  foreach AllActors(Class'Actor',A)
  {
    if ( A.CutName ~= sString )
    {
      // goto JL00E8;
	  break;
    }
  }
  if ( A == None )
  {
    CutErrorString = "No Actor with CutName '" $ sString $ "'";
    CutNotifyActor.CutCue(cue);
    return False;
  }
  StartPatrolPoint = A.Name;
  I++;
  sString = ParseDelimitedString(Command," ",I,False);
  foreach AllActors(Class'Actor',A)
  {
    if ( A.CutName ~= sString )
    {
      // goto JL0196;
	  break;
    }
  }
  if ( A == None )
  {
    CutErrorString = "No Actor with CutName '" $ sString $ "'";
    CutNotifyActor.CutCue(cue);
    return False;
  }
  DestPatrolPoint = A.Name;
// JL0196:
  I++;
  // I = I;
  // if ( I < 20 )
  for(I = I; I < 20; I++)
  {
    sString = ParseDelimitedString(Command," ",I,False);
    if ( sString == "" )
    {
      // goto JL029A;
	  break;
    } else //{
      if ( Left(sString,5) ~= "anim=" )
      {
        Anim = name(Mid(sString,5));
      } else //{
        if ( Left(sString,8) ~= "BumpSet=" )
        {
          Speech = Mid(sString,8);
        }
      //}
    //}
    // I++;
    // goto JL0209;
  }
  LeadActor(ActorToLead,StartPatrolPoint,DestPatrolPoint,Anim,Speech);
  sCutNotifyCue = cue;
  return True;
}

function bool CutCommand_FadeTo (string Command, optional string cue, optional bool bFastFlag)
{
  local FadeActorController FAControl;
  local string sString;
  local float fTime;
  local float fOpacity;
  local int I;

  fTime = 1.0;
  fOpacity = 0.5;
  // I = 1;
  // if ( I < 4 )
  for(I = 1; I < 4; I++)
  {
    sString = ParseDelimitedString(Command," ",I,False);
    if ( Left(sString,8) ~= "Opacity=" )
    {
      fOpacity = float(Mid(sString,8));
    } else //{
      if ( Left(sString,5) ~= "Time=" )
      {
        fTime = float(Mid(sString,5));
      } else //{
        if ( sString == "" )
        {
          // goto JL00AF;
		  break;
        }
      //}
    //}
    // I++;
    // goto JL001D;
  }
  if ( bFastFlag )
  {
    fTime = 0.0;
  }
  FAControl = Spawn(Class'FadeActorController');
  FAControl.Init(self,fOpacity,fTime,cue);
  return True;
}

function bool CutCommand_MatchRot (string Command, optional string cue, optional bool bFastFlag)
{
  local Actor A;
  local string sString;
  local int I;
  local Rotator R;

  I = 2;
  sString = ParseDelimitedString(Command," ",2,False);
  foreach AllActors(Class'Actor',A)
  {
    if ( A.CutName ~= sString )
    {
      // goto JL004B;
	  break;
    }
  }
  if ( A == None )
  {
    CutErrorString = "No Actor with ObjectName '" $ sString $ "'";
    CutNotifyActor.CutCue(cue);
    return False;
  }
  I++;
  // I = I;
  // if ( I < 20 )
  for(I = I; I < 20; I++)
  {
    sString = ParseDelimitedString(Command," ",I,False);
    if ( sString == "" )
    {
      // goto JL00EC;
	  break;
    }
    // I++;
    // goto JL00AD;
  }
  if ( A.IsA('InterpolationPoint') )
  {
    R = rotator(InterpolationPoint(A).StartControlPoint);
  } else {
    R = A.Rotation;
  }
  DesiredRotation = R;
  if ( Physics == PHYS_None )
  {
    SetPhysics(PHYS_Rotating);
  }
  bRotateToDesired = True;
  bFixedRotationDir = False;
  if ( bFastFlag )
  {
    SetRotation(R);
  }
  CutNotifyActor.CutCue(cue);
  return True;
}

function bool CutCommand_FlyTo (string Command, optional string cue, optional bool bFastFlag)
{
  local string sCutName;
  local Actor A;
  local string sString;
  local float f;
  local enumMoveType MoveType;
  local bool bFixedToChar;
  local int I;
  local Vector V;
  local Vector v2;
  local bool bTimeSupplied;
  local bool bCalcTimeFromSpeed;
  local float Speed;
  local float t;
  local bool bStayLockedToActor;
  local bool bRelativeJustForInit;

  bFixedToChar = True;
  bRelativeJustForInit = True;
  MoveType = MOVE_TYPE_EASE_FROM_AND_TO;
  sCutName = ParseDelimitedString(Command," ",2,False);
  DestroyControllers();
  foreach AllActors(Class'Actor',A)
  {
    if ( A.CutName ~= sCutName )
    {
      // goto JL0061;
	  break;
    }
  }
  if ( A == None )
  {
    CutErrorString = "FlyTo: No Actor with CutName '" $ sCutName $ "'";
    CutNotifyActor.CutCue(cue);
    return False;
  }
  if ( bFastFlag )
  {
    SetLocation(A.Location);
    CutNotifyActor.CutCue(cue);
    return True;
  }
  // I = 3;
  // if ( I < 15 )
  for(I = 3; I < 15; I++)
  {
    sString = ParseDelimitedString(Command," ",I,False);
    if ( sString == "" )
    {
      // goto JL03B0;
	  break;
    }
    if ( sString ~= "Snap" )
    {
      MoveType = MOVE_SNAP;
    } else //{
      if ( (sString ~= "Linear") || (sString ~= "l") )
      {
        MoveType = MOVE_TYPE_LINEAR;
      } else //{
        if ( (sString ~= "EaseFrom") || (sString ~= "ef") )
        {
          MoveType = MOVE_TYPE_EASE_FROM;
        } else //{
          if ( (sString ~= "EaseTo") || (sString ~= "et") )
          {
            MoveType = MOVE_TYPE_EASE_TO;
          } else //{
            if ( sString ~= "EaseBetween" )
            {
              MoveType = MOVE_TYPE_EASE_FROM_AND_TO;
            } else //{
              if ( (sString ~= "Relative") || (sString ~= "Rel") )
              {
                bFixedToChar = False;
              } else //{
                if ( sString ~= "Fixed" )
                {
                  bRelativeJustForInit = False;
                } else //{
                  if ( Left(sString,2) ~= "x=" )
                  {
                    V.X = float(Mid(sString,2));
                  } else //{
                    if ( Left(sString,2) ~= "y=" )
                    {
                      V.Y = float(Mid(sString,2));
                    } else //{
                      if ( Left(sString,2) ~= "z=" )
                      {
                        V.Z = float(Mid(sString,2));
                      } else //{
                        if ( Left(sString,5) ~= "time=" )
                        {
                          t = float(Mid(sString,5));
                          bTimeSupplied = True;
                        } else //{
                          if ( Left(sString,6) ~= "speed=" )
                          {
                            Speed = float(Mid(sString,6));
                            bCalcTimeFromSpeed = True;
                            bTimeSupplied = True;
                          } else //{
                            if ( (sString ~= "StayLocked") || (sString ~= "sl") )
                            {
                              bStayLockedToActor = True;
                            } else {
                              PlayerHarry.ClientMessage("***** ERROR:" $ string(self) $ ":FlyTo option '" $ sString $ "' not recognised.  Ignoring.");
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
    // I++;
    // goto JL00ED;
  }
  if (  !bTimeSupplied || (t == 0) )
  {
    MoveType = MOVE_SNAP;
  }
  if ( bRelativeJustForInit && (V != vect(0.00,0.00,0.00)) )
  {
    V = V >> A.Rotation;
  }
  if ( MoveType == MOVE_SNAP )
  {
    if (  !SetLocation2(A.Location + V) )
    {
      cm("********** ERROR:  FlyTo/SNAP wasn't able to move:" $ string(self) $ " (cutname:" $ CutName $ ") to destination");
    }
    if ( True )
    {
      CutNotifyActor.CutCue(cue);
    }
  } else {
    sCutNotifyCue = cue;
  }
  if ( bCalcTimeFromSpeed )
  {
    t = VSize(A.Location - Location) / Speed;
  }
  DoFlyTo_Actor(A,V,MoveType,t,bFixedToChar,bStayLockedToActor);
  return True;
}

function bool CutCommand_SetOnPatrolPointPath (string Command, optional string cue, optional bool bFastFlag)
{
  local PatrolPoint A;
  local string sString;
  local int I;

  sString = ParseDelimitedString(Command," ",2,False);
  foreach AllActors(Class'PatrolPoint',A)
  {
    if ( A.CutName ~= sString )
    {
// JL0043:
      // goto JL0043;
	  break;
    }
  }
  if ( A == None )
  {
    CutErrorString = " SetOnPatrolPointPath: No Actor with ObjectName '" $ sString $ "'";
    CutNotifyActor.CutCue(cue);
    return False;
  }
  // I = 3;
  // if ( I < 15 )
  for(I = 3; I < 15; I++)
  {
// JL00B2:
    sString = ParseDelimitedString(Command," ",I,False);
    if ( sString == "" )
    {
      // goto JL00F1;
	  break;
    }
    // I++;
    // goto JL00B2;
  }
  firstPatrolPointObjectName = A.Name;
  ePatrolType = PATROLTYPE_PATROL_POINTS;
  bGoBackToLastNavPoint = False;
// JL00F1:
  navP = None;
  tempNavP = None;
  LastNavP = None;
  GotoState('patrol');
  return True;
}

function float PlayDialog (string dlgId, optional ESoundSlot Slot, optional float Volume, optional bool bNoOverride, optional float Radius, optional float Pitch, optional bool Disable3D, optional bool Loop)
{
  local Sound dlgSound;
  local string dlgString;
  local float sndLen;
  local int I;

  if ( Slot == SLOT_None )
  {
    Slot = SLOT_Talk;
  }
  dlgString = Localize("all",dlgId,"HPdialog");
  dlgSound = Sound(DynamicLoadObject("AllDialog." $ dlgId,Class'Sound'));
  if ( dlgSound != None )
  {
    sndLen = GetSoundDuration(dlgSound);
    if ( Volume == 0 )
    {
      Volume = 1000.0;
    }
    if ( Radius == 0 )
    {
      Radius = 700.0;
    }
    if ( Pitch == 0 )
    {
      Pitch = 1.0;
    }
    PlaySound(dlgSound,Slot,Volume,bNoOverride,Radius,Pitch,Disable3D,Loop);
  } else {
    sndLen = (Len(dlgString) * 0.01) + 3.0;
  }
  return sndLen;
}

function float PlayDialogLoud (string dlgId, optional ESoundSlot Slot, optional float Volume, optional bool bNoOverride, optional float Radius, optional float Pitch, optional bool Disable3D, optional bool Loop)
{
  return PlayDialog(dlgId,Slot,1000000.0,bNoOverride,Radius,Pitch,Disable3D,Loop);
}

function float EaseBetween (float t)
{
  if ( t <= 0 )
  {
    return 0.0;
  } else //{
    if ( t < 0.5 )
    {
      return 2.0 * t * t;
    } else //{
      if ( t < 1.0 )
      {
        return 1.0 - 2.0 * (1.0 - t) * (1.0 - t);
      } else {
        return 1.0;
      }
    //}
  //}
}

function float EaseBetween2 (float t, float HowLinear)
{
  local float X;
  local float Y;
  local float M;
  local float B;

  if ( HowLinear <= 2 )
  {
    return EaseBetween(t);
  }
  X = (HowLinear - Sqrt(HowLinear * HowLinear - 2 * HowLinear)) / (2 * HowLinear);
  M = 2.0 * HowLinear * X;
  B =  -HowLinear * X * X;
  if ( t <= 0 )
  {
    return 0.0;
  } else //{
    if ( t < X )
    {
      return HowLinear * t * t;
    } else //{
      if ( t < 1.0 - X )
      {
        return M * t + B;
      } else {
        return 1.0 - HowLinear * (1.0 - t) * (1.0 - t);
      }
    //}
  //}
}

function float EaseFrom (float t)
{
  if ( t <= 0 )
  {
    return 0.0;
  } else //{
    if ( t < EaseFromX )
    {
      return 2.0 * t * t;
    } else //{
      if ( t < 1.0 )
      {
        return EaseFromM * t + EaseFromB;
      } else {
        return 1.0;
      }
    //}
  //}
}

function float EaseTo (float t)
{
  if ( t <= 0 )
  {
    return 0.0;
  } else //{
    if ( t < 1 - EaseFromX )
    {
      return EaseFromM * t + 0;
    } else //{
      if ( t < 1.0 )
      {
        return 1.0 - 2.0 * (1.0 - t) * (1.0 - t);
      } else {
        return 1.0;
      }
    //}
  //}
}

function float EaseFunction (float t, enumMoveType EaseType)
{
  t = FClamp(t,0.0,1.0);
  switch (EaseType)
  {
    case MOVE_TYPE_EASE_FROM:
    return EaseFrom(t);
    case MOVE_TYPE_EASE_TO:
    return EaseTo(t);
    case MOVE_TYPE_EASE_FROM_AND_TO:
    return EaseBetween(t);
    default:
  }
  return t;
}

function Vector LocationSameZ (Vector Loc, optional Vector ZRef)
{
  local Vector V;

  V = Loc;
  if ( ZRef != vect(0.00,0.00,0.00) )
  {
    V.Z = ZRef.Z;
  } else {
    V.Z = Location.Z;
  }
  return V;
}

function PlayerCutCapture ()
{
}

function PlayerCutRelease ()
{
}

function SetDespawnFlag ()
{
  bDespawned = True;
}

defaultproperties
{
    ShadowScale=1.00

    bPlayRunAnim=True

    fPatrolAnimRate=1.00

    fEaseBetweenLinearness=2.00

    fThrowVelocity=400.00

    // DrawType=2
	DrawType=DT_Mesh

    Mesh=SkeletalMesh'HProps.skSundialMesh'
}
