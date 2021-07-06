//================================================================================
// DebrisGenerator.
//================================================================================

class DebrisGenerator extends HPawn;

const DEFAULT_VELOCITY= 250;
const NUM_ENTRIES= 8;
struct DebrisParams
{
  var() Mesh aMesh;
  var() Class<ParticleFX> bParticles;
  var() Sound cSound;
  var() float DrawScale;
  var() bool hasParticles;
  var() float LifeBase;
  var() float LifeRand;
  var() int MaxParticles;
  var() int Velocity;
};
var() DebrisParams HitDebris;
var() DebrisParams BaseDebris[8];
var() bool JustOnce;
var() int NumDebris;
var() float ScaleForSlow;
var() float WaitingTime;
var float ScaleDown;
var int NumMeshs;


function PostBeginPlay()
{
  local int I;

  Super.PostBeginPlay();
  ScaleDown = 1.0;
  NumMeshs = 0;
  // I = 0;
  // if ( I < 8 )
  for(I = 0; I < 8; I++)
  {
    if ( BaseDebris[I].aMesh == None )
    {
      NumMeshs = I;
	  break;
    } //else {
      // I++;
      // goto JL001F;
    //}
  }
  // I = 0;
  // if ( I < 8 )
  for(I = 0; I < 8; I++)
  {
    if ( BaseDebris[I].Velocity == 0 )
    {
      BaseDebris[I].Velocity = 250;
    }
    // I++;
    // goto JL0060;
  }
  // I = 0;
  // if ( I < 8 )
  for(I = 0; I < 8; I++)
  {
    if ( BaseDebris[I].DrawScale == 0 )
    {
      BaseDebris[I].DrawScale = 1.0;
    }
    // I++;
    // goto JL00A6;
  }
}

function Mesh GetRandomMesh (int Index)
{
  local Mesh lMesh;

  lMesh = BaseDebris[Index].aMesh;
  return lMesh;
}

function GenerateDebris()
{
  local Vector V;
  local Rotator R;

  V = Location;
  V.Z +=  -CollisionHeight + CollisionRadius;
  R = rotator(vect(0.00,0.00,1.00));
  Disintegrate(V,R);
}

state() TriggerOpenTimed
{
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    GotoState('TriggerOpenTimed','Start');
  }
  
 //this is NOT begin, KW used 'Start' as described in the trigger function above -AdamJD
 Start:
  Disable('Trigger');
  GenerateDebris();
  Sleep(WaitingTime);
  Enable('Trigger');
}

function Disintegrate (Vector start_locn, Rotator dirn)
{
  local Rotator randRotVelocity;
  local int I;
  //local int Index;
  local int iIndex;
  local int nums;
  local Vector vectGap;
  local Debris A;
  local ParticleFX p;

  nums = NumDebris * ScaleDown;
  vectGap.Z = CollisionHeight * 2 / nums;
  vectGap = vectGap >> dirn;
  start_locn += vectGap / 2;
  if ( HitDebris.bParticles != None )
  {
    p = Spawn(HitDebris.bParticles,,,start_locn,rot(0,0,0));
    if ( p != None )
    {
      p.DrawScale *= HitDebris.DrawScale;
      if ( HitDebris.LifeBase > 0 )
      {
        p.Lifetime.Base = HitDebris.LifeBase;
        p.Lifetime.Base *= ScaleDown;
      }
      if ( HitDebris.LifeRand > 0 )
      {
        p.Lifetime.Rand = HitDebris.LifeRand;
        p.Lifetime.Rand *= ScaleDown;
      }
      if ( HitDebris.MaxParticles > 0 )
      {
        p.ParticlesMax = HitDebris.MaxParticles;
        p.ParticlesMax *= ScaleDown;
      }
      if ( HitDebris.cSound != None )
      {
        PlaySound(HitDebris.cSound,,,,100000.0,RandRange(0.89999998,1.12));
      }
    }
  }
  if ( NumMeshs == 0 )
  {
    return;
  }
  // I = 0;
  // if ( I < nums )
  for(I = 0; I < nums; ++I)
  {
    iIndex = Rand(NumMeshs);
    A = Spawn(Class'Debris',,,start_locn,RotRand());
    if ( A != None )
    {
      A.Mesh = GetRandomMesh(iIndex);
      A.DrawScale *= BaseDebris[iIndex].DrawScale;
      A.Particles = BaseDebris[iIndex].bParticles;
      A.MySound = BaseDebris[iIndex].cSound;
      A.newDrawScale = BaseDebris[iIndex].DrawScale;
      A.hasParticles = BaseDebris[iIndex].hasParticles;
      A.LifeBase = BaseDebris[iIndex].LifeBase;
      A.LifeRand = BaseDebris[iIndex].LifeRand;
      A.MaxParticles = BaseDebris[iIndex].MaxParticles;
      A.VelocityMultiplier = BaseDebris[iIndex].Velocity;
      A.ScaleDown = ScaleDown;
      A.InitializeDebris();
    }
    start_locn += vectGap;
    // ++I;
    // goto JL01C7;
  }
  if ( JustOnce )
  {
    Destroy();
  }
}

defaultproperties
{
    NumDebris=20

    ScaleForSlow=0.50

    WaitingTime=5.00

    bHidden=True

    InitialState=TriggerOpenTimed

}
