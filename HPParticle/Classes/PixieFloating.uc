//================================================================================
// PixieFloating.
//================================================================================

class PixieFloating extends PixieParticles;

defaultproperties
{
    ParticlesPerSec=(Base=10.00,Rand=5.00)

    SourceWidth=(Base=20.00,Rand=5.00)

    SourceHeight=(Base=20.00,Rand=5.00)

    SourceDepth=(Base=20.00,Rand=5.00)

    AngularSpreadWidth=(Base=30.00,Rand=0.00)

    AngularSpreadHeight=(Base=30.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=10.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=253,G=152,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=202,B=40,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=6.00)

    SizeLength=(Base=4.00,Rand=6.00)

    SizeEndScale=(Base=0.00,Rand=2.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    Textures=Texture'HPParticle.hp_fx.Particles.Les_Sparkle_04'

    Rotation=(Pitch=16323,Yaw=0,Roll=0)
}
