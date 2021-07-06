//================================================================================
// SpiderStickyWeb.
//================================================================================

class SpiderStickyWeb extends Characters;

const PARTICLES_PER_SECOND_BASE= 60;
var float fShrinkTime;
var float fGrowTime;
var Sound ShrinkSound;
var Sound BumpSound;
var float grownDrawScale;
var float fTimeSpent;
var Actor aSlimedHPawn;
var float fxParticlesPerSecond;
var ParticleFX fxHit;
var ParticleFX fxReact;
var Class<ParticleFX> fxHitClass;
var Class<ParticleFX> fxReactClass;
var float fWebLifetime;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  SetCollision(True,False,False);
}

function PostBeginPlay()
{
  Super.PostBeginPlay();
}

function Timer()
{
  PlayerHarry.ClientMessage("The timer has fired");
  GotoState('stateHiding');
}

function Bump (Actor Other)
{
  PlaySound(BumpSound,SLOT_None);
}

event Destroyed()
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

function bool HandleSpellRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
  GotoState('stateHiding');
  return True;
}

function UpdateFX()
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

auto state stateIdle
{
begin:
  SetTimer(fWebLifetime,False);
  SpiderLarge(Owner).AddWebs();
  GotoState('stateShowing');
}

state() stateShowing
{
  function BeginState()
  {
    bCollideWorld = True;
    // eVulnerableToSpell = 22;
	eVulnerableToSpell = SPELL_Rictusempra;
    fTimeSpent = 0.0;
  }
  
  function Tick (float fTimeDelta)
  {
    if ( DrawScale < grownDrawScale )
    {
      fTimeSpent += fTimeDelta;
      DrawScale = fTimeSpent / fGrowTime;
      if ( DrawScale >= grownDrawScale )
      {
        DrawScale = grownDrawScale;
      }
    }
  }
  
  function Touch (Actor Other)
  {
    if ( Other.IsA('harry') )
    {
      GotoState('StuckinSlime');
    }
  }
  
  function UnTouch (Actor Other)
  {
    if ( Other.IsA('harry') )
    {
      harry(Other).WebAnimRefCountSub();
      aSlimedHPawn = None;
    }
  }
  
}

state StuckinSlime
{
begin:
  PlayerHarry.PlayAnim('webstuck');
  FinishAnim();
  PlayerHarry.WebAnimRefCountAdd();
  aSlimedHPawn = PlayerHarry;
  GotoState('stateShowing');
}

state() stateHiding
{
  function BeginState()
  {
    bCollideWorld = False;
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    fTimeSpent = 0.0;
    if ( (aSlimedHPawn != None) && aSlimedHPawn.IsA('harry') )
    {
      harry(aSlimedHPawn).WebAnimRefCountSub();
    }
    aSlimedHPawn = None;
    PlaySound(ShrinkSound,SLOT_None);
  }
  
  function Tick (float fTimeDelta)
  {
    if ( bHidden == False )
    {
      fTimeSpent += fTimeDelta;
      DrawScale = grownDrawScale - (fTimeSpent / fShrinkTime);
      if ( DrawScale <= 0.0 )
      {
        DrawScale = 0.0;
        bHidden = True;
        GotoState('stateDestroy');
      }
    }
  }
  
}

state stateDestroy
{
begin:
  PlayerHarry.ClientMessage(string(self.Name) $ " :  We are in state Destroy");
  SpiderLarge(Owner).SubWebs();
  Destroy();
}

defaultproperties
{
    fShrinkTime=1.70

    fGrowTime=2.50

    ShrinkSound=Sound'HPSounds.Ch2Skurge.ecto_hit'

    BumpSound=Sound'HPSounds.Ch2Skurge.ecto_blocking_movement'

    grownDrawScale=1.00

    fxParticlesPerSecond=40.00

    fxHitClass=Class'HPParticle.Skurge_hit'

    fxReactClass=Class'HPParticle.Skurge_react'

    bDoEyeBlinks=False

    // Physics=0
	Physics=PHYS_None

    AnimSequence=idle1

    // eVulnerableToSpell=22
	eVulnerableToSpell=SPELL_Rictusempra

    // Style=3
	Style=STY_Translucent

    Texture=IceTexture'HPParticle.hp_fx.General.EctoplasmFX'

    Mesh=SkeletalMesh'HPModels.skectoplasmaMesh'

    DrawScale=0.20

    AmbientGlow=255

    bUnlit=True

    bRandomFrame=True

    bMeshEnviroMap=True

    CollisionRadius=35.00

    CollisionHeight=10.00

    bBlockActors=False

    bBlockPlayers=False
}
