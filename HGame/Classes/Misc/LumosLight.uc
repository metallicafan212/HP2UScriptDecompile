//================================================================================
// LumosLight.
//================================================================================

class LumosLight extends Actor;

var bool bLumosOn;
var ParticleFX Particles;
var float fLumosTimeToTurnOff;
var float fLumosTime;
var bool bInfiniteLumos;
var bool bUseDebugMode;
var harry PlayerHarry;

function bool EncroachingOn (Actor Other)
{
  return False;
}

singular simulated function Touch (Actor Other)
{
}

simulated function ProcessTouch (Actor Other, Vector HitLocation)
{
}

simulated function HitWall (Vector HitNormal, Actor Wall)
{
}

simulated function Explode (Vector HitLocation, Vector HitNormal)
{
}

function bool IsRelevantToMover()
{
  return False;
}

function PreBeginPlay()
{
  PlayerHarry = harry(Level.PlayerHarryActor);
  // SetPhysics(0);
  SetPhysics(PHYS_None);
  SetCollision(False,False,False);
  bLumosOn = False;
  Disable('Tick');
  PlayerHarry.bLumosOn = False;
}

event Destroyed()
{
  PlayerHarry.ClientMessage("LumosLight: Destroyed() CALLED!!!!!!!!!!!!!! while playerHarry.bLumosOn = " $ string(PlayerHarry.bLumosOn));
  TurnOff();
  if ( Particles != None )
  {
    Particles.Destroy();
  }
}

event FellOutOfWorld()
{
}

function ShowDebugInfo()
{
  PlayerHarry.ClientMessage("bLumosOn = " $ string(bLumosOn));
  PlayerHarry.ClientMessage("LightRadius   = " $ string(LightRadius));
  PlayerHarry.ClientMessage("fLumosTime = " $ string(fLumosTime));
  PlayerHarry.ClientMessage("player.bLumosOn = " $ string(PlayerHarry.bLumosOn));
}

function ScaleParticles (float fScale)
{
  fScale = FClamp(fScale,0.0,1.0);
  LightRadius = 5 + (10 * fScale);
  Particles.SizeWidth.Base = Particles.Default.SizeWidth.Base * fScale;
  Particles.SizeLength.Base = Particles.Default.SizeLength.Base * fScale;
}

function Tick (float fTimeDelta)
{
  if (  !bLumosOn )
  {
    return;
  }
  fLumosTime += fTimeDelta;
  if ( bInfiniteLumos )
  {
    ScaleParticles(0.75 - 0.5 * Abs(Sin(fLumosTime * 0.25)));
    return;
  } else //{
    if ( fLumosTime > fLumosTimeToTurnOff )
    {
      fLumosTime = fLumosTimeToTurnOff;
      TurnOff();
    }
  //}
  ScaleParticles(1.0 - (fLumosTime / fLumosTimeToTurnOff));
}

function UpdateLocation (Vector NewLocation)
{
  SetLocation(NewLocation);
  Particles.SetLocation(NewLocation);
}

function TurnOn()
{
  local Actor A;

  if ( bUseDebugMode )
  {
    PlayerHarry.ClientMessage("LumosLight.TurnOn()  Resetting Lumos counter to 0, was " $ string(fLumosTime));
  }
  fLumosTime = 0.0;
  if ( PlayerHarry.bLumosOn )
  {
    return;
  }
  bLumosOn = True;
  PlayerHarry.bLumosOn = True;
  Enable('Tick');
  TurnDynamicLightOn();
  foreach AllActors(Class'Actor',A)
  {
    A.OnLumosOn();
  }
  if ( Particles != None )
  {
    Particles.Destroy();
  }
  Particles = Spawn(Class'LumosLightFX',self,,Location);
  if ( Particles == None )
  {
    PlayerHarry.ClientMessage("ERROR!!! Particles could not be spawned!!!!!");
  }
  Particles.EnableEmission(True);
  if ( bUseDebugMode )
  {
    PlayerHarry.ClientMessage("LumosLight: Successfuly turned lumos ON!!! while bLumosOn = " $ string(PlayerHarry.bLumosOn) $ " fLumosTime = " $ string(fLumosTime));
  }
}

function TurnOff()
{
  local Actor A;

  if ( bUseDebugMode )
  {
    PlayerHarry.ClientMessage("LumosLight: TurnOff() called! ");
  }
  fLumosTime = 30.0;
  bLumosOn = False;
  PlayerHarry.bLumosOn = False;
  Disable('Tick');
  TurnDynamicLightOff();
  foreach AllActors(Class'Actor',A)
  {
    A.OnLumosOff();
  }
  if ( Particles != None )
  {
    Particles.Destroy();
  }
  if ( bUseDebugMode )
  {
    PlayerHarry.ClientMessage("LumosLight: Successfuly turned lumos OFF!!! while bLumosOn = " $ string(PlayerHarry.bLumosOn) $ " fLumosTime = " $ string(fLumosTime));
  }
}

function TurnDynamicLightOn()
{
  // LightType = 1;
  LightType = LT_Steady;
  // LightEffect = 13;
  LightEffect = LE_NonIncidence;
  LightBrightness = 400;
  LightHue = 32;
  LightSaturation = 72;
  LightRadius = 15;
  LightRadiusInner = 5;
}

function TurnDynamicLightOff()
{
  // LightType = 0;
  LightType = LT_None;
  // LightEffect = 0;
  LightEffect = LE_None;
  LightBrightness = 0;
  LightHue = 0;
  LightSaturation = 0;
  LightRadius = 0;
  LightRadiusInner = 0;
}

defaultproperties
{
    fLumosTimeToTurnOff=30.00

    bUseDebugMode=True

    // RemoteRole=2
	RemoteRole=ROLE_SimulatedProxy

    // DrawType=2
	DrawType=DT_Mesh

    // Style=3
	Style=STY_Translucent

    Texture=None
}
