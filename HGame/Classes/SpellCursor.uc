//================================================================================
// SpellCursor.
//================================================================================

class SpellCursor extends ParticleFX; 

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\SpellShapes.utx PACKAGE=SpellShapes.SpellFX

const MAX_GESTURE_SIZE= 100.0f;
const MIN_GESTURE_SIZE= 50.0f;
var harry PlayerHarry;
var Actor aPossibleTarget;
var Actor aCurrentTarget;
var Vector vLOS_Dir;
var Vector vLOS_Start;
var Vector vLOS_End;
var Vector vLastValidHitPos;
var float fLOS_Distance;
var bool bInvisibleCursor;
var globalconfig bool bSpellCursorAlwaysOn;
var Vector vTargetOffset; 
var Vector vHitLocation;
var Vector vHitNormal;
var bool bHitSomething;
var GestureSprite SpellGesture;
var Vector vGestureOffset;
var float fFinalGestureDistance;
var bool bDebugMode;

//wet texture variables -AdamJD
var WetTexture FlipendoWetTexture;
var WetTexture LumosWetTexture;
var WetTexture AlohomoraWetTexture;
var WetTexture SkurgeWetTexture;
var WetTexture RictusempraWetTexture;
var WetTexture DiffindoWetTexture;
var WetTexture SpongifyWetTexture;


function SetDebugMode (bool bOn)
{
  bDebugMode = bOn;
}

function bool IsLockedOn()
{
  return aCurrentTarget != None;
}

function PreBeginPlay()
{
  PlayerHarry = harry(Level.PlayerHarryActor);
  if (  !bSpellCursorAlwaysOn || bInvisibleCursor )
  {
    EnableEmission(False);
  }
  SpellGesture = Spawn(Class'GestureSprite');
  if ( SpellGesture == None )
  {
    PlayerHarry.ClientMessage(" Could not create Sprite SpellGesture!!! ");
  }
}

function Destroyed()
{
  if ( SpellGesture != None )
  {
    SpellGesture.Destroy();
  }
  Super.Destroyed();
}

function SetLOSDistance (float fNewDistance)
{
  if ( fNewDistance == 0 )
  {
    fNewDistance = Default.fLOS_Distance;
  }
  fLOS_Distance = fNewDistance;
  PlayerHarry.ClientMessage("SpellCursor: Set spell distance to " $ string(fNewDistance));
}

function WetTexture GetGestureTexture (ESpellType SpellType)
{
  switch (SpellType)
  {
	/*
    case SPELL_None:			return None;
	case SPELL_Flipendo:		return WetTexture'SpellShapes.SpellFX.FlipendoWet1';
	case SPELL_Lumos:			return WetTexture'SpellShapes.SpellFX.LumosWet1';
	case SPELL_Alohomora:		return WetTexture'SpellShapes.SpellFX.AlohomoraWet1';
	case SPELL_Skurge:			return WetTexture'SpellShapes.SpellFX.SkurgeWet1';
	case SPELL_Rictusempra:		return WetTexture'SpellShapes.SpellFX.RictusWet1';
	case SPELL_Diffindo:		return WetTexture'SpellShapes.SpellFX.DiffindoWet1';
	case SPELL_Spongify:		return WetTexture'SpellShapes.SpellFX.SpongifyWet1';
	*/
	
	//return the correct imported wet texture -AdamJD
	case SPELL_None:			return None;
	case SPELL_Flipendo:		return FlipendoWetTexture;
	case SPELL_Lumos:			return LumosWetTexture;
	case SPELL_Alohomora:		return AlohomoraWetTexture;
	case SPELL_Skurge:			return SkurgeWetTexture;
	case SPELL_Rictusempra:		return RictusempraWetTexture;
	case SPELL_Diffindo:		return DiffindoWetTexture;
	case SPELL_Spongify:		return SpongifyWetTexture;
  }
}

function TurnOnSpellGestureFX (ESpellType SpellType, Vector vLocation, float fFXSize)
{
  if ( aCurrentTarget == None )
  {
    return;
  }
  if ( fFXSize < 50.0 )
  {
    fFXSize = 50.0;
  } else //{
    if ( fFXSize > 100.0 )
    {
      fFXSize = 100.0;
    }
  //}
  SpellGesture.SetLocation(vLocation);
  SpellGesture.SetRotation(PlayerHarry.Rotation);
  SpellGesture.Texture = GetGestureTexture(SpellType);
  SpellGesture.DrawScale = 1.0;
}

