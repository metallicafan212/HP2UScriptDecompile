//================================================================================
// Ectoplasma.
//================================================================================

class Ectoplasma extends Characters;

const PARTICLES_PER_SECOND_BASE= 60;
var() float fShrinkTime;
var() float fGrowTime;
var() float fDamageTimer;
var() int iDamage;
var() bool bGrowOnEvent;
var float fTimeSpent;
var Actor aSlimedHPawn;
var() Sound ShrinkSound;
var() Sound BumpSound;
var float fxParticlesPerSecond;
var ParticleFX fxHit;
var ParticleFX fxReact;
var Class<ParticleFX> fxHitClass;
var Class<ParticleFX> fxReactClass;

function PreBeginPlay ()
{
  Super.PreBeginPlay();
  SetCollision(True,False,False);
  PlayerHarry = harry(Level.PlayerHarryActor);
  SetTimer(fDamageTimer,True);
  if ( bHidden || (InitialState == 'stateHiding') )
  {
    InitialState = 'stateHiding';
    DrawScale = 0.0;
    bHidden = True;
  }
}

function Bump (Actor Other)
{
  PlaySound(BumpSound,/*1*/SLOT_Misc);
}

function float GetDefaultDrawScale ()
{
  return Default.DrawScale;
}

event Destroyed ()
{
  if ( fxHit != None )
  {
    fxHit.Shutdown();
  }
  if ( fxReact != None )
  {
    fxReact.Shutdown();
  }
  Super.Destroyed();
}

function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
{
  return False;
}

function bool HandleSpellSkurge (optional baseSpell spell, optional Vector vHitLocation)
{
  if ( IsInState('stateShowing') )
  {
    TriggerEvent(Event,None,None);
    fxHit = Spawn(fxHitClass);
    fxHit.SetLocation(Location);
    fxHit.SetOwner(self);
    fxReact = Spawn(fxReactClass);
    fxReact.SetLocation(Location);
    fxReact.SetOwner(self);
    spell.fxHitParticleEffectClass = None;
    GotoState('stateHiding');
    return True;
  }
  return False;
}

function bool HandleSpellEcto (optional baseSpell spell, optional Vector vHitLocation)
{
  if ( IsInState('stateHiding') )
  {
    GotoState('stateShowing');
    return True;
  }
  return False;
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  if ( bGrowOnEvent )
  {
    GotoState('stateShowing');
  } else {
    GotoState('stateHiding');
  }
}

function UpdateFX ()
{
  local Vector colRotated;

  colRotated = Vec(CollisionRadius,CollisionRadius,CollisionHeight) >> Rotation;
  fxHit.SourceHeight.Base = colRotated.X * 2.0 * DrawScale;
  fxHit.SourceWidth.Base = colRotated.Y * 2.0 * DrawScale;
  fxHit.SourceDepth.Base = colRotated.Z * 2.0 * DrawScale;
  fxHit.ParticlesPerSec.Base = fxParticlesPerSecond * DrawScale;
  fxReact.SourceHeight.Base = colRotated.X * 2.0 * DrawScale;
  fxReact.SourceWidth.Base = colRotated.Y * 2.0 * DrawScale;
  fxReact.SourceDepth.Base = colRotated.Z * 2.0 * DrawScale;
  fxReact.ParticlesPerSec.Base = fxParticlesPerSecond * DrawScale;
}

auto state stateIdle //extends stateIdle
{
begin:
  if ( bHidden )
  {
    GotoState('stateHiding');
  } else {
    GotoState('stateShowing');
  }
}

state() stateShowing
{
  function BeginState ()
  {
    bCollideWorld = True;
    // eVulnerableToSpell = 20;
	eVulnerableToSpell = SPELL_Skurge;
    fTimeSpent = 0.0;
    if ( AmbientSound != None )
    {
      AmbientSound = Default.AmbientSound;
    }
  }
  
  function Tick (float fTimeDelta)
  {
    if ( DrawScale < GetDefaultDrawScale() )
    {
      fTimeSpent += fTimeDelta;
      DrawScale = fTimeSpent / fGrowTime;
      if ( DrawScale >= GetDefaultDrawScale() )
      {
        DrawScale = GetDefaultDrawScale();
      }
      UpdateFX();
    }
  }
  
  simulated function Timer ()
  {
    if ( (aSlimedHPawn != None) && aSlimedHPawn.IsA('harry') )
    {
      harry(aSlimedHPawn).TakeDamage(iDamage,self,Location,Vec(0.0,0.0,0.0),'Ectoplasma');
      PlayerHarry.ClientMessage("DamageTimer " $ string(fDamageTimer) $ ", taking damage " $ string(iDamage) $ ", current health is " $ string(PlayerHarry.GetHealthStatusItem().nCount));
    }
  }
  
  function Touch (Actor Other)
  {
    if ( Other.IsA('harry') )
    {
      harry(Other).EctoRefAdd();
      aSlimedHPawn = Other;
    }
  }
  
  function UnTouch (Actor Other)
  {
    if ( Other.IsA('harry') )
    {
      harry(Other).EctoRefSub();
      aSlimedHPawn = None;
    }
  }
  
 begin:
  LoopAnim(AnimSequence);
  AnimFrame = RandRange(0.0,0.94999999);
}

state() stateHiding
{
  function BeginState ()
  {
    bCollideWorld = False;
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    fTimeSpent = 0.0;
    if ( (aSlimedHPawn != None) && aSlimedHPawn.IsA('harry') )
    {
      harry(aSlimedHPawn).EctoRefSub();
    }
    aSlimedHPawn = None;
    PlaySound(ShrinkSound,/*1*/SLOT_Misc,0.69999999);
  }
  
  function EndState ()
  {
    bHidden = False;
  }
  
  function Tick (float fTimeDelta)
  {
    if ( bHidden == False )
    {
      fTimeSpent += fTimeDelta;
      DrawScale = GetDefaultDrawScale() - (fTimeSpent / fShrinkTime);
      if ( DrawScale <= 0.0 )
      {
        DrawScale = 0.0;
        bHidden = True;
        fxHit.Shutdown();
        fxReact.Shutdown();
        PlayerHarry.ClientMessage("Time spent shrinking ectoplasma = " $ string(fTimeSpent));
        if ( AmbientSound != None )
        {
          AmbientSound = None;
        }
      }
      UpdateFX();
    }
  }
  
  function Touch (Actor Other)
  {
  }
  
}

defaultproperties
{
    fShrinkTime=0.85

    fGrowTime=2.50

    fDamageTimer=0.50

    iDamage=10

    ShrinkSound=Sound'HPSounds.Ch2Skurge.ecto_hit'

    BumpSound=Sound'HPSounds.Ch2Skurge.ecto_blocking_movement'

    fxParticlesPerSecond=40.00

    fxHitClass=Class'HPParticle.Skurge_hit'

    fxReactClass=Class'HPParticle.Skurge_react'

    bDoEyeBlinks=False

    // Physics=0
	Physics=PHYS_None

    AnimSequence=idle1

    AmbientSound=Sound'HPSounds.Ch2Skurge.ecto_idle2'

    // eVulnerableToSpell=20
	eVulnerableToSpell=SPELL_Skurge

    // Style=3
	Style=STY_Translucent

    Texture=IceTexture'HPParticle.hp_fx.General.EctoplasmFX'

    Mesh=SkeletalMesh'HPModels.skectoplasmaMesh'

    AmbientGlow=255

    bUnlit=True

    bRandomFrame=True

    bMeshEnviroMap=True

    CollisionRadius=42.00

    CollisionHeight=10.00

    bBlockActors=False

    bBlockPlayers=False
}
