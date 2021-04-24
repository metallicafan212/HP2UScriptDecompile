//================================================================================
// TargetFX.
//================================================================================

class TargetFX extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\Particles.utx 	Package=HPParticle.particle_fx

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=0.00)

    SourceWidth=(Base=3.00,Rand=0.00)

    SourceHeight=(Base=3.00,Rand=0.00)

    SourceDepth=(Base=3.00,Rand=0.00)

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=0.55,Rand=0.00)

    ColorStart=(Base=(R=5,G=5,B=169,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=113,G=0,B=204,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=12.00,Rand=0.00)

    SizeLength=(Base=12.00,Rand=0.00)

    SizeEndScale=(Base=1.25,Rand=0.00)

    SpinRate=(Base=4.00,Rand=-8.00)

    Textures(0)=Texture'HPParticle.particle_fx.soft_pfx'
}
