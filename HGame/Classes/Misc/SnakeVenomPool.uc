//================================================================================
// SnakeVenomPool.
//================================================================================

class SnakeVenomPool extends HProp;

var() float fShrinkTime;
var() float fGrowTime;
var() float fDamageTimer;
var() int iDamage;
var bool bGrowOnEvent;
var float fTimeSpent;
var Actor aSlimedHPawn;
var() Sound ShrinkSound;
var float fxParticlesPerSecond;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  if (  !bInCurrentGameState )
  {
    bHidden = True;
    SetCollision(False,False,False);
    return;
  }
  SetCollision(True,False,False);
  SetTimer(fDamageTimer,True);
  if ( InitialState == 'stateHiding' )
  {
    DrawScale = 0.0;
    bHidden = True;
  }
  fShrinkTime *= RandRange(0.81,1.20);
  fGrowTime *= RandRange(0.81,1.20);
  if ( FRand() > 0.75 )
  {
    switch (Rand(6))
    {
      case 0:
      PlaySound(Sound'ss_COS_venomland_01E',,RandRange(0.31,0.62),,,RandRange(0.81,1.20));
      break;
      case 1:
      PlaySound(Sound'ss_COS_venomland_05E',,RandRange(0.31,0.62),,,RandRange(0.81,1.20));
      break;
      case 2:
      PlaySound(Sound'ss_COS_venomland_04E',,RandRange(0.31,0.62),,,RandRange(0.81,1.20));
      break;
      case 3:
      PlaySound(Sound'ss_COS_venomland_03E',,RandRange(0.31,0.62),,,RandRange(0.81,1.20));
      break;
      case 4:
      PlaySound(Sound'ss_COS_venomland_02E',,RandRange(0.31,0.62),,,RandRange(0.81,1.20));
      break;
      case 5:
      PlaySound(Sound'ss_COS_venomland_06E',,RandRange(0.31,0.62),,,RandRange(0.81,1.20));
      break;
      default:
    }
  }
}

function float GetDefaultDrawScale()
{
  return Default.DrawScale;
}

function UpdateFX()
{
  local Vector colRotated;

  return;
}

simulated function Timer()
{
  if ( (VSize2D(PlayerHarry.Location - Location) < PlayerHarry.CollisionRadius + CollisionRadius * DrawScale) && (Abs(PlayerHarry.Location.Z - Location.Z) < PlayerHarry.CollisionHeight + CollisionHeight) && (iDamage > 0) )
  {
    PlayerHarry.TakeDamage(iDamage,self,Location,Vec(0.0,0.0,0.0),'Ectoplasma');
    PlayerHarry.ClientMessage("DamageTimer " $ string(fDamageTimer) $ ", taking damage " $ string(iDamage) $ ", current health is " $ string(PlayerHarry.GetHealthStatusItem().nCount));
  }
}

auto state stateGrowing
{
  function BeginState()
  {
    DrawScale = 0.0;
    bCollideWorld = True;
    fTimeSpent = 0.0;
  }
  
  function Tick (float fTimeDelta)
  {
    if ( DrawScale < GetDefaultDrawScale() )
    {
      fTimeSpent += fTimeDelta;
      DrawScale = (fTimeSpent / fGrowTime) * GetDefaultDrawScale();
      if ( DrawScale >= GetDefaultDrawScale() )
      {
        DrawScale = GetDefaultDrawScale();
        GotoState('stateShrinking');
      }
      UpdateFX();
    }
  }
  
 begin:
  LoopAnim(AnimSequence);
  AnimFrame = RandRange(0.0,0.89999998);
}

state stateShrinking
{
  function BeginState()
  {
    fTimeSpent = 0.0;
  }
  
  function Tick (float fTimeDelta)
  {
    fTimeSpent += fTimeDelta;
    if ( fTimeSpent >= fShrinkTime )
    {
      Destroy();
    } else {
      DrawScale = (fShrinkTime - fTimeSpent) / fShrinkTime * GetDefaultDrawScale();
      UpdateFX();
    }
  }
  
}

defaultproperties
{
    fShrinkTime=17.00

    fGrowTime=0.30

    fDamageTimer=0.50

    iDamage=2

    AnimSequence=idle1

    // Style=3
	Style=STY_Translucent

    Mesh=SkeletalMesh'HProps.skvenomMesh'

    AmbientGlow=128

    MultiSkins(0)=WetTexture'HPParticle.hp_fx.General.Venomwet'

    CollisionRadius=44.00

    CollisionHeight=5.00

    bBlockActors=False

    bBlockPlayers=False

    bBlockCamera=False
}
