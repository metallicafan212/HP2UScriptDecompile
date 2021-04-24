//================================================================================
// FireSparks01.
//================================================================================

class FireSparks01 extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\Particles.utx 	Package=HPParticle.particle_fx

defaultproperties
{
    ParticlesPerSec=(Base=8.00,Rand=0.00)

    SourceWidth=(Base=20.00,Rand=0.00)

    SourceHeight=(Base=20.00,Rand=0.00)

    Speed=(Base=80.00,Rand=0.00)

    ColorEnd=(Base=(R=252,G=245,B=3,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=3.00,Rand=0.00)

    SizeLength=(Base=3.00,Rand=0.00)

    Chaos=16.00

    Gravity=(X=0.00,Y=0.00,Z=100.00)

    Textures(0)=Texture'HPParticle.particle_fx.soft_pfx'
}
