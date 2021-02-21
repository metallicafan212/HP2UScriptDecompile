//================================================================================
// SaveGameExplo.
//================================================================================

class SaveGameExplo extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=400.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=100.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=0,G=255,B=0,A=0),Rand=(R=255,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=128,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=6.00)

    SizeLength=(Base=2.00,Rand=6.00)

    SizeEndScale=(Base=0.00,Rand=3.00)

    SpinRate=(Base=0.50,Rand=0.00)

    Chaos=1.00

    Damping=10.00

    ParticlesMax=40

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'
}
