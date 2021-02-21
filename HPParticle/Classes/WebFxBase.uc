//================================================================================
// WebFxBase.
//================================================================================

class WebFxBase extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=30.00,Rand=10.00)

    SourceHeight=(Base=175.00,Rand=10.00)

    SourceDepth=(Base=30.00,Rand=10.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=90.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=20.00)

    Lifetime=(Base=2.00,Rand=2.00)

    ColorStart=(Base=(R=159,G=207,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=10.00,Rand=8.00)

    SizeLength=(Base=1.00,Rand=0.00)

    SpinRate=(Base=-4.00,Rand=4.00)

    Chaos=6.00

    Damping=2.00

    ParticlesMax=100

    Textures=Texture'HPParticle.hp_fx.Particles.webticle'
}
