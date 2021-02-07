//================================================================================
// Diffindo_ropeFx.
//================================================================================

class Diffindo_ropeFx extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=50.00,Rand=10.00)

    SourceWidth=(Base=64.00,Rand=0.00)

    SourceHeight=(Base=5.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=-15.00,Rand=30.00)

    Lifetime=(Base=1.50,Rand=0.75)

    ColorStart=(Base=(R=255,G=243,B=104,A=0),Rand=(R=255,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=255,B=0,A=0),Rand=(R=255,G=145,B=53,A=0))

    SizeWidth=(Base=6.00,Rand=4.00)

    SizeLength=(Base=6.00,Rand=4.00)

    SizeEndScale=(Base=0.00,Rand=2.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    DripTime=(Base=0.50,Rand=0.00)

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=48995,Yaw=0,Roll=0)
}
