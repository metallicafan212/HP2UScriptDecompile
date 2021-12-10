//================================================================================
// Debris.
//================================================================================

class Debris extends Projectile;

var Rotator RandSpin;
var int NumBounces;
var int PlaySoundTimer;
var Class<ParticleFX> Particles;
var Sound MySound;
var float newDrawScale;
var bool hasParticles;
var float MaxLiveTime;
var float ScaleDown;
var float LifeBase;
var float LifeRand;
var int MaxParticles;
var int VelocityMultiplier;

function InitializeDebris()
{
  local Rotator randRotVelocity;
  local int velocityMult;

  DrawScale *= 0.5 + (3.0 - 0.5) * FRand();
  RandSpin = RotRand() / 4;
  randRotVelocity = RotRand();
  velocityMult = VelocityMultiplier;
  Velocity = vector(randRotVelocity) * velocityMult;
  Velocity.Z += 2.0 * velocityMult;
  NumBounces = 1 + Rand(2);
}

auto state isFalling
{
  function BeginState()
  {
    MaxLiveTime = 1.0;
  }
  
  function Tick (float DeltaTime)
  {
    local ParticleFX p;
  
    SetRotation(Rotation + (RandSpin * DeltaTime * 3));
    Velocity.Z -= (DeltaTime * 1000);
    MaxLiveTime -= DeltaTime;
    if ( MaxLiveTime < 0 )
    {
      if ( hasParticles )
      {
        p = Spawn(Particles,,,Location,rot(0,0,0));
        if ( p != None )
        {
          p.DrawScale *= newDrawScale;
          if ( LifeBase > 0 )
          {
            p.Lifetime.Base = LifeBase;
            p.Lifetime.Base *= ScaleDown;
          }
          if ( LifeRand > 0 )
          {
            p.Lifetime.Rand = LifeRand;
            p.Lifetime.Rand *= ScaleDown;
          }
          if ( MaxParticles > 0 )
          {
            p.ParticlesMax = MaxParticles;
            p.ParticlesMax *= ScaleDown;
          }
        }
      }
      Destroy();
    }
  }
  
  function HitWall (Vector HitNormal, Actor Wall)
  {
    local ParticleFX p;
  
    Velocity.Z *= 0.2 + FRand() * 0.31;
    Velocity = MirrorVectorByNormal(Velocity,HitNormal);
    PlaySound(MySound,SLOT_None,0.75,,100000.0,RandRange(0.89999998,1.12));
    if ( hasParticles )
    {
      p = Spawn(Particles,,,Location,rot(0,0,0));
      if ( p != None )
      {
        p.DrawScale *= newDrawScale;
        if ( LifeBase > 0 )
        {
          p.Lifetime.Base = LifeBase;
          p.Lifetime.Base *= ScaleDown;
        }
        if ( LifeRand > 0 )
        {
          p.Lifetime.Rand = LifeRand;
          p.Lifetime.Rand *= ScaleDown;
        }
        if ( MaxParticles > 0 )
        {
          p.ParticlesMax = MaxParticles;
          p.ParticlesMax *= ScaleDown;
        }
      }
    }
    if ( NumBounces == 0 )
    {
      Destroy();
    }
    NumBounces--;
  }
  
  function Landed (Vector HitNormal)
  {
    Velocity = MirrorVectorByNormal(Velocity,HitNormal);
  }
  
}

defaultproperties
{
    // Physics=2
	Physics=PHYS_Falling

    CollisionRadius=1.00

    CollisionHeight=1.00

    bBounce=True
}
