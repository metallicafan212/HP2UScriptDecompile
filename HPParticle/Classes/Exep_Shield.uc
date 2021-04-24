//================================================================================
// Exep_Shield.
//================================================================================

class Exep_Shield extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=40.00,Rand=40.00)

    SourceHeight=(Base=40.00,Rand=40.00)

    bSteadyState=True

    Speed=(Base=0.00,Rand=0.00)

    Lifetime=(Base=0.25,Rand=0.50)

    ColorStart=(Base=(R=252,G=165,B=46,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=156,B=21,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=12.00)

    SizeLength=(Base=6.00,Rand=12.00)

    SpinRate=(Base=-4.00,Rand=8.00)

    Chaos=5.00

    ParticlesMax=200

    Textures(0)=Texture'HPParticle.hp_fx.Particles.FF_Wind'
}
