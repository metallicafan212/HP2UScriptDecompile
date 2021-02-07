//================================================================================
// avif_book.
//================================================================================

class avif_book extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=5.00,Rand=10.00)

    SourceWidth=(Base=20.00,Rand=10.00)

    SourceHeight=(Base=20.00,Rand=10.00)

    SourceDepth=(Base=20.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=5.00,Rand=15.00)

    Lifetime=(Base=1.00,Rand=3.00)

    ColorStart=(Base=(R=249,G=203,B=66,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=228,G=41,B=102,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=5.00,Rand=10.00)

    SizeLength=(Base=5.00,Rand=10.00)

    SizeEndScale=(Base=-2.00,Rand=4.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Chaos=5.00

    ChaosDelay=0.50

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_1'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
