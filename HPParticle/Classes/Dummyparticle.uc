//================================================================================
// Dummyparticle.
//================================================================================

class Dummyparticle extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=15.00,Rand=10.00)

    SourceWidth=(Base=50.00,Rand=0.00)

    SourceHeight=(Base=50.00,Rand=0.00)

    Speed=(Base=15.00,Rand=30.00)

    Lifetime=(Base=5.00,Rand=0.00)

    ColorStart=(Base=(R=149,G=166,B=244,A=0),Rand=(R=28,G=19,B=196,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=8.00)

    SizeLength=(Base=6.00,Rand=8.00)

    SizeEndScale=(Base=3.00,Rand=0.00)

    SpinRate=(Base=0.50,Rand=0.00)

    SizeDelay=2.00

    Chaos=1.00

    ChaosDelay=0.50

    Textures=FireTexture'HPParticle.hp_fx.Particles.spin'
}
