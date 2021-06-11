//================================================================================
// AragogStickyWeb.
//================================================================================

class AragogStickyWeb extends Characters;

var float fShrinkTime;
var float fGrowTime;
var Sound ShrinkSound;
var float grownDrawScale;
var float fTimeSpent;
var Actor aSlimedHPawn;
var ParticleFX fxHit;
var ParticleFX fxReact;
var Class<ParticleFX> fxHitClass;
var Class<ParticleFX> fxReactClass;
var float fLifetime;
var float fDamageTimer;
var int iDamage;
var float DamageTime;
var bool bTouch;

function PreBeginPlay ()
{
  Super.PreBeginPlay();
  SetCollision(True,False,False);
  DamageTime = 0.0;
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

function Timer ()
{
  GotoState('stateHiding');
}

function BeginToGrow ()
{
  PlaySound(ShrinkSound,SLOT_None,0.25);
  GotoState('stateShowing');
}

auto state stateIdle
{
begin:
  DrawScale = 0.0;
  bHidden = True;
}

state stateShowing
{
  function BeginState ()
  {
    bCollideWorld = True;
    // eVulnerableToSpell = 0;
	eVulnerableToSpell = SPELL_None;
    fTimeSpent = 0.0;
    bHidden = False;
    if ( FastTrace(Location + Vec(0.0,0.0,-45.0),Location) )
    {
      // SetPhysics(2);
	  SetPhysics(PHYS_Falling);
    }
    fGrowTime *= RandRange(0.2,0.31);
  }
  
  function Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    DamageTime -= fTimeDelta;
    if ( DamageTime <= 0 )
    {
      if ( (aSlimedHPawn != None) && aSlimedHPawn.IsA('harry') )
      {
        DamageTime = fDamageTimer;
        harry(aSlimedHPawn).TakeDamage(iDamage,self,Location,Vec(0.0,0.0,0.0),'AragogStickyWeb');
        PlayerHarry.ClientMessage("DamageTimer " $ string(fDamageTimer) $ ", taking damage " $ string(iDamage) $ ", current health is " $ string(PlayerHarry.GetHealthStatusItem().nCount));
      }
    }
    if ( DrawScale < grownDrawScale )
    {
      fTimeSpent += fTimeDelta;
      DrawScale = fTimeSpent / fGrowTime;
      if ( DrawScale >= grownDrawScale )
      {
        SetTimer(fLifetime + RandRange( -fLifetime / 5,fLifetime / 5),False);
        DrawScale = grownDrawScale;
        GotoState('DoneGrowing');
      }
    }
  }
  
  function Touch (Actor Other)
  {
    if ( bTouch == False )
    {
      bTouch = True;
      if ( Other.IsA('harry') )
      {
        Aragog(Owner).bOnStickyWeb = True;
        PlayerHarry.WebAnimRefCountAdd();
        aSlimedHPawn = PlayerHarry;
      }
    }
  }
  
  function Bump (Actor Other)
  {
    Touch(Other);
  }
  
  function UnTouch (Actor Other)
  {
    bTouch = False;
    if ( Other.IsA('harry') )
    {
      harry(Other).WebAnimRefCountSub();
      aSlimedHPawn = None;
    }
  }
  
}

state StuckinSlimeWhileGrowing
{
begin:
  Aragog(Owner).bOnStickyWeb = True;
  PlayerHarry.WebAnimRefCountAdd();
  aSlimedHPawn = PlayerHarry;
  GotoState('stateShowing');
}

state DoneGrowing
{
  function BeginState ()
  {
    // eVulnerableToSpell = 19;
	eVulnerableToSpell = SPELL_Diffindo;
  }
  
  function bool HandleSpellDiffindo (optional baseSpell spell, optional Vector vHitLocation)
  {
    GotoState('stateHiding');
    return True;
  }
  
  function Touch (Actor Other)
  {
    if ( bTouch == False )
    {
      bTouch = True;
      if ( Other.IsA('harry') )
      {
        Aragog(Owner).bOnStickyWeb = True;
        PlayerHarry.WebAnimRefCountAdd();
        aSlimedHPawn = PlayerHarry;
      }
    }
  }
  
  function Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    DamageTime -= fTimeDelta;
    DamageTime -= fTimeDelta;
    if ( DamageTime <= 0 )
    {
      if ( (aSlimedHPawn != None) && aSlimedHPawn.IsA('harry') )
      {
        DamageTime = fDamageTimer;
        harry(aSlimedHPawn).TakeDamage(iDamage,self,Location,Vec(0.0,0.0,0.0),'AragogStickyWeb');
        PlayerHarry.ClientMessage("DamageTimer " $ string(fDamageTimer) $ ", taking damage " $ string(iDamage) $ ", current health is " $ string(PlayerHarry.GetHealthStatusItem().nCount));
      }
    }
  }
  
  function UnTouch (Actor Other)
  {
    bTouch = False;
    if ( Other.IsA('harry') )
    {
      harry(Other).WebAnimRefCountSub();
      aSlimedHPawn = None;
    }
  }
  
 begin:
  LoopAnim(AnimSequence);
  AnimFrame = RandRange(0.0,0.94999999);
}

state StuckinSlimeDoneGrowing
{
begin:
  Aragog(Owner).bOnStickyWeb = True;
  PlayerHarry.WebAnimRefCountAdd();
  aSlimedHPawn = PlayerHarry;
  GotoState('DoneGrowing');
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
      harry(aSlimedHPawn).WebAnimRefCountSub();
    }
    aSlimedHPawn = None;
    fShrinkTime *= RandRange(0.81,1.25);
    PlaySound(ShrinkSound,SLOT_None,0.25);
  }
  
  function Tick (float fTimeDelta)
  {
    if ( bHidden == False )
    {
      fTimeSpent += fTimeDelta;
      DrawScale = grownDrawScale - fTimeSpent / fShrinkTime;
      if ( DrawScale <= 0.0 )
      {
        DrawScale = 0.0;
        bHidden = True;
        if ( fxHit != None )
        {
          fxHit.Shutdown();
        }
        if ( fxReact != None )
        {
          fxReact.Shutdown();
        }
      }
    }
  }
  
}

defaultproperties
{
    fShrinkTime=1.70

    fGrowTime=0.25

    ShrinkSound=Sound'HPSounds.Ch2Skurge.ecto_hit'

    grownDrawScale=1.00

    fxHitClass=Class'HPParticle.Skurge_hit'

    fxReactClass=Class'HPParticle.Skurge_react'

    fLifetime=1.00

    fDamageTimer=0.05

    iDamage=2

    bDoEyeBlinks=False

    // Physics=0
	Physics=PHYS_None

    AnimSequence=Idle

    AmbientSound=Sound'HPSounds.Ch2Skurge.ecto_idle2'

    // eVulnerableToSpell=19
	eVulnerableToSpell=SPELL_Diffindo

    Mesh=SkeletalMesh'HPModels.skAragogStickyWebMesh'

    DrawScale=0.20

    bRandomFrame=True

    CollisionRadius=25.00

    CollisionHeight=10.00

    bBlockActors=False

    bBlockPlayers=False
}