function bool CanCameraSeeYouInFOV (int rOutsideFOV, Vector Pos)
{
  //local Vector Normal;
  local Vector vNormal;
  local Vector Dir;
  local Rotator OutsideFOV;

  Dir = Pos - PlayerHarry.Cam.Location;
  if ( aCurrentTarget.IsA('spellTrigger') && spellTrigger(aCurrentTarget).bHitJustFromFront &&  !IsHarryFacingTarget(aCurrentTarget) )
  {
    return False;
  }
  if ( VSize(Dir) > fLOS_Distance * 1.25 )
  {
    return False;
  }
  OutsideFOV.Yaw = PlayerHarry.Cam.Rotation.Yaw - rOutsideFOV;
  vNormal = vector(OutsideFOV);
  if ( vNormal Dot Dir > 0.0 )
  {
    OutsideFOV.Yaw = PlayerHarry.Cam.Rotation.Yaw + rOutsideFOV;
    vNormal = vector(OutsideFOV);
    if ( vNormal Dot Dir > 0.0 )
    {
      return True;
    }
  }
  return False;
}

function bool IsHarryFacingTarget (Actor aTarget)
{
  local float fDotProduct;
  local Vector X;
  local Vector Y;
  local Vector Z;

  GetAxes(aTarget.Rotation,X,Y,Z);
  fDotProduct = PlayerHarry.Cam.vForward Dot X;
  PlayerHarry.cm("vLOS_Dir = " $ string(vLOS_Dir) $ " dot =" $ string(fDotProduct));
  if ( fDotProduct >= 0.0 )
  {
    return False;
  }
  return True;
}

function UpdateCursor (optional bool bJustStopAtClosestPawnOrWall)
{
  //local Actor HitActor;
  local Actor aHitActor;
  local bool bHitActor;
  local Vector vFirstHitPos;
  local float fDotProduct;

  if ( bEmit == False &&  !bInvisibleCursor )
  {
    return;
  }
  aPossibleTarget = None;
  bHitSomething = False;
  vLOS_Start = PlayerHarry.Cam.CamTarget.Location;
  if ( PlayerHarry.bInDuelingMode )
  {
    vLOS_End = PlayerHarry.Location + (vector (PlayerHarry.Rotation) * fLOS_Distance);
  } else //{
    if ( PlayerHarry.bHarryUsingSword )
    {
      vLOS_End = PlayerHarry.Cam.Location + (vector (PlayerHarry.Cam.Rotation + PlayerHarry.AimRotOffset) * (PlayerHarry.Cam.CurrentSet.fLookAtDistance + fLOS_Distance));
    } else {
      vLOS_End = PlayerHarry.Cam.Location + (PlayerHarry.Cam.vForward * (PlayerHarry.Cam.CurrentSet.fLookAtDistance + fLOS_Distance));
    }
  //}
  vLOS_Dir = Normal(vLOS_End - vLOS_Start);
  aHitActor = Trace(vHitLocation,vHitNormal,vLOS_End,PlayerHarry.Cam.Location);
  if ( (aHitActor != None) &&  !aHitActor.IsA('harry') )
  {
    bHitSomething = True;
    vLOS_End = vHitLocation + (vLOS_Dir * 5.0);
  }
  foreach TraceActors(Class'Actor',aHitActor,vHitLocation,vHitNormal,vLOS_End,vLOS_Start)
  {
    if ( aHitActor == Owner || aHitActor.IsA('harry') ||  (!aHitActor.IsA('Pawn') &&  !aHitActor.IsA('GridMover') &&  !aHitActor.IsA('spellTrigger')) )
    {
      continue;
    } //else {
      if ( bEmit && bDebugMode )
      {
        PlayerHarry.ClientMessage(" TraceActors Hit actor -> " $ string(HitActor));
      }
      if (  !bHitActor &&  !aHitActor.bHidden )
      {
        bHitSomething = True;
        bHitActor = True;
        vFirstHitPos = vHitLocation;
      }
      if ( aHitActor.eVulnerableToSpell == SPELL_None )
      {
        continue;
      } //else {
        if ( PlayerHarry.IsInSpellBook(aHitActor.eVulnerableToSpell) || (bJustStopAtClosestPawnOrWall) )
        {
          if ( aHitActor.IsA('spellTrigger') && !spellTrigger(aHitActor).bInitiallyActive )
          {
            continue;
          } //else {
              if ( spellTrigger(aHitActor).bHitJustFromFront &&  !IsHarryFacingTarget(HitActor) )
              {
                continue;
              } //else {
                if (  !bJustStopAtClosestPawnOrWall )
                {
                  aPossibleTarget = aHitActor;
                  vTargetOffset = vHitLocation - aPossibleTarget.Location;
                }
                vLastValidHitPos = vHitLocation;
    }
          // }
        // }
      // }
    // }
	 vLOS_End = vHitLocation;
	 break;
  }
  if ( aPossibleTarget == None && bHitActor )
  {
    vLOS_End = vFirstHitPos;
  }
  if ( aCurrentTarget == None )
  {
    MoveSmooth((vLOS_End - (vLOS_Dir * 8.0)) - Location);
    if ( aPossibleTarget != None )
    {
      SpellGesture.SetLocation(vLOS_End);
    }
  }
}

