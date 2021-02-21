//================================================================================
// WrongFX.
//================================================================================

class WrongFX extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=500.00,Rand=0.00)

    SourceWidth=(Base=48.00,Rand=0.00)

    SourceHeight=(Base=48.00,Rand=0.00)

    SourceDepth=(Base=24.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=5.00,Rand=25.00)

    Lifetime=(Base=2.00,Rand=1.00)

    ColorStart=(Base=(R=254,G=192,B=101,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=128,G=119,B=136,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=12.00,Rand=4.00)

    SizeLength=(Base=12.00,Rand=4.00)

    SizeEndScale=(Base=-1.00,Rand=4.00)

    SpinRate=(Base=-2.00,Rand=2.00)

    Chaos=10.00

    ChaosDelay=0.25

    ParticlesMax=50

    Textures=Texture'HPParticle.hp_fx.Particles.Smoke4'

    Rotation=(Pitch=-16840,Yaw=7776,Roll=0)

    bRotateToDesired=True
}
