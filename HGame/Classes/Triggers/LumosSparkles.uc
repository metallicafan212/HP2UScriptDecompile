//================================================================================
// LumosSparkles.
//================================================================================

class LumosSparkles extends Triggers;

var harry PlayerHarry;
var float fArea;
var() float fAreaSparklesPerSquareGameUnit;
var() ParticleFX fxAreaSparkles;
var() Class<ParticleFX> fxAreaSparklesClass;
var() float fEdgeSparklesThickness;
var() ParticleFX fxEdgeSparkles[12];
var() Class<ParticleFX> fxEdgeSparklesClass;
var() float fDistanceForAreaEffects;
var() float fDistanceForEdgeEffects;
// DivingDeep39: Vars for customizable Sound and Volume
var(LumosSparklesM212) Sound SparklesSound;
var(LumosSparklesM212) float SparklesSoundVolume;

var float fDistanceToLumosSource;

function PostBeginPlay()
{
  Super.PostBeginPlay();
  PlayerHarry = harry(Level.PlayerHarryActor);
}

event Destroyed()
{
  TurnOffAreaEffects();
  TurnOffEdgeEffects();
}

function TurnOnAreaEffects()
{
  local Vector hwd;
  local Vector hwdRotated;

  if ( fxAreaSparkles == None )
  {
    // if ( (bool(CollideType) == bool(0)) || (bool(CollideType) == bool(1)) || (CollisionWidth == byte(0)) )
    if( CollideType == CT_AlignedCylinder || CollideType == CT_OrientedCylinder || CollisionWidth == 0 )
	{
      hwd = Vec(CollisionRadius,CollisionRadius,CollisionHeight);
    } else {
      hwd = Vec(CollisionRadius,CollisionWidth,CollisionHeight);
    }
    hwdRotated = hwd >> Rotation;
    fxAreaSparkles = Spawn(fxAreaSparklesClass,self,,Location);
    fxAreaSparkles.SourceDepth.Base = hwdRotated.X * 2;
    fxAreaSparkles.SourceWidth.Base = hwdRotated.Y * 2;
    fxAreaSparkles.SourceHeight.Base = hwdRotated.Z * 2;
    fArea = VSize(hwd);
  }
}

function TurnOffAreaEffects()
{
  if ( fxAreaSparkles != None )
  {
    fxAreaSparkles.Shutdown();
    fxAreaSparkles = None;
  }
}

function TurnOnEdgeEffects()
{
  local BoundingBox bbox;
  local float fBoxWidth;
  local float fBoxHeight;
  local float fBoxDepth;
  local int I;

  if ( fxEdgeSparkles[0] == None )
  {
    bbox = GetWorldCollisionBox(True);
    fBoxWidth = bbox.Max.X - bbox.Min.X;
    fBoxDepth = bbox.Max.Y - bbox.Min.Y;
    fBoxHeight = bbox.Max.Z - bbox.Min.Z;
    // I = 0;
    // if ( I < 12 )
	for(I = 0; I < 12; ++I) //for loop -AdamJD
    {
      fxEdgeSparkles[I] = Spawn(fxEdgeSparklesClass,self,,Location);
      fxEdgeSparkles[I].SourceDepth.Base = fEdgeSparklesThickness;
      fxEdgeSparkles[I].SourceWidth.Base = fEdgeSparklesThickness;
      fxEdgeSparkles[I].SourceHeight.Base = fEdgeSparklesThickness;
      // ++I;
      // goto JL0090;
    }	
	fxEdgeSparkles[0].SetLocation(Location + Vec(fBoxWidth / 2,0.0,fBoxHeight / 2));
    fxEdgeSparkles[0].SourceWidth.Base = fBoxDepth;
    fxEdgeSparkles[1].SetLocation(Location + Vec(fBoxWidth / 2,0.0, -(fBoxHeight / 2)));
    fxEdgeSparkles[1].SourceWidth.Base = fBoxDepth;
    fxEdgeSparkles[2].SetLocation(Location + Vec( -(fBoxWidth / 2),0.0,fBoxHeight / 2));
    fxEdgeSparkles[2].SourceWidth.Base = fBoxDepth;
    fxEdgeSparkles[3].SetLocation(Location + Vec( -(fBoxWidth / 2),0.0, -(fBoxHeight / 2)));
    fxEdgeSparkles[3].SourceWidth.Base = fBoxDepth;
    fxEdgeSparkles[4].SetLocation(Location + Vec(0.0,fBoxDepth / 2,fBoxHeight / 2));
    fxEdgeSparkles[4].SourceDepth.Base = fBoxWidth;
    fxEdgeSparkles[5].SetLocation(Location + Vec(0.0,fBoxDepth / 2, -(fBoxHeight / 2)));
    fxEdgeSparkles[5].SourceDepth.Base = fBoxWidth;
    fxEdgeSparkles[6].SetLocation(Location + Vec(0.0, -(fBoxDepth / 2),fBoxHeight / 2));
    fxEdgeSparkles[6].SourceDepth.Base = fBoxWidth;
    fxEdgeSparkles[7].SetLocation(Location + Vec(0.0, -(fBoxDepth / 2), -(fBoxHeight / 2)));
    fxEdgeSparkles[7].SourceDepth.Base = fBoxWidth;
    fxEdgeSparkles[8].SetLocation(Location + Vec(fBoxWidth / 2,fBoxDepth / 2,0.0));
    fxEdgeSparkles[8].SourceHeight.Base = fBoxHeight;
    fxEdgeSparkles[9].SetLocation(Location + Vec( -(fBoxWidth / 2),fBoxDepth / 2,0.0));
    fxEdgeSparkles[9].SourceHeight.Base = fBoxHeight;
    fxEdgeSparkles[10].SetLocation(Location + Vec(fBoxWidth / 2, -(fBoxDepth / 2),0.0));
    fxEdgeSparkles[10].SourceHeight.Base = fBoxHeight;
    fxEdgeSparkles[11].SetLocation(Location + Vec( -(fBoxWidth / 2), -(fBoxDepth / 2),0.0));
    fxEdgeSparkles[11].SourceHeight.Base = fBoxHeight;
  }
  // DivingDeep39: Replaced the original function to insert new vars
  //PlaySound(Sound'Lumos_glow_loop',SLOT_Interact,0.5,True,,,,True);
  PlaySound(SparklesSound,SLOT_Interact,SparklesSoundVolume,True,,,,True);
}

