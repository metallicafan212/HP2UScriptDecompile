//================================================================================
// BroomHoop.
//================================================================================

class BroomHoop extends HProp;

const fSmallParticlesPerSec= 50.0f;
var() int PathNumber;
var() int Stage;
var() int HoopNumber;
var() float PlayScale;
var() bool bBobbing;
var float fOriginalParticlesPerSec;
var bool bPulseUp;
var float fGlowOutRate;

function PostBeginPlay()
{
  Super.PostBeginPlay();
  // DrawType = 0;
  DrawType = DT_None;
  InitialState = 'HoopInvisible';
  if ( attachedParticleFX[0] != None )
  {
    fOriginalParticlesPerSec = attachedParticleFX[0].ParticlesPerSec.Base;
  }
}

function changeAttachedParticleFX (Class<ParticleFX> newFX)
{
  if ( attachedParticleFX[0] != None )
  {
    attachedParticleFX[0].Destroy();
  }
  attachedParticleFX[0] = Spawn(newFX,self,,Location + attachedParticleOffset[0]);
  if ( attachedParticleFX[0] != None )
  {
    attachedParticleFX[0].SetRotation(newFX.Default.Rotation);
    // attachedParticleFX[0].SetPhysics(11);
	attachedParticleFX[0].SetPhysics(PHYS_Trailer);
    fOriginalParticlesPerSec = attachedParticleFX[0].ParticlesPerSec.Base;
    if ( IsInState('HoopVisible') || IsInState('HoopAppearing') )
    {
      attachedParticleFX[0].ParticlesPerSec.Base = fSmallParticlesPerSec;
    }
  }
}

state HoopInvisible
{
  function BeginState()
  {
    if ( attachedParticleFX[0] != None )
    {
      attachedParticleFX[0].EnableEmission(False);
    }
    PlayAnim('hold1',,0.0);
  }
  
}

state HoopAppearing
{
  function BeginState()
  {
    bHidden = False;
    if ( attachedParticleFX[0] != None )
    {
      attachedParticleFX[0].EnableEmission(True);
      attachedParticleFX[0].ParticlesPerSec.Base = fSmallParticlesPerSec;
    }
    DrawScale = PlayScale;
    ScaleGlow = 1.0;
    PlayAnim('hold1',,0.0);
  }
  
  event AnimEnd()
  {
    GotoState('HoopVisible');
    LoopAnim('hold1');
  }
  
}

state HoopVisible
{
  function BeginState()
  {
    bHidden = False;
    if ( attachedParticleFX[0] != None )
    {
      attachedParticleFX[0].EnableEmission(True);
      attachedParticleFX[0].ParticlesPerSec.Base = fSmallParticlesPerSec;
    }
    DrawScale = PlayScale;
    ScaleGlow = 1.0;
  }
  
}

state HoopNextToHit
{
  function BeginState()
  {
    bHidden = False;
    if ( attachedParticleFX[0] != None )
    {
      attachedParticleFX[0].EnableEmission(True);
      attachedParticleFX[0].ParticlesPerSec.Base = fOriginalParticlesPerSec;
    }
    DrawScale = PlayScale;
    ScaleGlow = 1.0;
    PlayAnim('grow2',,0.0);
    bPulseUp = True;
  }
  
  event AnimEnd()
  {
    LoopAnim('hold3');
  }
  
  event Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    if ( bPulseUp )
    {
      ScaleGlow += 20.0 * DeltaTime;
      if ( ScaleGlow >= 3.0 )
      {
        ScaleGlow = 5.19999981;
        bPulseUp = False;
      }
    } else {
      ScaleGlow -= 20.0 * DeltaTime;
      if ( ScaleGlow < 0.2 )
      {
        ScaleGlow = 0.2;
        bPulseUp = True;
      }
    }
  }
  
}

state HoopDisappearing
{
  function BeginState()
  {
    bHidden = False;
    if ( attachedParticleFX[0] != None )
    {
      attachedParticleFX[0].EnableEmission(True);
      attachedParticleFX[0].ParticlesPerSec.Base = fOriginalParticlesPerSec;
    }
    PlayAnim('Die');
    fGlowOutRate = ScaleGlow / 0.69999999;
  }
  
  event AnimEnd()
  {
  }
  
  event Tick (float DeltaTime)
  {
    Super.Tick(DeltaTime);
    ScaleGlow -= fGlowOutRate * DeltaTime;
    if ( ScaleGlow <= 0.0 )
    {
      ScaleGlow = 0.0;
      GotoState('HoopInvisible');
    }
  }
  
}

defaultproperties
{
    PathNumber=1

    HoopNumber=1

    PlayScale=1.00

    Mesh=SkeletalMesh'HProps.skBroomHoopMesh'

    CollisionRadius=70.00

    CollisionHeight=70.00

    bCollideActors=False

    bCollideWorld=False

    bBlockActors=False

    bBlockPlayers=False
}