function bool LookForTarget()
{
  if ( aPossibleTarget == None )
  {
    return False;
  }
  if ( aPossibleTarget == aCurrentTarget )
  {
    return True;
  }
  LockOn(aPossibleTarget);
  return True;
}

function UnLock()
{
  if ( aCurrentTarget == None )
  {
    return;
  }
  StopLockedOnSoundLoop();
  aPossibleTarget = None;
  aCurrentTarget = None;
  SpellGesture.bHidden = True;
}

function LockOn (Actor TargetActor)
{
  local float fTargetWidth;
  local float fTargetHeight;
  local float fTargetDepth;
  local Vector dwh;

  if ( TargetActor.CollideType == CT_AlignedCylinder  || TargetActor.CollideType == CT_OrientedCylinder || TargetActor.CollisionWidth == 0 )
  {
    dwh = Vec(TargetActor.CollisionRadius,TargetActor.CollisionRadius,TargetActor.CollisionHeight);
  } else {
    dwh = Vec(TargetActor.CollisionRadius,TargetActor.CollisionWidth,TargetActor.CollisionHeight);
  }
  fTargetDepth = dwh.X * 2.25 * TargetActor.SizeModifier;
  fTargetWidth = dwh.Y * 2.25 * TargetActor.SizeModifier;
  fTargetHeight = dwh.Z * 2.25 * TargetActor.SizeModifier;
  if ( (TargetActor == None) || (PlayerHarry == None) || (PlayerHarry.Weapon == None) )
  {
    Log("SpellCursor::LockOn() -> ERROR TargetActor or playerHarry or playerHarry.Weapon is invalid!!!");
    return;
  }
  if ( fTargetDepth < fTargetWidth )
  {
    fFinalGestureDistance = (fTargetDepth *0.5f) + 2.0 + TargetActor.GestureDistance;
  } else {
    fFinalGestureDistance = (fTargetWidth *0.5f) + 2.0 + TargetActor.GestureDistance;
  }
  baseWand(PlayerHarry.Weapon).ChooseSpell(TargetActor.eVulnerableToSpell);
  aCurrentTarget = TargetActor;
  if ( aCurrentTarget.bGestureFaceHorizOnly )
  {
    vGestureOffset =  -(Vec(fFinalGestureDistance,0.0,0.0));
    TurnOnSpellGestureFX(TargetActor.eVulnerableToSpell,TargetActor.Location + TargetActor.CentreOffset + (vGestureOffset >> PlayerHarry.Rotation),fFinalGestureDistance * TargetActor.SizeModifier);
  } else {
    vGestureOffset = Normal(PlayerHarry.Location - aCurrentTarget.Location) * fFinalGestureDistance;
    TurnOnSpellGestureFX(TargetActor.eVulnerableToSpell,vLOS_End,fFinalGestureDistance * TargetActor.SizeModifier);
  }
  if ( bDebugMode )
  {
    PlayerHarry.ClientMessage("LockedOnto Target using Depth:" $ string(fTargetDepth) $ " Width:" $ string(fTargetWidth) $ " Height:" $ string(fTargetHeight));
  }
  SetSparklesLockedOn(fTargetWidth,fTargetHeight,fTargetDepth);
  SetRotation(TargetActor.Rotation);
  StartLockedOnSoundLoop();
}

function StartLockedOnSoundLoop()
{
  PlaySound(Sound'spell_target_nl3',SLOT_Misc);
  PlaySound(Sound'spell_targetloop',SLOT_Interact);
}

function StopLockedOnSoundLoop()
{
  StopSound(Sound'spell_targetloop',SLOT_Interact);
}

function TurnSparklesOff()
{
}

