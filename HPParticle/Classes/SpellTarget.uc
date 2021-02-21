//================================================================================
// SpellTarget.
//================================================================================

class SpellTarget extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=80.00,Rand=0.00)

    SourceWidth=(Base=5.00,Rand=5.00)

    SourceHeight=(Base=5.00,Rand=5.00)

    SourceDepth=(Base=5.00,Rand=5.00)

    AngularSpreadWidth=(Base=180.00,Rand=181.00)

    AngularSpreadHeight=(Base=180.00,Rand=180.00)

    Speed=(Base=1.00,Rand=40.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=255,G=0,B=0,A=0),Rand=(R=255,G=255,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=5.00)

    SizeLength=(Base=2.00,Rand=5.00)

    SizeEndScale=(Base=0.00,Rand=3.00)

    Chaos=1.00

    Damping=4.00

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'
}
