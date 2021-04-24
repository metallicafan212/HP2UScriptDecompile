//================================================================================
// SnakeHeadFlame.
//================================================================================

class SnakeHeadFlame extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\Particles.utx 	Package=HPParticle.particle_fx

defaultproperties
{
    ParticlesPerSec=(Base=75.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=300.00,Rand=100.00)

    Lifetime=(Base=2.50,Rand=2.50)

    ColorStart=(Base=(R=250,G=185,B=14,A=0),Rand=(R=255,G=208,B=98,A=0))

    ColorEnd=(Base=(R=151,G=0,B=0,A=0),Rand=(R=206,G=81,B=81,A=0))

    SizeWidth=(Base=12.00,Rand=16.00)

    SizeLength=(Base=12.00,Rand=16.00)

    SizeEndScale=(Base=2.00,Rand=0.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    Damping=2.00

    GravityModifier=-0.10

    ParticlesMax=200

    Textures(0)=Texture'HPParticle.particle_fx.PotFire08'

    Rotation=(Pitch=-2336,Yaw=-16272,Roll=-240)
}