function TurnOffEdgeEffects()
{
  local int I;

  if ( fxEdgeSparkles[0] != None )
  {
	for(I = 0; I < 12; ++I) 
    {
      if ( fxEdgeSparkles[I] != None )
      {
        fxEdgeSparkles[I].Shutdown();
        fxEdgeSparkles[I] = None;
      }
    }
  }
  StopSound(Sound'Lumos_glow_loop',SLOT_Interact);
}

function UpdateSparkles()
{
  fDistanceToLumosSource = VSize(PlayerHarry.Cam.Location - Location);
  if ( fDistanceToLumosSource < fDistanceForEdgeEffects )
  {
    TurnOnEdgeEffects();
  } else {
    TurnOffEdgeEffects();
  }
  if ( fDistanceToLumosSource < fDistanceForAreaEffects )
  {
    TurnOnAreaEffects();
    fxAreaSparkles.ParticlesPerSec.Base = fArea * fAreaSparklesPerSquareGameUnit;
    fxAreaSparkles.ParticlesPerSec.Base -= (fDistanceToLumosSource * 0.015);
    if ( fxAreaSparkles.ParticlesPerSec.Base < 0.025 )
    {
      fxAreaSparkles.ParticlesPerSec.Base = 0.025;
    }
  } else {
    TurnOffAreaEffects();
  }
}

auto state StateLumosOff
{
  function BeginState()
  {
    PlayerHarry.ClientMessage(" LumosSparkles " $ string(self) $ " BeginState LumosOff called!!");
    TurnOffAreaEffects();
    TurnOffEdgeEffects();
  }
  
  function OnLumosOn()
  {
    GotoState('StateWaitingToTurnOn');
  }
}

state StateWaitingToTurnOn
{
  event Tick (float fTimeDelta)
  {
    fDistanceToLumosSource = VSize(PlayerHarry.Cam.Location - Location);
    if ( fDistanceToLumosSource < fDistanceForAreaEffects )
    {
      GotoState('StateLumosOn');
    }
  }
  
  function OnLumosOff()
  {
    GotoState('StateLumosOff');
  }
}

state StateLumosOn
{
  event Tick (float fTimeDelta)
  {
    UpdateSparkles();
  }
  
  function OnLumosOff()
  {
    GotoState('StateLumosOff');
  }
}

defaultproperties
{
    fAreaSparklesPerSquareGameUnit=0.25

    fxAreaSparklesClass=Class'HPParticle.Lumos_react'

    fEdgeSparklesThickness=4.00

    fxEdgeSparklesClass=Class'HPParticle.Diffindo_ropeFx'

    fDistanceForAreaEffects=1536.00

    fDistanceForEdgeEffects=768.00

    CollisionRadius=128.00

    CollisionHeight=128.00

    // CollideType=2
	CollideType=CT_Box
	
	// DivingDeep39: New vars defaults
	SparklesSound=Sound'Lumos_glow_loop'
	
	SparklesSoundVolume=0.5
}
