//================================================================================
// FlyingClouds.
//================================================================================

class FlyingClouds extends FlyingFord;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=0.05,Rand=0.00)

    SourceWidth=(Base=500.00,Rand=200.00)

    SourceHeight=(Base=500.00,Rand=200.00)

    Period=(Base=300.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=False

    Speed=(Base=1200.00,Rand=400.00)

    Lifetime=(Base=3000.00,Rand=0.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaEnd=(Base=0.50,Rand=0.00)

    SizeWidth=(Base=400.00,Rand=200.00)

    SizeLength=(Base=400.00,Rand=200.00)

    SizeEndScale=(Base=750.00,Rand=0.00)

    SpinRate=(Base=-0.25,Rand=0.50)

    DripTime=(Base=5.00,Rand=0.00)

    ParticlesAlive=10

    Textures(0)=Texture'HPParticle.hp_fx.Particles.FF_Cloud'

    Texture=Texture'HPParticle.hp_fx.Particles.SepiaFlamefx'
}
