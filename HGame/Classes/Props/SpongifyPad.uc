//================================================================================
// SpongifyPad.
//================================================================================

class SpongifyPad extends HProp;

var Actor Target;
var Vector vStartPosition;
var Rotator rLast;
var float fScale;
var() bool bEnableOnEvent;
var float fTimeLeft;
var() float fTimeEnabled;
var() float fRaiseAmount;
var() float fTimeToHitTarget;
var() Vector PadDir;
var() float PadSpeed;
var() ParticleFX fxSparkles;
var() Class<ParticleFX> fxSparklesClass;
var SpongifySheet fxSheet;
var bool bBouncing;
var() float fLogTimeInc;

function float ConvertDegToRot (float fDeg)
{
  return (fDeg / 360) * 65536;
}

function Color Col (float R, float G, float B)
{
  local Color C;

  C.R = R;
  C.G = G;
  C.B = B;
  return C;
}

function PreBeginPlay ()
{
  local float Time;
  local Vector Vel;

  PostBeginPlay();
  PlayerHarry = harry(Level.PlayerHarryActor);
  SetCollision(,,);
  if ( Event != 'None' )
  {
    foreach AllActors(Class'Actor',Target)
    {
      if ( Event == Target.Tag )
      {
        // goto JL005F;
		break;
      }
    }
  }
  if ( Target != None )
  {
    Vel = ComputeTrajectoryByTime(Location,Target.Location,fTimeToHitTarget);
    PadSpeed = VSize(Vel);
    PadDir = Normal(Vel);
  }
  vStartPosition = Location;
}

function Vector ProjectFuturePosition (float AtTime)
{
  return Location + (PadDir * PadSpeed * AtTime) + Region.Zone.ZoneGravity * AtTime;
}

event Destroyed ()
{
  TurnOffSpecialFX();
  Super.Destroyed();
}

function bool IsEnabled ()
{
  return  !IsInState('stateDisabled');
}

function TurnOnSpecialFX ()
{
  local Vector hwd;
  local Vector hwdRotated;

  if ( fxSheet == None )
  {
    fxSheet = Spawn(Class'SpongifySheet',self,,Location);
    fxSheet.DesiredRotation = rot(0,0,0);
    fxSheet.DesiredRotation.Yaw += 16383;
    fxSheet.SetRotation(fxSheet.DesiredRotation);
  }
  if ( fxSparkles == None )
  {
    // if ( (bool(CollideType) == bool(0)) || (bool(CollideType) == bool(1)) || (CollisionWidth == byte(0)) )
    if( CollideType == CT_AlignedCylinder || CollideType == CT_OrientedCylinder || CollisionWidth == 0 )
	{
      hwd = Vec(CollisionRadius,CollisionRadius,CollisionHeight);
    } else {
      hwd = Vec(CollisionRadius,CollisionWidth,CollisionHeight);
    }
    hwdRotated = hwd >> Rotation;
    fxSparkles = Spawn(fxSparklesClass,self,,Location);
    fxSparkles.SourceDepth.Base = hwdRotated.X * 2.0;
    fxSparkles.SourceWidth.Base = hwdRotated.Y * 2.0;
    fxSparkles.SourceHeight.Base = hwdRotated.Z * 1.0;
  }
}

function TurnOffSpecialFX ()
{
  if ( fxSparkles != None )
  {
    fxSparkles.Shutdown();
    fxSparkles = None;
  }
  if ( fxSheet != None )
  {
    fxSheet.Destroy();
    fxSheet = None;
  }
}

function UpdateSpecialFX (float fTimeDelta)
{
  fxSparkles.SetRotation(Rotation);
  fxSparkles.SetLocation(Location);
  fxSheet.DesiredRotation = Rotation;
  fxSheet.DesiredRotation.Yaw += 16383;
  fxSheet.SetRotation(fxSheet.DesiredRotation);
  fxSheet.SetLocation(Location);
  if ( bBouncing )
  {
    if ( fxSheet.DrawScale > fxSheet.Default.DrawScale )
    {
      fxSheet.DrawScale -= 4 * fTimeDelta;
    } else {
      fxSheet.DrawScale = fxSheet.Default.DrawScale;
      bBouncing = False;
    }
  }
}

