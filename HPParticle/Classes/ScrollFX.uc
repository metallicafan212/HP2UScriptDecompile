//================================================================================
// ScrollFX.
//================================================================================

class ScrollFX extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=5.00,Rand=20.00)

    SourceWidth=(Base=8.00,Rand=15.00)

    SourceHeight=(Base=2.00,Rand=10.00)

    SourceDepth=(Base=8.00,Rand=15.00)

    AngularSpreadWidth=(Base=10.00,Rand=0.00)

    AngularSpreadHeight=(Base=1.00,Rand=0.00)

    Speed=(Base=10.00,Rand=15.00)

    Lifetime=(Base=1.00,Rand=5.00)

    ColorStart=(Base=(R=116,G=55,B=176,A=0),Rand=(R=168,G=84,B=237,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=8.00)

    SizeLength=(Base=2.00,Rand=8.00)

    SizeEndScale=(Base=0.10,Rand=20.00)

    SpinRate=(Base=0.50,Rand=20.00)

    SizeDelay=3.00

    Chaos=3.00

    ChaosDelay=1.00

    Attraction=(X=10.00,Y=10.00,Z=0.00)

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_4'
}