function SetSparklesIdle()
{
  ParticlesPerSec.Base = 20.0;
  SourceWidth.Base = 3.0;
  SourceHeight.Base = 3.0;
  SourceDepth.Base = 3.0;
  Speed.Base = 0.0;
  Lifetime.Base = 0.31;
  SizeWidth.Base = 4.0;
  SizeLength.Base = 4.0;
  SizeEndScale.Base = 0.75;
  SpinRate.Base = 4.0;
  SpinRate.Rand = -8.0;
  ParticlesAlive = 10;
  ColorStart.Base.R = 255;
  ColorStart.Base.G = 0;
  ColorStart.Base.B = 0;
  ColorEnd.Base.R = 255;
  ColorEnd.Base.G = 255;
  ColorEnd.Base.B = 255;
}

function SetSparklesSeeking()
{
  ParticlesPerSec.Base = 20.0;
  SourceWidth.Base = 10.0;
  SourceHeight.Base = 10.0;
  SourceDepth.Base = 10.0;
  AngularSpreadWidth.Base = 2.0;
  AngularSpreadHeight.Base = 2.0;
  Speed.Base = 5.0;
  Lifetime.Base = 2.0;
  SizeWidth.Base = 8.0;
  SizeWidth.Rand = 10.0;
  SizeLength.Base = 8.0;
  SizeLength.Rand = 10.0;
  SizeEndScale.Base = -0.5;
  SpinRate.Base = 1.0;
  SpinRate.Rand = 20.0;
  Attraction.X = 10.0;
  Attraction.Y = 10.0;
  ParticlesAlive = 10;
  ColorStart.Base.R = 255;
  ColorStart.Base.G = 255;
  ColorStart.Base.B = 255;
  ColorEnd.Base.R = 255;
  ColorEnd.Base.G = 255;
  ColorEnd.Base.B = 0;
}

function SetSparklesLockedOn (float fTargetWidth, float fTargetHeight, float fTargetDepth)
{
  PlayerHarry.cm("SetSparklesLockedOn -> fTargetWidth=" $ string(fTargetWidth) $ " fTargetHeight=" $ string(fTargetHeight) $ " fTargetDepth=" $ string(fTargetDepth));
  ParticlesPerSec.Base = 60.0;
  SourceWidth.Base = fTargetWidth;
  SourceHeight.Base = fTargetHeight;
  SourceDepth.Base = fTargetDepth;
  AngularSpreadWidth.Base = 2.0;
  AngularSpreadHeight.Base = 2.0;
  Speed.Base = 5.0;
  Lifetime.Base = 2.0;
  SizeWidth.Base = 2.0;
  SizeWidth.Rand = 10.0;
  SizeLength.Base = 2.0;
  SizeLength.Rand = 10.0;
  SizeEndScale.Base = -0.5;
  SpinRate.Base = 1.0;
  SpinRate.Rand = 20.0;
  Attraction.X = 10.0;
  Attraction.Y = 10.0;
  ParticlesAlive = 30;
  bRotateToDesired = True;
  ColorStart.Base.R = 255;
  ColorStart.Base.G = 0;
  ColorStart.Base.B = 255;
  ColorEnd.Base.R = 255;
  ColorEnd.Base.G = 0;
  ColorEnd.Base.B = 255;
}

function TurnTargetingOn()
{
}

function TurnTargetingOff()
{
  UnLock();
  GotoState('stateIdle');
}

auto state stateIdle
{
  function BeginState()
  {
    SetSparklesIdle();
    if (  !bSpellCursorAlwaysOn || bInvisibleCursor )
    {
      EnableEmission(False);
    }
  }
  
  function Tick (float fTimeDelta)
  {
    UpdateCursor(PlayerHarry.bHarryUsingSword);
    if ( bHitSomething )
    {
      ColorStart.Base.R = 255;
      ColorStart.Base.G = 255;
      ColorStart.Base.B = 0;
    } else {
      ColorStart.Base.R = 255;
      ColorStart.Base.G = 0;
      ColorStart.Base.B = 0;
    }
  }
  
  function TurnTargetingOn()
  {
    GotoState('stateSeeking');
  }
  
  begin:
  if ( bDebugMode )
  {
    PlayerHarry.ClientMessage("BeginState -> StateIdle");
  }
}

