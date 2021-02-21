//================================================================================
// SorcererStoneFX.
//================================================================================

class SorcererStoneFX extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=30.00,Rand=30.00)

    SourceWidth=(Base=1.00,Rand=10.00)

    SourceHeight=(Base=1.00,Rand=10.00)

    SourceDepth=(Base=1.00,Rand=10.00)

    AngularSpreadWidth=(Base=180.00,Rand=180.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=1.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=128,B=0,A=0),Rand=(R=128,G=128,B=128,A=0))

    SizeWidth=(Base=1.00,Rand=2.00)

    SizeLength=(Base=1.00,Rand=2.00)

    SizeEndScale=(Base=3.00,Rand=0.00)

    Chaos=1.00

    GravityModifier=-0.02

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_3'
}
