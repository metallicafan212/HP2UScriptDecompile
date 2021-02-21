//================================================================================
// Serpentsoria.
//================================================================================

class Serpentsoria extends ParticleFX;

defaultproperties
{
    SourceWidth=(Base=1.00,Rand=1.00)

    SourceHeight=(Base=1.00,Rand=1.00)

    SourceDepth=(Base=0.00,Rand=2.00)

    bSteadyState=True

    Speed=(Base=25.00,Rand=10.00)

    Lifetime=(Base=1.00,Rand=1.00)

    ColorStart=(Base=(R=104,G=167,B=78,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=66,G=167,B=37,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=10.00,Rand=5.00)

    SizeLength=(Base=10.00,Rand=5.00)

    SizeEndScale=(Base=-1.00,Rand=2.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    DripTime=(Base=0.50,Rand=0.00)

    Chaos=2.00

    Damping=2.00

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_8'

    CutName="serpentsoriaPE"
}