function OnBounce (Actor Other)
{
  PlayerHarry.ClientMessage(" ONBounce called " $ string(Other));
  if ( Other.IsA('harry') )
  {
    if ( Target != None )
    {
      Other.Velocity = ComputeTrajectoryByTime(Location,Target.Location,fTimeToHitTarget);
    } else {
      Other.Velocity = PadDir * PadSpeed;
    }
    fxSheet.DrawScale = fxSheet.Default.DrawScale * 2;
    bBouncing = True;
    PlaySound(Sound'SPN_bounce_on',/*0*/SLOT_None,,True);
  }
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  GotoState('stateDisabled');
}

auto state stateWaitForEvent
{
  function BeginState ()
  {
    if (  !bEnableOnEvent )
    {
      GotoState('stateDisabled');
    }
  }
  
}

state stateDisabled
{
  function BeginState ()
  {
    // eVulnerableToSpell = 21;
	eVulnerableToSpell = SPELL_Spongify;
    bHidden = True;
    DesiredRotation = Default.Rotation;
    SetRotation(DesiredRotation);
    TurnOffSpecialFX();
  }
  
  function bool HandleSpellSpongify (optional baseSpell spell, optional Vector vHitLocation)
  {
    GotoState('stateGoingToEnabled');
    return True;
  }
  
}

state stateGoingToEnabled
{
  function BeginState ()
  {
    local Vector vNewPos;
    local Rotator rNewRot;
  
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    TurnOnSpecialFX();
    rNewRot = rotator(PadDir);
    DesiredRotation.Yaw = rNewRot.Yaw;
    rLast = DesiredRotation;
    PlaySound(Sound'SPN_activate',/*0*/SLOT_None,,True);
    SetLocation(vStartPosition + Vec(0.0,0.0,fRaiseAmount));
    fxSheet.SetLocation(Location);
  }
  
  function Tick (float fTimeDelta)
  {
    local float fNewZ;
  
    UpdateSpecialFX(fTimeDelta);
    if ( (rLast == Rotation) && (fxSheet.Location.Z == vStartPosition.Z + fRaiseAmount) )
    {
      GotoState('stateEnabled');
    }
    rLast = Rotation;
  }
  
}

state stateEnabled
{
  function BeginState ()
  {
    fTimeEnabled = 0.0;
  }
  
  function Tick (float fTimeDelta)
  {
    fTimeEnabled += fTimeDelta;
    UpdateSpecialFX(fTimeDelta);
    if ( fTimeEnabled > Default.fTimeEnabled )
    {
      GotoState('stateGoingToDisabled');
    }
  }
  
}

state stateGoingToDisabled
{
  function BeginState ()
  {
    DesiredRotation = rot(0,0,0);
    SetLocation(vStartPosition);
    fxSheet.SetLocation(Location);
  }
  
  function Tick (float fTimeDelta)
  {
    UpdateSpecialFX(fTimeDelta);
    if ( rLast == Rotation )
    {
      GotoState('stateDisabled');
    }
    rLast = Rotation;
  }
  
}

defaultproperties
{
    fTimeEnabled=30.00

    fRaiseAmount=10.00

    fTimeToHitTarget=2.00

    PadDir=(X=0.00,Y=0.00,Z=1.00)

    PadSpeed=500.00

    fxSparklesClass=Class'HPParticle.SpongifyFlash'

    fLogTimeInc=0.10

    bHidden=True

    // Physics=5
	Physics=PHYS_Rotating

    // DrawType=1
	DrawType=DT_Sprite

    Texture=Texture'HGame.SpongifyTexture'

    Mesh=None

    CollisionRadius=48.00

    CollisionWidth=48.00

    CollisionHeight=4.00

    // CollideType=2
	CollideType=CT_Box

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False

    RotationRate=(Pitch=50000,Yaw=50000,Roll=50000)
}
