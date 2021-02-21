//================================================================================
// WebFxAragog.
//================================================================================

class WebFxAragog extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=1000.00,Rand=0.00)

    SourceWidth=(Base=900.00,Rand=100.00)

    SourceHeight=(Base=50.00,Rand=10.00)

    SourceDepth=(Base=900.00,Rand=100.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=90.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=20.00)

    Lifetime=(Base=3.00,Rand=2.00)

    ColorStart=(Base=(R=159,G=207,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=40.00,Rand=10.00)

    SizeLength=(Base=4.00,Rand=1.00)

    SpinRate=(Base=-6.00,Rand=6.00)

    Chaos=6.00

    GravityModifier=1.00

    ParticlesMax=300

    Textures=Texture'HPParticle.hp_fx.Particles.webticle'
}
