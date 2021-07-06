//================================================================================
// HDiffindo.
//================================================================================

class HDiffindo extends HProp;

var ParticleFX fxCut;
var Class<ParticleFX> fxCutClass;
var ParticleFX fxExplode;
var() Class<ParticleFX> fxExplodeClass0;
var() Class<ParticleFX> fxExplodeClass1;
var() Class<ParticleFX> fxExplodeClass2;
var() Class<ParticleFX> fxExplodeClass3;
var Vector vStartPoint;
var Vector vEndPoint;
var Vector vCutLength;
var BoundingBox bbArea;
var float fCutTime;
var() float fSingleCutTimer;
var() float fDiffindoTimer;
var() bool bUseDiffindoSpellHitFX;
var() Sound DiffindoImpactSound;
var() Sound DiffindoCutSound;

function PreBeginPlay()
{
  PlayerHarry = harry(Level.PlayerHarryActor);
  SetCollision(True,True,True);
  bbArea = GetWorldCollisionBox(True);
  ComputeNewStartAndEndPoints();
}

event Destroyed()
{
  if ( fxCut != None )
  {
    fxCut.Shutdown();
  }
  Super.Destroyed();
}

function ComputeNewStartAndEndPoints()
{
  local float fWidth;
  local float fHeight;
  local float fDepth;

  fWidth = bbArea.Max.X - bbArea.Min.X;
  fDepth = bbArea.Max.Y - bbArea.Min.Y;
  fHeight = bbArea.Max.Z - bbArea.Min.Z;
  switch (Rand(6))
  {
    case 0:
    vStartPoint = bbArea.Min + Vec(0.0,FRand() * fDepth,FRand() * fHeight);
    vEndPoint = bbArea.Max - Vec(0.0,FRand() * fDepth,FRand() * fHeight);
    break;
    case 1:
    vStartPoint = bbArea.Min + Vec(FRand() * fWidth,0.0,FRand() * fHeight);
    vEndPoint = bbArea.Max - Vec(FRand() * fWidth,0.0,FRand() * fHeight);
    break;
    case 2:
    vStartPoint = bbArea.Min + Vec(FRand() * fWidth,FRand() * fDepth,0.0);
    vEndPoint = bbArea.Max - Vec(FRand() * fWidth,FRand() * fDepth,0.0);
    break;
    case 3:
    vStartPoint = bbArea.Max - Vec(0.0,FRand() * fDepth,FRand() * fHeight);
    vEndPoint = bbArea.Min + Vec(0.0,FRand() * fDepth,FRand() * fHeight);
    break;
    case 4:
    vStartPoint = bbArea.Max - Vec(FRand() * fWidth,0.0,FRand() * fHeight);
    vEndPoint = bbArea.Min + Vec(FRand() * fWidth,0.0,FRand() * fHeight);
    break;
    case 5:
    vStartPoint = bbArea.Max - Vec(FRand() * fWidth,FRand() * fDepth,0.0);
    vEndPoint = bbArea.Min + Vec(FRand() * fWidth,FRand() * fDepth,0.0);
    break;
    default:
  }
  vCutLength = vEndPoint - vStartPoint;
}

function UpdateDiffindoFX (float fTimeDelta)
{
  local float fTravel;

  fCutTime += fTimeDelta;
  fTravel = fCutTime / fSingleCutTimer;
  if ( fTravel >= 1.0 )
  {
    fxCut.SetLocation(vEndPoint);
    ComputeNewStartAndEndPoints();
    fCutTime = 0.0;
    fSingleCutTimer *= 0.89999998;
    return;
  }
  fxCut.SetLocation(vStartPoint + vCutLength * fTravel);
}

function OnDiffindoExplode()
{
  if ( fxExplodeClass0 != None )
  {
    fxExplode = Spawn(fxExplodeClass0,self,,Location);
  }
  if ( fxExplodeClass1 != None )
  {
    fxExplode = Spawn(fxExplodeClass1,self,,Location);
  }
  if ( fxExplodeClass2 != None )
  {
    fxExplode = Spawn(fxExplodeClass2,self,,Location);
  }
  if ( fxExplodeClass3 != None )
  {
    fxExplode = Spawn(fxExplodeClass3,self,,Location);
  }
  if ( DiffindoCutSound != None )
  {
    PlaySound(DiffindoCutSound,SLOT_None);
  }
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  GotoState('stateHitByDiffindo');
}

auto state stateIdle
{
  function bool HandleSpellDiffindo (optional baseSpell spell, optional Vector vHitLocation)
  {
    if (  !bUseDiffindoSpellHitFX )
    {
      spell.fxHitParticleEffectClass = None;
    }
    GotoState('stateHitByDiffindo');
    return True;
  }
  
}

function Died (Pawn Killer, name DamageType, Vector HitLocation)
{
  cm("diffindo died()");
}

state stateHitByDiffindo
{
  function BeginState()
  {
    fxCut = Spawn(fxCutClass);
    fxCut.SetLocation(Location);
    fxCut.SetOwner(self);
    ComputeNewStartAndEndPoints();
    fxCut.SetLocation(vStartPoint);
    if ( DiffindoImpactSound != None )
    {
      PlaySound(DiffindoImpactSound,SLOT_Interact,1.0,False,2000.0,1.0);
    }
  }
  
  function Tick (float fTimeDelta)
  {
    fDiffindoTimer -= fTimeDelta;
    UpdateDiffindoFX(fTimeDelta);
    if ( fDiffindoTimer < 0.0 )
    {
      OnDiffindoExplode();
      TriggerEvent(Event,None,None);
      fxCut.Shutdown();
      Destroy();
    }
  }
  
}

state stateHitByDiffindoNoFX
{
  function Tick (float fTimeDelta)
  {
    fDiffindoTimer -= fTimeDelta;
    if ( fDiffindoTimer < 0.0 )
    {
      TriggerEvent(Event,None,None);
      Destroy();
    }
  }
  
}

defaultproperties
{
    fxCutClass=Class'HPParticle.Diffindo_Fly'

    fxExplodeClass0=Class'HPParticle.Diffindo_hit'

    fSingleCutTimer=0.30

    fDiffindoTimer=3.00

    DiffindoCutSound=Sound'HPSounds.Magic_sfx.DFO_hit_rope'

    // eVulnerableToSpell=19
	eVulnerableToSpell=SPELL_Diffindo
}