state stateSeeking
{
  function BeginState()
  {
    if (  !bInvisibleCursor )
    {
      EnableEmission(True);
    }
    SetSparklesSeeking();
  }
  
  function EndState()
  {
  }
  
  function Tick (float fTimeDelta)
  {
    UpdateCursor(PlayerHarry.bHarryUsingSword);
    if ( bHitSomething )
    {
      ColorStart.Base.R = 255;
      ColorStart.Base.G = 255;
      ColorStart.Base.B = 0;
    } else {
      ColorStart.Base.R = 255;
      ColorStart.Base.G = 0;
      ColorStart.Base.B = 0;
    }
    if ( True == LookForTarget() )
    {
      GotoState('stateLockedOn');
    }
  }
  
  begin:
  if ( bDebugMode )
  {
    PlayerHarry.ClientMessage("BeginState -> StateSeeking");
  }
}

state stateLockedOn
{
  function Tick (float fTimeDelta)
  {
    UpdateCursor();
    if (  !LookForTarget() &&  !CanCameraSeeYouInFOV(10923,aCurrentTarget.Location) )
    {
      UnLock();
      GotoState('stateSeeking');
    }
    SetLocation(aCurrentTarget.Location);
    if ( (aCurrentTarget != None) && aCurrentTarget.bGestureFaceHorizOnly )
    {
      SpellGesture.SetLocation(aCurrentTarget.Location + aCurrentTarget.CentreOffset + (vGestureOffset >> PlayerHarry.Rotation));
      SpellGesture.bHidden = False;
    } else //{
      if ( aPossibleTarget != None )
      {
        if ( SpellGesture.bHidden && aPossibleTarget == aCurrentTarget )
        {
          SpellGesture.SetLocation(vLOS_End);
          SpellGesture.bHidden = False;
        } else {
          SpellGesture.MoveSmooth((vLOS_End - SpellGesture.Location) * 10.0 * fTimeDelta);
        }
        vTargetOffset = SpellGesture.Location - Location;
      } else //{
        if ( aCurrentTarget != None )
        {
          vGestureOffset = Normal(PlayerHarry.Location - aCurrentTarget.Location) * fFinalGestureDistance;
          SpellGesture.MoveSmooth(((aCurrentTarget.Location + aCurrentTarget.CentreOffset + vGestureOffset) - SpellGesture.Location) * 8.0 * fTimeDelta);
          vTargetOffset = SpellGesture.Location - Location;
        }
      // }
    // }
    if ( bHitSomething || aCurrentTarget != None )
    {
      ColorStart.Base.R = 255;
      ColorStart.Base.G = 255;
      ColorStart.Base.B = 0;
    } else {
      ColorStart.Base.R = 255;
      ColorStart.Base.G = 0;
      ColorStart.Base.B = 0;
    }
  }
  
  begin:
  if ( bDebugMode )
  {
    PlayerHarry.ClientMessage("BeginState -> StateLockedOn ( " $ string(aCurrentTarget) $ " )");
  }
}

defaultproperties
{
    fLOS_Distance=512.00
	
    ParticlesPerSec=(Base=20.00,Rand=0.00)

    SourceWidth=(Base=100.00,Rand=0.00)

    SourceHeight=(Base=100.00,Rand=0.00)

    SourceDepth=(Base=100.00,Rand=0.00)

    AngularSpreadWidth=(Base=2.00,Rand=0.00)

    AngularSpreadHeight=(Base=2.00,Rand=0.00)

    Speed=(Base=5.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=0,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=10.00)

    SizeLength=(Base=2.00,Rand=10.00)

    SizeEndScale=(Base=-0.50,Rand=0.00)

    SpinRate=(Base=1.00,Rand=20.00)

    Attraction=(X=10.00,Y=10.00,Z=0.00)

    ParticlesAlive=10

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_1'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
	
	//wet texture paths, only way I can get these imported is to set them up here in the default properties -AdamJD
	//
	FlipendoWetTexture=WetTexture'SpellShapes.SpellFX.FlipendoWet1'
	
	LumosWetTexture=WetTexture'SpellShapes.SpellFX.LumosWet1'
	
	AlohomoraWetTexture=WetTexture'SpellShapes.SpellFX.AlohomoraWet1'
	
	SkurgeWetTexture=WetTexture'SpellShapes.SpellFX.SkurgeWet1'
	
	RictusempraWetTexture=WetTexture'SpellShapes.SpellFX.RictusWet1'
	
	DiffindoWetTexture=WetTexture'SpellShapes.SpellFX.DiffindoWet1'
	
	SpongifyWetTexture=WetTexture'SpellShapes.SpellFX.SpongifyWet1'
}
