//================================================================================
// VoldBigFireBall.
//================================================================================

class VoldBigFireBall extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\Particles.utx 	Package=HPParticle.particle_fx

var() float fFireBallSpeed;

function Tick (float dtime)
{
  SetLocation(Location + Velocity * dtime);
}

defaultproperties
{
    fFireBallSpeed=400.00

    ParticlesPerSec=(Base=50.00,Rand=0.00)

    SourceHeight=(Base=5.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=0.40,Rand=0.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=60.00,Rand=0.00)

    SizeLength=(Base=60.00,Rand=0.00)

    SizeEndScale=(Base=0.01,Rand=0.00)

    SpinRate=(Base=10.00,Rand=20.00)

    Chaos=4.00

    Textures=Texture'HPParticle.particle_fx.PotFire08'

    LifeSpan=2.00
}
