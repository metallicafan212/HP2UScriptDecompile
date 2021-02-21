//================================================================================
// TomRiddleFX.
//================================================================================

class TomRiddleFX extends ParticleFX;

defaultproperties
{
    ParticlesPerSec=(Base=1.00,Rand=1.00)

    SourceWidth=(Base=30.00,Rand=10.00)

    SourceHeight=(Base=30.00,Rand=10.00)

    SourceDepth=(Base=30.00,Rand=10.00)

    AngularSpreadWidth=(Base=15.00,Rand=10.00)

    AngularSpreadHeight=(Base=15.00,Rand=10.00)

    bSteadyState=True

    Speed=(Base=1.00,Rand=1.00)

    Lifetime=(Base=4.00,Rand=1.00)

    ColorStart=(Base=(R=0,G=128,B=64,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=128,B=64,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaStart=(Base=0.40,Rand=0.00)

    SizeWidth=(Base=2.00,Rand=4.00)

    SizeLength=(Base=2.00,Rand=4.00)

    SizeEndScale=(Base=2.00,Rand=0.00)

    SpinRate=(Base=0.20,Rand=2.00)

    SizeDelay=2.00

    Chaos=1.50

    ChaosDelay=0.50

    Gravity=(X=0.00,Y=0.00,Z=5.00)

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

    Rotation=(Pitch=-16352,Yaw=0,Roll=0)

    DesiredRotation=(Pitch=-16352,Yaw=0,Roll=0)
}
